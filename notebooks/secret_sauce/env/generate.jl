# execute this julia file to generate the notebooks from ../tutorial.jl

env = @__DIR__
joinpath(env, "..", "..", "..", "generate.jl") |> include
generate(env)
