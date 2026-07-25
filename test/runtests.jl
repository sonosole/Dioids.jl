using Dioids
using Test

@testset verbose=true "Dioids" begin
    include("add-div-str.jl")
    include("addmul.jl")
    include("adj.jl")
    include("alias.jl")
    include("bcast.jl")
    include("copy.jl")
    include("equal.jl")
    include("identity.jl")
    include("order.jl")
    include("parse.jl")
    include("promote.jl")
    include("random.jl")
end
