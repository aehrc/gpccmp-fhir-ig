import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { createRequire } from 'node:module';
import { createHash } from 'node:crypto';
import { spawnSync } from 'node:child_process';
import assert from 'node:assert/strict';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const [archive, ...flags] = process.argv.slice(2);
if (!archive)
  throw new Error(
    'Usage: npm run test:toolkit-candidate -- <compiled.tgz> [--sha256 <hash>] [--source-revision <commit>] [--offline] [--inherited] [--browser] [--renderer-candidate <compiled.tgz> --renderer-sha256 <hash> --renderer-source-revision <revision>]'
  );
const option = (name) =>
  flags.includes(name) ? flags[flags.indexOf(name) + 1] : undefined;
const tarball = fs.realpathSync(archive);
const sha256 = createHash('sha256')
  .update(fs.readFileSync(tarball))
  .digest('hex');
if (option('--sha256'))
  assert.equal(
    sha256,
    option('--sha256'),
    'Candidate tarball SHA-256 mismatch'
  );
const rendererArchive = option('--renderer-candidate');
const rendererTarball = rendererArchive
  ? fs.realpathSync(rendererArchive)
  : null;
const rendererSha256 = rendererTarball
  ? createHash('sha256').update(fs.readFileSync(rendererTarball)).digest('hex')
  : null;
if (rendererTarball) {
  assert(
    option('--renderer-sha256'),
    'Renderer candidate requires its SHA-256'
  );
  assert(
    option('--renderer-source-revision'),
    'Renderer candidate requires its source identity'
  );
  assert.equal(
    rendererSha256,
    option('--renderer-sha256'),
    'Renderer tarball SHA-256 mismatch'
  );
}
const consumer = fs.mkdtempSync(
  path.join(os.tmpdir(), 'gpccmp-toolkit-consumer-')
);
console.log(`Isolated consumer: ${consumer}\nCandidate SHA-256: ${sha256}`);
const allowed = new Set([
  'package.json',
  'package-lock.json',
  'sushi-config.yaml',
  'ig.ini',
  'input',
  'test',
  'browser',
  'tooling',
  'tsconfig.json',
  'tsconfig.candidate.json',
  'vitest.config.ts',
  'vitest.candidate.config.ts',
  'playwright.config.ts',
  'vite.browser.config.ts'
]);
fs.cpSync(root, consumer, {
  recursive: true,
  filter: (source) =>
    source === root ||
    allowed.has(path.relative(root, source).split(path.sep)[0])
});
fs.copyFileSync(tarball, path.join(consumer, 'toolkit-candidate.tgz'));
if (rendererTarball)
  fs.copyFileSync(
    rendererTarball,
    path.join(consumer, 'renderer-candidate.tgz')
  );
const pkgPath = path.join(consumer, 'package.json');
const pkg = JSON.parse(fs.readFileSync(pkgPath, 'utf8'));
pkg.devDependencies['@aehrc/questionnaire-test-toolkit'] =
  'file:./toolkit-candidate.tgz';
if (rendererTarball)
  pkg.devDependencies['@aehrc/smart-forms-renderer'] =
    'file:./renderer-candidate.tgz';
fs.writeFileSync(pkgPath, JSON.stringify(pkg, null, 2) + '\n');
const igRevision = spawnSync('git', ['rev-parse', 'HEAD'], {
  cwd: root,
  encoding: 'utf8'
});
const inputFiles = fs
  .readdirSync(path.join(root, 'test'), { recursive: true })
  .filter((name) => /\.(tsx?|mjs)$/.test(name))
  .sort();
