# # Solutions to exercises

# ## Setup

# The following instantiates a package environment.

using Pkg
Pkg.activate(joinpath(@__DIR__, "..", ".."))
Pkg.instantiate()


# ## Exercise 1

# Write a function named `total` that adds the elements of its vector input.

# ### Solution

function total(v)
    sum = 0.0 # better is zero(v)
    for i in 1:length(v)
        sum = sum + v[i]
    end
    return sum
end

#-

total(1:10)

# The built-in function is called `sum`.


# ## Exercise 2

# Generate a 1000 random samples from the standard normal
# distribution. Create a second such sample, and add the two samples
# point-wise.  Compute the (sample) mean and variance of the combined
# samples. In the same plot, show a frequency-normalized histogram of
# the combined samples and a plot of the pdf for normal distribution
# with zero mean and variance `2`.

# ### Solution

using Distributions, Statistics

samples1 = randn(1000); # or rand(Normal(), 1000)
samples2 = randn(1000);

samples = samples1 .+ samples2;

mu = mean(samples)
var = std(samples)^2

@show mu var

#-

d = Normal(0, sqrt(2))
f(x) = pdf(d, x)

xs = -5:(0.1):5
ys = f.(xs);

using CairoMakie
using ElectronDisplay #src
CairoMakie.activate!(type = "svg") #nb

fig = hist(samples, normalization=:pdf)
lines!(xs, ys)
current_figure()


# ## Exercise 3

# The following shows that named tuples share some behaviour with dictionaries:

t = (x = 1, y = "cat", z = 4.5)
keys(t)

#-

t[:y]

#-

# Write a function called `dict` that converts a named tuple to an
# actual dictionary. You can create an empty dictionary using `Dict()`.

# ### Solution

function dict(t)
    d = Dict()
    for k in keys(t)
        d[k] = t[k]
    end
    return d
end

#-

dict(t)

# A slicker way to do the same thing is:

dict2(t) = Dict(k => t[k] for k in keys(t))
