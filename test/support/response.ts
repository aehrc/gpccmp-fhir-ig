import type { QuestionnaireResponse, QuestionnaireResponseItem } from 'fhir/r4';
import { getResponse } from '@aehrc/smart-forms-renderer';

export interface ResponseStep {
  linkId: string;
  /** Required when more than one sibling group has this linkId. Zero-based. */
  occurrence?: number;
  /** Descend through this answer's item, rather than the current item's item. */
  answer?: number;
}

/** Full hierarchical paths, never a global first-match search or a label fallback. */
export function queryResponseItem(
  steps: readonly ResponseStep[],
  response: QuestionnaireResponse = getResponse()
): QuestionnaireResponseItem | undefined {
  if (steps.length === 0)
    throw new Error('Response path must contain at least one item');
  let siblings = response.item ?? [];
  let selected: QuestionnaireResponseItem | undefined;
  for (const [index, step] of steps.entries()) {
    const matches = siblings.filter((item) => item.linkId === step.linkId);
    if (
      step.occurrence !== undefined &&
      (!Number.isInteger(step.occurrence) || step.occurrence < 0)
    ) {
      throw new Error(
        `Invalid occurrence for "${step.linkId}": ${step.occurrence}`
      );
    }
    if (matches.length === 0) return undefined;
    if (matches.length > 1 && step.occurrence === undefined) {
      throw new Error(
        `Response item "${step.linkId}" has ${matches.length} instances; specify occurrence`
      );
    }
    selected = matches[step.occurrence ?? 0];
    if (!selected)
      throw new Error(
        `Response occurrence ${step.occurrence} of "${step.linkId}" was not found`
      );
    if (index < steps.length - 1) {
      if (step.answer !== undefined) {
        if (!Number.isInteger(step.answer) || step.answer < 0)
          throw new Error(`Invalid answer index for "${step.linkId}"`);
        const answer = selected.answer?.[step.answer];
        if (!answer)
          throw new Error(
            `Answer ${step.answer} of "${step.linkId}" was not found`
          );
        siblings = answer.item ?? [];
      } else {
        if (selected.answer?.some((answer) => answer.item?.length)) {
          throw new Error(
            `Response item "${step.linkId}" has answer children; specify answer index`
          );
        }
        siblings = selected.item ?? [];
      }
    } else if (step.answer !== undefined) {
      throw new Error(
        'Answer index selects a child-item path; omit it on the final step'
      );
    }
  }
  return selected;
}

export function requireResponseItem(
  steps: readonly ResponseStep[],
  response = getResponse()
): QuestionnaireResponseItem {
  const item = queryResponseItem(steps, response);
  if (!item)
    throw new Error(
      `Required response path missing: ${steps.map((step) => step.linkId).join(' / ')}`
    );
  return item;
}