const report = {
  igRevision: igRevision.status === 0 ? igRevision.stdout.trim() : null,
  testInputs: Object.fromEntries(
    inputFiles.map((name) => [
      name,
      createHash('sha256')
        .update(fs.readFileSync(path.join(root, 'test', name)))
        .digest('hex')
    ])
  ),
  browserInputs: Object.fromEntries(
    [
      'playwright.config.ts',
      'vite.browser.config.ts',
      ...fs
        .readdirSync(path.join(root, 'browser'))
        .map((name) => `browser/${name}`)
    ].map((name) => [
      name,
      createHash('sha256')
        .update(fs.readFileSync(path.join(root, name)))
        .digest('hex')
    ])
  ),
  sourceRevision: option('--source-revision') ?? null,
  rendererCandidate: rendererTarball
    ? {
        sourceRevision: option('--renderer-source-revision'),
        sha256: rendererSha256
      }
    : null,
  sha256,
  node: process.version,
  consumer,
  checks: []
};
process.on('exit', (code) => {
  report.status = code === 0 ? 'passed' : 'failed';
  fs.writeFileSync(
    path.join(consumer, 'candidate-report.json'),
    JSON.stringify(report, null, 2) + '\n'
  );
});
function run(executable, args, logName) {
  console.log(`Running ${logName}`);
  const log = path.join(consumer, logName + '.log');
  const fd = fs.openSync(log, 'w');
  const result = spawnSync(executable, args, {
    cwd: consumer,
    env: { ...process.env, TZ: 'Australia/Sydney' },
    stdio: ['ignore', fd, fd]
  });
  fs.closeSync(fd);
  if (logName === 'inherited-tests') {
    const resultPath = path.join(consumer, 'inherited-results.json');
    if (fs.existsSync(resultPath)) {
      const results = JSON.parse(fs.readFileSync(resultPath, 'utf8'));
      report.inherited = {
        total: results.numTotalTests,
        passed: results.numPassedTests,
        failed: results.numFailedTests,
        pending: results.numPendingTests,
        cases: results.testResults.flatMap((file) =>
          file.assertionResults.map((test) => ({
            name: test.fullName,
            status: test.status
          }))
        )
      };
    }
  }
  report.checks.push({
    command: [executable, ...args],
    exit: result.status,
    log
  });
  fs.writeFileSync(
    path.join(consumer, 'candidate-report.json'),
    JSON.stringify(report, null, 2) + '\n'
  );
  if (result.error || result.status !== 0) {
    if (logName === 'inherited-tests' && report.inherited) {
      console.error(JSON.stringify(report.inherited, null, 2));
    } else console.error(fs.readFileSync(log, 'utf8').slice(-16000));
    throw (
      result.error ??
      new Error(
        `${logName} failed (${result.status}); consumer and logs retained at ${consumer}`
      )
    );
  }
}
run(
  'npm',
  [
    'install',
    '--ignore-scripts',
    '--no-audit',
    '--no-fund',
    ...(flags.includes('--offline') ? ['--offline'] : [])
  ],
  'install'
);
const require = createRequire(pkgPath);
const toolkitEntry = require.resolve('@aehrc/questionnaire-test-toolkit');
const toolkitRequire = createRequire(toolkitEntry);
report.sharedDependencies = Object.fromEntries(
  [
    'react',
    '@aehrc/smart-forms-renderer',
    '@aehrc/sdc-populate',
    '@aehrc/sdc-template-extract'
  ].map((name) => {
    const direct = fs.realpathSync(require.resolve(name));
    assert.equal(
      direct,
      fs.realpathSync(toolkitRequire.resolve(name)),
      `${name} must be shared with toolkit`
    );
    return [name, direct];
  })
);
const locked = JSON.parse(
  fs.readFileSync(path.join(consumer, 'package-lock.json'), 'utf8')
);
const originalLock = JSON.parse(
  fs.readFileSync(path.join(root, 'package-lock.json'), 'utf8')
);
for (const [name, version] of Object.entries(pkg.devDependencies)) {
  if (name === '@aehrc/questionnaire-test-toolkit') continue;
  if (rendererTarball && name === '@aehrc/smart-forms-renderer') {
    assert.equal(
      locked.packages[`node_modules/${name}`].version,
      originalLock.packages[`node_modules/${name}`].version,
      'Renderer candidate keeps the pinned version; hash identifies the candidate'
    );
    report.rendererCandidate.package = locked.packages[`node_modules/${name}`];
    continue;
  }
  assert.equal(
    locked.packages[`node_modules/${name}`].version,
    version,
    `Keep IG dependency ${name} pinned`
  );
}
for (const name of ['@aehrc/sdc-populate', '@aehrc/sdc-template-extract']) {
  assert.equal(
    locked.packages[`node_modules/${name}`].version,
    originalLock.packages[`node_modules/${name}`].version
  );
}
report.candidate =
  locked.packages['node_modules/@aehrc/questionnaire-test-toolkit'];
report.versions = Object.fromEntries(
  [
    '@aehrc/smart-forms-renderer',
    '@aehrc/sdc-populate',
    '@aehrc/sdc-template-extract',
    'react',
    'react-dom',
    '@types/fhir',
    'vitest',
    'typescript'
  ].map((name) => [name, locked.packages[`node_modules/${name}`].version])
);
run('npm', ['run', 'generate'], 'generation');
report.questionnaireSha256 = createHash('sha256')
  .update(
    fs.readFileSync(
      path.join(
        consumer,
        'fsh-generated/resources/Questionnaire-GPChronicConditionManagementPlan.json'
      )
    )
  )
  .digest('hex');
