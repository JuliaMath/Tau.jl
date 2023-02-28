module Tau

import IrrationalConstants

export tau, τ,
       sintau, costau, sincostau, cistau, modtau

# Definition of τ as irrational constant
const τ = IrrationalConstants.twoπ
const tau = τ

const modtau = mod2pi

# Trigonometric functions
sintau(x) = sinpi(2 * x)
costau(x) = cospi(2 * x)
function sincostau(x)
    y = 2 * x
    # sincospi was added in https://github.com/JuliaLang/julia/pull/35816
    @static if VERSION < v"1.6.0-DEV.292"
        return (sinpi(y), cospi(y))
    else
        return sincospi(y)
    end
end
cistau(x::Real) = complex(reverse(sincostau(x))...)
function cistau(z::Complex)
    sitau, cotau = sincostau(z)
    re_sitau, im_sitau = reim(sitau)
    re_cotau, im_cotau = reim(cotau)
    return complex(re_cotau - im_sitau, im_cotau + re_sitau)
end

# Optimization for integers
sintau(x::Integer) = zero(float(x))
costau(x::Integer) = one(float(x))
function sincostau(x::Integer)
    y = float(x)
    return (zero(y), one(y))
end
function cistau(x::Integer)
    y = float(x)
    return complex(one(y), zero(y))
end

end
