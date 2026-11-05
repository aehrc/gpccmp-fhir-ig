import { getConfig } from '@testing-library/react';

/** Exact linkId selection. Repeat collections must be explicitly scoped by the caller. */
export function queryItems(scope: ParentNode, linkId: string): HTMLElement[] {
  // Compare attributes rather than interpolating an unescaped linkId into a CSS selector.
  const matches = Array.from(
    scope.querySelectorAll<HTMLElement>('[data-linkid]')
  ).filter((element) => element.getAttribute('data-linkid') === linkId);
  // String/choice controls repeat their ID on nested field markup. Count logical
  // roots once, while preserving distinct sibling repeat instances. Desktop tab
  // navigation also carries the panel ID; selectTab owns that separate control.
  return matches.filter(
    (element) =>
      !matches.some(
        (ancestor) => ancestor !== element && ancestor.contains(element)
      ) &&
      (element.hasAttribute('data-test') ||
        !element.querySelector('[id^="tab-"]'))
  );
}

export function queryItem(
  scope: ParentNode,
  linkId: string
): HTMLElement | undefined {
  const matches = queryItems(scope, linkId);
  if (matches.length > 1) {
    throw new Error(
      `Item "${linkId}" matched ${matches.length} elements; provide a repeat-instance scope`
    );
  }
  return matches[0];
}

export function requireItem(scope: ParentNode, linkId: string): HTMLElement {
  const item = queryItem(scope, linkId);
  if (!item)
    throw new Error(
      `Required item "${linkId}" was not found in the supplied scope`
    );
  return item;
}

/**
 * Initialization errors reject immediately, independently of the readiness timeout.
 *
 * The toolkit wrapper initializes asynchronously, so the renderer mounts while this waits. Run
 * the wait through Testing Library's configured asyncWrapper, the same lifecycle `waitFor` uses,
 * so React treats that mount as asynchronous test work rather than an update outside act().
 */
export function waitForFormReady(
  container: HTMLElement,
  itemIds: readonly string[],
  {
    timeoutMs = 10_000,
    ready = () => true
  }: { timeoutMs?: number; ready?: () => boolean } = {}
): Promise<void> {
  if (itemIds.length === 0)
    return Promise.reject(new Error('Readiness requires an expected item ID'));
  return getConfig().asyncWrapper(
    () =>
      new Promise<void>((resolve, reject) => {
        let timer: ReturnType<typeof setTimeout>;
        const observer = new MutationObserver(check);
        function finish(error?: Error) {
          observer.disconnect();
          clearTimeout(timer);
          if (error) reject(error);
          else resolve();
        }
        function check() {
          try {
            const error = container.querySelector(
              '[data-testid="toolkit-init-error"]'
            );
            if (error)
              throw new Error(
                `Toolkit initialization failed: ${error.textContent?.trim()}`
              );
            const save = container.querySelector('[data-testid="save-button"]');
            if (
              save &&
              itemIds.every((id) => queryItem(container, id)) &&
              ready()
            )
              finish();
          } catch (error) {
            finish(error instanceof Error ? error : new Error(String(error)));
          }
        }
        observer.observe(container, {
          childList: true,
          subtree: true,
          attributes: true,
          characterData: true
        });
        timer = setTimeout(
          () =>
            finish(
              new Error(
                `Form readiness timed out waiting for ${itemIds.join(', ')}`
              )
            ),
          timeoutMs
        );
        check();
      })
  );
}
