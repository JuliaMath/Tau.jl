module Tau
export tau, τ

# Derived from Base.@math_const as defined in base/constants.jl
macro math_const(sym, val, def)
    esym = esc(sym)
    qsym = esc(Expr(:quote, sym))

    bigconvert = quote
      # Long version of Tau isn't defined in MPFR library so it's defined manually here:
        Base.convert(::Type{BigFloat}, ::MathConst{:τ}) = BigFloat("6.283185307179586476925286766559005768394338798750211641949889184615632812572417997256069650684234135964296173026564613294187689219101164463450718816256")
        big(x::MathConst{:τ}) = Base.convert(BigFloat, τ)
    end

    quote
        const $esym = MathConst{$qsym}()
        $bigconvert
        Base.convert(::Type{Float64}, ::MathConst{$qsym}) = $val
        Base.convert(::Type{Float32}, ::MathConst{$qsym}) = $(float32(val))
    end
end

# Use overridden macro definition to define conversion methods for tau
@math_const τ        6.28318530717958647692  tau
const tau = τ


end
