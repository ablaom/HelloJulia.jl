# execute this julia file to generate the notebooks from ../tutorial.jl

joinpath(@__DIR__, "..", "..", "generate.jl") |> include
generate(@__DIR__, execute=false) # problem with apropos in notebook