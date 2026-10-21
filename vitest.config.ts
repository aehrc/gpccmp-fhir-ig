import { defineConfig } from 'vitest/config';

export default defineConfig({
  optimizeDeps: {
    include: ['react/jsx-dev-runtime']
  },
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: ['./test/setup.ts'],
    include: ['test/**/*.test.tsx'],
    fileParallelism: false,
    testTimeout: 40000,
    server: {
      deps: {
        // Installed packages need Vite's CSS and directory-import handling.
        // Workspace symlinks in Smart Forms previously provided this implicitly.
        inline: [/@aehrc\//, /@fontsource/]
      }
    }
  }
});
