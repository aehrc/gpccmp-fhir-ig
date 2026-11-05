import type {
  Questionnaire,
  QuestionnaireItem,
  QuestionnaireResponse,
  QuestionnaireResponseItem,
  QuestionnaireResponseItemAnswer
} from 'fhir/r4';
import { act, fireEvent, within } from '@testing-library/react';
import { getResponse } from '@aehrc/smart-forms-renderer';
import generated from '../../fsh-generated/resources/Questionnaire-GPChronicConditionManagementPlan.json';
import { queryResponseItem, type ResponseStep } from './response';
import { responseForPersistence } from './form';

export const nodes: {
  item: QuestionnaireItem;
  path: string[];
}[] = [];
function walk(items: QuestionnaireItem[], parent: string[] = []) {
  for (const item of items) {
    const path = [...parent, item.linkId];
    nodes.push({ item, path });
    walk(item.item ?? [], path);
  }
}
walk((generated as Questionnaire).item ?? []);
export function node(id: string) {
  const found = nodes.find((n) => n.item.linkId === id);
  if (!found) throw new Error(`Unknown Questionnaire item ${id}`);
  return found;
}
export function path(
  id: string,
  occurrences: Record<string, number> = {}
): ResponseStep[] {
  return node(id).path.map((linkId) => ({
    linkId,
    occurrence: occurrences[linkId] ?? 0
  }));
}
export function answers(
  id: string,
  occurrences: Record<string, number> = {},
  response = getResponse()
) {
  return queryResponseItem(path(id, occurrences), response)?.answer ?? [];
}
export function expectAnswers(
  id: string,
  expected: QuestionnaireResponseItemAnswer[],
  occurrences: Record<string, number> = {}
) {
  expect(answers(id, occurrences), `${id}: raw`).toEqual(expected);
  if (expected.length === 0) {
    const raw = queryResponseItem(path(id, occurrences));
    expect(raw, `${id}: cleared raw item omitted`).toBeUndefined();
    expect(raw?.answer, `${id}: absent answer property`).toBeUndefined();
    expect(
      queryResponseItem(path(id, occurrences), responseForPersistence()),
      `${id}: cleaned empty item omitted`
    ).toBeUndefined();
  }
  expect(
    answers(id, occurrences, responseForPersistence()),
    `${id}: cleaned`
  ).toEqual(expected);
}
export function saved(
  values: {
    id: string;
    answer: QuestionnaireResponseItemAnswer[];
    occurrences?: Record<string, number>;
  }[]
): QuestionnaireResponse {
  const item: QuestionnaireResponseItem[] = [];
  for (const value of values) {
    let siblings = item;
    for (const [index, step] of path(value.id, value.occurrences).entries()) {
      let matches = siblings.filter((i) => i.linkId === step.linkId);
      while (matches.length <= step.occurrence!) {
        const created = { linkId: step.linkId };
        siblings.push(created);
        matches = siblings.filter((i) => i.linkId === step.linkId);
      }
      const current = matches[step.occurrence!]!;
      if (index === node(value.id).path.length - 1)
        current.answer = structuredClone(value.answer);
      else siblings = current.item ??= [];
    }
  }
  return { resourceType: 'QuestionnaireResponse', status: 'in-progress', item };
}
export const string = (valueString: string) => [{ valueString }];
export const sct = (code: string, display: string) => ({
  system: 'http://snomed.info/sct',
  code,
  display
});

/** Call through; only the inherited, explicitly deferred DIAG-S3-03 is accepted. */
/** Open the exact plan accordion before interacting with its repeated instances. */
export async function openGoals(container: HTMLElement) {
  const summary = within(container)
    .getByText('Goals and tasks', { exact: true })
    .closest<HTMLElement>('[aria-expanded]');
  if (summary?.getAttribute('aria-expanded') === 'false')
    await act(async () => {
      fireEvent.click(summary);
    });
}

export function expectGroupCount(
  id: string,
  count: number,
  occurrences: Record<string, number> = {}
) {
  const parentPath = path(id, occurrences).slice(0, -1);
  for (const response of [getResponse(), responseForPersistence()]) {
    const siblings = parentPath.length
      ? queryResponseItem(parentPath, response)?.item
      : response.item;
    expect(
      siblings?.filter((item) => item.linkId === id) ?? [],
      `${id}: raw/cleaned collection size`
    ).toHaveLength(count);
  }
}
