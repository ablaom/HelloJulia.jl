### A Pluto.jl notebook ###
# v0.19.5

using Markdown
using InteractiveUtils

# ╔═╡ ba8d00b0-8ec2-409a-92b7-4ceba56e97ad
begin
  using Pkg                        # built-in package manager
  Pkg.status()                     # list packages in active environment
  Pkg.activate("env", shared=true) # create a new pkg env
end

# ╔═╡ 68c22caf-b951-4500-8a4b-c83694978e38
begin
  Pkg.add("Distributions")
  Pkg.add("CairoMakie")
  Pkg.status()
end

# ╔═╡ cc2371a4-26be-4325-9b33-09b4b6661170
using Random

# ╔═╡ 3a2fb476-5685-40aa-92c8-6db3a590d963
using Statistics

# ╔═╡ 237c338d-45af-4585-81e1-74ef03c2e79e
begin
  using Distributions
  
  using CairoMakie
  CairoMakie.activate!(type = "svg")
  
  N = 1000
  samples = rand(Normal(), N);   # equivalent to Julia's built-in `randn(d)`
  samples = (samples).^2;        # square element-wise
end

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

# ╔═╡ 96774cd2-130c-4455-8af5-148d95ea2900
md"## Julia is a calculator:"

# ╔═╡ 8e8a0cbc-96b9-490c-a6bf-47194d7e8e12
1 + 2^3

# ╔═╡ a65fb83a-f977-47ce-828a-4cc485149963
sqrt(1 + 2^3) # do `sqrt(ans)` in REPL

# ╔═╡ dc16182e-b6b3-47ee-9e54-3f7b3ca87ecb
sin(pi)

# ╔═╡ d8abfd9d-2625-49b8-ba1f-6363f43ec697
md"Query a function's document:"

# ╔═╡ 048a1195-1107-46e9-95ea-2955abd45275
@doc sin

# ╔═╡ b6d865b7-c2f6-4c65-b1b3-dd47e367ba54
md"""
At the REPL, you can instead do `?sin`. And you can search for all
doc-strings referring to "sine" with `apropos("sine")`.
"""

# ╔═╡ c00b48c5-d35b-409a-8d7e-8e449afd1c48
md"## Arrays"

# ╔═╡ 3694faf5-d9a4-4089-a949-7f3bd292fe31
md"One dimensional vectors:"

# ╔═╡ cad4d998-43d7-421b-8514-99938a2932db
v = [3, 5, 7]

# ╔═╡ 5c43b0f6-30f4-4ef7-a0de-1721c1bc2df2
length(v)

# ╔═╡ 26ce1939-e595-496a-bca8-7eec7950fd82
md"A \"row vector\" is a 1 x n array:"

# ╔═╡ d66140c7-958b-4347-9873-1b1430e635cc
row = [3 5 7]

# ╔═╡ 7aee99b6-3c6e-4a71-b43e-d0ebe87da176
md"Multiple row vectors separated by semicolons or new lines define matrices:"

# ╔═╡ 96c1adb9-1b29-433d-9009-4cfb2012998f
A = [3 5 7
     2 4 6
     1 3 5]

# ╔═╡ ef6a776c-8c63-4d30-abd3-cb77d7a79683
size(A)

# ╔═╡ 4bb2001b-3b46-40f3-879e-dc128f3db7b3
length(A)

# ╔═╡ b97d12e6-2346-410b-a367-9aa3c6cf34d0
md"Accessing elements (Julia indices start at 1 not 0):"

# ╔═╡ 177a30bb-473a-4e5e-bf32-94657e65284e
A[1, 2]

# ╔═╡ d0db4f8e-282e-45d4-9afd-65a5b5facac9
md"Get the second column:"

# ╔═╡ 26714555-a4ad-49cb-b6c8-54f5ed90a964
A[:, 2] # 2nd column

# ╔═╡ d00b2507-e891-4ec5-9292-fe822525fc77
md"Changing elements:"

