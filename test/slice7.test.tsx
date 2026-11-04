import { act, fireEvent, waitFor, within } from '@testing-library/react';
import { inputText, selectTab } from '@aehrc/questionnaire-test-toolkit';
import { renderGpccmp } from './support/form';
import { requireItem } from './support/items';
import {
  useFormEnvironment,
  installViewport,
  DESKTOP,
  SMALL_SCREEN
} from './support/environment';
import { expectAnswers, string, useControlDiagnostics } from './support/slice6';

import { navigationScenarios, sections } from './support/navigation';

function input(scope: HTMLElement, id: string) {
  const result = requireItem(scope, id).querySelector<
    HTMLInputElement | HTMLTextAreaElement
  >('input, textarea');
  if (!result) throw new Error(`Missing input ${id}`);
  return result;
}

async function editOrCheck(
  container: HTMLElement,
  scenario: (typeof navigationScenarios)[number]
) {
  if (scenario.editable)
    await inputText(container, scenario.field, scenario.value);
  await waitFor(() => {
    expect(input(container, scenario.field).value).toBe(scenario.value);
    expectAnswers(scenario.field, string(scenario.value));
  });
}

function sectionButton(container: HTMLElement, id: string) {
  const section = container.querySelector<HTMLElement>(
    `[data-test="renderer-accordion"][data-linkid="${id}"]`
  );
  if (!section) throw new Error(`Missing section ${id}`);
  // Only the top-level summary, not nested accordions or form controls.
  return within(section).getAllByRole('button')[0];
}

describe('S7 desktop navigation', () => {
  useFormEnvironment(DESKTOP);
  useControlDiagnostics();

  it('S7 desktop: all four exact panels preserve edited and populated raw/cleaned answers', async () => {
    const { container } = await renderGpccmp();
    expect(
      container.querySelectorAll('[data-test="renderer-tab-list"]')
    ).toHaveLength(1);
    expect(
      container.querySelectorAll(
        '[data-test="renderer-accordion"][data-linkid="patient"]'
      )
    ).toHaveLength(0);
    for (const [index, scenario] of navigationScenarios.entries()) {
      const id = scenario.section;
      await selectTab(container, id);
      const panel = within(container).getByRole('tabpanel');
      expect(panel.id).toBe(`tabpanel-${index}`);
      expect(panel.getAttribute('aria-labelledby')).toBe(`tab-${index}`);
      expect(panel.querySelector(`[data-linkid="${id}"]`)).not.toBeNull();
      // Only the selected panel is shown, and it holds no other section's content.
      expect(
        [...container.querySelectorAll<HTMLElement>('[role="tabpanel"]')].map(
          (element) => element.hidden
        )
      ).toEqual(sections.map((section) => section !== id));
      for (const other of sections)
        if (other !== id)
          expect(panel.querySelector(`[data-linkid="${other}"]`)).toBeNull();
      await editOrCheck(container, scenario);
    }
    for (const scenario of navigationScenarios) {
      const id = scenario.section;
      await selectTab(container, id);
      expect(input(container, scenario.field).value).toBe(scenario.value);
      expectAnswers(scenario.field, string(scenario.value));
    }
  });

  it('S7 resize: selected section and answers survive desktop/small-screen/desktop transitions', async () => {
    const viewport = installViewport(DESKTOP);
    try {
      const { container } = await renderGpccmp();
      const plan = navigationScenarios.find(
        (scenario) => scenario.section === 'plan'
      )!;
      await selectTab(container, plan.section);
      await editOrCheck(container, plan);
      await act(async () => viewport.set(SMALL_SCREEN));
      await waitFor(() =>
        expect(
          sectionButton(container, 'plan').getAttribute('aria-expanded')
        ).toBe('true')
      );
      expect(
        container.querySelector('[data-test="renderer-tab-list"]')
      ).toBeNull();
      expect(input(container, plan.field).value).toBe(plan.value);
      await act(async () => viewport.set(DESKTOP));
      await waitFor(() =>
        expect(within(container).getByRole('tabpanel').id).toBe('tabpanel-3')
      );
      expect(input(container, plan.field).value).toBe(plan.value);
      expectAnswers(plan.field, string(plan.value));
    } finally {
      viewport.restore();
    }
  });
});

describe('S7 smaller-screen sections', () => {
  useFormEnvironment(SMALL_SCREEN);
  useControlDiagnostics();

  it('S7 small-screen: all four sections expand/collapse, isolate content and retain raw/cleaned answers', async () => {
    const { container } = await renderGpccmp();
    expect(
      container.querySelector('[data-test="renderer-tab-list"]')
    ).toBeNull();
    for (const scenario of navigationScenarios) {
      const id = scenario.section;
      const button = sectionButton(container, id);
      if (button.getAttribute('aria-expanded') !== 'true')
        await act(async () => fireEvent.click(button));
      await waitFor(() => {
        for (const section of sections)
          expect(
            sectionButton(container, section).getAttribute('aria-expanded')
          ).toBe(String(section === id));
      });
      await editOrCheck(container, scenario);
      await act(async () => fireEvent.click(button));
      await waitFor(() => {
        expect(button.getAttribute('aria-expanded')).toBe('false');
        expect(
          container.querySelector(`[data-linkid="${scenario.field}"]`)
        ).toBeNull();
      });
      expectAnswers(scenario.field, string(scenario.value));
      await act(async () => fireEvent.click(button));
      await waitFor(() =>
        expect(input(container, scenario.field).value).toBe(scenario.value)
      );
      expectAnswers(scenario.field, string(scenario.value));
    }
  }, 90000);
});
