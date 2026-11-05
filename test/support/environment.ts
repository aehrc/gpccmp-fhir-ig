import { afterEach, beforeEach, vi } from 'vitest';

export const FIXED_NOW = '2026-08-17T12:00:00+10:00';
export const DESKTOP = { width: 1280, height: 900 };
export const SMALL_SCREEN = { width: 600, height: 900 };
export type Viewport = typeof DESKTOP;

// Implements MUI dimensions and a fixed mouse pointer for its date/time pickers.
// Reject unsupported media features explicitly; this does not simulate browser geometry.
function mediaMatches(query: string, viewport: Viewport): boolean {
  return query
    .replace(/^@media\s*/, '')
    .split(',')
    .map((alternative) => {
      let text = alternative.trim();
      const negate = text.startsWith('not ');
      if (negate) text = text.slice(4);
      const result = text
        .split(/\s+and\s+/)
        .map((part) => {
          if (part === 'all' || part === 'screen') return true;
          if (part === 'print') return false;
          if (
            [
              '(pointer: fine)',
              '(hover: hover)',
              '(prefers-reduced-motion: no-preference)'
            ].includes(part)
          )
            return true;
          if (
            [
              '(pointer: coarse)',
              '(pointer: none)',
              '(hover: none)',
              '(prefers-reduced-motion: reduce)'
            ].includes(part)
          )
            return false;
          const dimension =
            /^\((min|max)-(width|height):\s*(\d+(?:\.\d+)?)px\)$/.exec(part);
          if (!dimension)
            throw new Error(`Unsupported test media query: ${query}`);
          const current =
            dimension[2] === 'width' ? viewport.width : viewport.height;
          return dimension[1] === 'min'
            ? current >= Number(dimension[3])
            : current <= Number(dimension[3]);
        })
        .every(Boolean);
      return negate ? !result : result;
    })
    .some(Boolean);
}

export function installViewport(initial: Viewport = DESKTOP) {
  let viewport = { ...initial };
  const lists: TestMediaQueryList[] = [];
  const saved = ['innerWidth', 'innerHeight', 'matchMedia', 'scrollTo'].map(
    (key) => [key, Object.getOwnPropertyDescriptor(window, key)] as const
  );
  class TestMediaQueryList extends EventTarget implements MediaQueryList {
    readonly media: string;
    onchange: MediaQueryList['onchange'] = null;
    constructor(query: string) {
      super();
      this.media = query;
      mediaMatches(query, viewport);
    }
    get matches() {
      return mediaMatches(this.media, viewport);
    }
    addListener(callback: Parameters<MediaQueryList['addListener']>[0]) {
      if (callback) this.addEventListener('change', callback as EventListener);
    }
    removeListener(callback: Parameters<MediaQueryList['removeListener']>[0]) {
      if (callback)
        this.removeEventListener('change', callback as EventListener);
    }
    changed() {
      const event = new Event('change');
      Object.defineProperties(event, {
        media: { value: this.media },
        matches: { value: this.matches }
      });
      this.dispatchEvent(event);
      this.onchange?.call(this, event as MediaQueryListEvent);
    }
  }
  Object.defineProperties(window, {
    innerWidth: { configurable: true, get: () => viewport.width },
    innerHeight: { configurable: true, get: () => viewport.height },
    // jsdom cannot scroll; actual geometry is checked by the later browser slice.
    scrollTo: { configurable: true, value: () => {} },
    matchMedia: {
      configurable: true,
      value: (query: string) => {
        const list = new TestMediaQueryList(query);
        lists.push(list);
        return list;
      }
    }
  });
  return {
    set(next: Viewport) {
      const previous = lists.map((list) => list.matches);
      viewport = { ...next };
      lists.forEach((list, index) => {
        if (list.matches !== previous[index]) list.changed();
      });
      window.dispatchEvent(new Event('resize'));
    },
    restore() {
      for (const [key, descriptor] of saved) {
        if (descriptor) Object.defineProperty(window, key, descriptor);
        else Reflect.deleteProperty(window, key);
      }
    }
  };
}

/** Apply the same anchored calendar and explicit viewport to each form suite. */
export function useFormEnvironment(viewport: Viewport = DESKTOP) {
  let restoreViewport: (() => void) | undefined;
  beforeEach(() => {
    if (
      Intl.DateTimeFormat().resolvedOptions().timeZone !== 'Australia/Sydney'
    ) {
      throw new Error('Run form tests with TZ=Australia/Sydney');
    }
    // Lodash debounce compares Date.now() with native timer deadlines. A fully
    // frozen Date would reschedule forever; advance only Date with real elapsed time.
    vi.useFakeTimers({
      toFake: ['Date'],
      shouldAdvanceTime: true,
      advanceTimeDelta: 20
    });
    vi.setSystemTime(new Date(FIXED_NOW));
    restoreViewport = installViewport(viewport).restore;
  });
  afterEach(() => {
    restoreViewport?.();
    vi.useRealTimers();
  });
}
