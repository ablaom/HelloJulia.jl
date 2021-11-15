# # Basic demonstration of Julia package composability

# Instantiate package environment:

using Pkg
Pkg.activate("env")
Pkg.instantiate()


# The Unitiful package allows you to **bind physical units** to numerical data:

using Unitful

#-

a = 5.0u"m^2/s^2"

#-

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