# ╔═╡ 4d1dd37a-194e-4ed2-ae5e-4b83dcbc9675
A[1, 1] = 42

# ╔═╡ 86e6e727-5a64-4c78-8a29-32f11452654a
md"""
Matrices can also be indexed as if columns where concatenated into a
single vector (which is how they are stored internally):
"""

# ╔═╡ 488fc97f-87c1-4801-a5f1-151fcbe229a2
A[2, 1] == A[2]

# ╔═╡ 38477997-58dd-4248-81bc-2d5603785a09
inv(A) # inverse

# ╔═╡ e61c7ae2-8204-4a20-9d87-1d1fbb0e3997
isapprox(inv(A)*v, A\v) # but RHS more efficient

# ╔═╡ d38b7040-bb41-44be-b950-fddef2a1fb10
md"## \"Variables\" in Julia *point* to objects"

# ╔═╡ 3b676271-26dc-41df-951b-64cb2a36c8e3
md"Corollary: all passing of function arguments is pass by reference."

# ╔═╡ 494f9e7c-e53a-4c65-b0e6-441461cc8770
md"Like Python; Unlike R, C or FORTRAN."

# ╔═╡ 6f797a43-242f-4643-8cb0-de601961bc02
begin
  u = [3, 5, 7]
  
  w = u
end

# ╔═╡ 76dc6ac8-03fe-4c6e-a87d-950c50fb2955
w

# ╔═╡ 30bf880d-0dc5-4690-8448-4bcb089096cd
u[1] = 42

# ╔═╡ dedd841b-a636-4bbd-a012-a84240254fb6
u

# ╔═╡ 76dc6ac8-03fe-4c6e-bbdd-9799f7bb2e60
w

# ╔═╡ 5b3a3587-31f7-4a00-97a7-88e3af4f10ee
md"## Tuples"

# ╔═╡ 82f84505-336f-4845-b372-8c9866e51852
md"Similar to vectors but of fixed length and immutable (cannot be changed)"

# ╔═╡ 5b71f2a1-5567-4e59-8f3d-b82f1e7b6f7a
begin
  t1 = (1, 2.0, "cat")
  typeof(t1)
end

# ╔═╡ 249c3a08-3ca6-463e-ab04-579e5608ae53
t1[3]

# ╔═╡ f85e0bbc-9db0-4a9f-86cf-35420d9e6995
md"Tuples also come in a *named* variety:"

# ╔═╡ b8b91bc0-0a63-4695-a29a-8d0445351914
t2 = (i = 1, x = 2.0, animal="cat")

# ╔═╡ e0e4f0da-69c7-4941-be65-28d0fcca50a8
t2.x

# ╔═╡ 166a1850-cddb-4f72-9a2e-c468345d87d1
md"## Strings and relatives"

# ╔═╡ 44ef9d71-f75b-4140-b5fa-cb79ebf595ef
begin
  a_string = "the cat"
  a_character = 't'
  a_symbol = :t
end

# ╔═╡ ff4b5618-4be7-4111-91c5-524da38aa391
a_string[1] == a_character

# ╔═╡ fb16016a-87d7-4e9f-ad90-b4405b216771
md"""
A `Symbol` is string-like but
[interned](https://en.wikipedia.org/wiki/String_interning). Generally
use `String` for ordinary textual data, but use `Symbol` for
language reflection (metaprogramming). For example:
"""

# ╔═╡ 20ba7245-15ed-417e-895b-997a92b731e0
isdefined(Main, :z)

# ╔═╡ 697eed84-bdd2-49cd-a525-e9b04a4bd246
z = 1 + 2im

# ╔═╡ 20ba7245-15ed-417e-80f0-ba7781e173cf
isdefined(Main, :z)

# ╔═╡ 8b1e2b91-947c-4046-9cbc-9a2c39793333
z.im

# ╔═╡ 3dcab89a-20ca-462a-b887-2b16710e5502
fieldnames(typeof(z))

