import { expect, test, type Locator, type Page } from '@playwright/test';
import type { QuestionnaireResponseItem } from 'fhir/r4';

const sections = [
  'patient',
  'practitioner',
  'clinicaldetails',
  'plan'
] as const;
const fields = [
  'patient-additionalinformation',
  'practitioner-name',
  'clinicaldetails-observations-additionalinformation',
  'plan-conditions-comments'
] as const;
const values = [
  'Browser patient seven',
  'Jane Smith',
  'Browser observations seven',
  'Browser plan seven'
] as const;
const structures = {
  clinicaldetails: [
    'clinicaldetails-problemsdiagnoses-recordedproblems',
    'clinicaldetails-problemsdiagnoses-newproblems',
    'clinicaldetails-observations-maingrid',
    'clinicaldetails-observations-bpgrid',
    'clinicaldetails-observations-substanceusegrid'
  ],
  plan: [
    'plan-goalstasks-details-interventionsactions',
    'plan-goalstasks-details-servicestreatments'
  ]
};

function field(page: Page, id: string) {
  return page
    .locator(`[data-linkid="${id}"]`)
    .locator('input, textarea')
    .first();
}

function sectionButton(page: Page, id: string, small: boolean) {
  return small
    ? page
        .locator(`[data-test="renderer-accordion"][data-linkid="${id}"]`)
        .getByRole('button')
        .first()
    : page
        .locator(`[data-test="renderer-tab-list"] [data-linkid="${id}"]`)
        .getByRole('button');
}

async function openSection(page: Page, id: string, small: boolean) {
  const button = sectionButton(page, id, small);
  await expect(button).toBeVisible();
  if (!small || (await button.getAttribute('aria-expanded')) !== 'true')
    await button.click();
  if (small) {
    for (const section of sections)
      await expect(sectionButton(page, section, true)).toHaveAttribute(
        'aria-expanded',
        String(section === id)
      );
  } else {
    const index = sections.indexOf(id as (typeof sections)[number]);
    await expect(page.getByRole('tabpanel')).toHaveAttribute(
      'id',
      `tabpanel-${index}`
    );
    await expect(page.getByRole('tabpanel')).toHaveAttribute(
      'aria-labelledby',
      `tab-${index}`
    );
  }
}

async function expectSaved(page: Page, id: string, value: string) {
  await expect
    .poll(() =>
      page.evaluate(
        ({ id }) => {
          function find(
            items: QuestionnaireResponseItem[] = []
          ): QuestionnaireResponseItem[] {
            return items.flatMap((item) => [
              ...(item.linkId === id ? [item] : []),
              ...find(item.item),
              ...(item.answer ?? []).flatMap((answer) => find(answer.item))
            ]);
          }
          return [
            window.gpccmp.response(),
            window.gpccmp.cleanedResponse()
          ].map((qr) => find(qr.item).map((item) => item.answer));
        },
        { id }
      )
    )
    .toEqual([[[{ valueString: value }]], [[{ valueString: value }]]]);
}

/** Check actual document geometry and clipping ancestors, without hiding overflow in host CSS. */
async function expectLayout(page: Page) {
  await expect
    .poll(() =>
      page.evaluate(() => ({
        width: document.documentElement.clientWidth,
        scroll: document.documentElement.scrollWidth
      }))
    )
    .toEqual({
      width: page.viewportSize()!.width,
      scroll: page.viewportSize()!.width
    });
  const clipped = await page
    .locator(
      'input:not([type="hidden"]), textarea, select, button, [role="button"]'
    )
    .evaluateAll((elements) => {
      const problems: string[] = [];
      for (const element of elements) {
        const rect = element.getBoundingClientRect();
        if (
          !rect.width ||
          !rect.height ||
          getComputedStyle(element).visibility === 'hidden'
        )
          continue;
        let left = rect.left;
        let right = rect.right;
        for (
          let parent = element.parentElement;
          parent;
          parent = parent.parentElement
        ) {
          const style = getComputedStyle(parent);
          const box = parent.getBoundingClientRect();
          // Offscreen table columns remain reachable through their own scrollport.
          // Test their visible intersection against outer clipping containers;
          // expectReachable separately scrolls every control fully into view.
          if (['auto', 'scroll'].includes(style.overflowX)) {
            left = Math.max(left, box.left);
            right = Math.min(right, box.right);
            if (right <= left) break;
          }
          if (!['hidden', 'clip'].includes(style.overflowX)) continue;
          if (left < box.left - 2 || right > box.right + 2) {
            problems.push(
              `${element.closest('[data-linkid]')?.getAttribute('data-linkid') ?? element.textContent}: ${style.overflowX} ${parent.tagName}`
            );
            break;
          }
        }
      }
      return problems;
    });
  expect(
    clipped,
    'Controls must not be cut off by a non-scrollable ancestor'
  ).toEqual([]);
}

