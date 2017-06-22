# Precompile the module:
# https://docs.julialang.org/en/latest/manual/modules.html#Module-initialization-and-precompilation-1
__precompile__()

module Tau
export tau, τ,
       sintau, costau, modtau,
       sinτ, cosτ, modτ

# Use overridden macro definition to define conversion methods for tau
Base.@irrational τ 6.28318530717958647692 (2 * big(pi))
const tau = τ

# Implement tau == 2pi (and pi = tau/2) by defining additional signatures for the == method.
# This overrides, for these cases only, the (always false) result
# of `==(::Irrational, ::Real)` defined in base/irrationals.jl
import Base.==
=={T<:Real}(::Irrational{:τ}, n::T) = n == 2 * T(π)
=={T<:Real}(n::T, ::Irrational{:τ}) = n == 2 * T(π)
=={T<:Real}(::Irrational{:π}, n::T) = n == T(τ) / 2
=={T<:Real}(n::T, ::Irrational{:π}) = n == T(τ) / 2
# Note: we're using the method signature syntax `foo{T<:Real}(x::T) = ...` that's valid in julia 0.5,
# instead of the new `foo(x::T) where T<:Real = ...` syntax introduced in julia 0.6,
# to avoid breaking backward compatibility or introducing a dependency on Compat.jl

# Disambiguate the `==(:`Irrational{s}, ::Irrational{s}) where {s}`
# defined in base/irrationals.jl
==(::Irrational{:τ}, ::Irrational{:τ}) = true
==(::Irrational{:π}, ::Irrational{:π}) = true

include("trig.jl")

modtau(x) = Base.mod2pi(x)
const modτ = modtau

end
