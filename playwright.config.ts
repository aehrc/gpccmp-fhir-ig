import { defineConfig } from '@playwright/test';

export default defineConfig({
  testDir: './browser',
  testMatch: '**/*.spec.ts',
  fullyParallel: false,
  workers: 1,
  retries: 0,
  timeout: 180000,
  expect: { timeout: 15000 },
  reporter: [
    ['list'],
    ['json', { outputFile: 'browser-results/results.json' }]
  ],
  outputDir: 'browser-results/artifacts',
  use: {
    baseURL: 'http://127.0.0.1:4173',
    browserName: 'chromium',
    timezoneId: 'Australia/Sydney',
    actionTimeout: 15000,
    trace: 'retain-on-failure',
    screenshot: 'only-on-failure'
  },
  projects: [
    { name: 'desktop', use: { viewport: { width: 1280, height: 900 } } },
    { name: 'small-screen', use: { viewport: { width: 600, height: 900 } } }
  ],
  webServer: {
    command: 'npm run browser:serve',
    url: 'http://127.0.0.1:4173/browser/',
    reuseExistingServer: false
  }
});
