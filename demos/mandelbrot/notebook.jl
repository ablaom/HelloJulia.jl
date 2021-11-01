# # Generate a Mandelbrot set with Julia

# Instantiate package environment:

using Pkg
Pkg.activate("env")
Pkg.instantiate()

#-

using Plots
plotly() # choose plotting backend

#-

function mandel(z)
    c = z
    maxiter = 20
    for n = 1:maxiter
        if abs(z) > 2
            return n-1
        end
        z = z^2 + c
    end
    return maxiter
end

#-

xs = -2.5:0.005:0.75
ys = -1.5:0.005:1.5
z = [mandel(x + im*y) for y in ys, x in xs]
heatmap(xs, ys, z)

#-

savefig("mandelbrot.html")
