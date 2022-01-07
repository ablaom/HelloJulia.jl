# execute this julia file to generate the notebooks from ../tutorial.jl

joinpath(@__DIR__, "..", "..", "generate.jl") |> include
generate(@__DIR__, pluto=false) # doesn't handle @time @eval macros properly
