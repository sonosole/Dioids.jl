"""
``SVec`` is an **`infinite-possible-vector`** having **`infinite`** kinds of variants, so we use 
symbol `∞` when printing. `Vecinf` can be seen as such a vector that any vector `s ∈ ∞`, so that:
+ if `+` is `longest-common-prefix/suffix`, then `∞` + `s` = `s`
+ if `*` is concatenation, then `∞` * `s` = `∞`, i.e. still a `infinite-possible-vector`
"""
struct SVec{T}
    data   :: Vector{T}
    isainf :: Bool
    function SVec{T}(v::Vector{T}, isainf::Bool=false) where T
        return new{T}(v, isainf)
    end
    function SVec(v::Vector{T}, isainf::Bool=false) where T
        return new{T}(v, isainf)
    end
end


function Base.show(io::IO, x::SVec{T}) where T
    if x.isainf
        return print(io, "\e[32m∞\e[0m")
    else
        return print(io, x.data)
    end
end


function lcprefix(x::SVec{T}, y::SVec{T}) where T
    x.isainf && return y
    y.isainf && return x
    return SVec{T}(lcprefix(x.data, y.data), false)
end

function lcsuffix(x::SVec{T}, y::SVec{T}) where T
    x.isainf && return y
    y.isainf && return x
    return SVec{T}(lcsuffix(x.data, y.data), false)
end

function Base.:*(x::SVec{T}, y::SVec{T}) where T
    x.isainf && return x
    y.isainf && return y
    return SVec{T}(append!(x.data, y.data), false)
end


