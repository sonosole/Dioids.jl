module Dioids

include("prekits/logaddfn.jl")

include("basic/01-type.jl")
include("basic/02-add.jl")
include("basic/03-mul.jl")
include("basic/04-power.jl")
include("basic/05-div.jl")
include("basic/06-sub.jl")
include("basic/07-random.jl")
include("basic/08-identity.jl")
include("basic/09-unary.jl")

include("special/infstr.jl")
include("special/infvec.jl")
include("special/semiring-carctic.jl")
include("special/semiring-dual.jl")

include("extend/inact.jl")
include("extend/inverse.jl")
include("extend/kclosed.jl")

include("identity/logadd-n.jl")
include("identity/logadd-p.jl")
include("identity/and-or.jl")
include("identity/lcm-gcd.jl")
include("identity/max.jl")
include("identity/min.jl")
include("identity/add.jl")
include("identity/mul.jl")
include("identity/str-concat.jl")
include("identity/str-prefix.jl")
include("identity/str-suffix.jl")
include("identity/vec-concat.jl")
include("identity/vec-prefix.jl")
include("identity/vec-suffix.jl")


export Dioid
export value
export setmark
export unary

# compounded
export Carctic, carctic, carctic₊, carcticₓ
export Dual, dual, dual₊, dualₓ

# mathematical alias
export ⊕
export ⊖
export ⊙
export ⨸

# special symbols
export Strinf, s∞
export SVec
export inact
export inverse

# binary operations
export  logadd, smoothmax
export nlogadd, smoothmin
export lcprefix, deprefix
export lcsuffix, desuffix

# some properties
export iszeroclosed, is0closed


end # module Dioids
