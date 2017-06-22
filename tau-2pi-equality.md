When this package was first created, the equality `tau == 2pi` did hold true,
in accordance to the mathematical definition of the constant.
However, for a while that wasn't the case
-- i.e. the two values were only approximately equal, i.e. `tau ≈ 2*pi`.
This document explains in detail the reasons for the inequality.

Both `pi` and `tau` are defined as instances of the type `Irrational`,
which from its very introduction
(under the name `MathConst`, in [JuliaLang/julia#3316][3316]),
had promotion rules that converted them into a floating point representation
when involved in operations with other numbers.
This means, in particular, that the `*` operator implicit in `2pi`
converts that expression to a floating point number.

The fact that one side of the `tau==2pi` equation was a `MathConst` and the other was a `Float64`
did not make the equality fail, since the same promotion rules
meant that the `==` operator in `tau == 2pi` *also* converted both its operands to floating point.

However, this behavior changed in [JuliaLang/julia#9198][9198],
which defined an explicit override for the `==` operator when involving `MathConst`s,
with the following reasoning:
> MathConsts are irrational, so unequal to everything else

Later changed, in [JuliaLang/julia#11929][11929], to:
> Irrationals, by definition, can't have a finite representation equal them exactly

This was further explained in [a comment in JuliaLang/julia#9975][9975]:
> All numbers should only compare equal if they are actually numerically equal, so `pi != float(pi)`.
> As `MathConst`s usually represent irrational numbers, they will never be equal to any floating point values.

(Here, "numerical" is used in the computing sense, rather than in the mathematical sense,
referring to the underlying representation of a number as bits in the memory.)

This may initially seem strange for end users, but is certainly nothing new to Julia,
which has in other occasions had to choose between moving closer to abstract mathematical correctness
or to the internal mechanics underlying its concrete implementation.
A prime example is the non-checking of integer overflow, which often surprised users
(see the links in [JuliaLang/julia#2085][2085])
so much so that it has led to [a dedicated FAQ entry][FAQ].

Although the general reasoning for `Irrational`s to be strictly unequal to any other number remains valid,
this package provides a special case for the `tau == 2pi` equality, since that's true *by definition*.
This is achieved by specifying additional function signatures for the `==` method.
Doing `==(tau, 2pi) = true` rather than `*(2, pi) = tau` (dummy code, simplified for clarity)
prevents breaking type stability, which would be an issue if the `*` function returned
an Irrational when called with the parameters `2` and `pi`, and Float64 for all other cases.

[3316]: https://github.com/JuliaLang/julia/pull/3316
[9198]: https://github.com/JuliaLang/julia/pull/9198
[11929]: https://github.com/JuliaLang/julia/pull/11929
[9975]: https://github.com/JuliaLang/julia/issues/9975#issuecomment-72268963
[2085]: https://github.com/JuliaLang/julia/issues/2085
[FAQ]: https://docs.julialang.org/en/latest/manual/faq/#Why-does-Julia-use-native-machine-integer-arithmetic?-1
