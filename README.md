# Tau

Defines the Tau constant. Pretty self-explanatory.

```
tau == 2*pi
```

# Usage

```julia
using Tau

tau == τ == 2*pi  # => true
typeof(tau)       # => MathConst{:τ} (constructor with 1 method)
```

The tau variants of `sinpi`, `cospi`, and `mod2pi` are also defined:

```julia
sintau(1//4) # => 1.0
costau(1//2) # => -1.0
```

