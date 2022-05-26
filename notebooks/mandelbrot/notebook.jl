# # Fractals using Julia

# Notebook from [HelloJulia.jl](https://github.com/ablaom/HelloJulia.jl)

# Instantiate package environment:

using Pkg
Pkg.activate(joinpath(@__DIR__, "..", ".."))
Pkg.instantiate()

#-

# Load plotting package and set in-line display type:
using CairoMakie
CairoMakie.activate!(type = "svg") #nb

#-

function mandelbrot(z)
    c = z     # starting value and constant shift
    max_iterations = 20
    for n = 1:max_iterations
        if abs(z) > 2
            return n-1
        end
        z = z^2 + c
    end
    return max_iterations
end

#-

xs = -2.5:0.01:0.75
ys = -1.5:0.01:1.5

fig = heatmap(xs, ys, (x, y) -> mandelbrot(x + im*y),
        colormap = Reverse(:deep))

#-

save("mandelbrot.svg", fig);

# ![](mandelbrot.svg) #nb
