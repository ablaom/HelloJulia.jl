### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ 4474fd86-9496-44c7-9e54-3f7b3ca87ecb
begin
  using Pkg
  Pkg.activate(joinpath(@__DIR__, "..", ".."))
  Pkg.instantiate()
end

# ╔═╡ cc2371a4-26be-4325-a38a-beb5c7157b57
using Random

# ╔═╡ 3a2fb476-5685-40aa-9b21-6d4eb642d87e
using Statistics

# ╔═╡ c0df6812-9717-454b-a8b6-f7ff516dedc4
begin
  using Distributions
  
  N = 1000
  samples = rand(Normal(), N);   # equivalent to Julia's built-in `randn(d)`
  samples = (samples).^2;        # square element-wise
end

# ╔═╡ 4d822ecd-c6da-4bcb-b10e-562ce21caa04
using PkgOnlineHelp

# ╔═╡ 912dc07c-b98e-45fb-a02f-27b6c05e4d02
begin
  using CairoMakie
  CairoMakie.activate!(type = "png")
end

# ╔═╡ 142b62e1-364e-45d6-9bca-7c69b794f8ce
md"# Tutorial 1"

# ╔═╡ eb23f2c6-61f4-4a82-b795-033f6f2a0674
md"Notebook from [HelloJulia.jl](https://github.com/ablaom/HelloJulia.jl)"

# ╔═╡ 27f5936d-4043-4cb6-935f-ddf6a6bfbbdd
md"Crash course in Julia basics:"

# ╔═╡ 3f08e241-e53d-4d65-af2a-25235e544a31
md"""
Arithmetic, arrays, tuples, strings, dictionaries, functions,
iteration, random numbers, package loading, plotting
"""

# ╔═╡ 3e3bcc53-7840-4af7-8af5-148d95ea2900
md"(40 min)"

# ╔═╡ 40956165-26d0-4d61-a6bf-47194d7e8e12
md"## Setup"

# ╔═╡ c50bf0b8-8a19-4086-828a-4cc485149963
md"""
The following block of code installs some third-party Julia packges. Beginners do not need
to understand it.
"""

# ╔═╡ 96774cd2-130c-4455-ba1f-6363f43ec697
md"## Julia is a calculator:"

# ╔═╡ 8e8a0cbc-96b9-490c-95ea-2955abd45275
1 + 2^3

# ╔═╡ a65fb83a-f977-47ce-b1b3-dd47e367ba54
sqrt(1 + 2^3) # do `sqrt(ans)` in REPL

# ╔═╡ dc16182e-b6b3-47ee-8d7e-8e449afd1c48
sin(pi)

# ╔═╡ d8abfd9d-2625-49b8-a949-7f3bd292fe31
md"Query a function's document:"

# ╔═╡ 048a1195-1107-46e9-8514-99938a2932db
@doc sin

# ╔═╡ b6d865b7-c2f6-4c65-a0de-1721c1bc2df2
md"""
At the REPL, you can instead do `?sin`. And you can search for all
doc-strings referring to "sine" with `apropos("sine")`.
"""

# ╔═╡ c00b48c5-d35b-409a-bca8-7eec7950fd82
md"## Arrays"

# ╔═╡ 3694faf5-d9a4-4089-9873-1b1430e635cc
md"One dimensional vectors:"

# ╔═╡ cad4d998-43d7-421b-b43e-d0ebe87da176
v = [3, 5, 7]

# ╔═╡ 5c43b0f6-30f4-4ef7-9009-4cfb2012998f
length(v)

# ╔═╡ 26ce1939-e595-496a-abd3-cb77d7a79683
md"A \"row vector\" is a 1 x n array:"

# ╔═╡ d66140c7-958b-4347-879e-dc128f3db7b3
row = [3 5 7]

# ╔═╡ 7aee99b6-3c6e-4a71-a367-9aa3c6cf34d0
md"Multiple row vectors separated by semicolons or new lines define matrices:"

# ╔═╡ 96c1adb9-1b29-433d-bf32-94657e65284e
A = [3 5 7
     2 4 6
     1 3 5]

