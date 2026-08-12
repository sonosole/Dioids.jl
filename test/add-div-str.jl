@testset "StringAddDivOps" begin
    #= ⚠️ digital string has no common part with a-z string
       its crucial to make the test passed with no error =#

    let PREFIX  = string(rand(UInt32)),
        SUFFIX1 = reduce(*, rand('a':'z', 5)),
        SUFFIX2 = reduce(*, rand('A':'Z', 5))
        S1 = PREFIX * SUFFIX1
        S2 = PREFIX * SUFFIX2
        
        @test lcprefix(S1, S2) == PREFIX  # +
        @test deprefix(S1, S2) == SUFFIX1 # -
    end

    let SUFFIX  = string(rand(UInt32)),
        PREFIX1 = reduce(*, rand('a':'z', 5)),
        PREFIX2 = reduce(*, rand('A':'Z', 5))
        S1 = PREFIX1 * SUFFIX
        S2 = PREFIX2 * SUFFIX
        
        @test lcsuffix(S1, S2) == SUFFIX  # +
        @test desuffix(S1, S2) == PREFIX1 # -
    end
end
