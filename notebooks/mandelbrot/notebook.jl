# # Fractals using Julia

# Notebook from [HelloJulia.jl](https://github.com/ablaom/HelloJulia.jl)

# Instantiate package environment:

using Pkg
Pkg.activate(joinpath(@__DIR__, "..", ".."))
Pkg.instantiate()

#-

# Load plotting package and set in-line display type:
using CairoMakie
CairoMakie.activate!(type = "png") #nb

# To plot the famous Mandelbrot set, we need to apply the following function millions of
# times:

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

# Let's see how long it takes to apply it just once:

@time @eval mandelbrot(0.5)

# Slow!! Why? Because Julia is a *compiled* language and does not
# compile new code until it knows the type of arguments you want to
# use. (The use of the macro `@eval` helps us to include this
# compilation time in the total measurement, since `@time` is designed
# to cleverly exclude it in recent Julia versions.)

# Let's try again *with the same type* of argument:

@time @eval mandelbrot(0.6)

# Fast!!! Why? Because Julia caches the compiled code and the types
# are the same. 

# If we call with a new argument type (complex instead of float) we'll incur a compilation
# delay once more:

@time @eval mandelbrot(0.6 + im*0.1)

#-

xs = -2.5:0.01:0.75
ys = -1.5:0.01:1.5

fig = heatmap(xs, ys, (x, y) -> mandelbrot(x + im*y),
        colormap = Reverse(:deep))

#-

save("mandelbrot.png", fig);

# ![](mandelbrot.png) #nb
