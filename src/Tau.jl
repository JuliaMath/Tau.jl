module Tau

import IrrationalConstants

export tau, τ,
       sintau, costau, modtau,
       sinτ, cosτ, modτ

# Definition of τ as irrational constant
const τ = IrrationalConstants.twoπ
const tau = τ

const modτ = mod2pi
const modtau = modτ

# Trigonometric functions
sinτ(x) = sinpi(2 * x)
cosτ(x) = cospi(2 * x)

# Optimization for integers
sinτ(x::Integer) = zero(float(x))
cosτ(x::Integer) = one(float(x))

const sintau = sinτ
const costau = cosτ

end