# ╔═╡ 65eb310b-82e8-4a1d-9452-5298a8a4a401
md"Symbols are generalized by *expressions*:"

# ╔═╡ 35998a8b-6fda-4a2f-b017-96f1602f2cad
begin
  ex = :(z == 3)
  eval(ex)
end

# ╔═╡ 2db5e586-237b-45aa-8be2-2a4017c45345
md"If this is confusing, forget it for now."

# ╔═╡ 8b1c08d9-f8dd-4ec9-a7ad-80d84f5b0070
md"## Dictionaries"

# ╔═╡ 4942a061-18dd-41d0-8378-5aa686f0b407
d = Dict('a' => "ant", 'z' => "zebra")

# ╔═╡ d1fb9147-4a06-44fa-9f43-49763e8691a1
d['a']

# ╔═╡ 4f4bf27c-b2f9-4c15-bb0e-3a45761c733a
begin
  d['b'] = "bat"
  d
end

# ╔═╡ 29d71401-66e5-484e-9979-7044b2f2df33
keys(d)

# ╔═╡ 4b80c58d-646a-405b-b2a1-fbbde543f620
md"The expression 'a' => \"ant\" is itself a stand-alone object:"

# ╔═╡ 6afba978-b1a6-4e33-910b-f8a9a217eff2
begin
  pair = 'a' => "ant"
  first(pair)
end

# ╔═╡ 63badfd3-c501-4d7c-aa36-d2e8546da46a
md"## Functions"

# ╔═╡ e089aa5e-8d6e-48a4-88a1-a2bf91434413
md"Three ways to define a generic function:"

# ╔═╡ c4c0e393-0c62-4e8e-a1cb-54e34396a855
begin
  foo(x) = x^2 # METHOD 1 (inline)
  foo(3)
end

# ╔═╡ 115b6c86-a0f2-4546-8037-0de5806e1a54
md"or"

# ╔═╡ 3c8e1237-ff55-4dd0-9961-a09632c33fb0
3 |> foo

# ╔═╡ 115b6c86-a0f2-4546-b7cc-46f4ef988c68
md"or"

# ╔═╡ 169c078b-2f81-4b5e-90fb-7f2721f6fcc7
3 |> x -> x^2 # METHOD 2 (anonymous)

# ╔═╡ 115b6c86-a0f2-4546-af65-ccd25ecb9818
md"or"

# ╔═╡ 1d690f10-1e44-4e9a-8890-979691212d9b
begin
  function foo2(x) # METHOD 3 (verbose)
      y = x
      z = y
      w = z
      return w^2
  end
  
  foo2(3)
end

# ╔═╡ 7a568a60-5212-4c87-a6fa-eaf14df5d44b
md"## Basic iteration"

# ╔═╡ 77d49aef-9644-41c2-8025-5084804a9f6c
md"Here are three ways to square the integers from 1 to 10."

# ╔═╡ c3d721a1-ae10-4c0b-9e90-09023d201062
md"METHOD 1 (explicit loop):"

# ╔═╡ d9016c54-9656-4684-b7bb-2f33ef765cc0
begin
  squares = [] # or Int[] if performance matters
  for x in 1:10
      push!(squares, x^2)
  end
  
  squares
end

# ╔═╡ a707446f-b9f3-4405-9625-01172c4a0081
md"METHOD 2 (comprehension):"

# ╔═╡ f86cc305-d2b6-4be3-af4f-11c7de9e21dd
[x^2 for x in 1:10]

# ╔═╡ a0c15cdb-6294-47bc-8dba-241d9b744683
md"METHOD 3 (map):"

# ╔═╡ 7d2bb0cb-fe63-443b-a6e5-2f0b4dca5c59
map(x -> x^2, 1:10)

# ╔═╡ 4455b804-b818-4fa0-8550-20498aa03ed0
md"METHOD 4 (broadcasting with dot syntax):"

