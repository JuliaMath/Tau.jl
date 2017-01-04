# Adapted from julia/special/trig.jl

function sintau{T<:Real}(x::T)
    if !isfinite(x)
        throw(DomainError())
    end

    rx = copysign(float(rem(x,1)),x)
    arx = abs(rx)

    if arx <= oftype(rx,1/8)
        return sin(tau*rx)
    elseif arx <= oftype(rx,3/8)
        arx = oftype(rx,1/4) - arx
        return copysign(cos(tau*arx),rx)
    elseif arx < oftype(rx,5/8)
        rx = (oftype(rx,1/2) - arx)*sign(rx)
        return sin(tau*rx)
    elseif arx <= oftype(rx,7/8)
        arx = oftype(rx,3/4) - arx
        return -copysign(cos(tau*arx),rx)
    else
        rx = rx - copysign(one(rx),rx)
        return sin(tau*rx)
    end
end

function costau{T<:Real}(x::T)
    if !isfinite(x)
        throw(DomainError())
    end

    rx = abs(float(rem(x,1)))

    if rx <= oftype(rx,1/8)
        return cos(tau*rx)
    elseif rx < oftype(rx,3/8)
        rx = oftype(rx,1/4) - rx
        return sin(tau*rx)
    elseif rx <= oftype(rx,5/8)
        rx = oftype(rx,1/2) - rx
        return -cos(tau*rx)
    elseif rx < oftype(rx,7/8)
        rx = rx - oftype(rx,3/4)
        return sin(tau*rx)
    else
        rx = one(rx) - rx
        return cos(tau*rx)
    end
end

sintau(x::Integer) = zero(x)
costau(x::Integer) = one(x)

function sintau{T}(z::Complex{T})
    zr, zi = reim(z)
    if !isfinite(zi) && zr == 0 return complex(zr, zi) end
    if isnan(zr) && !isfinite(zi) return complex(zr, zi) end
    if !isfinite(zr) && zi == 0 return complex(oftype(zr, NaN), zi) end
    if !isfinite(zr) && isfinite(zi) return complex(oftype(zr, NaN), oftype(zi, NaN)) end
    if !isfinite(zr) && !isfinite(zi) return complex(zr, oftype(zi, NaN)) end
    tauzi = tau*zi
    complex(sintau(zr)*cosh(tauzi), costau(zr)*sinh(tauzi))
end

function costau{T}(z::Complex{T})
    zr, zi = reim(z)
    if !isfinite(zi) && zr == 0
        return complex(isnan(zi) ? zi : oftype(zi, Inf),
                       isnan(zi) ? zr : zr*-sign(zi))
    end
    if !isfinite(zr) && isinf(zi)
        return complex(oftype(zr, Inf), oftype(zi, NaN))
    end
    if isinf(zr)
        return complex(oftype(zr, NaN), zi==0 ? -copysign(zi, zr) : oftype(zi, NaN))
    end
    if isnan(zr) && zi==0 return complex(zr, abs(zi)) end
    tauzi = tau*zi
    complex(costau(zr)*cosh(tauzi), -sintau(zr)*sinh(tauzi))
end

Base.@vectorize_1arg Number sintau
Base.@vectorize_1arg Number costau

const sinτ = sintau
const cosτ = costau
