### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ 142b62e1-364e-45d6-9bca-7c69b794f8ce
md"# Tutorial 1"

# ╔═╡ 27f5936d-4043-4cb6-b795-033f6f2a0674
md"Crash course in Julia basics:"

# ╔═╡ 3f08e241-e53d-4d65-935f-ddf6a6bfbbdd
md"""
Arithmetic, arrays, tuples, strings, dictionaries, functions,
iteration, random numbers, package loading, plotting
"""

# ╔═╡ 3e3bcc53-7840-4af7-af2a-25235e544a31
md"(40 min)"

# ╔═╡ 40956165-26d0-4d61-8af5-148d95ea2900
md"## Setup"

# ╔═╡ cd938161-9f05-477e-a6bf-47194d7e8e12
md"""
The following block of code installs some third-party Julia packges. Beginners do not need
to understand them.
"""

# ╔═╡ 4474fd86-9496-44c7-828a-4cc485149963
begin
  using Pkg
  Pkg.activate(joinpath(@__DIR__, "..", ".."))
  Pkg.instantiate()
end

# ╔═╡ 96774cd2-130c-4455-9e54-3f7b3ca87ecb
md"## Julia is a calculator:"

# ╔═╡ 8e8a0cbc-96b9-490c-ba1f-6363f43ec697
1 + 2^3

# ╔═╡ a65fb83a-f977-47ce-95ea-2955abd45275
sqrt(1 + 2^3) # do `sqrt(ans)` in REPL

# ╔═╡ dc16182e-b6b3-47ee-b1b3-dd47e367ba54
sin(pi)

# ╔═╡ d8abfd9d-2625-49b8-8d7e-8e449afd1c48
md"Query a function's document:"

# ╔═╡ 048a1195-1107-46e9-a949-7f3bd292fe31
@doc sin

# ╔═╡ b6d865b7-c2f6-4c65-8514-99938a2932db
md"""
At the REPL, you can instead do `?sin`. And you can search for all
doc-strings referring to "sine" with `apropos("sine")`.
"""

# ╔═╡ c00b48c5-d35b-409a-a0de-1721c1bc2df2
md"## Arrays"

# ╔═╡ 3694faf5-d9a4-4089-bca8-7eec7950fd82
md"One dimensional vectors:"

# ╔═╡ cad4d998-43d7-421b-9873-1b1430e635cc
v = [3, 5, 7]

# ╔═╡ 5c43b0f6-30f4-4ef7-b43e-d0ebe87da176
length(v)

# ╔═╡ 26ce1939-e595-496a-9009-4cfb2012998f
md"A \"row vector\" is a 1 x n array:"

# ╔═╡ d66140c7-958b-4347-abd3-cb77d7a79683
row = [3 5 7]

# ╔═╡ 7aee99b6-3c6e-4a71-879e-dc128f3db7b3
md"Multiple row vectors separated by semicolons or new lines define matrices:"

# ╔═╡ 96c1adb9-1b29-433d-a367-9aa3c6cf34d0
A = [3 5 7
     2 4 6
     1 3 5]

# ╔═╡ ef6a776c-8c63-4d30-bf32-94657e65284e
size(A)

# ╔═╡ 4bb2001b-3b46-40f3-9afd-65a5b5facac9
length(A)

# ╔═╡ b97d12e6-2346-410b-b6c8-54f5ed90a964
md"Accessing elements (Julia indices start at 1 not 0):"

# ╔═╡ 177a30bb-473a-4e5e-9292-fe822525fc77
A[1, 2]

# ╔═╡ d0db4f8e-282e-45d4-ae5e-4b83dcbc9675
md"Get the second column:"

# ╔═╡ 26714555-a4ad-49cb-8a29-32f11452654a
A[:, 2] # 2nd column

# ╔═╡ d00b2507-e891-4ec5-a5f1-151fcbe229a2
md"Changing elements:"

# ╔═╡ 4d1dd37a-194e-4ed2-81bc-2d5603785a09
A[1, 1] = 42

