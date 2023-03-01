module Tau

import IrrationalConstants

export tau, τ,
       sintau, costau, sincostau, cistau, modtau,
       sinτ, cosτ, sincosτ, cisτ, modτ

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
cisτ(x::Real) = complex(reverse(sincosτ(x))...)
function cisτ(z::Complex)
    sitau, cotau = sincosτ(z)
    re_sitau, im_sitau = reim(sitau)
    re_cotau, im_cotau = reim(cotau)
    return complex(re_cotau - im_sitau, im_cotau + re_sitau)
end

# Optimization for integers
sinτ(x::Integer) = zero(float(x))
cosτ(x::Integer) = one(float(x))
function sincosτ(x::Integer)
    y = float(x)
    return (zero(y), one(y))
end
function cisτ(x::Integer)
    y = float(x)
    return complex(one(y), zero(y))
end

# Aliases
const sintau = sinτ
const costau = cosτ
const sincostau = sincosτ
const cistau = cisτ

# Documentation

"""
    sinτ(x)
    sintau(x)

Compute ``\\sin(\\tau x)`` more accurately than `sin(tau*x)`, especially for large `x`.

See also: `costau`, `sincostau`.
"""
function sinτ end

"""
    cosτ(x)
    costau(x)

Compute ``\\cos(\\tau x)`` more accurately than `cos(tau*x)`, especially for large `x`.

See also: `sintau`, `sincostau`.
"""
function cosτ end

"""
    sincosτ(x)
    costau(x)

Simultaneously compute `sintau(x)` and `costau(x)` (the sine and cosine of `tau*x`,
where `x` is in radians), returning a tuple `(sine, cosine)`.

See also: `sintau`, `costau`.
"""
function sincosτ end


"""
    cisτ(x)
    cistau(x)

Compute ``\\exp(\\tau i x)`` more accurately than `cis(tau*x)`, especially for large `x`.

See also: `cis`, `sincostau`.
"""
function cisτ end

end
