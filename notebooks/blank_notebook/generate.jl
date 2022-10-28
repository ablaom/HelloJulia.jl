# execute this julia file to generate the notebooks from notebook.jl

joinpath(@__DIR__, "..", "..", "src", "_generate.jl") |> include
generate(@__DIR__)
