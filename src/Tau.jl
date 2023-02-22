module Tau

import IrrationalConstants

export tau, τ,
       sintau, costau, sincostau, modtau,
       sinτ, cosτ, sincosτ, modτ

# Definition of τ as irrational constant
const τ = IrrationalConstants.twoπ
const tau = τ

const modτ = mod2pi
const modtau = modτ

# Trigonometric functions
sinτ(x) = sinpi(2 * x)
cosτ(x) = cospi(2 * x)
function sincosτ(x)
    y = 2 * x
    # sincospi was added in https://github.com/JuliaLang/julia/pull/35816
    @static if VERSION < v"1.6.0-DEV.292"
        return (sinpi(y), cospi(y))
    else
        return sincospi(y)
    end
end

# Optimization for integers
sinτ(x::Integer) = zero(float(x))
cosτ(x::Integer) = one(float(x))
function sincosτ(x::Integer)
    y = float(x)
    return (zero(y), one(y))
end

const sintau = sinτ
const costau = cosτ
const sincostau = sincosτ

end
