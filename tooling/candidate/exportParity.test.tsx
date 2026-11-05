import { expect, test } from 'vitest';
import path from 'node:path';

test('compiled ESM and CommonJS public entries expose the same runtime API in a browser consumer', async () => {
  const root = path.resolve('.candidate-check');
  const esm = await import(/* @vite-ignore */ path.join(root, 'esm.mjs'));
  const cjs = (await import(/* @vite-ignore */ path.join(root, 'cjs.mjs')))
    .default;
  expect(Object.keys(esm).sort()).toEqual(Object.keys(cjs).sort());
  for (const name of [
    'BehavioralTestWrapper',
    'inputText',
    'addRepeatInstance',
    'removeRepeatInstance'
  ]) {
    expect(typeof esm[name]).toBe('function');
    expect(typeof cjs[name]).toBe('function');
  }
});
