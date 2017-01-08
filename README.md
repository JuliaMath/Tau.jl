# Tau

[![tests-0.4](http://pkg.julialang.org/badges/Tau_0.4.svg)](http://pkg.julialang.org/?pkg=Tau)
[![tests-0.5](http://pkg.julialang.org/badges/Tau_0.5.svg)](http://pkg.julialang.org/?pkg=Tau)
[![tests-0.6](http://pkg.julialang.org/badges/Tau_0.6.svg)](http://pkg.julialang.org/?pkg=Tau)

Linux, OSX: [![Build Status](https://travis-ci.org/Aerlinger/Tau.jl.svg?branch=master)](https://travis-ci.org/Aerlinger/Tau.jl)

Windows: [![Build status](https://ci.appveyor.com/api/projects/status/dpoqmol3k4hivtmr/branch/master?svg=true)](https://ci.appveyor.com/project/waldyrious/tau-jl/branch/master)

Code coverage:
[![Coverage Status](https://coveralls.io/repos/Aerlinger/Tau.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/Aerlinger/Tau.jl?branch=master)
[![codecov.io](http://codecov.io/github/Aerlinger/Tau.jl/coverage.svg?branch=master)](http://codecov.io/github/Aerlinger/Tau.jl?branch=master)

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
