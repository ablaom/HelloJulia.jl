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


# ## Just-in-time compilation

# Here's how we define a new function in Julia:

add(x, y) = x + y

# Let's see how long it takes to add two numbers:

t = time(); add(3, 5); time() - t

# Slow!! Why? Because Julia is a *compiled* language and does not
# compile new code until it knows the type of arguments you want to
# use.

# Let's try again *with the same type* of argument:

t = time(); add(4, 7); time() - t

# Fast!!! Why? Because Julia caches the compiled code and the types
# are the same.

# Let's try complex numbers:

t = time(); add(1 + 2im, 4 + 3im); time() - t

# Slow :-(

t = time(); add(3 + 6im, 7 - 5im); time() - t

# Fast :-)


# ## Multiple dispatch

y = [1 2; 3 4]

#-

typeof(y)

# Julia doesn't know how to apply `+` to a scalar and a
# matrix. Uncomment the following line to see the error thrown:

## add(4, y)

# So we add a more specialized version of our function (called a
# *method*) to handle this case:

add(x::Int, y::Array{Int,2}) = x .+ y

# Here we are using the built-in broadcasted version of `+` which adds
# the scalar `x` to each element of `y`. Now this works:

add(4, y)

# This is essentially what multiple dispatch is about. We use *all*
# the arguments of a function to determine what specific method to
# call. In a traditional object oriented language methods are owned by
# objects (data structures) and we see syntax like `x.add(y)` which is
# *single* dispatch on `x`.

# In Julia *functions*, not objects, own *methods*:

methods(add)

# Or, stated differently, there is less conflation of *structure* and
# *behaviour* in Julia!

# But, we're not out of the woods yet. Uncomment to see a new error
# thrown:

## add(4.0, y)

# Oh dear. Do we need to write a special method for every kind of
# scalar and matrix???!

# No, because abstract types come to the rescue...


# ## Abstract types

# Everything in Julia has a type:

typeof(1 + 2im)

#-

typeof(rand(2,3))

#-

# These are examples of *concrete* types. But concrete types have
# *supertypes*, which are *abstract*:

supertype(Int)

#-

supertype(Signed)

#-

supertype(Integer)

# And we can travel in the other direction:

subtypes(Real)

#-

4 isa Real

#-

Bool <: Integer

#-

String <: Integer

# Now we can solve our problem: How to extend our `add` function to
# arbitrary scalars and matrices:

add(x::Real, y::Matrix) = x .+ y

#-

add(4.0, rand(Bool, 2, 3))

# Note that abstract types have no instances. The only "information"
# in an abstract type is what its supertype and subtypes
# are. Collectively, abstract types and concrete types constitute a
# tree structure, with the concrete types as leaves. This structure
# exists to *organize* the concrete types in a way that facilitates
# extension of functionality. This tree is not static, but can be
# extended by the programmer.
