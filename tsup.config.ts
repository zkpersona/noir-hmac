import { defineConfig } from 'tsup';

export default defineConfig({
  entry: ['src/index.ts'],
  splitting: true,
  clean: true,
  format: ['esm'],
  treeshake: true,
  dts: true,
  sourcemap: 'inline',
  target: 'esnext',
  shims: true,
});
