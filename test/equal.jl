@testset "Equalities: String vs Strinf" begin
    str = "abc"
    @test (s∞ == s∞) == true
    @test (s∞ != s∞) == false
    @test (s∞ ≠ s∞)  == false

    @test (s∞ == str) == false
    @test (str == s∞) == false

    @test (s∞ != str) == true
    @test (str != s∞) == true
    @test (s∞ ≠ str)  == true
    @test (str ≠ s∞)  == true
end


import Dioids._smoothmax
import Dioids._smoothmin

@testset "MaxMin: soft vs hard" begin
    x = rand(Int)/10
    y = rand(Int)/10
    sxy = smoothmax(x,y) + smoothmin(x,y)
    @test isapprox(sxy, x + y, atol=1e-5)

    _sxy = _smoothmax(x,y) + _smoothmin(x,y)
    @test isapprox(sxy, _sxy, rtol=1e-5)

    A = rand(Int, 32, 32) ./ 10
    B = rand(Int, 32, 32) ./ 10
    @test all(@. isapprox(smoothmax(A,B), _smoothmax(A,B), rtol=1e-5))
    @test all(@. isapprox(smoothmin(A,B), _smoothmin(A,B), rtol=1e-5))
end;