# ╔═╡ ef6a776c-8c63-4d30-9afd-65a5b5facac9
size(A)

# ╔═╡ 4bb2001b-3b46-40f3-b6c8-54f5ed90a964
length(A)

# ╔═╡ b97d12e6-2346-410b-9292-fe822525fc77
md"Accessing elements (Julia indices start at 1 not 0):"

# ╔═╡ 177a30bb-473a-4e5e-ae5e-4b83dcbc9675
A[1, 2]

# ╔═╡ d0db4f8e-282e-45d4-8a29-32f11452654a
md"Get the second column:"

# ╔═╡ 26714555-a4ad-49cb-a5f1-151fcbe229a2
A[:, 2] # 2nd column

# ╔═╡ d00b2507-e891-4ec5-81bc-2d5603785a09
md"Changing elements:"

# ╔═╡ 4d1dd37a-194e-4ed2-9d87-1d1fbb0e3997
A[1, 1] = 42

# ╔═╡ 86e6e727-5a64-4c78-b950-fddef2a1fb10
md"""
Matrices can also be indexed as if columns where concatenated into a
single vector (which is how they are stored internally):
"""

# ╔═╡ e43cabe7-48a5-4c51-951b-64cb2a36c8e3
A[2, 3] == A[8]

# ╔═╡ 38477997-58dd-4248-b0e6-441461cc8770
inv(A) # inverse

# ╔═╡ e61c7ae2-8204-4a20-8cb0-de601961bc02
isapprox(inv(A)*v, A\v) # but RHS more efficient

# ╔═╡ d38b7040-bb41-44be-a87d-950c50fb2955
md"## \"Variables\" in Julia *point* to objects"

# ╔═╡ 3b676271-26dc-41df-8448-4bcb089096cd
md"Corollary: all passing of function arguments is pass by reference."

# ╔═╡ 494f9e7c-e53a-4c65-a012-a84240254fb6
md"Like Python; Unlike R, C or FORTRAN."

# ╔═╡ 6f797a43-242f-4643-bbdd-9799f7bb2e60
begin
  u = [3, 5, 7]
  
  w = u
end

# ╔═╡ 76dc6ac8-03fe-4c6e-97a7-88e3af4f10ee
w

# ╔═╡ 30bf880d-0dc5-4690-b372-8c9866e51852
u[1] = 42

# ╔═╡ dedd841b-a636-4bbd-8f3d-b82f1e7b6f7a
u

# ╔═╡ 76dc6ac8-03fe-4c6e-ab04-579e5608ae53
w

# ╔═╡ 5b3a3587-31f7-4a00-86cf-35420d9e6995
md"## Tuples"

# ╔═╡ 82f84505-336f-4845-a29a-8d0445351914
md"Similar to vectors but of fixed length and immutable (cannot be changed)"

# ╔═╡ 5b71f2a1-5567-4e59-be65-28d0fcca50a8
begin
  t1 = (1, 2.0, "cat")
  typeof(t1)
end

# ╔═╡ 249c3a08-3ca6-463e-9a2e-c468345d87d1
t1[3]

# ╔═╡ f85e0bbc-9db0-4a9f-b5fa-cb79ebf595ef
md"Tuples also come in a *named* variety:"

# ╔═╡ b8b91bc0-0a63-4695-91c5-524da38aa391
t2 = (i = 1, x = 2.0, animal="cat")

# ╔═╡ e0e4f0da-69c7-4941-ad90-b4405b216771
t2.x

# ╔═╡ 166a1850-cddb-4f72-895b-997a92b731e0
md"## Strings and relatives"

# ╔═╡ 44ef9d71-f75b-4140-a525-e9b04a4bd246
begin
  a_string = "the cat"
  a_character = 't'
  a_symbol = :t
end

# ╔═╡ ff4b5618-4be7-4111-80f0-ba7781e173cf
a_string[1] == a_character

