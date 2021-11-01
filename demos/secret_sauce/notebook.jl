# # Brief sketch of Julia's secret sauce

# Julia's *secret sauce*

# - **Ahead-of-time compilation**
# - **Multiple dispatch**
# - **Abstract types**

# The following is not needed if running from the REPL:

using Pkg
Pkg.activate(temp=true)
Pkg.add("InteractiveUtils")
using InteractiveUtils

#-

## Just-in-time compilation

# **Note.** Because of some more recent fancy optimizations, this demo only
# works on Julia versions 1.3 and older.

2 + 2

#-

typeof(42.0)

# ## Just-in-time compilation

add(x, y) = x + y

@elapsed add(3, 5)

#-

@elapsed add(2, 4)

#-

@elapsed add(1 + 2im, 4 + 3im)

#-

@elapsed add(3 + 6im, 7 - 5im)


# ## Multiple dispatch

# Objects don't own methods, functions do:

y = [1 2; 3 4]

#-

typeof(y)

# Uncomment to see error thrown:

# add(4, y)

#-

add(x::Int, y::Array{Int,2}) = x .+ y

#-

add(4, y)

#-

methods(add)

# Uncomment to see error thrown:

# add(4.0, y)


# ## Abstract types

supertype(Int)

#-

supertype(Signed)

#-

supertype(Integer)

#-

subtypes(Real)

#-

4 isa Real

#-

Bool <: Integer

#-

String <: Integer

#-

add(x::Real, y::Matrix) = x .+ y

#-

add(4.0, rand(Bool, 2, 3))
