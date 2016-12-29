using Tau
using Base.Test

@test_broken tau == 2*pi
@test Float32(tau) == 2*Float32(pi)
@test Float64(Float32(tau)) == Float64(2*Float32(pi))
@test big(tau) == 2(big(pi))
@test isa(tau, Irrational)

# degree-based trig functions
for T = (Float32,Float64)
    for x = -2:0.1:2
        @test_approx_eq_eps sintau(convert(T,x))::T convert(T,sin(tau*x)) eps(tau*convert(T,x))
        @test_approx_eq_eps costau(convert(T,x))::T convert(T,cos(tau*x)) eps(tau*convert(T,x))
    end
    for x = 0.0:1.0:4.0
        @test sintau(convert(T,x)) === zero(T)
        @test sintau(-convert(T,x)) === -zero(T)
    end
end

# Adapted from julia/test/math.jl

# check type stability
for T = (Float32,Float64,BigFloat)
    for f = (sintau,costau)
        @test Base.return_types(f,Tuple{T}) == [T]
    end
end

# Adapted from julia/test/mod2pi.jl

@test_throws ArgumentError modtau(Int64(2)^60-1)

@test modtau(10) ≈ mod(10, tau)
@test modtau(-10) ≈ mod(-10, tau)
@test modtau(355) ≈ 3.1416227979431572
@test modtau(Int32(355)) ≈ 3.1416227979431572
@test modtau(355.0) ≈ 3.1416227979431572
@test modtau(355.0f0) ≈ 3.1416228f0
@test modtau(Int64(2)^60) == modtau(2.0^60)