# ╔═╡ b2af25ee-1007-4e6d-9cbc-9a2c39793333
md"""
A `Symbol` is string-like but
[interned](https://en.wikipedia.org/wiki/String_interning). Generally use `String` for
ordinary textual data, but use `Symbol` for language reflection (metaprogramming) - for
example when referring to the *name* of a variable, as opposed to its value:
"""

# ╔═╡ 7b5d88e0-e6ea-4568-b887-2b16710e5502
names = keys(t2)

# ╔═╡ 1498397f-1c26-42ff-9452-5298a8a4a401
:x in names

# ╔═╡ ff78a242-e137-4043-b017-96f1602f2cad
isdefined(@__MODULE__, :z)

# ╔═╡ 697eed84-bdd2-49cd-8be2-2a4017c45345
z = 1 + 2im

# ╔═╡ ff78a242-e137-4043-a7ad-80d84f5b0070
isdefined(@__MODULE__, :z)

# ╔═╡ 65eb310b-82e8-4a1d-8378-5aa686f0b407
md"Symbols are generalized by *expressions*:"

# ╔═╡ 0a592f40-596b-43ce-9f43-49763e8691a1
ex = :(z == 3)

# ╔═╡ 6b31d4c7-8229-4f76-bb0e-3a45761c733a
eval(ex)

# ╔═╡ 2db5e586-237b-45aa-9979-7044b2f2df33
md"If this is confusing, forget it for now."

# ╔═╡ 8b1c08d9-f8dd-4ec9-b2a1-fbbde543f620
md"## Dictionaries"

# ╔═╡ 4942a061-18dd-41d0-910b-f8a9a217eff2
d = Dict('a' => "ant", 'z' => "zebra")

# ╔═╡ d1fb9147-4a06-44fa-aa36-d2e8546da46a
d['a']

# ╔═╡ 4f4bf27c-b2f9-4c15-88a1-a2bf91434413
begin
  d['b'] = "bat"
  d
end

# ╔═╡ 29d71401-66e5-484e-a1cb-54e34396a855
keys(d)

# ╔═╡ 2c99a8b4-cc41-4ea1-8037-0de5806e1a54
md"The expression 'a' => \"ant\" is itself a stand-alone object called a *pair*:"

# ╔═╡ 6afba978-b1a6-4e33-9961-a09632c33fb0
begin
  pair = 'a' => "ant"
  first(pair)
end

# ╔═╡ 63badfd3-c501-4d7c-b7cc-46f4ef988c68
md"## Functions"

# ╔═╡ e089aa5e-8d6e-48a4-90fb-7f2721f6fcc7
md"Three ways to define a generic function:"

# ╔═╡ c4c0e393-0c62-4e8e-af65-ccd25ecb9818
begin
  foo(x) = x^2 # METHOD 1 (inline)
  foo(3)
end

# ╔═╡ 115b6c86-a0f2-4546-8890-979691212d9b
md"or"

# ╔═╡ 3c8e1237-ff55-4dd0-a6fa-eaf14df5d44b
3 |> foo

# ╔═╡ 115b6c86-a0f2-4546-8025-5084804a9f6c
md"or"

# ╔═╡ 169c078b-2f81-4b5e-9e90-09023d201062
3 |> x -> x^2 # METHOD 2 (anonymous)

# ╔═╡ 115b6c86-a0f2-4546-b7bb-2f33ef765cc0
md"or"

# ╔═╡ 1d690f10-1e44-4e9a-9625-01172c4a0081
begin
  function foo2(x) # METHOD 3 (verbose)
      y = x
      z = y
      w = z
      return w^2
  end
  
  foo2(3)
end

# ╔═╡ 7a568a60-5212-4c87-af4f-11c7de9e21dd
md"## Basic iteration"

# ╔═╡ 3e371473-56dc-452a-8dba-241d9b744683
md"Here are four ways to square the integers from 1 to 10."

# ╔═╡ c3d721a1-ae10-4c0b-a6e5-2f0b4dca5c59
md"METHOD 1 (explicit loop):"

# ╔═╡ d9016c54-9656-4684-8550-20498aa03ed0
begin
  squares = [] # or Int[] if performance matters
  for x in 1:10
      push!(squares, x^2)
  end
  
  squares
