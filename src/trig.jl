# Adapted from julia/special/trig.jl

function sintau(x::Real)
    if !isfinite(x)
        isnan(x) && return x
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

function costau(x::Real)
    if !isfinite(x)
        isnan(x) && return x
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

# Implementations of complex sintau/costau are adapted from julia/base/special/trig.jl.
function sintau{T}(z::Complex{T})
    F = float(T)
    zr, zi = reim(z)
    if isinteger(zr)
        Complex(zero(F), sinh(tau * zi))
    elseif !isfinite(zr)
        if zi == 0 || isinf(zi)
            Complex(F(NaN), F(zi))
        else
            Complex(F(NaN), F(NaN))
        end
    else
        tauzi = tau * zi
        Complex(sintau(zr) * cosh(tauzi), costau(zr) * sinh(tauzi))
    end
end

function costau{T}(z::Complex{T})
    F = float(T)
    zr, zi = reim(z)
    if isinteger(zr)
        s = copysign(zero(F), zr)
        Complex(cosh(tau * zi), isnan(zi) ? s : -flipsign(s,zi))
    elseif !isfinite(zr)
        if zi == 0
            Complex(F(NaN), isnan(zr) ? zero(F) : -flipsign(F(zi), zr))
        elseif isinf(zi)
            Complex(F(Inf), F(NaN))
        else
            Complex(F(NaN), F(NaN))
        end
    else
        tauzi = tau * zi
        Complex(costau(zr) * cosh(tauzi), -sintau(zr) * sinh(tauzi))
    end
end

const sinτ = sintau
const cosτ = costau
