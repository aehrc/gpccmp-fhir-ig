import { createRequire } from 'node:module';
import { defineConfig } from 'vite';

const require = createRequire(import.meta.url);
export default defineConfig({
  resolve: {
    alias: [
      {
        find: /^fhirclient$/,
        replacement: require.resolve('fhirclient/lib/entry/browser.js')
      }
    ]
  },
  server: { host: '127.0.0.1', port: 4173, strictPort: true }
});
