# Noir Library Starter

This is a template for building Noir libraries. It includes a basic example of a Noir library with an example bin circuit and test suite.

 This Starter Template includes:

- A basic library at `lib/`
- Example bin circuit at `examples/lib_example/`
- Tests at `tests/`
- CI Scripts at `scripts/`

---

# LIBRARY_NAME

Add a brief description of the library

## Noir version compatibility

This library is tested to work as of Noir version 0.36.0 & 1.0.0-beta.x.

## Benchmarks

Benchmarks are ignored by `git` and checked on pull-request. As such, benchmarks may be generated
with the following command.

```bash
./scripts/build-gates-report.sh
```

The benchmark will be generated at `./gates_report.json`.

## Profiling

To profile the circuit, run the following command:

```bash
./scripts/profile.sh
```

## Installation

In your _Nargo.toml_ file, add the version of this library you would like to install under dependency:

```toml
[dependencies]
LIBRARY = { tag = "v0.1.0", git = "https://github.com/noir-lang/LIBRARY_NAME" }
```

## `library`

### Usage

`PLACEHOLDER`
