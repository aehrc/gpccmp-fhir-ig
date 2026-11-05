import { defineConfig } from 'vitest/config';
import base from './vitest.config';

// The candidate-only checks use APIs that are not in the current registry release.
// They run in the isolated tarball consumer, not by silently replacing registry code.
export default defineConfig({
  ...base,
  test: {
    ...base.test,
    include: ['test/support.test.tsx', 'tooling/candidate/**/*.test.tsx']
  }
});
