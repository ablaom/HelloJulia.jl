# # Basic demonstration of Julia package composability

# Notebook from [HelloJulia.jl](https://github.com/ablaom/HelloJulia.jl)

# Instantiate package environment:

using Pkg
Pkg.activate(joinpath(@__DIR__, "..", ".."))
Pkg.instantiate()


# The Unitiful package allows you to **bind physical units** to numerical data:

using Unitful

#-

A = 5.0u"m^2/s^2"

#-

sqrt(A)

# The using Measurements package allows you to **propogate uncertainties**
# in numerical computations:

using Measurements

#

b = 5.0 ± 1.2 # or measurement(5.0, 1.2)

#-

sqrt(b)

#-

# The Unitful and Measurements packages are blissfully ignorant of one
# another. That, is neither package is a dependency of the other. And yet the
# following "just works", as if by magic:

c = 5.0u"m^2/s^2" ± 0.1u"m^2/s^2"

#-

sqrt(c)
