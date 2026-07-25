"""
    logadd(a <: Real, b <: Real)

Calculate (a,b) -> log(eᵃ + eᵇ), is a soft version of `max(a,b)`
"""
function logadd(a::Ta, b::Tb) where {Ta <: Real, Tb <: Real}
    T = promote_type(Ta, Tb)
    isequal(a, -Inf) && return T(b)
    isequal(b, -Inf) && return T(a)
    if a < b
        a, b = b, a
    end
    l = one(T)
    return a + log(l + exp(b-a))
end



"""
    nlogadd(a <: Real, b <: Real)

Calculate (a,b) -> - log(e⁻ᵃ + e⁻ᵇ), is a soft version of `min(a,b)`
"""
function nlogadd(a::Ta, b::Tb) where {Ta <: Real, Tb <: Real}
    return - logadd(-a, -b)
end


#=
x = randn()
y = randn()
smoothmax(x,y) + smoothmin(x,y) == x + y is true
=#
const smoothmax =  logadd
const smoothmin = nlogadd