# ╔═╡ 87188f88-6519-4ffd-9e7b-5b943cf6b560
(1:10) .^ 2

# ╔═╡ d1f615d1-644a-4358-bce6-0a1379cc1259
md"## Random numbers"

# ╔═╡ da033108-0b83-4ee8-9608-b5032c116833
typeof(2)

# ╔═╡ c494e441-4853-4a6d-b473-4aa968e6937a
rand() # sample a Float64 uniformly from interval [0, 1]

# ╔═╡ 2063cdaf-dbb9-4587-8d9e-644a1b3cc6b6
rand(3, 4) # do that 12 times and put in a 3 x 4 array

# ╔═╡ a2a2be72-f9fe-4e2c-ac0a-23ded81445da
randn(3, 4) # use normal distribution instead

# ╔═╡ 6deb462e-668e-475d-8535-1a088a6a3228
rand(Int8) # random elment of type Int8

# ╔═╡ 112438a5-ef2f-4c5d-a39f-7893c73eef39
rand(['a', 'b', 'c'], 10) # 10 random elements from a vector

# ╔═╡ b87a9e77-1e26-4a1f-bcca-51a27994a151
md"Some standard libraries are needed to do more, for example:"

# ╔═╡ 9ac1f1af-bfdc-4499-b45d-88d068bb0fa2
randstring(30)

# ╔═╡ 974b70c1-2df2-40c6-abf5-96f457eb2bdf
begin
  y = rand(30)
  mean(y)
end

# ╔═╡ 9c18343b-4459-44d2-8a60-2e0214c059f5
quantile(y, 0.75);

# ╔═╡ bd256b23-4c27-4ca0-a38a-beb5c7157b57
md"""
(Use the macro @show before stuff you want printed prefixed by
*what* it is that is being printed.)
"""

# ╔═╡ 133e6f93-bb0b-460d-81f5-507803ea9ed6
md"""
For sampling from more general distributions we need
Distributions.jl package which is not part of the standard library.
"""

# ╔═╡ e7c2edc1-91cb-4ef1-9b21-6d4eb642d87e
md"## Loading packages"

# ╔═╡ ab20d999-4cfa-4104-b98c-3df1f31879bf
md"If not in the REPL:"

# ╔═╡ f7215fcd-0f87-4b4a-b122-214de244406c
md"""
Add some packages to your environment (latest compatible versions
added by default):
"""

# ╔═╡ 64a59295-2630-40c2-a8b6-f7ff516dedc4
md"To load the code for use:"

# ╔═╡ f618c762-a936-433f-a04e-0b76409c14a7
g = fit(Gamma, samples)

# ╔═╡ 52bf705d-bc40-4990-b979-3458f2f26667
mean(g)

# ╔═╡ 33fdde7c-1c73-42a6-97e3-6677afc6ca9f
median(g)

# ╔═╡ bcce5556-9e92-4dfa-b10e-562ce21caa04
pdf(g, 1)

# ╔═╡ 2a96dfa7-cf5a-4e7f-8f78-ab549ef1544e
md"## Plotting"

# ╔═╡ 6439f7a8-34f3-4a01-a8a4-a53f5149481e
begin
  f(x) = pdf(g, x)
  
  xs = 0:0.1:4 # floats from 0 to 4 in steps of 0.1
  ys = f.(xs)  # apply f element-wise to xs
  
  fig = lines(xs, ys)
  hist!(samples, normalization=:pdf, bins=40, alpha=0.4)
  current_figure()
end

# ╔═╡ 98dfc0a3-83fc-4c05-8704-dbab8e09b4f1
save("my_first_plot.svg", fig)

# ╔═╡ a7f061b8-d1ed-4b1f-a02f-27b6c05e4d02
md"# Exercises"

# ╔═╡ 19dae74b-24bd-428f-bea4-3d467d48781c
md"## Exercise 1"

# ╔═╡ 3af8467f-4988-44dc-97c5-2979af8a507d
md"Write a function named `total` that adds the elements of its vector input."

