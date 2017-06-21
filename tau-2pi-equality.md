When this package was first created, the equality `tau == 2pi` did hold true,
in accordance to the mathematical definition of the constant.
However, that is not valid anymore -- the two values are now only approximately equal, i.e. `tau ≈ 2*pi`.
This document explains in detail the reasons for the inequality.

Both `pi` and `tau` are defined as instances of the type `Irrational`,
which from its very introduction
(under the name `MathConst`, in [JuliaLang/julia#3316](https://github.com/JuliaLang/julia/pull/3316)),
had promotion rules that converted them into a floating point representation
when involved in operations with other numbers.
This means, in particular, that the `*` operator implicit in `2pi`
converts that expression to a floating point number.

The fact that one side of the `tau==2pi` equation was a `MathConst` and the other was a `Float64`
did not make the equality fail, since the same promotion rules
meant that the `==` operator in `tau == 2pi` *also* converted both its operands to floating point.

However, this behavior changed in [JuliaLang/julia#9198](https://github.com/JuliaLang/julia/pull/9198),
which defined an explicit override for the `==` operator when involving `MathConst`s,
with the following reasoning:
> MathConsts are irrational, so unequal to everything else

This was further explained in [a comment in JuliaLang/julia#9975](https://github.com/JuliaLang/julia/issues/9975#issuecomment-72268963):
> All numbers should only compare equal if they are actually numerically equal, so `pi != float(pi)`.
> As `MathConst`s usually represent irrational numbers, they will never be equal to any floating point values.

(Here, "numerical" is used in the computing sense, rather than in the mathematical sense,
referring to the underlying representation of a number as bits in the memory.)

This may initially seem strange for end users, but is certainly nothing new to Julia,
which has in other occasions had to choose between moving closer to abstract mathematical correctness
or to the internal mechanics underlying its concrete implementation.
A prime example is the non-checking of integer overflow, which often surprised users
(see the links in [JuliaLang/julia#2085](https://github.com/JuliaLang/julia/issues/2085))
so much so that it has led to [a dedicated FAQ entry]
(https://docs.julialang.org/en/latest/manual/faq/#Why-does-Julia-use-native-machine-integer-arithmetic?-1).

So the reason for `tau != 2pi` is that, in the computing sense, they are represented by different structures in Julia.
