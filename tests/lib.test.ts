import { beforeAll, describe, expect, it } from 'vitest';

import { BoundedVec, Prover, Str, U8, toJSON } from '@zkpersona/noir-helpers';

import circuit from '../target/hmac_sha256_example.json' assert {
  type: 'json',
};

import type { CompiledCircuit } from '@noir-lang/noir_js';

const keyBytes = new Str('secret').asBytes();
const key = new BoundedVec(keyBytes.length, () => new U8(0));
key.extendFromArray(keyBytes);

const messageBytes = new Str('hello_world').asBytes();
const message = new BoundedVec(messageBytes.length, () => new U8(0));
message.extendFromArray(messageBytes);

const inputs = {
  key,
  message,
};

describe('Circuit Proof Verification', () => {
  let prover: Prover;

  beforeAll(() => {
    prover = new Prover(circuit as CompiledCircuit, { type: 'all' });
  });

  it('should prove using honk backend', async () => {
    const parsedInputs = toJSON(inputs);
    const proof = await prover.fullProve(parsedInputs, { type: 'honk' });
    const isVerified = await prover.verify(proof, { type: 'honk' });

    expect(isVerified).toBe(true);
  });

  it('should prove using plonk backend', async () => {
    const parsedInputs = toJSON(inputs);
    const proof = await prover.fullProve(parsedInputs, { type: 'plonk' });
    const isVerified = await prover.verify(proof, { type: 'plonk' });

    expect(isVerified).toBe(true);
  });
});