# ╔═╡ 86e6e727-5a64-4c78-9d87-1d1fbb0e3997
md"""
Matrices can also be indexed as if columns where concatenated into a
single vector (which is how they are stored internally):
"""

# ╔═╡ e43cabe7-48a5-4c51-b950-fddef2a1fb10
A[2, 3] == A[8]

# ╔═╡ 38477997-58dd-4248-951b-64cb2a36c8e3
inv(A) # inverse

# ╔═╡ e61c7ae2-8204-4a20-b0e6-441461cc8770
isapprox(inv(A)*v, A\v) # but RHS more efficient

# ╔═╡ d38b7040-bb41-44be-8cb0-de601961bc02
md"## \"Variables\" in Julia *point* to objects"

# ╔═╡ 3b676271-26dc-41df-a87d-950c50fb2955
md"Corollary: all passing of function arguments is pass by reference."

# ╔═╡ 494f9e7c-e53a-4c65-8448-4bcb089096cd
md"Like Python; Unlike R, C or FORTRAN."

# ╔═╡ 6f797a43-242f-4643-a012-a84240254fb6
begin
  u = [3, 5, 7]
  
  w = u
end

# ╔═╡ 76dc6ac8-03fe-4c6e-bbdd-9799f7bb2e60
w

# ╔═╡ 30bf880d-0dc5-4690-97a7-88e3af4f10ee
u[1] = 42

# ╔═╡ dedd841b-a636-4bbd-b372-8c9866e51852
u

# ╔═╡ 76dc6ac8-03fe-4c6e-8f3d-b82f1e7b6f7a
w

# ╔═╡ 5b3a3587-31f7-4a00-ab04-579e5608ae53
md"## Tuples"

# ╔═╡ 82f84505-336f-4845-86cf-35420d9e6995
md"Similar to vectors but of fixed length and immutable (cannot be changed)"

# ╔═╡ 5b71f2a1-5567-4e59-a29a-8d0445351914
begin
  t1 = (1, 2.0, "cat")
  typeof(t1)
end

# ╔═╡ 249c3a08-3ca6-463e-be65-28d0fcca50a8
t1[3]

# ╔═╡ f85e0bbc-9db0-4a9f-9a2e-c468345d87d1
md"Tuples also come in a *named* variety:"

# ╔═╡ b8b91bc0-0a63-4695-b5fa-cb79ebf595ef
t2 = (i = 1, x = 2.0, animal="cat")

# ╔═╡ e0e4f0da-69c7-4941-91c5-524da38aa391
t2.x

# ╔═╡ 166a1850-cddb-4f72-ad90-b4405b216771
md"## Strings and relatives"

# ╔═╡ 44ef9d71-f75b-4140-895b-997a92b731e0
begin
  a_string = "the cat"
  a_character = 't'
  a_symbol = :t
end

# ╔═╡ ff4b5618-4be7-4111-a525-e9b04a4bd246
a_string[1] == a_character

# ╔═╡ b2af25ee-1007-4e6d-80f0-ba7781e173cf
md"""
A `Symbol` is string-like but
[interned](https://en.wikipedia.org/wiki/String_interning). Generally use `String` for
ordinary textual data, but use `Symbol` for language reflection (metaprogramming) - for
example when referring to the *name* of a variable, as opposed to its value:
"""

# ╔═╡ 7b5d88e0-e6ea-4568-9cbc-9a2c39793333
names = keys(t2)

# ╔═╡ 1498397f-1c26-42ff-b887-2b16710e5502
:x in names

# ╔═╡ 20ba7245-15ed-417e-9452-5298a8a4a401
isdefined(Main, :z)

# ╔═╡ 697eed84-bdd2-49cd-b017-96f1602f2cad
z = 1 + 2im

# ╔═╡ 20ba7245-15ed-417e-8be2-2a4017c45345
isdefined(Main, :z)

# ╔═╡ 65eb310b-82e8-4a1d-a7ad-80d84f5b0070
md"Symbols are generalized by *expressions*:"

