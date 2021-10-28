# # Test

# Dummy tutorial to test notebook generation for this repository

# ### Set-up

# Inspect Julia version:

VERSION

# The following instantiates a package environment.

# The package environment has been created using **Julia 1.6** and may not
# instantiate properly for other Julia versions.

using Pkg
Pkg.activate("env")
Pkg.instantiate()

#-

using Plots
x = 0:0.1:2pi
y = sin.(x)
plt = plot(x, y)
savefig("my_plot.png")
plt #!md

# ![](my_plot.png) #md