async function expectReachable(control: Locator, page: Page) {
  await control.scrollIntoViewIfNeeded();
  // Field Clear buttons are shown on hover. Scrolling can move the
  // pointer out of its field, so establish that presentation before measuring.
  if ((await control.getAttribute('title')) === 'Clear') {
    const inputRoot = control.locator(
      'xpath=ancestor::*[contains(@class, "MuiInputBase-root")][1]'
    );
    if (await inputRoot.count()) await inputRoot.hover();
  }
  await expect(control).toBeVisible();
  const box = await control.boundingBox();
  expect(box!.width).toBeGreaterThan(0);
  expect(box!.x).toBeGreaterThanOrEqual(-1);
  expect(box!.y).toBeGreaterThanOrEqual(-1);
  expect(box!.y + box!.height).toBeLessThanOrEqual(
    page.viewportSize()!.height + 1
  );
  expect(box!.x + box!.width).toBeLessThanOrEqual(
    page.viewportSize()!.width + 1
  );
  // Trial click also rejects overlays and clipping, without changing an answer.
  if (await control.isEnabled()) await control.click({ trial: true });
}

test('S7 browser: navigation, answer persistence and structural controls remain reachable without page overflow', async ({
  page
}, testInfo) => {
  const small = testInfo.project.name === 'small-screen';
  const diagnostics: string[] = [];
  const terminology: { url: string; status: number }[] = [];
  page.on('pageerror', (error) =>
    diagnostics.push(`pageerror: ${error.message}`)
  );
  page.on('console', (message) => {
    if (!['error', 'warning'].includes(message.type())) return;
    // Existing narrow DIAG-S3-03 disposition remains Slice 8; messages stay visible in evidence.
    if (
      /Support for defaultProps will be removed from memo components|The final argument passed to use\w+ changed size between renders/.test(
        message.text()
      )
    ) {
      console.log(`DIAG-S3-03: ${message.text()}`);
    } else diagnostics.push(`${message.type()}: ${message.text()}`);
  });
  page.on('response', (response) => {
    if (/ontoserver.*\/(ValueSet|CodeSystem)\//.test(response.url())) {
      terminology.push({ url: response.url(), status: response.status() });
      if (!response.ok())
        diagnostics.push(
          `Terminology HTTP ${response.status()}: ${response.url()}`
        );
    }
  });
  page.on('requestfailed', (request) =>
    diagnostics.push(
      `requestfailed: ${request.url()} ${request.failure()?.errorText}`
    )
  );
  try {
    // Anchor Date only and let it advance against native performance/timers (Lodash debounce).
    await page.addInitScript(() => {
      const NativeDate = Date;
      const start = performance.now();
      const anchor = NativeDate.parse('2026-08-17T12:00:00+10:00');
      const now = () => anchor + performance.now() - start;
      window.Date = new Proxy(NativeDate, {
        construct(target, args) {
          return Reflect.construct(target, args.length ? args : [now()]);
        },
        apply() {
          return new NativeDate(now()).toString();
        },
        get(target, property, receiver) {
          return property === 'now'
            ? now
            : Reflect.get(target, property, receiver);
        }
      });
    });
    await page.goto('/browser/');
    await expect(page.getByTestId('toolkit-init-error')).toHaveCount(0);
    await expect(field(page, 'patient-name')).toHaveValue('Snow John', {
      timeout: 60000
    });
    await expect(page.getByTestId('save-button')).toBeVisible();

    for (const [index, id] of sections.entries()) {
      await openSection(page, id, small);
      const control = field(page, fields[index]);
      await expectReachable(control, page);
      if (index !== 1) await control.fill(values[index]);
      await expect(control).toHaveValue(values[index]);
      await expectSaved(page, fields[index], values[index]);
      if (id === 'plan') {
        const goals = page.getByRole('button', {
          name: 'Goals and tasks',
          exact: true
        });
        if ((await goals.getAttribute('aria-expanded')) === 'false')
          await goals.click();
      }
      for (const structure of structures[id as keyof typeof structures] ?? []) {
        const group = page.locator(`[data-linkid="${structure}"]`).first();
        await expect(group).toBeVisible();
        const controls = group.locator(
          'input:not([type="hidden"]), textarea, button'
        );
        expect(
          await controls.count(),
          `${structure} contains visible controls`
        ).toBeGreaterThan(0);
        for (const control of await controls.all()) {
          if (await control.isVisible()) await expectReachable(control, page);
        }
      }
      await expectLayout(page);
      await testInfo.attach(`${id}-${small ? '600' : '1280'}`, {
        body: await page.screenshot({ fullPage: true }),
        contentType: 'image/png'
      });
    }
    for (const [index, id] of sections.entries()) {
      await openSection(page, id, small);
      await expect(field(page, fields[index])).toHaveValue(values[index]);
      await expectSaved(page, fields[index], values[index]);
      if (small) {
        await sectionButton(page, id, true).click();
        await expect(sectionButton(page, id, true)).toHaveAttribute(
          'aria-expanded',
          'false'
        );
        await expect(field(page, fields[index])).toHaveCount(0);
        await expectSaved(page, fields[index], values[index]);
      }
    }
    const requests = await page.evaluate(() => window.gpccmp.clinicalRequests);
    expect(requests.length).toBeGreaterThan(0);
    expect(requests.filter((request) => !request.matched)).toEqual([]);
    expect(
      terminology.length,
      'Real browser terminology requests must run'
    ).toBeGreaterThan(0);
    expect(diagnostics).toEqual([]);
  } finally {
    const requests = await page
      .evaluate(() => window.gpccmp?.clinicalRequests)
      .catch((error) => ({ observationError: String(error) }));
    await testInfo.attach('requests-and-diagnostics', {
      body: JSON.stringify({ requests, terminology, diagnostics }, null, 2),
      contentType: 'application/json'
    });
  }
});
