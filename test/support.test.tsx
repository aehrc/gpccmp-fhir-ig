import { describe, expect, test, vi } from 'vitest';
import type { QuestionnaireResponse } from 'fhir/r4';
import { createClinicalAdapter } from './support/clinicalRequests';
import {
  DESKTOP,
  FIXED_NOW,
  installViewport,
  SMALL_SCREEN,
  useFormEnvironment
} from './support/environment';
import {
  queryItem,
  queryItems,
  requireItem,
  waitForFormReady
} from './support/items';
import { queryResponseItem, requireResponseItem } from './support/response';

useFormEnvironment();

describe('IG support contracts', () => {
  test('anchors Sydney Date while allowing debounce time and asynchronous timers to advance', async () => {
    const started = Date.now();
    expect(started).toBeGreaterThanOrEqual(new Date(FIXED_NOW).getTime());
    expect(started - new Date(FIXED_NOW).getTime()).toBeLessThan(1000);
    expect(new Date().getDate()).toBe(17);
    await new Promise((resolve) => setTimeout(resolve, 60));
    expect(Date.now()).toBeGreaterThan(started);
    expect(new Date().getDate()).toBe(17);
  });

  test('evaluates renderer breakpoints and notifies subscribers on viewport changes', () => {
    const viewport = installViewport(DESKTOP);
    try {
      const media = window.matchMedia('(min-width:900px)');
      const listener = vi.fn();
      media.addEventListener('change', listener);
      expect(media.matches).toBe(true);
      expect(window.matchMedia('(pointer: fine)').matches).toBe(true);
      viewport.set({ width: 900, height: 900 });
      expect(listener).not.toHaveBeenCalled();
      viewport.set({ width: 899, height: 900 });
      expect(media.matches).toBe(false);
      expect(listener).toHaveBeenCalledTimes(1);
      viewport.set(SMALL_SCREEN);
      expect(window.innerWidth).toBe(600);
      expect(
        window.matchMedia('(min-width:600px) and (max-width:899.95px)').matches
      ).toBe(true);
      expect(() => window.matchMedia('(unknown-feature: yes)')).toThrow(
        'Unsupported test media query'
      );
    } finally {
      viewport.restore();
    }
    expect(window.innerWidth).toBe(DESKTOP.width);
  });

  test('distinguishes missing, unique and repeated items without label fallback', () => {
    const scope = document.createElement('div');
    scope.innerHTML =
      '<div data-label="patient-name"></div><section data-linkid="patient-contacts"><div data-linkid="patient-contacts-name"></div></section><section data-linkid="patient-contacts"><div data-linkid="patient-contacts-name"></div></section>';
    expect(queryItem(scope, 'patient-name')).toBeUndefined();
    expect(() => requireItem(scope, 'patient-name')).toThrow('was not found');
    expect(queryItems(scope, 'patient-contacts')).toHaveLength(2);
    expect(() => requireItem(scope, 'patient-contacts-name')).toThrow(
      'repeat-instance scope'
    );
    expect(
      requireItem(
        queryItems(scope, 'patient-contacts')[1],
        'patient-contacts-name'
      )
    ).toBeInstanceOf(HTMLElement);
  });

  test('readiness requires the expected item and Save, and fails promptly on a later initialization alert', async () => {
    const container = document.createElement('div');
    container.innerHTML = '<div data-linkid="patient"></div>';
    const waiting = waitForFormReady(container, ['patient'], {
      timeoutMs: 1000
    });
    setTimeout(() => {
      container.innerHTML =
        '<div role="alert" data-testid="toolkit-init-error">Unexpected clinical request: Condition</div>';
    }, 5);
    await expect(waiting).rejects.toThrow(
      'Toolkit initialization failed: Unexpected clinical request: Condition'
    );
    container.innerHTML =
      '<div data-linkid="patient"></div><button data-testid="save-button">Save</button>';
    await waitForFormReady(container, ['patient']);
    container.innerHTML += '<div data-linkid="patient"></div>';
    await expect(waitForFormReady(container, ['patient'])).rejects.toThrow(
      'repeat-instance scope'
    );
  });

  test('item roots exclude nested field metadata and the separate desktop tab control', () => {
    const scope = document.createElement('div');
    scope.innerHTML =
      '<div data-linkid="patient"><button><span id="tab-0">Patient details</span></button></div><div data-linkid="patient" data-test="q-item-group-box"><div data-linkid="patient-name" data-test="q-item-string-box"><div data-linkid="patient-name" data-test="q-item-string-field"></div></div></div>';
    expect(queryItems(scope, 'patient')).toHaveLength(1);
    expect(requireItem(scope, 'patient-name').getAttribute('data-test')).toBe(
      'q-item-string-box'
    );
  });

  test('response paths isolate nested group and answer instances, preserving absent versus empty', () => {
    const response: QuestionnaireResponse = {
      resourceType: 'QuestionnaireResponse',
      status: 'in-progress',
      item: [
        {
          linkId: 'plan-goalstasks',
          item: [
            {
              linkId: 'plan-goalstasks-problemneed',
              answer: [{ valueString: 'first' }]
            }
          ]
        },
        {
          linkId: 'plan-goalstasks',
          item: [
            { linkId: 'plan-goalstasks-problemneed', answer: [] },
            {
              linkId: 'plan-goalstasks-details-goalsetting',
              item: [
                {
                  linkId: 'plan-goalstasks-details-goalsetting-goals',
                  answer: [{ valueString: 'second outer goal' }]
                }
              ]
            }
          ]
        },
        {
          linkId: 'patient-contacts-role',
          answer: [
            { valueString: 'first' },
            {
              valueString: 'second',
              item: [
                {
                  linkId: 'patient-contacts-name',
                  answer: [{ valueString: 'second answer child' }]
                }
              ]
            }
          ]
        }
      ]
    };
    expect(() =>
      queryResponseItem([{ linkId: 'plan-goalstasks' }], response)
    ).toThrow('specify occurrence');
    expect(
      requireResponseItem(
        [
          { linkId: 'plan-goalstasks', occurrence: 1 },
          { linkId: 'plan-goalstasks-problemneed' }
        ],
        response
      ).answer
    ).toEqual([]);
    expect(
      queryResponseItem([{ linkId: 'missing' }], response)
    ).toBeUndefined();
    expect(
      requireResponseItem(
        [
          { linkId: 'plan-goalstasks', occurrence: 1 },
          { linkId: 'plan-goalstasks-details-goalsetting' },
          { linkId: 'plan-goalstasks-details-goalsetting-goals' }
        ],
        response
      ).answer
    ).toEqual([{ valueString: 'second outer goal' }]);
    expect(() =>
      queryResponseItem(
        [
          { linkId: 'patient-contacts-role' },
          { linkId: 'patient-contacts-name' }
        ],
        response
      )
    ).toThrow('specify answer index');
    expect(
      requireResponseItem(
        [
          { linkId: 'patient-contacts-role', answer: 1 },
          { linkId: 'patient-contacts-name' }
        ],
        response
      ).answer
    ).toEqual([{ valueString: 'second answer child' }]);
    expect(() =>
      queryResponseItem(
        [{ linkId: 'plan-goalstasks', occurrence: 2 }],
        response
      )
    ).toThrow('was not found');
  });

  test('clinical adapter normalizes encoding/order and rejects extra, missing, duplicate or different requests', async () => {
    const query =
      'Condition?patient=patient-123&category=http://terminology.hl7.org/CodeSystem/condition-category|problem-list-item';
    const adapter = createClinicalAdapter([
      [query, { resourceType: 'Bundle', type: 'searchset', entry: [] }]
    ]);
    const config = { sourceServerUrl: 'http://mock.example' };
    const reordered =
      'Condition?category=http%3A%2F%2Fterminology.hl7.org%2FCodeSystem%2Fcondition-category%7Cproblem-list-item&patient=patient-123';
    expect(await adapter.callback(reordered, config)).toEqual({
      resourceType: 'Bundle',
      type: 'searchset',
      entry: []
    });
    for (const unexpected of [
      query + '&extra=x',
      query + '&patient=patient-123',
      'Condition?patient=patient-123',
      query.replace('Condition?', 'ConditionHistory?')
    ]) {
      await expect(adapter.callback(unexpected, config)).rejects.toThrow(
        'Unexpected clinical request'
      );
    }
    expect(adapter.requests.map((r) => r.matched)).toEqual([
      true,
      false,
      false,
      false,
      false
    ]);
    expect(() =>
      createClinicalAdapter([
        [query, { resourceType: 'Patient' }],
        [reordered, { resourceType: 'Patient' }]
      ])
    ).toThrow('Duplicate clinical fixture');
  });
});
