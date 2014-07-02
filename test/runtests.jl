using Tau
using Base.Test

@test tau == 2*pi
@test float32(tau) == 2*float32(pi)
@test float64(float32(tau)) == float64(2*float32(pi))
@test isa(tau, MathConst)