end

# ╔═╡ a707446f-b9f3-4405-9e7b-5b943cf6b560
md"METHOD 2 (comprehension):"

# ╔═╡ f86cc305-d2b6-4be3-bce6-0a1379cc1259
[x^2 for x in 1:10]

# ╔═╡ a0c15cdb-6294-47bc-9608-b5032c116833
md"METHOD 3 (map):"

# ╔═╡ 7d2bb0cb-fe63-443b-b473-4aa968e6937a
map(x -> x^2, 1:10)

# ╔═╡ 4455b804-b818-4fa0-8d9e-644a1b3cc6b6
md"METHOD 4 (broadcasting with dot syntax):"

# ╔═╡ 87188f88-6519-4ffd-ac0a-23ded81445da
(1:10) .^ 2

# ╔═╡ d1f615d1-644a-4358-8535-1a088a6a3228
md"## Random numbers"

# ╔═╡ da033108-0b83-4ee8-a39f-7893c73eef39
typeof(2)

# ╔═╡ c494e441-4853-4a6d-bcca-51a27994a151
rand() # sample a Float64 uniformly from interval [0, 1]

# ╔═╡ 2063cdaf-dbb9-4587-9b33-09b4b6661170
rand(3, 4) # do that 12 times and put in a 3 x 4 array

# ╔═╡ a2a2be72-f9fe-4e2c-b45d-88d068bb0fa2
randn(3, 4) # use normal distribution instead

# ╔═╡ 6deb462e-668e-475d-92c8-6db3a590d963
rand(Int8) # random elment of type Int8

# ╔═╡ 112438a5-ef2f-4c5d-abf5-96f457eb2bdf
rand(['a', 'b', 'c'], 10) # 10 random elements from a vector

# ╔═╡ b87a9e77-1e26-4a1f-8a60-2e0214c059f5
md"Some standard libraries are needed to do more, for example:"

# ╔═╡ 9ac1f1af-bfdc-4499-81f5-507803ea9ed6
randstring(30)

# ╔═╡ 974b70c1-2df2-40c6-b98c-3df1f31879bf
begin
  y = rand(30)
  mean(y)
end

# ╔═╡ 9a14db74-4138-42b0-92b7-4ceba56e97ad
quantile(y, 0.75)

# ╔═╡ 6043c761-98c1-4f5f-b122-214de244406c
md"## Probability distributions"

# ╔═╡ 133e6f93-bb0b-460d-8a4b-c83694978e38
md"""
For sampling from more general distributions we need
Distributions.jl package which is not part of the standard library.
"""

# ╔═╡ f618c762-a936-433f-81e1-74ef03c2e79e
g = fit(Gamma, samples)

# ╔═╡ 52bf705d-bc40-4990-a04e-0b76409c14a7
mean(g)

# ╔═╡ 33fdde7c-1c73-42a6-b979-3458f2f26667
median(g)

# ╔═╡ bcce5556-9e92-4dfa-97e3-6677afc6ca9f
pdf(g, 1)

# ╔═╡ 60aef579-9404-4272-8f78-ab549ef1544e
md"Uncomment and execute the next line to launch Distribution documentation in your browser:"

# ╔═╡ a35c0fe8-afc4-4eaf-a8a4-a53f5149481e
#@docs Distributions

# ╔═╡ 2a96dfa7-cf5a-4e7f-8704-dbab8e09b4f1
md"## Plotting"

# ╔═╡ 6439f7a8-34f3-4a01-bea4-3d467d48781c
begin
  f(x) = pdf(g, x)
  
  xs = 0:0.1:4 # floats from 0 to 4 in steps of 0.1
  ys = f.(xs)  # apply f element-wise to xs
  
  fig = lines(xs, ys)
  hist!(samples, normalization=:pdf, bins=40, alpha=0.4)
  current_figure()
end

# ╔═╡ bf64e629-d0bc-4e89-97c5-2979af8a507d
save("my_first_plot.png", fig)

# ╔═╡ a7f061b8-d1ed-4b1f-b639-63c76c72c513
md"# Exercises"

