# # Generate a Mandelbrot set with Julia

# Notebook from [HelloJulia.jl](https://github.com/ablaom/HelloJulia.jl)

# Instantiate package environment:

using Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()

#-

using Plots
plotly() # choose plotting backend

#-

function mandel(z)
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

xs = -2.5:0.005:0.75
ys = -1.5:0.005:1.5
z = [mandel(x + im*y) for y in ys, x in xs]
heatmap(xs, ys, z)

#-

savefig("mandelbrot.html")
