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
  'Screen seven patient',
  'Jane Smith',
  'Screen seven observations',
  'Screen seven plan'
] as const;

function input(scope: HTMLElement, id: string) {
  const result = requireItem(scope, id).querySelector<
    HTMLInputElement | HTMLTextAreaElement
  >('input, textarea');
  if (!result) throw new Error(`Missing input ${id}`);
  return result;
}

async function editOrCheck(container: HTMLElement, index: number) {
  if (index !== 1) await inputText(container, fields[index], values[index]);
  await waitFor(() => {
    expect(input(container, fields[index]).value).toBe(values[index]);
    expectAnswers(fields[index], string(values[index]));
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
    for (const [index, id] of sections.entries()) {
      await selectTab(container, id);
      const panel = within(container).getByRole('tabpanel');
      expect(panel.id).toBe(`tabpanel-${index}`);
      expect(panel.getAttribute('aria-labelledby')).toBe(`tab-${index}`);
      expect(panel.querySelector(`[data-linkid="${id}"]`)).not.toBeNull();
      await editOrCheck(container, index);
    }
    for (const [index, id] of sections.entries()) {
      await selectTab(container, id);
      expect(input(container, fields[index]).value).toBe(values[index]);
      expectAnswers(fields[index], string(values[index]));
    }
  });

  it('S7 resize: selected section and answers survive desktop/small-screen/desktop transitions', async () => {
    const viewport = installViewport(DESKTOP);
    try {
      const { container } = await renderGpccmp();
      await selectTab(container, 'plan');
      await editOrCheck(container, 3);
      await act(async () => viewport.set(SMALL_SCREEN));
      await waitFor(() =>
        expect(
          sectionButton(container, 'plan').getAttribute('aria-expanded')
        ).toBe('true')
      );
      expect(
        container.querySelector('[data-test="renderer-tab-list"]')
      ).toBeNull();
      expect(input(container, fields[3]).value).toBe(values[3]);
      await act(async () => viewport.set(DESKTOP));
      await waitFor(() =>
        expect(within(container).getByRole('tabpanel').id).toBe('tabpanel-3')
      );
      expect(input(container, fields[3]).value).toBe(values[3]);
      expectAnswers(fields[3], string(values[3]));
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
    for (const [index, id] of sections.entries()) {
      const button = sectionButton(container, id);
      if (button.getAttribute('aria-expanded') !== 'true')
        await act(async () => fireEvent.click(button));
      await waitFor(() => {
        for (const section of sections)
          expect(
            sectionButton(container, section).getAttribute('aria-expanded')
          ).toBe(String(section === id));
      });
      await editOrCheck(container, index);
      await act(async () => fireEvent.click(button));
      await waitFor(() => {
        expect(button.getAttribute('aria-expanded')).toBe('false');
        expect(
          container.querySelector(`[data-linkid="${fields[index]}"]`)
        ).toBeNull();
      });
      expectAnswers(fields[index], string(values[index]));
      await act(async () => fireEvent.click(button));
      await waitFor(() =>
        expect(input(container, fields[index]).value).toBe(values[index])
      );
      expectAnswers(fields[index], string(values[index]));
    }
  }, 90000);
});
