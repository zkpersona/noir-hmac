import { beforeAll, describe, expect, it } from 'vitest';

import { Prover } from '@zkpersona/noir-helpers';

import circuit from '../target/lib_test.json' assert { type: 'json' };

import type { CompiledCircuit } from '@noir-lang/noir_js';

const inputs = { x: '1', y: '2' };

describe('Circuit Proof Verification', () => {
  let prover: Prover;

  beforeAll(() => {
    prover = new Prover(circuit as CompiledCircuit, { type: 'all' });
  });

  it('should prove using honk backend', async () => {
    const proof = await prover.fullProve(inputs, { type: 'honk' });
    const isVerified = await prover.verify(proof, { type: 'honk' });

    expect(isVerified).toBe(true);
  });

  it('should prove using plonk backend', async () => {
    const proof = await prover.fullProve(inputs, { type: 'plonk' });
    const isVerified = await prover.verify(proof, { type: 'plonk' });

    expect(isVerified).toBe(true);
  });
});
