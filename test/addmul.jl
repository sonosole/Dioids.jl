@testset "AddMulOps" begin
    fs = [+,*, max,min, logadd,nlogadd]
    for ⨁ ∈ fs, ⨀ ∈ fs
        ⨁ == ⨀ && continue
        α = rand() + 1
        β = rand() + 1
        a = Dioid{⨁,⨀}(α)
        b = Dioid{⨁,⨀}(β)
        @test a+b == Dioid{⨁,⨀}(⨁(α,β))
        @test a*b == Dioid{⨁,⨀}(⨀(α,β))
    end

    fs = [lcprefix, *, lcsuffix]
    for ⨁ ∈ fs, ⨀ ∈ fs
        ⨁ == ⨀ && continue
        α = "sole_luna_yi"
        β = "sole_yi"
        a = Dioid{⨁,⨀}(α)
        b = Dioid{⨁,⨀}(β)
        @test a+b == Dioid{⨁,⨀}(⨁(α,β))
        @test a*b == Dioid{⨁,⨀}(⨀(α,β))
    end

    fs = [lcm, gcd]
    for ⨁ ∈ fs, ⨀ ∈ fs
        ⨁ == ⨀ && continue
        α = rand(0:1:100)
        β = rand(0:1:100)
        a = Dioid{⨁,⨀}(α)
        b = Dioid{⨁,⨀}(β)
        @test a+b == Dioid{⨁,⨀}(⨁(α,β))
        @test a*b == Dioid{⨁,⨀}(⨀(α,β))
    end

    fs = [|, &]
    for ⨁ ∈ fs, ⨀ ∈ fs
        ⨁ == ⨀ && continue
        α = rand(Bool)
        β = rand(Bool)
        a = Dioid{⨁,⨀}(α)
        b = Dioid{⨁,⨀}(β)
        @test a+b == Dioid{⨁,⨀}(⨁(α,β))
        @test a*b == Dioid{⨁,⨀}(⨀(α,β))
    end

    begin
        α = (rand(), randn())
        β = (rand(), randn())
        a = Dual{Float64}(α)
        b = Dual{Float64}(β)
        @test a+b == Dual{Float64}(dual₊(α,β))
        @test a*b == Dual{Float64}(dualₓ(α,β))
    end

    begin
        α = (rand(), rand(1:100))
        β = (rand(), rand(1:100))
        a = Carctic{Float64}(α)
        b = Carctic{Float64}(β)
        @test a+b == Carctic{Float64}(carctic₊(α,β))
        @test a*b == Carctic{Float64}(carcticₓ(α,β))
    end
end

