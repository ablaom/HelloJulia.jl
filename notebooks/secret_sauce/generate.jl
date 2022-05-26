# execute this julia file to generate the notebooks from notebook.jl

joinpath(@__DIR__, "..", "..", "src", "_generate.jl") |> include
generate(@__DIR__)#, pluto=false) # doesn't handle @time @eval macros properly
