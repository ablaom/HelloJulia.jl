# # Tutorial 1

# Crash course in Julia basics:

# Arithmetic, arrays, tuples, strings, dictionaries, functions,
# iteration, random numbers, package loading, plotting

# (40 min)

# ## Julia is a calculator:

1 + 2^3

#-

sqrt(1 + 2^3) # do `sqrt(ans)` in REPL

#-

sin(pi)

# Query a function's document:

@doc sin

# At the REPL, you can instead do `?sin`. And you can search for all
# doc-strings referring to "sine" with `apropos("sine")`.


# ## Arrays

# One dimensional vectors:

v = [3, 5, 7]

#-

length(v)

# A "row vector" is a 1 x n array:

row = [3 5 7]

#-

# Multiple row vectors separated by semicolons or new lines define matrices:

A = [3 5 7
     2 4 6
     1 3 5]

#-

size(A)

#-

length(A)

# Accessing elements (Julia indices start at 1 not 0):

A[1, 2]

# Get the second column:

A[:, 2] # 2nd column

# Changing elements:

A[1, 1] = 42

#-

# Matrices can also be indexed as if columns where concatenated into a
# single vector (which is how they are stored internally):

A[2, 1] == A[2]

#-

inv(A) # inverse

#-

isapprox(inv(A)*v, A\v) # but RHS more efficient


# ## "Variables" in Julia *point* to objects

# Corollary: all passing of function arguments is pass by reference.

# Like Python; Unlike R, C or FORTRAN.

u = [3, 5, 7]

w = u

#-

w

#-

u[1] = 42

#-

u

#-

w

#

# ## Tuples

# Similar to vectors but of fixed length and immutable (cannot be changed)

t1 = (1, 2.0, "cat")
typeof(t1)

#-

t1[3]

# Tuples also come in a *named* variety:

t2 = (i = 1, x = 2.0, animal="cat")

#-

t2.x

# ## Strings and relatives

a_string = "the cat"
a_character = 't'
a_symbol = :t

#-

a_string[1] == a_character

# A `Symbol` is string-like but
# [interned](https://en.wikipedia.org/wiki/String_interning). Generally
# use `String` for ordinary textual data, but use `Symbol` for
# language reflection (metaprogramming). For example:

isdefined(Main, :z)

#-

z = 1 + 2im

#-

isdefined(Main, :z)

#-

z.im

#-

fieldnames(typeof(z))

# Symbols are generalized by *expressions*:

ex = :(z == 3)
eval(ex)

# If this is confusing, forget it for now.


# ## Dictionaries

d = Dict('a' => "ant", 'z' => "zebra")

#-

d['a']

#-

d['b'] = "bat"
d

#-

keys(d)

# The expression 'a' => "ant" is itself a stand-alone object:

pair = 'a' => "ant"
first(pair)


# ## Functions

# Three ways to define a generic function:

foo(x) = x^2 # METHOD 1 (inline)
foo(3)

# or

3 |> foo

# or

3 |> x -> x^2 # METHOD 2 (anonymous)

# or

function foo2(x) # METHOD 3 (verbose)
    y = x
    z = y
    w = z
    return w^2
end

foo2(3)


# ## Basic iteration

# Here are four ways to square the integers from 1 to 10.

# METHOD 1 (explicit loop):

squares = [] # or Int[] if performance matters
for x in 1:10
    push!(squares, x^2)
end

squares


# METHOD 2 (comprehension):

[x^2 for x in 1:10]

# METHOD 3 (map):

map(x -> x^2, 1:10)


# METHOD 4 (broadcasting with dot syntax):

(1:10) .^ 2


# ## Random numbers

typeof(2)

#-

rand() # sample a Float64 uniformly from interval [0, 1]

#-

rand(3, 4) # do that 12 times and put in a 3 x 4 array

#-

randn(3, 4) # use normal distribution instead

#-

rand(Int8) # random elment of type Int8

#-

rand(['a', 'b', 'c'], 10) # 10 random elements from a vector

# Some standard libraries are needed to do more, for example:

using Random

#-

randstring(30)

#-

using Statistics

#-

y = rand(30)
mean(y)

#-

quantile(y, 0.75);

# (Use the macro @show before stuff you want printed prefixed by
# *what* it is that is being printed.)

# For sampling from more general distributions we need
# Distributions.jl package which is not part of the standard library.


# ## Loading packages

# If not in the REPL:

using Pkg                        # built-in package manager
Pkg.status()                     # list packages in active environment
Pkg.activate("env", shared=true) # create a new pkg env

# Add some packages to your environment (latest compatible versions
# added by default):

Pkg.add("Distributions")
Pkg.add("ElectronDisplay") #src
Pkg.add("CairoMakie")
Pkg.status()

# To load the code for use:

using Distributions

using ElectronDisplay #src
using CairoMakie
CairoMakie.activate!(type = "svg")

N = 1000
samples = rand(Normal(), N);   # equivalent to Julia's built-in `randn(d)`
samples = (samples).^2;        # square element-wise

#-

g = fit(Gamma, samples)

#-

mean(g)

#-

median(g)

#-

pdf(g, 1)


# ## Plotting

f(x) = pdf(g, x)

xs = 0:0.1:4 # floats from 0 to 4 in steps of 0.1
ys = f.(xs)  # apply f element-wise to xs

fig = lines(xs, ys)
hist!(samples, normalization=:pdf, bins=40, alpha=0.4)
current_figure()

#-

save("my_first_plot.svg", fig)


# # Exercises

# ## Exercise 1

# Write a function named `total` that adds the elements of its vector input.

# ## Exercise 2

# Generate a 1000 random samples from the standard normal
# distribution. Create a second such sample, and add the two samples
# point-wise.  Compute the (sample) mean and variance of the combined
# samples. In the same
# plot, show a frequency-normalized histogram of the combined samples
# and a plot of the pdf for normal distribution with zero mean and
# variance `2`.

# You can use `std` to compute the standard deviation and `sqrt` to
# compute square roots.

# ## Exercise 3

# The following shows that named tuples share some behaviour with dictionaries:

t = (x = 1, y = "cat", z = 4.5)
keys(t)

#-

t[:y]

#-

# Write a function called `dict` that converts a named tuple to an
# actual dictionary. You can create an empty dictionary using `Dict()`.