# ╔═╡ b04e2fdc-8f1a-4964-b639-63c76c72c513
md"## Exercise 2"

# ╔═╡ 2b88d9c5-61a4-4e1f-8f5a-e1ee9eb5c15c
md"""
Generate a 1000 random samples from the standard normal
distribution. Create a second such sample, and add the two samples
point-wise.  Compute the (sample) mean and variance of the combined
samples. In the same
plot, show a frequency-normalized histogram of the combined samples
and a plot of the pdf for normal distribution with zero mean and
variance `2`.
"""

# ╔═╡ b899ecf2-1e43-4783-adc5-e671db8bca5d
md"""
You can use `std` to compute the standard deviation and `sqrt` to
compute square roots.
"""

# ╔═╡ 4f939d4a-e802-4b7d-86f1-0ea38de21abb
md"## Exercise 3"

# ╔═╡ 63f410ea-c37a-4761-a55c-0cb44ab816d7
md"The following shows that named tuples share some behaviour with dictionaries:"

# ╔═╡ cb2c42bf-21b5-4e04-be86-92ecfd0d2343
begin
  t = (x = 1, y = "cat", z = 4.5)
  keys(t)
end

# ╔═╡ b8996fa3-c046-4fb1-9cf1-facf39e3f302
t[:y]

# ╔═╡ 6584c100-ffd6-4fa1-b61c-748aec38e674
md"""
Write a function called `dict` that converts a named tuple to an
actual dictionary. You can create an empty dictionary using `Dict()`.
"""

