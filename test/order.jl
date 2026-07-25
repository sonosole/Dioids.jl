@testset "OrderPreserving" begin
    for R ∈ [==, >, ≥, <, ≤, ≈]
        α = rand()
        β = rand()
        a = Dioid{max,+}(α)
        b = Dioid{max,+}(β)
        @test R(a,b) == R(α,β)
    end
end
