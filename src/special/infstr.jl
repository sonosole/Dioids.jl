"""
``Strinf`` is an **`infinite-possible-string`** having **`infinite`** kinds of variants, so we use 
symbol `∞` when printing. `Strinf` can be seen as such a string that any string `s ∈ ∞`, so that:
+ if `+` is `longest-common-prefix/suffix`, then `∞` + `s` = `s`
+ if `*` is concatenation, then `∞` * `s` = `∞`, i.e. still a `infinite-possible-string`
"""
struct Strinf <: AbstractString end


const s∞ = Strinf()
Base.ncodeunits(::Strinf) = 3
Base.codeunit(::Strinf) = UInt8
Base.iterate(::Strinf) = ("∞", 1)
Base.iterate(::Strinf, ::Integer) = nothing
Base.show(io::IO, x::Strinf) = print(io, "∞")
Base.isvalid(::Strinf, i::Integer) = isequal(i,1) ? true : false

promote_rule(::Type{Strinf}, ::Type{T}) where T <: AbstractString = T
promote_rule(::Type{T}, ::Type{Strinf}) where T <: AbstractString = T

# corner cases of "add"
lcprefix(x::Strinf, y::S) where S <:AbstractString = y
lcprefix(x::S, y::Strinf) where S <:AbstractString = x
lcprefix(x::Strinf, y::Strinf) = s∞

lcsuffix(x::Strinf, y::S) where S <:AbstractString = y
lcsuffix(x::S, y::Strinf) where S <:AbstractString = x
lcsuffix(x::Strinf, y::Strinf) = s∞


# corner cases of "mul"
Base.:*(::Strinf, ::S) where S <:AbstractString = s∞
Base.:*(::S, ::Strinf) where S <:AbstractString = s∞
Base.:*(::Strinf, ::Strinf) = s∞



Base.isequal(x::Strinf, y::S) where S <:AbstractString = false
Base.isequal(x::S, y::Strinf) where S <:AbstractString = false
Base.isequal(x::Strinf, y::Strinf) = true

Base.:(==)(x::Strinf, y::S) where S <:AbstractString = false
Base.:(==)(x::S, y::Strinf) where S <:AbstractString = false
Base.:(==)(x::Strinf, y::Strinf) = true

Base.:(!=)(x::Strinf, y::S) where S <:AbstractString = true
Base.:(!=)(x::S, y::Strinf) where S <:AbstractString = true
Base.:(!=)(x::Strinf, y::Strinf) = false


"""
    lcprefix(x::S, y::S) where S <: Union{AbstractString, AbstractVector}

Return the longest common prefix between `x` and `y`.
"""
function lcprefix(x::S, y::S) where S <: Union{AbstractString, AbstractVector}
    offset = 0  # offset from 1st index
    n = min(length(x), length(y))
    for i = 1:n
        !isequal(x[i], y[i]) && break
        offset = i
    end
    return x[1 : offset]
end



"""
    lcsuffix(x::S, y::S) where S <: Union{AbstractString, AbstractVector}

Return the longest common suffix between `x` and `y`.
"""
function lcsuffix(x::S, y::S) where S <: Union{AbstractString, AbstractVector}
    offset = 0   # offset from last index
    lx = length(x)
    ly = length(y)
    n  = min(lx, ly)
    while offset < n
        !isequal(x[lx-offset], y[ly-offset]) && break
        offset += 1
    end
    return x[lx-offset+1 : lx]
end


function Base.convert(::Type{Dioid{⨁, ⨀, AbstractString}}, 
                     x::Dioid{⨁, ⨀, Strinf}) where {⨁, ⨀}
    return Dioid{⨁, ⨀, AbstractString}(value(x))
end


function Base.convert(::Type{Dioid{⨁, ⨀, AbstractString}}, 
                     x::Dioid{⨁, ⨀, String}) where {⨁, ⨀}
    return Dioid{⨁, ⨀, AbstractString}(value(x))
end


function Base.convert(::Type{Dioid{⨁, ⨀, String}}, 
                     x::Dioid{⨁, ⨀, AbstractString}) where {⨁, ⨀}
    return Dioid{⨁, ⨀, String}(value(x))
end


"""
    deprefix(x::S, y::S) where S <: Union{AbstractString, AbstractVector}
Remove the common prefix from `x`

# Example
```julia
julia> deprefix("abcd","ab")
"cd"
julia> deprefix("abc","abcd")
ERROR: length of "abc" is less than length of "abcd"
...
```
"""
function deprefix(x::S, y::S) where S <: Union{AbstractString, AbstractVector}
    lx = length(x)
    ly = length(y)
    if lx < ly
        error("length of \"$x\" is less than length of \"$y\"")
    end

    offset = 0  # offset from 1st index
    for i = 1:ly
        !isequal(x[i], y[i]) && break
        offset = i
    end
    return x[offset+1:lx]
end


"""
    desuffix(x::S, y::S) where S <: Union{AbstractString, AbstractVector}
Remove the common suffix from `x`

# Example
```julia
julia> desuffix("abcd","cd")
"ab"
julia> desuffix("abc","abcdc")
ERROR: length of "abc" is less than length of "abcdc"
...
```
"""
function desuffix(x::S, y::S) where S <: Union{AbstractString, AbstractVector}
    lx = length(x)
    ly = length(y)
    if lx < ly
        error("length of \"$x\" is less than length of \"$y\"")
    end
    n = min(lx, ly)
    offset = 0          # offset from last index
    while offset < n
        !isequal(x[lx-offset], y[ly-offset]) && break
        offset += 1
    end
    return x[1 : lx-offset]
end

