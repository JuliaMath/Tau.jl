using Tau
using Base.Test

# Basic tests
@test_broken tau == 2*pi
@test Float32(tau) == 2*Float32(pi)
@test Float64(Float32(tau)) == Float64(2*Float32(pi))
@test big(tau) == 2(big(pi))
@test isa(tau, Irrational)

# Test approximate results of degree-based trig functions
for T = (Float32,Float64)
    for x = -2:0.1:2
        @test_approx_eq_eps sintau(convert(T,x))::T convert(T,sin(tau*x)) eps(tau*convert(T,x))
        @test_approx_eq_eps costau(convert(T,x))::T convert(T,cos(tau*x)) eps(tau*convert(T,x))
    end
end

# Test exact results of passing integer values to sintau/costau
for T = (Int, Complex)
    for x = -3:3
        @test sintau(convert(T,x)) == zero(T)
        @test costau(convert(T,x)) == one(T)
    end
end

# Test exact results of passing integer values to sintau/costau as float types
for T = (Float32, Float64, BigFloat, Complex)
    for x = -3.0:3.0
        @test sintau(convert(T,x)) == sign(x)*zero(T)
        @test costau(convert(T,x)) == one(T)
    end
end

# Check type stability of sintau/costau (adapted from julia/test/math.jl)
for T = (Int,Float32,Float64,BigFloat)
    for f = (sintau,costau)
        @test Base.return_types(f,Tuple{T}) == [T]
    end
end

# Test passing Inf to sintau / costau
@test_throws DomainError sintau(Inf)
@test_throws DomainError costau(Inf)

# Test modtau (adapted from julia/test/mod2pi.jl)
@test_throws ArgumentError modtau(Int64(2)^60-1)
@test modtau(10) ≈ mod(10, tau)
@test modtau(-10) ≈ mod(-10, tau)
@test modtau(355) ≈ 3.1416227979431572
@test modtau(Int32(355)) ≈ 3.1416227979431572
@test modtau(355.0) ≈ 3.1416227979431572
@test modtau(355.0f0) ≈ 3.1416228f0
@test modtau(Int64(2)^60) == modtau(2.0^60)
