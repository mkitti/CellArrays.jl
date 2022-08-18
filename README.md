# CellArrays

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://omlins.github.io/CellArrays.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://omlins.github.io/CellArrays.jl/dev)
[![CI](https://github.com/omlins/CellArrays.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/omlins/CellArrays.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/omlins/CellArrays.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/omlins/CellArrays.jl)
[![Coverage](https://coveralls.io/repos/github/omlins/CellArrays.jl/badge.svg?branch=main)](https://coveralls.io/github/omlins/CellArrays.jl?branch=main)

This is the source repository of the Julia package `CellArrays.jl`. Please head to the [-> documentation website <-](https://omlins.github.io/CellArrays.jl) to learn about its usage.

## Fork

This is currently a fork that separates the CPU functionality into CellArraysCore.jl, a smaller package without GPU dependencies.

See the following upstream issue for discussion.
https://github.com/omlins/CellArrays.jl/issues/16

## Fork Installation

To install the full package, add the package using the full URL and revision.
```julia
using Pkg
pkg"add https://github.com/mkitti/CellArrays.jl#cellarrayscore:lib/CellArraysCore"
pkg"add https://github.com/mkitti/CellArrays.jl#cellarrayscore"
```

I have no intention of registering the fork or the core package at the moment. Create an issue if this is of interest to you.

### Fork Development and Testing

After using `Pkg.develop` or `git clone`, you may need to manually add CellArraysCore.jl to create a Manifest.toml for testing. Within the CellArrays.jl, execute the following:

From a shell, invoke `julia` as follows.

```
$ julia --project=.
```

Then within Julia, execute the following.

```julia
using Pkg
pkg"dev lib/CellArraysCore"
pkg"test"
```
