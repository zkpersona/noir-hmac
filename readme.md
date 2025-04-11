# Noir HMAC(Hash-based Message Authentication Code)

Noir implementation of HMAC(Hash-based Message Authentication Code). Currently, the following hash functions are supported:

- SHA256

> Note: SHA512 will be supported in the future as soon as library is reviewed. See [noir-lang/sha512/pull/2](https://github.com/noir-lang/sha512/pull/2)

## Noir version compatibility

This library is tested to work as of Noir version >=1.0.0.beta-2

## Benchmarks

Benchmarks are ignored by `git` and checked on pull-request. As such, benchmarks may be generated
with the following command.

```bash
./scripts/build-gates-report.sh
```

The benchmark will be generated at `./gates_report.json`.

## Installation

In your _Nargo.toml_ file, add the version of this library you would like to install under dependency:

```toml
[dependencies]
noir_hmac = { tag = "v0.1.0", git = "https://github.com/zkpersona/noir-hmac", directory = "lib" }
```

## Usage

### HMAC-SHA256

```noir
use noir_hmac::hmac_sha256::hmac_sha256;

fn hmac_sha256_test() {
    let key: BoundedVec<u8, 10> = BoundedVec::from_array("secret_key".as_bytes());
    let message: BoundedVec<u8, 11> = BoundedVec::from_array("hello_world".as_bytes());
    let hmac: [u8; 32] = hmac_sha256(key, message);

    let expected: [u8; 32] = [
        32, 245, 74, 230, 153, 92, 121, 130, 198, 181, 233, 222, 161, 142, 167, 35, 8, 91, 220, 193,
        245, 93, 185, 150, 77, 51, 84, 8, 96, 219, 96, 75,
    ];

    assert(hmac == expected);
}
```
