# Tau.jl

<div align="center"><img src="tau-2pi.svg" width="300"/></div><br/><br/>

[![version](https://juliahub.com/docs/General/Tau/stable/version.svg)](https://juliahub.com/ui/Packages/General/Tau)
[![CI](https://github.com/JuliaMath/Tau.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/JuliaMath/Tau.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![codecov](https://img.shields.io/codecov/c/github/JuliaMath/Tau.jl/master.svg?label=coverage)](http://codecov.io/github/JuliaMath/Tau.jl)

This [Julia](https://github.com/JuliaLang/julia) [package](http://pkg.julialang.org/)
defines the [Tau](http://www.tauday.com/tau-manifesto) constant
and related functions.

```
tau ≈ 2*pi
```

## Usage

After installing this package with `Pkg.add("Tau")`, it can be used as follows:

```julia
julia> using Tau

julia> tau === τ ≈ 2*pi
true

julia> typeof(tau)
IrrationalConstants.Twoπ
```

Note: to input the τ character, type `\tau` then press <kbd>Tab</kbd>.

The tau variants of `sinpi`, `cospi`, `sincospi`, `cispi`, and `mod2pi` are also defined:

```julia
julia> sintau(1//4)
1.0

julia> costau(1//2)
-1.0

julia> sincostau(1//2)
(0.0, -1.0)

julia> cistau(1//2)
-1.0 + 0.0im

julia> modtau(9*pi/4)
0.7853981633974481
```

Alternatively, one can use the Unicode aliases `sinτ`, `cosτ`, `sincosτ`, `cisτ`, and `modτ`.

## The tau != 2pi inequality

When this package was first created, the equality `tau == 2pi` did hold true,
in accordance to the mathematical definition of the constant.
However, that is not valid anymore -- the two values are only approximately equal: `tau ≈ 2*pi`.

For a detailed explanation of the reasons for this, see [this document](tau-2pi-equality.md).