# ╔═╡ 35998a8b-6fda-4a2f-8378-5aa686f0b407
begin
  ex = :(z == 3)
  eval(ex)
end

# ╔═╡ 2db5e586-237b-45aa-9f43-49763e8691a1
md"If this is confusing, forget it for now."

# ╔═╡ 8b1c08d9-f8dd-4ec9-bb0e-3a45761c733a
md"## Dictionaries"

# ╔═╡ 4942a061-18dd-41d0-9979-7044b2f2df33
d = Dict('a' => "ant", 'z' => "zebra")

# ╔═╡ d1fb9147-4a06-44fa-b2a1-fbbde543f620
d['a']

# ╔═╡ 4f4bf27c-b2f9-4c15-910b-f8a9a217eff2
begin
  d['b'] = "bat"
  d
end

# ╔═╡ 29d71401-66e5-484e-aa36-d2e8546da46a
keys(d)

# ╔═╡ 4b80c58d-646a-405b-88a1-a2bf91434413
md"The expression 'a' => \"ant\" is itself a stand-alone object:"

# ╔═╡ 6afba978-b1a6-4e33-a1cb-54e34396a855
begin
  pair = 'a' => "ant"
  first(pair)
end

# ╔═╡ 63badfd3-c501-4d7c-8037-0de5806e1a54
md"## Functions"

# ╔═╡ e089aa5e-8d6e-48a4-9961-a09632c33fb0
md"Three ways to define a generic function:"

# ╔═╡ c4c0e393-0c62-4e8e-b7cc-46f4ef988c68
begin
  foo(x) = x^2 # METHOD 1 (inline)
  foo(3)
end

# ╔═╡ 115b6c86-a0f2-4546-90fb-7f2721f6fcc7
md"or"

# ╔═╡ 3c8e1237-ff55-4dd0-af65-ccd25ecb9818
3 |> foo

# ╔═╡ 115b6c86-a0f2-4546-8890-979691212d9b
md"or"

# ╔═╡ 169c078b-2f81-4b5e-a6fa-eaf14df5d44b
3 |> x -> x^2 # METHOD 2 (anonymous)

# ╔═╡ 115b6c86-a0f2-4546-8025-5084804a9f6c
md"or"

# ╔═╡ 1d690f10-1e44-4e9a-9e90-09023d201062
begin
  function foo2(x) # METHOD 3 (verbose)
      y = x
      z = y
      w = z
      return w^2
  end
  
  foo2(3)
end

# ╔═╡ 7a568a60-5212-4c87-b7bb-2f33ef765cc0
md"## Basic iteration"

# ╔═╡ 3e371473-56dc-452a-9625-01172c4a0081
md"Here are four ways to square the integers from 1 to 10."

# ╔═╡ c3d721a1-ae10-4c0b-af4f-11c7de9e21dd
md"METHOD 1 (explicit loop):"

# ╔═╡ d9016c54-9656-4684-8dba-241d9b744683
begin
  squares = [] # or Int[] if performance matters
  for x in 1:10
      push!(squares, x^2)
  end
  
  squares
end

# ╔═╡ a707446f-b9f3-4405-a6e5-2f0b4dca5c59
md"METHOD 2 (comprehension):"

# ╔═╡ f86cc305-d2b6-4be3-8550-20498aa03ed0
[x^2 for x in 1:10]

# ╔═╡ a0c15cdb-6294-47bc-9e7b-5b943cf6b560
md"METHOD 3 (map):"

# ╔═╡ 7d2bb0cb-fe63-443b-bce6-0a1379cc1259
map(x -> x^2, 1:10)

# ╔═╡ 4455b804-b818-4fa0-9608-b5032c116833
md"METHOD 4 (broadcasting with dot syntax):"

# ╔═╡ 87188f88-6519-4ffd-b473-4aa968e6937a
(1:10) .^ 2

# ╔═╡ d1f615d1-644a-4358-8d9e-644a1b3cc6b6
md"## Random numbers"

