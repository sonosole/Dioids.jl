function _smoothmax(a::Ta, b::Tb) where {Ta <: Real, Tb <: Real}
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
    logadd(a <: Real, b <: Real)

Calculate a soft version of `max(a,b)`:
    log(eᵃ + eᵇ) = log(eᵃ(1+eᵇ⁻ᵃ)) = a + log(1 + eᵇ⁻ᵃ)
"""
function logadd(a::Ta, b::Tb) where {Ta <: Real, Tb <: Real}
    MAX = max(a, b)
    MIN = min(a, b)
    return MAX + log1p(exp(MIN-MAX))
end




function _smoothmin(a::Ta, b::Tb) where {Ta <: Real, Tb <: Real}
    return - logadd(-a, -b)
end


"""
    nlogadd(a <: Real, b <: Real)

Calculate a soft version of `min(a,b)`:
    -log(e⁻ᵃ + e⁻ᵇ) = -log[e⁻ᵃ(1+eᵃ⁻ᵇ)] = a - log(1 + eᵃ⁻ᵇ)
"""
function nlogadd(a::Ta, b::Tb) where {Ta <: Real, Tb <: Real}
    MAX = max(a, b)
    MIN = min(a, b)
    return MIN - log1p(exp(MIN-MAX))
end


#=
x = randn()
y = randn()
smoothmax(x,y) + smoothmin(x,y) == x + y is true
=#
"""
    smoothmax(a <: Real, b <: Real)

Calculate a soft version of `max(a,b)`:
    log(eᵃ + eᵇ) = log(eᵃ(1+eᵇ⁻ᵃ)) = a + log(1 + eᵇ⁻ᵃ)
"""
const smoothmax =  logadd


"""
    smoothmin(a <: Real, b <: Real)

Calculate a soft version of `min(a,b)`:
    -log(e⁻ᵃ + e⁻ᵇ) = -log[e⁻ᵃ(1+eᵃ⁻ᵇ)] = a - log(1 + eᵃ⁻ᵇ)
"""
const smoothmin = nlogadd
