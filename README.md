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

### Fork Installation

To install the full package, add the package using the full URL and revision.
```julia
using Pkg
pkg"add https://github.com/mkitti/CellArrays.jl#cellarrayscore:lib/CellArraysCore"
pkg"add https://github.com/mkitti/CellArrays.jl#cellarrayscore"
```

I have no intention of registering the fork or the core package at the moment. Create an issue if this is of interest to you.

### Fork Development and Testing

After using `Pkg.develop` or `git clone`, you may need to manually add CellArraysCore.jl to create a Manifest.toml for testing.

Within the `CellArrays.jl` directory, from a shell, invoke `julia` as follows.

```
$ julia --project=.
```

Then within Julia, execute the following.

```julia
using Pkg
pkg"dev lib/CellArraysCore"
pkg"test"
```

### Fork Motivation

Installing CellArrays.jl into an empty repository results in 492 mebibytes of storage as of version 0.1.0 (August 18th, 2022).

```
$ export JULIA_DEPOT_PATH=`mktemp -d`; julia -e 'using Pkg; Pkg.add(name="CellArrays")' && du -hcs $JULIA_DEPOT_PATH/*
...
  62 dependencies successfully precompiled in 73 seconds (14 already precompiled)
436M	/tmp/tmp.lzpItiqbQL/artifacts
32M	/tmp/tmp.lzpItiqbQL/compiled
32K	/tmp/tmp.lzpItiqbQL/environments
20K	/tmp/tmp.lzpItiqbQL/logs
20M	/tmp/tmp.lzpItiqbQL/packages
5.0M	/tmp/tmp.lzpItiqbQL/registries
24K	/tmp/tmp.lzpItiqbQL/scratchspaces
492M	total
```

If one just requires the CPU based functionality, then installing the core functionality without GPU dependencies can save a considerable amount of space (480 megabytes).
```
$ export JULIA_DEPOT_PATH=`mktemp -d`; julia -e 'using Pkg; Pkg.add(url="https://github.com/mkitti/CellArrays.jl", rev="cellarrayscore", subdir="lib/CellArraysCore")' && du -hcs $JULIA_DEPOT_PATH/*
...
  7 dependencies successfully precompiled in 9 seconds
220K	/tmp/tmp.LJJJIVJM4Y/clones
4.2M	/tmp/tmp.LJJJIVJM4Y/compiled
16K	/tmp/tmp.LJJJIVJM4Y/environments
8.0K	/tmp/tmp.LJJJIVJM4Y/logs
1.5M	/tmp/tmp.LJJJIVJM4Y/packages
5.0M	/tmp/tmp.LJJJIVJM4Y/registries
16K	/tmp/tmp.LJJJIVJM4Y/scratchspaces
11M	total
```

### Potential Overhead

An issue raised in not separating the packages was potential overhead in doing so. It should be noted that separating the packages does not use Requires.jl. Rather CellArrays.jl just acquires a dependency on the subdirectory package CellArraysCore.jl.

#### Time to load the registered package
```
julia> @time using CellArrays
  6.320209 seconds (11.13 M allocations: 790.322 MiB, 3.40% gc time, 13.13% compilation time)
```

#### Time to load the fork
```
julia> @time using CellArrays
  6.092831 seconds (11.13 M allocations: 790.411 MiB, 0.62% gc time, 12.25% compilation time)
```

#### Time to load CellArraysCore.jl then CellArrays.jl (fork)

```
julia> @time using CellArraysCore
  1.002167 seconds (1.89 M allocations: 138.611 MiB, 4.29% gc time, 0.37% compilation time)

julia> @time using CellArrays
  5.333837 seconds (9.24 M allocations: 651.726 MiB, 15.21% compilation time)
```

#### Other sources of overhead?

There may be other sources of overhead such as potential method invalidations. I am interested in developing methods to measure this overhead. Please create an issue here if you have an idea how to do so.
