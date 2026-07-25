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


@testset "MaxMin: soft vs hard" begin
    x = rand()
    y = rand()
    sxy = smoothmax(x,y) + smoothmin(x,y)
    hxy = x + y
    @test isapprox(sxy, hxy, atol=1e-5)
end