# ╔═╡ 135dac9b-0bd9-4e1d-9727-ed822e4fd85d
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─142b62e1-364e-45d6-9bca-7c69b794f8ce
# ╟─27f5936d-4043-4cb6-b795-033f6f2a0674
# ╟─3f08e241-e53d-4d65-935f-ddf6a6bfbbdd
# ╟─3e3bcc53-7840-4af7-af2a-25235e544a31
# ╟─96774cd2-130c-4455-8af5-148d95ea2900
# ╠═8e8a0cbc-96b9-490c-a6bf-47194d7e8e12
# ╠═a65fb83a-f977-47ce-828a-4cc485149963
# ╠═dc16182e-b6b3-47ee-9e54-3f7b3ca87ecb
# ╟─d8abfd9d-2625-49b8-ba1f-6363f43ec697
# ╠═048a1195-1107-46e9-95ea-2955abd45275
# ╟─b6d865b7-c2f6-4c65-b1b3-dd47e367ba54
# ╟─c00b48c5-d35b-409a-8d7e-8e449afd1c48
# ╟─3694faf5-d9a4-4089-a949-7f3bd292fe31
# ╠═cad4d998-43d7-421b-8514-99938a2932db
# ╠═5c43b0f6-30f4-4ef7-a0de-1721c1bc2df2
# ╟─26ce1939-e595-496a-bca8-7eec7950fd82
# ╠═d66140c7-958b-4347-9873-1b1430e635cc
# ╟─7aee99b6-3c6e-4a71-b43e-d0ebe87da176
# ╠═96c1adb9-1b29-433d-9009-4cfb2012998f
# ╠═ef6a776c-8c63-4d30-abd3-cb77d7a79683
# ╠═4bb2001b-3b46-40f3-879e-dc128f3db7b3
# ╟─b97d12e6-2346-410b-a367-9aa3c6cf34d0
# ╠═177a30bb-473a-4e5e-bf32-94657e65284e
# ╟─d0db4f8e-282e-45d4-9afd-65a5b5facac9
# ╠═26714555-a4ad-49cb-b6c8-54f5ed90a964
# ╟─d00b2507-e891-4ec5-9292-fe822525fc77
# ╠═4d1dd37a-194e-4ed2-ae5e-4b83dcbc9675
# ╟─86e6e727-5a64-4c78-8a29-32f11452654a
# ╠═488fc97f-87c1-4801-a5f1-151fcbe229a2
# ╠═38477997-58dd-4248-81bc-2d5603785a09
# ╠═e61c7ae2-8204-4a20-9d87-1d1fbb0e3997
# ╟─d38b7040-bb41-44be-b950-fddef2a1fb10
# ╟─3b676271-26dc-41df-951b-64cb2a36c8e3
# ╟─494f9e7c-e53a-4c65-b0e6-441461cc8770
# ╠═6f797a43-242f-4643-8cb0-de601961bc02
# ╠═76dc6ac8-03fe-4c6e-a87d-950c50fb2955
# ╠═30bf880d-0dc5-4690-8448-4bcb089096cd
# ╠═dedd841b-a636-4bbd-a012-a84240254fb6
# ╠═76dc6ac8-03fe-4c6e-bbdd-9799f7bb2e60
# ╟─5b3a3587-31f7-4a00-97a7-88e3af4f10ee
# ╟─82f84505-336f-4845-b372-8c9866e51852
# ╠═5b71f2a1-5567-4e59-8f3d-b82f1e7b6f7a
# ╠═249c3a08-3ca6-463e-ab04-579e5608ae53
# ╟─f85e0bbc-9db0-4a9f-86cf-35420d9e6995
# ╠═b8b91bc0-0a63-4695-a29a-8d0445351914
# ╠═e0e4f0da-69c7-4941-be65-28d0fcca50a8
# ╟─166a1850-cddb-4f72-9a2e-c468345d87d1
# ╠═44ef9d71-f75b-4140-b5fa-cb79ebf595ef
# ╠═ff4b5618-4be7-4111-91c5-524da38aa391
# ╟─fb16016a-87d7-4e9f-ad90-b4405b216771
# ╠═20ba7245-15ed-417e-895b-997a92b731e0
# ╠═697eed84-bdd2-49cd-a525-e9b04a4bd246
# ╠═20ba7245-15ed-417e-80f0-ba7781e173cf
# ╠═8b1e2b91-947c-4046-9cbc-9a2c39793333
# ╠═3dcab89a-20ca-462a-b887-2b16710e5502
# ╟─65eb310b-82e8-4a1d-9452-5298a8a4a401
# ╠═35998a8b-6fda-4a2f-b017-96f1602f2cad
# ╟─2db5e586-237b-45aa-8be2-2a4017c45345
# ╟─8b1c08d9-f8dd-4ec9-a7ad-80d84f5b0070
# ╠═4942a061-18dd-41d0-8378-5aa686f0b407
# ╠═d1fb9147-4a06-44fa-9f43-49763e8691a1
# ╠═4f4bf27c-b2f9-4c15-bb0e-3a45761c733a
# ╠═29d71401-66e5-484e-9979-7044b2f2df33
# ╟─4b80c58d-646a-405b-b2a1-fbbde543f620
# ╠═6afba978-b1a6-4e33-910b-f8a9a217eff2
# ╟─63badfd3-c501-4d7c-aa36-d2e8546da46a
# ╟─e089aa5e-8d6e-48a4-88a1-a2bf91434413
# ╠═c4c0e393-0c62-4e8e-a1cb-54e34396a855
# ╟─115b6c86-a0f2-4546-8037-0de5806e1a54
# ╠═3c8e1237-ff55-4dd0-9961-a09632c33fb0
# ╟─115b6c86-a0f2-4546-b7cc-46f4ef988c68
# ╠═169c078b-2f81-4b5e-90fb-7f2721f6fcc7
# ╟─115b6c86-a0f2-4546-af65-ccd25ecb9818
# ╠═1d690f10-1e44-4e9a-8890-979691212d9b
# ╟─7a568a60-5212-4c87-a6fa-eaf14df5d44b
# ╟─77d49aef-9644-41c2-8025-5084804a9f6c
# ╟─c3d721a1-ae10-4c0b-9e90-09023d201062
# ╠═d9016c54-9656-4684-b7bb-2f33ef765cc0
# ╟─a707446f-b9f3-4405-9625-01172c4a0081
# ╠═f86cc305-d2b6-4be3-af4f-11c7de9e21dd
# ╟─a0c15cdb-6294-47bc-8dba-241d9b744683
# ╠═7d2bb0cb-fe63-443b-a6e5-2f0b4dca5c59
# ╟─4455b804-b818-4fa0-8550-20498aa03ed0
# ╠═87188f88-6519-4ffd-9e7b-5b943cf6b560
# ╟─d1f615d1-644a-4358-bce6-0a1379cc1259
# ╠═da033108-0b83-4ee8-9608-b5032c116833
# ╠═c494e441-4853-4a6d-b473-4aa968e6937a
# ╠═2063cdaf-dbb9-4587-8d9e-644a1b3cc6b6
# ╠═a2a2be72-f9fe-4e2c-ac0a-23ded81445da
# ╠═6deb462e-668e-475d-8535-1a088a6a3228
# ╠═112438a5-ef2f-4c5d-a39f-7893c73eef39
# ╟─b87a9e77-1e26-4a1f-bcca-51a27994a151
# ╠═cc2371a4-26be-4325-9b33-09b4b6661170
# ╠═9ac1f1af-bfdc-4499-b45d-88d068bb0fa2
# ╠═3a2fb476-5685-40aa-92c8-6db3a590d963
# ╠═974b70c1-2df2-40c6-abf5-96f457eb2bdf
# ╠═9c18343b-4459-44d2-8a60-2e0214c059f5
# ╟─bd256b23-4c27-4ca0-a38a-beb5c7157b57
# ╟─133e6f93-bb0b-460d-81f5-507803ea9ed6
# ╟─e7c2edc1-91cb-4ef1-9b21-6d4eb642d87e
# ╟─ab20d999-4cfa-4104-b98c-3df1f31879bf
# ╠═ba8d00b0-8ec2-409a-92b7-4ceba56e97ad
# ╟─f7215fcd-0f87-4b4a-b122-214de244406c
# ╠═68c22caf-b951-4500-8a4b-c83694978e38
# ╟─64a59295-2630-40c2-a8b6-f7ff516dedc4
# ╠═237c338d-45af-4585-81e1-74ef03c2e79e
# ╠═f618c762-a936-433f-a04e-0b76409c14a7
# ╠═52bf705d-bc40-4990-b979-3458f2f26667
# ╠═33fdde7c-1c73-42a6-97e3-6677afc6ca9f
# ╠═bcce5556-9e92-4dfa-b10e-562ce21caa04
# ╟─2a96dfa7-cf5a-4e7f-8f78-ab549ef1544e
# ╠═6439f7a8-34f3-4a01-a8a4-a53f5149481e
# ╠═98dfc0a3-83fc-4c05-8704-dbab8e09b4f1
# ╟─a7f061b8-d1ed-4b1f-a02f-27b6c05e4d02
# ╟─19dae74b-24bd-428f-bea4-3d467d48781c
# ╟─3af8467f-4988-44dc-97c5-2979af8a507d
# ╟─b04e2fdc-8f1a-4964-b639-63c76c72c513
# ╟─2b88d9c5-61a4-4e1f-8f5a-e1ee9eb5c15c
# ╟─b899ecf2-1e43-4783-adc5-e671db8bca5d
# ╟─4f939d4a-e802-4b7d-86f1-0ea38de21abb
# ╟─63f410ea-c37a-4761-a55c-0cb44ab816d7
# ╠═cb2c42bf-21b5-4e04-be86-92ecfd0d2343
# ╠═b8996fa3-c046-4fb1-9cf1-facf39e3f302
# ╟─6584c100-ffd6-4fa1-b61c-748aec38e674
# ╟─135dac9b-0bd9-4e1d-9727-ed822e4fd85d