# ╔═╡ da033108-0b83-4ee8-ac0a-23ded81445da
typeof(2)

# ╔═╡ c494e441-4853-4a6d-8535-1a088a6a3228
rand() # sample a Float64 uniformly from interval [0, 1]

# ╔═╡ 2063cdaf-dbb9-4587-a39f-7893c73eef39
rand(3, 4) # do that 12 times and put in a 3 x 4 array

# ╔═╡ a2a2be72-f9fe-4e2c-bcca-51a27994a151
randn(3, 4) # use normal distribution instead

# ╔═╡ 6deb462e-668e-475d-9b33-09b4b6661170
rand(Int8) # random elment of type Int8

# ╔═╡ 112438a5-ef2f-4c5d-b45d-88d068bb0fa2
rand(['a', 'b', 'c'], 10) # 10 random elements from a vector

# ╔═╡ b87a9e77-1e26-4a1f-92c8-6db3a590d963
md"Some standard libraries are needed to do more, for example:"

# ╔═╡ cc2371a4-26be-4325-abf5-96f457eb2bdf
using Random

# ╔═╡ 9ac1f1af-bfdc-4499-8a60-2e0214c059f5
randstring(30)

# ╔═╡ 3a2fb476-5685-40aa-a38a-beb5c7157b57
using Statistics

# ╔═╡ 974b70c1-2df2-40c6-81f5-507803ea9ed6
begin
  y = rand(30)
  mean(y)
end

# ╔═╡ 9c18343b-4459-44d2-9b21-6d4eb642d87e
quantile(y, 0.75);

# ╔═╡ 6043c761-98c1-4f5f-b98c-3df1f31879bf
md"## Probability distributions"

# ╔═╡ 133e6f93-bb0b-460d-92b7-4ceba56e97ad
md"""
For sampling from more general distributions we need
Distributions.jl package which is not part of the standard library.
"""

# ╔═╡ c0df6812-9717-454b-b122-214de244406c
begin
  using Distributions
  
  N = 1000
  samples = rand(Normal(), N);   # equivalent to Julia's built-in `randn(d)`
  samples = (samples).^2;        # square element-wise
end

# ╔═╡ f618c762-a936-433f-8a4b-c83694978e38
g = fit(Gamma, samples)

# ╔═╡ 52bf705d-bc40-4990-a8b6-f7ff516dedc4
mean(g)

# ╔═╡ 33fdde7c-1c73-42a6-81e1-74ef03c2e79e
median(g)

# ╔═╡ bcce5556-9e92-4dfa-a04e-0b76409c14a7
pdf(g, 1)

# ╔═╡ 4d822ecd-c6da-4bcb-b979-3458f2f26667
using PkgOnlineHelp

# ╔═╡ 60aef579-9404-4272-97e3-6677afc6ca9f
md"Uncomment and execute the next line to launch Distribution documentation in your browser:"

# ╔═╡ a35c0fe8-afc4-4eaf-b10e-562ce21caa04
#@docs Distributions

# ╔═╡ 2a96dfa7-cf5a-4e7f-8f78-ab549ef1544e
md"## Plotting"

# ╔═╡ fd21ac37-974b-452a-a8a4-a53f5149481e
begin
  using CairoMakie
  CairoMakie.activate!(type = "svg")
end

# ╔═╡ 6439f7a8-34f3-4a01-8704-dbab8e09b4f1
begin
  f(x) = pdf(g, x)
  
  xs = 0:0.1:4 # floats from 0 to 4 in steps of 0.1
  ys = f.(xs)  # apply f element-wise to xs
  
  fig = lines(xs, ys)
  hist!(samples, normalization=:pdf, bins=40, alpha=0.4)
  current_figure()
end

# ╔═╡ 98dfc0a3-83fc-4c05-a02f-27b6c05e4d02
save("my_first_plot.svg", fig)

# ╔═╡ a7f061b8-d1ed-4b1f-bea4-3d467d48781c
md"# Exercises"

