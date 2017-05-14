# Tau

[![tests-0.4][tests-0.4-img]](http://pkg.julialang.org/detail/Tau)
[![tests-0.5][tests-0.5-img]](http://pkg.julialang.org/detail/Tau)
[![tests-0.6][tests-0.6-img]](http://pkg.julialang.org/detail/Tau)  
[![travis][travis-img]](https://travis-ci.org/JuliaMath/Tau.jl)
[![appveyor][appveyor-img]](https://ci.appveyor.com/project/waldyrious/tau-jl)
[![codecov][codecov-img]](http://codecov.io/github/JuliaMath/Tau.jl)

[tests-0.4-img]: http://pkg.julialang.org/badges/Tau_0.4.svg
[tests-0.5-img]: http://pkg.julialang.org/badges/Tau_0.5.svg
[tests-0.6-img]: http://pkg.julialang.org/badges/Tau_0.6.svg
[travis-img]: https://img.shields.io/travis/JuliaMath/Tau.jl/master.svg?label=Linux,%20macOS
[appveyor-img]: https://img.shields.io/appveyor/ci/waldyrious/tau-jl/master.svg?label=Windows
[codecov-img]: https://img.shields.io/codecov/c/github/JuliaMath/Tau.jl/master.svg?label=coverage


This [Julia](https://github.com/JuliaLang/julia) [package](http://pkg.julialang.org/)
defines the [Tau](http://www.tauday.com/tau-manifesto) constant
and related functions.

```
tau == 2*pi
```

# Usage

```julia
using Tau

tau == τ == 2*pi  # => true
typeof(tau)       # => Irrational{:τ} (constructor with 1 method)
```

The tau variants of `sinpi`, `cospi`, and `mod2pi` are also defined:

```julia
sintau(1//4) # => 1.0
costau(1//2) # => -1.0
```
