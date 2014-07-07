module Tau
export tau, τ,
       sintau, costau, modtau,
       sinτ, cosτ, modτ

# Use overridden macro definition to define conversion methods for tau
Base.@math_const τ        6.28318530717958647692  (2*big(pi))
const tau = τ

include("trig.jl")

modtau(x) = Base.mod2pi(x)
const modτ = modtau

end