run(
  process.execPath,
  [
    path.join(consumer, 'node_modules/typescript/bin/tsc'),
    '--noEmit',
    '-p',
    'tsconfig.candidate.json'
  ],
  'typecheck'
);

// Both promised export conditions are exercised through a browser bundler. The renderer
// requires CSS/directory-import handling, as in the IG's Vite consumer; this is not a Node server smoke test.
const bundles = path.join(consumer, '.candidate-check');
fs.mkdirSync(bundles);
fs.writeFileSync(
  path.join(bundles, 'import.mts'),
  "export * from '@aehrc/questionnaire-test-toolkit';\n"
);
fs.writeFileSync(
  path.join(bundles, 'require.cts'),
  "import toolkit = require('@aehrc/questionnaire-test-toolkit'); export = toolkit;\n"
);
for (const [entry, output] of [
  ['import.mts', 'esm.mjs'],
  ['require.cts', 'cjs.mjs']
]) {
  run(
    path.join(consumer, 'node_modules/.bin/esbuild'),
    [
      path.join(bundles, entry),
      '--bundle',
      '--platform=browser',
      '--format=esm',
      '--loader:.css=empty',
      `--outfile=${path.join(bundles, output)}`,
      `--metafile=${path.join(bundles, output + '.json')}`
    ],
    `bundle-${output}`
  );
  const metadata = JSON.parse(
    fs.readFileSync(path.join(bundles, output + '.json'), 'utf8')
  );
  assert(
    Object.keys(metadata.inputs).some((name) =>
      name.endsWith(
        output === 'esm.mjs'
          ? 'questionnaire-test-toolkit/dist/index.js'
          : 'questionnaire-test-toolkit/dist/index.cjs'
      )
    ),
    `Verify ${entry} uses the promised public export condition`
  );
}
const publicTypes =
  "import type { BehavioralTestWrapperProps } from '@aehrc/questionnaire-test-toolkit';\nconst props: BehavioralTestWrapperProps = {questionnaire:{resourceType:'Questionnaire',status:'draft'},patient:{resourceType:'Patient'},fetchResourceCallback:async () => ({resourceType:'Bundle',type:'searchset'}),questionnaireResponse:{resourceType:'QuestionnaireResponse',status:'in-progress'}};\nexport { props };\n";
fs.writeFileSync(path.join(bundles, 'public-types.mts'), publicTypes);
fs.writeFileSync(
  path.join(bundles, 'public-types.cts'),
  publicTypes.replace(
    "import type { BehavioralTestWrapperProps } from '@aehrc/questionnaire-test-toolkit';",
    "import type Toolkit = require('@aehrc/questionnaire-test-toolkit');\ntype BehavioralTestWrapperProps = Toolkit.BehavioralTestWrapperProps;"
  )
);
run(
  process.execPath,
  [
    path.join(consumer, 'node_modules/typescript/bin/tsc'),
    '--noEmit',
    '--strict',
    '--skipLibCheck',
    'false',
    '--module',
    'preserve',
    '--moduleResolution',
    'bundler',
    '--target',
    'ES2020',
    '--lib',
    'ES2020,DOM',
    '--esModuleInterop',
    path.join(bundles, 'public-types.mts'),
    path.join(bundles, 'public-types.cts')
  ],
  'public-declarations'
);
run(
  process.execPath,
  [
    path.join(consumer, 'node_modules/vitest/vitest.mjs'),
    'run',
    '--config',
    'vitest.candidate.config.ts'
  ],
  'adoption-tests'
);
if (flags.includes('--inherited')) {
  run(
    process.execPath,
    [
      path.join(consumer, 'node_modules/vitest/vitest.mjs'),
      'run',
      '--config',
      'vitest.config.ts',
      '--reporter=default',
      '--reporter=json',
      '--outputFile=inherited-results.json'
    ],
    'inherited-tests'
  );
}
if (flags.includes('--browser')) {
  run('npm', ['run', 'test:browser'], 'browser-tests');
}
console.log(
  `Candidate checks passed${flags.includes('--inherited') ? ' including the inherited suite' : ''}. Evidence: ${path.join(consumer, 'candidate-report.json')}`
);