# ╔═╡ 19dae74b-24bd-428f-8f5a-e1ee9eb5c15c
md"## Exercise 1"

# ╔═╡ 3af8467f-4988-44dc-adc5-e671db8bca5d
md"Write a function named `total` that adds the elements of its vector input."

# ╔═╡ b04e2fdc-8f1a-4964-86f1-0ea38de21abb
md"## Exercise 2"

# ╔═╡ 2b88d9c5-61a4-4e1f-a55c-0cb44ab816d7
md"""
Generate a 1000 random samples from the standard normal
distribution. Create a second such sample, and add the two samples
point-wise.  Compute the (sample) mean and variance of the combined
samples. In the same
plot, show a frequency-normalized histogram of the combined samples
and a plot of the pdf for normal distribution with zero mean and
variance `2`.
"""

# ╔═╡ b899ecf2-1e43-4783-be86-92ecfd0d2343
md"""
You can use `std` to compute the standard deviation and `sqrt` to
compute square roots.
"""

# ╔═╡ 4f939d4a-e802-4b7d-9cf1-facf39e3f302
md"## Exercise 3"

# ╔═╡ 63f410ea-c37a-4761-b61c-748aec38e674
md"The following shows that named tuples share some behaviour with dictionaries:"

# ╔═╡ cb2c42bf-21b5-4e04-9727-ed822e4fd85d
begin
  t = (x = 1, y = "cat", z = 4.5)
  keys(t)
end

# ╔═╡ b8996fa3-c046-4fb1-b2f2-e08965e5be66
t[:y]

# ╔═╡ 6584c100-ffd6-4fa1-897c-f79712f9ec7c
md"""
Write a function called `dict` that converts a named tuple to an
actual dictionary. You can create an empty dictionary using `Dict()`.
"""

