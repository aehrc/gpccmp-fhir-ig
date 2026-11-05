import { createRequire } from 'node:module';
import { defineConfig } from 'vitest/config';

const require = createRequire(import.meta.url);

export default defineConfig({
  optimizeDeps: {
    include: ['react/jsx-dev-runtime']
  },
  resolve: {
    alias: [
      {
        // fhirclient's Node entry exports a server adapter function without `client`, while the
        // renderer imports the named `client` export. Point the bare specifier at the browser
        // entry, resolved absolutely from the installed package. The exact `^fhirclient$` match
        // leaves explicit `fhirclient/...` subpath imports untouched.
        find: /^fhirclient$/,
        replacement: require.resolve('fhirclient/lib/entry/browser.js')
      }
    ]
  },
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: ['./test/setup.ts'],
    include: ['test/**/*.test.tsx'],
    fileParallelism: false,
    testTimeout: 40000,
    server: {
      deps: {
        // Installed packages need Vite's CSS and directory-import handling.
        // Workspace symlinks in Smart Forms previously provided this implicitly.
        inline: [/@aehrc\//, /@fontsource/]
      }
    }
  }
});
