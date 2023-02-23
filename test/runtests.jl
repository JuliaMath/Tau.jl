using Tau
using Test

@testset "self-identity" begin
    @test tau isa Irrational{:twoπ}
    @test τ === τ
    @test τ === tau
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
        @test Float32(tau) == 2 * Float32(pi)
        @test Float64(Float32(tau)) == Float64(2 * Float32(pi))
        @test BigFloat(tau) == 2 * BigFloat(pi)
    end
end

@testset "sintau/costau/sincostau/cistau" begin
    @testset "approximate results for fractional inputs" begin
        @testset "real values" begin
            for T = (Float32, Float64), x = -3:0.1:3.0
                @test @inferred(sintau(T(x))) ≈ T(sinpi(2 * parse(BigFloat, string(x))))
                @test @inferred(costau(T(x))) ≈ T(cospi(2 * parse(BigFloat, string(x))))
                @test @inferred(sincostau(T(x))) == (sintau(T(x)), costau(T(x)))
                @test @inferred(cistau(T(x))) == costau(T(x)) + im * sintau(T(x))
            end
        end

        @testset "complex values" begin
            for x in -1.0:0.1:1.0, y in -1.0:0.1:1.0
                z = complex(x, y)
                @test @inferred(sintau(z)) ≈ sinpi(2 * z)
                @test @inferred(costau(z)) ≈ cospi(2 * z)
                @test @inferred(sincostau(z)) == (sintau(z), costau(z))
                @test @inferred(cistau(T(x))) == costau(T(x)) + im * sintau(T(x))
            end
        end
    end

    @testset "exact results for integer inputs" begin
        @testset "real and complex values passed as integer types" begin
            for T = (Int, Complex), x = -3:3
                @test @inferred(sintau(T(x))) == zero(T)
                @test @inferred(costau(T(x))) == one(T)
                @test @inferred(sincostau(T(x))) == (sintau(T(x)), costau(T(x)))
                @test @inferred(cistau(T(x))) == costau(T(x)) + im * sintau(T(x))
            end
        end

        @testset "real and complex values passed as floating point types" begin
            for T = (Float32, Float64, BigFloat, Complex), x = -3.0:3.0
                @test @inferred(sintau(T(x))) == sign(x) * zero(T)
                @test @inferred(costau(T(x))) == one(T)
                @test @inferred(sincostau(T(x))) == (sintau(T(x)), costau(T(x)))
                @test @inferred(cistau(T(x))) == costau(T(x)) + im * sintau(T(x))
            end
        end
    end

    @testset "corner cases for abnormal inputs" begin
        @testset "real values" begin
            for x in (Inf, -Inf)
                @test_throws DomainError sintau(x)
                @test_throws DomainError costau(x)
                @test_throws DomainError sincostau(x)
            end
            @test isequal(@inferred(sintau(NaN)), sinpi(NaN))
            @test isequal(@inferred(costau(NaN)), cospi(NaN))
            @test isequal(@inferred(sincostau(NaN)), (sintau(NaN), costau(NaN)))
            @test isequal(@inferred(cistau(NaN)), costau(NaN) + im * sintau(NaN))
        end

        @testset "complex values" begin
            for x in (Inf, NaN, 0), y in (Inf, NaN, 0)
                z = complex(x, y)
                @test isequal(@inferred(sintau(z)), sinpi(2 * z))
                @test isequal(@inferred(costau(z)), cospi(2 * z))
                @test isequal(@inferred(sincostau(z)), (sintau(z), costau(z)))
                @test isequal(@inferred(cistau(z)), costau(z) + im * sintau(z))
            end
        end
    end

    # Adapted from julia/test/math.jl
    @testset "type stability" begin
        for T = (Int, Float32, Float64, BigFloat)
            for f = (sintau, costau)
                @test Base.return_types(f, Tuple{T}) == [float(T)]
                @test Base.return_types(f, Tuple{Complex{T}}) == [Complex{float(T)}]
            end
            @test Base.return_types(sincostau, Tuple{T}) == [Tuple{float(T), float(T)}]
            @test Base.return_types(sincostau, Tuple{Complex{T}}) == [Tuple{Complex{float(T)}, Complex{float(T)}}]
            @test Base.return_types(cistau, Tuple{T}) == [Complex{float(T)}]
            @test Base.return_types(cistau, Tuple{Complex{T}}) == [Complex{float(T)}]
        end
    end

    @testset "aliases" begin
        @test sinτ === sintau
        @test cosτ === costau
        @test sincosτ === sincostau
        @test cisτ === cistau
    end
end

# Adapted from julia/test/mod2pi.jl
@testset "modtau" begin
    @test_throws ArgumentError modtau(Int64(2)^60 - 1)
    @test modtau(10) ≈ mod(10, tau)
    @test modtau(-10) ≈ mod(-10, tau)
    @test modtau(355) ≈ 3.1416227979431572
    @test modtau(Int32(355)) ≈ 3.1416227979431572
    @test modtau(355.0) ≈ 3.1416227979431572
    @test modtau(355.0f0) ≈ 3.1416228f0
    @test modtau(Int64(2)^60) == modtau(2.0^60)

    # aliases
    @test modtau === mod2pi
    @test modτ === modtau
end