# ╔═╡ 135dac9b-0bd9-4e1d-a543-f9324a87efad
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─142b62e1-364e-45d6-9bca-7c69b794f8ce
# ╟─eb23f2c6-61f4-4a82-b795-033f6f2a0674
# ╟─27f5936d-4043-4cb6-935f-ddf6a6bfbbdd
# ╟─3f08e241-e53d-4d65-af2a-25235e544a31
# ╟─3e3bcc53-7840-4af7-8af5-148d95ea2900
# ╟─40956165-26d0-4d61-a6bf-47194d7e8e12
# ╟─c50bf0b8-8a19-4086-828a-4cc485149963
# ╠═4474fd86-9496-44c7-9e54-3f7b3ca87ecb
# ╟─96774cd2-130c-4455-ba1f-6363f43ec697
# ╠═8e8a0cbc-96b9-490c-95ea-2955abd45275
# ╠═a65fb83a-f977-47ce-b1b3-dd47e367ba54
# ╠═dc16182e-b6b3-47ee-8d7e-8e449afd1c48
# ╟─d8abfd9d-2625-49b8-a949-7f3bd292fe31
# ╠═048a1195-1107-46e9-8514-99938a2932db
# ╟─b6d865b7-c2f6-4c65-a0de-1721c1bc2df2
# ╟─c00b48c5-d35b-409a-bca8-7eec7950fd82
# ╟─3694faf5-d9a4-4089-9873-1b1430e635cc
# ╠═cad4d998-43d7-421b-b43e-d0ebe87da176
# ╠═5c43b0f6-30f4-4ef7-9009-4cfb2012998f
# ╟─26ce1939-e595-496a-abd3-cb77d7a79683
# ╠═d66140c7-958b-4347-879e-dc128f3db7b3
# ╟─7aee99b6-3c6e-4a71-a367-9aa3c6cf34d0
# ╠═96c1adb9-1b29-433d-bf32-94657e65284e
# ╠═ef6a776c-8c63-4d30-9afd-65a5b5facac9
# ╠═4bb2001b-3b46-40f3-b6c8-54f5ed90a964
# ╟─b97d12e6-2346-410b-9292-fe822525fc77
# ╠═177a30bb-473a-4e5e-ae5e-4b83dcbc9675
# ╟─d0db4f8e-282e-45d4-8a29-32f11452654a
# ╠═26714555-a4ad-49cb-a5f1-151fcbe229a2
# ╟─d00b2507-e891-4ec5-81bc-2d5603785a09
# ╠═4d1dd37a-194e-4ed2-9d87-1d1fbb0e3997
# ╟─86e6e727-5a64-4c78-b950-fddef2a1fb10
# ╠═e43cabe7-48a5-4c51-951b-64cb2a36c8e3
# ╠═38477997-58dd-4248-b0e6-441461cc8770
# ╠═e61c7ae2-8204-4a20-8cb0-de601961bc02
# ╟─d38b7040-bb41-44be-a87d-950c50fb2955
# ╟─3b676271-26dc-41df-8448-4bcb089096cd
# ╟─494f9e7c-e53a-4c65-a012-a84240254fb6
# ╠═6f797a43-242f-4643-bbdd-9799f7bb2e60
# ╠═76dc6ac8-03fe-4c6e-97a7-88e3af4f10ee
# ╠═30bf880d-0dc5-4690-b372-8c9866e51852
# ╠═dedd841b-a636-4bbd-8f3d-b82f1e7b6f7a
# ╠═76dc6ac8-03fe-4c6e-ab04-579e5608ae53
# ╟─5b3a3587-31f7-4a00-86cf-35420d9e6995
# ╟─82f84505-336f-4845-a29a-8d0445351914
# ╠═5b71f2a1-5567-4e59-be65-28d0fcca50a8
# ╠═249c3a08-3ca6-463e-9a2e-c468345d87d1
# ╟─f85e0bbc-9db0-4a9f-b5fa-cb79ebf595ef
# ╠═b8b91bc0-0a63-4695-91c5-524da38aa391
# ╠═e0e4f0da-69c7-4941-ad90-b4405b216771
# ╟─166a1850-cddb-4f72-895b-997a92b731e0
# ╠═44ef9d71-f75b-4140-a525-e9b04a4bd246
# ╠═ff4b5618-4be7-4111-80f0-ba7781e173cf
# ╟─b2af25ee-1007-4e6d-9cbc-9a2c39793333
# ╠═7b5d88e0-e6ea-4568-b887-2b16710e5502
# ╠═1498397f-1c26-42ff-9452-5298a8a4a401
# ╠═ff78a242-e137-4043-b017-96f1602f2cad
# ╠═697eed84-bdd2-49cd-8be2-2a4017c45345
# ╠═ff78a242-e137-4043-a7ad-80d84f5b0070
# ╟─65eb310b-82e8-4a1d-8378-5aa686f0b407
# ╠═0a592f40-596b-43ce-9f43-49763e8691a1
# ╠═6b31d4c7-8229-4f76-bb0e-3a45761c733a
# ╟─2db5e586-237b-45aa-9979-7044b2f2df33
# ╟─8b1c08d9-f8dd-4ec9-b2a1-fbbde543f620
# ╠═4942a061-18dd-41d0-910b-f8a9a217eff2
# ╠═d1fb9147-4a06-44fa-aa36-d2e8546da46a
# ╠═4f4bf27c-b2f9-4c15-88a1-a2bf91434413
# ╠═29d71401-66e5-484e-a1cb-54e34396a855
# ╟─2c99a8b4-cc41-4ea1-8037-0de5806e1a54
# ╠═6afba978-b1a6-4e33-9961-a09632c33fb0
# ╟─63badfd3-c501-4d7c-b7cc-46f4ef988c68
# ╟─e089aa5e-8d6e-48a4-90fb-7f2721f6fcc7
# ╠═c4c0e393-0c62-4e8e-af65-ccd25ecb9818
# ╟─115b6c86-a0f2-4546-8890-979691212d9b
# ╠═3c8e1237-ff55-4dd0-a6fa-eaf14df5d44b
# ╟─115b6c86-a0f2-4546-8025-5084804a9f6c
# ╠═169c078b-2f81-4b5e-9e90-09023d201062
# ╟─115b6c86-a0f2-4546-b7bb-2f33ef765cc0
# ╠═1d690f10-1e44-4e9a-9625-01172c4a0081
# ╟─7a568a60-5212-4c87-af4f-11c7de9e21dd
# ╟─3e371473-56dc-452a-8dba-241d9b744683
# ╟─c3d721a1-ae10-4c0b-a6e5-2f0b4dca5c59
# ╠═d9016c54-9656-4684-8550-20498aa03ed0
# ╟─a707446f-b9f3-4405-9e7b-5b943cf6b560
# ╠═f86cc305-d2b6-4be3-bce6-0a1379cc1259
# ╟─a0c15cdb-6294-47bc-9608-b5032c116833
# ╠═7d2bb0cb-fe63-443b-b473-4aa968e6937a
# ╟─4455b804-b818-4fa0-8d9e-644a1b3cc6b6
# ╠═87188f88-6519-4ffd-ac0a-23ded81445da
# ╟─d1f615d1-644a-4358-8535-1a088a6a3228
# ╠═da033108-0b83-4ee8-a39f-7893c73eef39
# ╠═c494e441-4853-4a6d-bcca-51a27994a151
# ╠═2063cdaf-dbb9-4587-9b33-09b4b6661170
# ╠═a2a2be72-f9fe-4e2c-b45d-88d068bb0fa2
# ╠═6deb462e-668e-475d-92c8-6db3a590d963
# ╠═112438a5-ef2f-4c5d-abf5-96f457eb2bdf
# ╟─b87a9e77-1e26-4a1f-8a60-2e0214c059f5
# ╠═cc2371a4-26be-4325-a38a-beb5c7157b57
# ╠═9ac1f1af-bfdc-4499-81f5-507803ea9ed6
# ╠═3a2fb476-5685-40aa-9b21-6d4eb642d87e
# ╠═974b70c1-2df2-40c6-b98c-3df1f31879bf
# ╠═9a14db74-4138-42b0-92b7-4ceba56e97ad
# ╟─6043c761-98c1-4f5f-b122-214de244406c
# ╟─133e6f93-bb0b-460d-8a4b-c83694978e38
# ╠═c0df6812-9717-454b-a8b6-f7ff516dedc4
# ╠═f618c762-a936-433f-81e1-74ef03c2e79e
# ╠═52bf705d-bc40-4990-a04e-0b76409c14a7
# ╠═33fdde7c-1c73-42a6-b979-3458f2f26667
# ╠═bcce5556-9e92-4dfa-97e3-6677afc6ca9f
# ╠═4d822ecd-c6da-4bcb-b10e-562ce21caa04
# ╟─60aef579-9404-4272-8f78-ab549ef1544e
# ╠═a35c0fe8-afc4-4eaf-a8a4-a53f5149481e
# ╟─2a96dfa7-cf5a-4e7f-8704-dbab8e09b4f1
# ╠═912dc07c-b98e-45fb-a02f-27b6c05e4d02
# ╠═6439f7a8-34f3-4a01-bea4-3d467d48781c
# ╠═bf64e629-d0bc-4e89-97c5-2979af8a507d
# ╟─a7f061b8-d1ed-4b1f-b639-63c76c72c513
# ╟─19dae74b-24bd-428f-8f5a-e1ee9eb5c15c
# ╟─3af8467f-4988-44dc-adc5-e671db8bca5d
# ╟─b04e2fdc-8f1a-4964-86f1-0ea38de21abb
# ╟─2b88d9c5-61a4-4e1f-a55c-0cb44ab816d7
# ╟─b899ecf2-1e43-4783-be86-92ecfd0d2343
# ╟─4f939d4a-e802-4b7d-9cf1-facf39e3f302
# ╟─63f410ea-c37a-4761-b61c-748aec38e674
# ╠═cb2c42bf-21b5-4e04-9727-ed822e4fd85d
# ╠═b8996fa3-c046-4fb1-b2f2-e08965e5be66
# ╟─6584c100-ffd6-4fa1-897c-f79712f9ec7c
# ╟─135dac9b-0bd9-4e1d-a543-f9324a87efad