# ╔═╡ 19dae74b-24bd-428f-97c5-2979af8a507d
md"## Exercise 1"

# ╔═╡ 3af8467f-4988-44dc-b639-63c76c72c513
md"Write a function named `total` that adds the elements of its vector input."

# ╔═╡ b04e2fdc-8f1a-4964-8f5a-e1ee9eb5c15c
md"## Exercise 2"

# ╔═╡ 2b88d9c5-61a4-4e1f-adc5-e671db8bca5d
md"""
Generate a 1000 random samples from the standard normal
distribution. Create a second such sample, and add the two samples
point-wise.  Compute the (sample) mean and variance of the combined
samples. In the same
plot, show a frequency-normalized histogram of the combined samples
and a plot of the pdf for normal distribution with zero mean and
variance `2`.
"""

# ╔═╡ b899ecf2-1e43-4783-86f1-0ea38de21abb
md"""
You can use `std` to compute the standard deviation and `sqrt` to
compute square roots.
"""

# ╔═╡ 4f939d4a-e802-4b7d-a55c-0cb44ab816d7
md"## Exercise 3"

# ╔═╡ 63f410ea-c37a-4761-be86-92ecfd0d2343
md"The following shows that named tuples share some behaviour with dictionaries:"

# ╔═╡ cb2c42bf-21b5-4e04-9cf1-facf39e3f302
begin
  t = (x = 1, y = "cat", z = 4.5)
  keys(t)
end

# ╔═╡ b8996fa3-c046-4fb1-b61c-748aec38e674
t[:y]

# ╔═╡ 6584c100-ffd6-4fa1-9727-ed822e4fd85d
md"""
Write a function called `dict` that converts a named tuple to an
actual dictionary. You can create an empty dictionary using `Dict()`.
"""

