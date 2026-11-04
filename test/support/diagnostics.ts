/**
 * Console diagnostics gate (plan criterion 7). Every console warning and error calls through, so
 * it stays in the log, and fails the test unless it is one of these exact, tracked exceptions.
 */
export const trackedConsoleExceptions = [
  {
    // DIAG-S8-01: react-beautiful-dnd 13.1.1, a renderer dependency deprecated upstream,
    // declares defaultProps on its memoised Connect(Droppable). React 18.3 reports it once per
    // module load. Accepted on 4 November 2026 until the renderer replaces the dependency.
    id: 'DIAG-S8-01',
    format:
      'Warning: %s: Support for defaultProps will be removed from memo components in a future major release. Use JavaScript default parameters instead.%s',
    component: 'Connect(Droppable)'
  }
] as const;

/** Match console arguments; only React's trailing component stack may vary. */
export function trackedConsoleException(args: readonly unknown[]) {
  return trackedConsoleExceptions.find(
    (exception) =>
      args.length === 3 &&
      args[0] === exception.format &&
      args[1] === exception.component &&
      typeof args[2] === 'string'
  );
}

/** Console calls recorded by the gate in test/setup.ts for the current test. */
export const consoleDiagnostics: unknown[][] = [];

/**
 * Remove and return the diagnostics a case deliberately provokes, so the case asserts them and
 * the gate still fails every other message.
 */
export function takeConsoleDiagnostics(match: (message: string) => boolean) {
  const taken: string[] = [];
  for (let i = consoleDiagnostics.length - 1; i >= 0; i--) {
    const message = consoleDiagnostics[i].map(String).join(' ');
    if (match(message)) {
      taken.unshift(message);
      consoleDiagnostics.splice(i, 1);
    }
  }
  return taken;
}

/** Browser console text is the space-joined arguments, ending with the component stack. */
export function trackedBrowserConsoleException(text: string) {
  return trackedConsoleExceptions.find((exception) =>
    text.startsWith(`${exception.format} ${exception.component} \n`)
  );
}
