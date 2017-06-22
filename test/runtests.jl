using Tau
using Base.Test

@testset "self-identity" begin
    @test isa(tau, Irrational)
    @test τ == τ
    @test τ == tau
end

@testset "tau vs. 2pi" begin
    @testset "symbols" begin
        @test τ ≠ 2π # tau is Irrational, can't be equal to an AbstractFloat
        @test 2π ≠ τ
        @test π ≠ τ/2
        @test τ/2 ≠ π
    end

    @testset "ascii" begin
        @test tau ≠ 2*pi # tau is Irrational, can't be equal to an AbstractFloat
        @test 2*pi ≠ tau
        @test pi ≠ tau/2 # pi is Irrational, can't be equal to an AbstractFloat
        @test tau/2 ≠ pi
    end

    @testset "explicit type conversions" begin
        @test Float32(tau) == 2*Float32(pi)
        @test Float64(Float32(tau)) == Float64(2*Float32(pi))
        @test big(tau) == 2(big(pi))
    end
end

@testset "sintau/costau" begin

    @testset "approximate results for fractional inputs" begin

        @testset "real values" begin
            for T = (Float32, Float64), x = -3:0.1:3.0
                @test @inferred(sintau(T(x))) ≈ T(sinpi(2 * parse(BigFloat, string(x))))
                @test @inferred(costau(T(x))) ≈ T(cospi(2 * parse(BigFloat, string(x))))
            end
        end

        @testset "complex values" begin
            for x in -1.0:0.1:1.0, y in -1.0:0.1:1.0
                z = complex(x, y)
                @test @inferred(sintau(z)) ≈ sinpi(2 * z)
                @test @inferred(costau(z)) ≈ cospi(2 * z)
            end
        end

    end

    @testset "exact results for integer inputs" begin

        @testset "real and complex values passed as integer types" begin
            for T = (Int, Complex), x = -3:3
                @test @inferred(sintau(T(x))) == zero(T)
                @test @inferred(costau(T(x))) == one(T)
            end
        end

        @testset "real and complex values passed as floating point types" begin
            for T = (Float32, Float64, BigFloat, Complex), x = -3.0:3.0
                @test @inferred(sintau(T(x))) == sign(x)*zero(T)
                @test @inferred(costau(T(x))) == one(T)
            end
        end

    end

    @testset "corner cases for abnormal inputs" begin

        @testset "real values" begin
            for x in (Inf, -Inf)
                @test_throws DomainError sintau(x)
                @test_throws DomainError costau(x)
            end
            @test isequal(@inferred(sintau(NaN)), sinpi(NaN))
            @test isequal(@inferred(costau(NaN)), cospi(NaN))
        end

        @testset "complex values" begin
            for x in (Inf, NaN, 0), y in (Inf, NaN, 0)
                z = complex(x, y)
                @test isequal(@inferred(sintau(z)), sinpi(2 * z))
                @test isequal(@inferred(costau(z)), cospi(2 * z))
            end
        end

    end

    # Adapted from julia/test/math.jl
    @testset "type stability" begin
        for T = (Int,Float32,Float64,BigFloat), f = (sintau,costau)
            @test Base.return_types(f,Tuple{T}) == [T]
            @test Base.return_types(f,Tuple{Complex{T}}) == [Complex{float(T)}]
        end
    end
end

# Adapted from julia/test/mod2pi.jl
@testset "modtau" begin
    @test_throws ArgumentError modtau(Int64(2)^60-1)
    @test modtau(10) ≈ mod(10, tau)
    @test modtau(-10) ≈ mod(-10, tau)
    @test modtau(355) ≈ 3.1416227979431572
    @test modtau(Int32(355)) ≈ 3.1416227979431572
    @test modtau(355.0) ≈ 3.1416227979431572
    @test modtau(355.0f0) ≈ 3.1416228f0
    @test modtau(Int64(2)^60) == modtau(2.0^60)
end