# ╔═╡ 135dac9b-0bd9-4e1d-b2f2-e08965e5be66
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─142b62e1-364e-45d6-9bca-7c69b794f8ce
# ╟─27f5936d-4043-4cb6-b795-033f6f2a0674
# ╟─3f08e241-e53d-4d65-935f-ddf6a6bfbbdd
# ╟─3e3bcc53-7840-4af7-af2a-25235e544a31
# ╟─40956165-26d0-4d61-8af5-148d95ea2900
# ╟─cd938161-9f05-477e-a6bf-47194d7e8e12
# ╠═4474fd86-9496-44c7-828a-4cc485149963
# ╟─96774cd2-130c-4455-9e54-3f7b3ca87ecb
# ╠═8e8a0cbc-96b9-490c-ba1f-6363f43ec697
# ╠═a65fb83a-f977-47ce-95ea-2955abd45275
# ╠═dc16182e-b6b3-47ee-b1b3-dd47e367ba54
# ╟─d8abfd9d-2625-49b8-8d7e-8e449afd1c48
# ╠═048a1195-1107-46e9-a949-7f3bd292fe31
# ╟─b6d865b7-c2f6-4c65-8514-99938a2932db
# ╟─c00b48c5-d35b-409a-a0de-1721c1bc2df2
# ╟─3694faf5-d9a4-4089-bca8-7eec7950fd82
# ╠═cad4d998-43d7-421b-9873-1b1430e635cc
# ╠═5c43b0f6-30f4-4ef7-b43e-d0ebe87da176
# ╟─26ce1939-e595-496a-9009-4cfb2012998f
# ╠═d66140c7-958b-4347-abd3-cb77d7a79683
# ╟─7aee99b6-3c6e-4a71-879e-dc128f3db7b3
# ╠═96c1adb9-1b29-433d-a367-9aa3c6cf34d0
# ╠═ef6a776c-8c63-4d30-bf32-94657e65284e
# ╠═4bb2001b-3b46-40f3-9afd-65a5b5facac9
# ╟─b97d12e6-2346-410b-b6c8-54f5ed90a964
# ╠═177a30bb-473a-4e5e-9292-fe822525fc77
# ╟─d0db4f8e-282e-45d4-ae5e-4b83dcbc9675
# ╠═26714555-a4ad-49cb-8a29-32f11452654a
# ╟─d00b2507-e891-4ec5-a5f1-151fcbe229a2
# ╠═4d1dd37a-194e-4ed2-81bc-2d5603785a09
# ╟─86e6e727-5a64-4c78-9d87-1d1fbb0e3997
# ╠═e43cabe7-48a5-4c51-b950-fddef2a1fb10
# ╠═38477997-58dd-4248-951b-64cb2a36c8e3
# ╠═e61c7ae2-8204-4a20-b0e6-441461cc8770
# ╟─d38b7040-bb41-44be-8cb0-de601961bc02
# ╟─3b676271-26dc-41df-a87d-950c50fb2955
# ╟─494f9e7c-e53a-4c65-8448-4bcb089096cd
# ╠═6f797a43-242f-4643-a012-a84240254fb6
# ╠═76dc6ac8-03fe-4c6e-bbdd-9799f7bb2e60
# ╠═30bf880d-0dc5-4690-97a7-88e3af4f10ee
# ╠═dedd841b-a636-4bbd-b372-8c9866e51852
# ╠═76dc6ac8-03fe-4c6e-8f3d-b82f1e7b6f7a
# ╟─5b3a3587-31f7-4a00-ab04-579e5608ae53
# ╟─82f84505-336f-4845-86cf-35420d9e6995
# ╠═5b71f2a1-5567-4e59-a29a-8d0445351914
# ╠═249c3a08-3ca6-463e-be65-28d0fcca50a8
# ╟─f85e0bbc-9db0-4a9f-9a2e-c468345d87d1
# ╠═b8b91bc0-0a63-4695-b5fa-cb79ebf595ef
# ╠═e0e4f0da-69c7-4941-91c5-524da38aa391
# ╟─166a1850-cddb-4f72-ad90-b4405b216771
# ╠═44ef9d71-f75b-4140-895b-997a92b731e0
# ╠═ff4b5618-4be7-4111-a525-e9b04a4bd246
# ╟─b2af25ee-1007-4e6d-80f0-ba7781e173cf
# ╠═7b5d88e0-e6ea-4568-9cbc-9a2c39793333
# ╠═1498397f-1c26-42ff-b887-2b16710e5502
# ╠═20ba7245-15ed-417e-9452-5298a8a4a401
# ╠═697eed84-bdd2-49cd-b017-96f1602f2cad
# ╠═20ba7245-15ed-417e-8be2-2a4017c45345
# ╟─65eb310b-82e8-4a1d-a7ad-80d84f5b0070
# ╠═35998a8b-6fda-4a2f-8378-5aa686f0b407
# ╟─2db5e586-237b-45aa-9f43-49763e8691a1
# ╟─8b1c08d9-f8dd-4ec9-bb0e-3a45761c733a
# ╠═4942a061-18dd-41d0-9979-7044b2f2df33
# ╠═d1fb9147-4a06-44fa-b2a1-fbbde543f620
# ╠═4f4bf27c-b2f9-4c15-910b-f8a9a217eff2
# ╠═29d71401-66e5-484e-aa36-d2e8546da46a
# ╟─4b80c58d-646a-405b-88a1-a2bf91434413
# ╠═6afba978-b1a6-4e33-a1cb-54e34396a855
# ╟─63badfd3-c501-4d7c-8037-0de5806e1a54
# ╟─e089aa5e-8d6e-48a4-9961-a09632c33fb0
# ╠═c4c0e393-0c62-4e8e-b7cc-46f4ef988c68
# ╟─115b6c86-a0f2-4546-90fb-7f2721f6fcc7
# ╠═3c8e1237-ff55-4dd0-af65-ccd25ecb9818
# ╟─115b6c86-a0f2-4546-8890-979691212d9b
# ╠═169c078b-2f81-4b5e-a6fa-eaf14df5d44b
# ╟─115b6c86-a0f2-4546-8025-5084804a9f6c
# ╠═1d690f10-1e44-4e9a-9e90-09023d201062
# ╟─7a568a60-5212-4c87-b7bb-2f33ef765cc0
# ╟─3e371473-56dc-452a-9625-01172c4a0081
# ╟─c3d721a1-ae10-4c0b-af4f-11c7de9e21dd
# ╠═d9016c54-9656-4684-8dba-241d9b744683
# ╟─a707446f-b9f3-4405-a6e5-2f0b4dca5c59
# ╠═f86cc305-d2b6-4be3-8550-20498aa03ed0
# ╟─a0c15cdb-6294-47bc-9e7b-5b943cf6b560
# ╠═7d2bb0cb-fe63-443b-bce6-0a1379cc1259
# ╟─4455b804-b818-4fa0-9608-b5032c116833
# ╠═87188f88-6519-4ffd-b473-4aa968e6937a
# ╟─d1f615d1-644a-4358-8d9e-644a1b3cc6b6
# ╠═da033108-0b83-4ee8-ac0a-23ded81445da
# ╠═c494e441-4853-4a6d-8535-1a088a6a3228
# ╠═2063cdaf-dbb9-4587-a39f-7893c73eef39
# ╠═a2a2be72-f9fe-4e2c-bcca-51a27994a151
# ╠═6deb462e-668e-475d-9b33-09b4b6661170
# ╠═112438a5-ef2f-4c5d-b45d-88d068bb0fa2
# ╟─b87a9e77-1e26-4a1f-92c8-6db3a590d963
# ╠═cc2371a4-26be-4325-abf5-96f457eb2bdf
# ╠═9ac1f1af-bfdc-4499-8a60-2e0214c059f5
# ╠═3a2fb476-5685-40aa-a38a-beb5c7157b57
# ╠═974b70c1-2df2-40c6-81f5-507803ea9ed6
# ╠═9c18343b-4459-44d2-9b21-6d4eb642d87e
# ╟─6043c761-98c1-4f5f-b98c-3df1f31879bf
# ╟─133e6f93-bb0b-460d-92b7-4ceba56e97ad
# ╠═c0df6812-9717-454b-b122-214de244406c
# ╠═f618c762-a936-433f-8a4b-c83694978e38
# ╠═52bf705d-bc40-4990-a8b6-f7ff516dedc4
# ╠═33fdde7c-1c73-42a6-81e1-74ef03c2e79e
# ╠═bcce5556-9e92-4dfa-a04e-0b76409c14a7
# ╠═4d822ecd-c6da-4bcb-b979-3458f2f26667
# ╟─60aef579-9404-4272-97e3-6677afc6ca9f
# ╠═a35c0fe8-afc4-4eaf-b10e-562ce21caa04
# ╟─2a96dfa7-cf5a-4e7f-8f78-ab549ef1544e
# ╠═fd21ac37-974b-452a-a8a4-a53f5149481e
# ╠═6439f7a8-34f3-4a01-8704-dbab8e09b4f1
# ╠═98dfc0a3-83fc-4c05-a02f-27b6c05e4d02
# ╟─a7f061b8-d1ed-4b1f-bea4-3d467d48781c
# ╟─19dae74b-24bd-428f-97c5-2979af8a507d
# ╟─3af8467f-4988-44dc-b639-63c76c72c513
# ╟─b04e2fdc-8f1a-4964-8f5a-e1ee9eb5c15c
# ╟─2b88d9c5-61a4-4e1f-adc5-e671db8bca5d
# ╟─b899ecf2-1e43-4783-86f1-0ea38de21abb
# ╟─4f939d4a-e802-4b7d-a55c-0cb44ab816d7
# ╟─63f410ea-c37a-4761-be86-92ecfd0d2343
# ╠═cb2c42bf-21b5-4e04-9cf1-facf39e3f302
# ╠═b8996fa3-c046-4fb1-b61c-748aec38e674
# ╟─6584c100-ffd6-4fa1-9727-ed822e4fd85d
# ╟─135dac9b-0bd9-4e1d-b2f2-e08965e5be66
