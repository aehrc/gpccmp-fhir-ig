import { afterEach, beforeEach, expect } from 'vitest';
import { cleanup } from '@testing-library/react';
import { destroyForm } from '@aehrc/smart-forms-renderer';
import {
  consoleDiagnostics,
  trackedConsoleException
} from './support/diagnostics';

// jsdom has no ResizeObserver; the renderer's layout components require one.
globalThis.ResizeObserver = class ResizeObserver {
  observe() {}
  unobserve() {}
  disconnect() {}
};

// Diagnostics gate for every suite. Registered first, so with Vitest's stacked hooks its
// afterEach runs last and also sees diagnostics from unmounting. Messages call through.
let restoreConsole = () => {};
beforeEach(() => {
  consoleDiagnostics.length = 0;
  const { warn, error } = console;
  console.warn = (...args: unknown[]) => {
    consoleDiagnostics.push(args);
    warn(...args);
  };
  console.error = (...args: unknown[]) => {
    consoleDiagnostics.push(args);
    error(...args);
  };
  restoreConsole = () => {
    console.warn = warn;
    console.error = error;
  };
});
afterEach(() => {
  restoreConsole();
  const unexpected = consoleDiagnostics
    .filter((args) => !trackedConsoleException(args))
    .map((args) => args.map(String).join(' '));
  expect(unexpected, 'Unexpected console diagnostics').toEqual([]);
});

// The renderer keeps form state in module-level stores that outlive an unmounted component, so
// every test in a file shares them. buildForm happens to overwrite all of them but
// formChangesHistory, which makes the isolation an accident of renderer internals rather than
// something these tests ask for. destroyForm is the documented lifecycle — the application calls
// it before building a new form — so call it here and stop depending on the accident.
beforeEach(() => {
  destroyForm();
});

afterEach(() => {
  cleanup();
  destroyForm();
});
