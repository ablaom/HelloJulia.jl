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

# ╔═╡ 96774cd2-130c-4455-8af5-148d95ea2900
md"## Julia is a calculator:"

# ╔═╡ 8e8a0cbc-96b9-490c-a6bf-47194d7e8e12
1 + 2^3

# ╔═╡ a65fb83a-f977-47ce-828a-4cc485149963
sqrt(1 + 2^3) # do `sqrt(ans)` in REPL

# ╔═╡ dc16182e-b6b3-47ee-9e54-3f7b3ca87ecb
sin(pi)

# ╔═╡ bc1912b8-c66a-4ab5-ba1f-6363f43ec697
md"""
Query a function's document string using `?sin` at the REPL, or in a
notebook:
"""

# ╔═╡ 048a1195-1107-46e9-95ea-2955abd45275
@doc sin

# ╔═╡ ef72056a-9321-4290-b1b3-dd47e367ba54
md"""
I've forgotten how the arcsin is called. Is it `asin` or `arcsin`? I
can search all doc-strings containing "sine" to locate the method:
"""

# ╔═╡ af710d1b-f8c2-4219-8d7e-8e449afd1c48
apropos("sine")

# ╔═╡ 3e690f1c-4e80-4016-a949-7f3bd292fe31
md"Okay, I see it's called `asin`."

# ╔═╡ b541c5ac-3c15-4e71-8514-99938a2932db
asin(1 + 3*im)

# ╔═╡ c00b48c5-d35b-409a-a0de-1721c1bc2df2
md"## Arrays"

# ╔═╡ 3694faf5-d9a4-4089-bca8-7eec7950fd82
md"One dimensional vectors:"

# ╔═╡ cad4d998-43d7-421b-9873-1b1430e635cc
v = [3, 5, 7]

# ╔═╡ 26ce1939-e595-496a-b43e-d0ebe87da176
md"A \"row vector\" is a 1 x n array:"

# ╔═╡ d66140c7-958b-4347-9009-4cfb2012998f
row = [3 5 7]

# ╔═╡ 7aee99b6-3c6e-4a71-abd3-cb77d7a79683
md"Multiple row vectors separated by semicolons or new lines define matrices:"

# ╔═╡ 96c1adb9-1b29-433d-879e-dc128f3db7b3
A = [3 5 7
     2 4 6
     1 3 5]

# ╔═╡ ef6a776c-8c63-4d30-a367-9aa3c6cf34d0
size(A)

# ╔═╡ b97d12e6-2346-410b-bf32-94657e65284e
md"Accessing elements (Julia indices start at 1 not 0):"

# ╔═╡ 177a30bb-473a-4e5e-9afd-65a5b5facac9
A[1, 2]

# ╔═╡ 109564cb-ea6f-4264-b6c8-54f5ed90a964
A[1, 2] == A[2]

# ╔═╡ 26714555-a4ad-49cb-9292-fe822525fc77
A[:, 2] # 2nd column

# ╔═╡ d00b2507-e891-4ec5-ae5e-4b83dcbc9675
md"Changing elements:"

# ╔═╡ 4d1dd37a-194e-4ed2-8a29-32f11452654a
A[1, 1] = 42

# ╔═╡ 38477997-58dd-4248-a5f1-151fcbe229a2
inv(A) # inverse

# ╔═╡ e61c7ae2-8204-4a20-81bc-2d5603785a09
isapprox(inv(A)*v, A\v) # but RHS more efficient

# ╔═╡ d38b7040-bb41-44be-9d87-1d1fbb0e3997
md"## \"Variables\" in Julia *point* to objects"

# ╔═╡ 9f1e3326-b738-4b60-b950-fddef2a1fb10
md"Corollary: all passing of function arguments is pass by reference"

# ╔═╡ 494f9e7c-e53a-4c65-951b-64cb2a36c8e3
md"Like Python; Unlike R, C or FORTRAN."

# ╔═╡ 259bf65c-6868-47b0-b0e6-441461cc8770
begin
  w = v
  
  w
end

# ╔═╡ 6ef57fdd-3188-4b19-8cb0-de601961bc02
v[1] = 42

# ╔═╡ ef2473e2-bb35-4bd7-a87d-950c50fb2955
v

# ╔═╡ 76dc6ac8-03fe-4c6e-8448-4bcb089096cd
w

# ╔═╡ 5b3a3587-31f7-4a00-a012-a84240254fb6
md"## Tuples"

# ╔═╡ 82f84505-336f-4845-bbdd-9799f7bb2e60
md"Similar to vectors but of fixed length and immutable (cannot be changed)"

# ╔═╡ 42d147e9-cbf9-4456-97a7-88e3af4f10ee
begin
  t = (1, 2.0, "cat")
  typeof(t)
end

# ╔═╡ 8c7dcea2-e879-405c-b372-8c9866e51852
t[3]

# ╔═╡ f85e0bbc-9db0-4a9f-8f3d-b82f1e7b6f7a
md"Tuples also come in a *named* variety:"

# ╔═╡ dff4b531-62c4-4ccb-ab04-579e5608ae53
(; i = 1, x = 2.0, animal="cat")

# ╔═╡ 166a1850-cddb-4f72-86cf-35420d9e6995
md"## Strings and relatives"

# ╔═╡ 44ef9d71-f75b-4140-a29a-8d0445351914
begin
  a_string = "the cat"
  a_character = 't'
  a_symbol = :t
end

# ╔═╡ ff4b5618-4be7-4111-be65-28d0fcca50a8
a_string[1] == a_character

# ╔═╡ fb16016a-87d7-4e9f-9a2e-c468345d87d1
md"""
A `Symbol` is string-like but
[interned](https://en.wikipedia.org/wiki/String_interning). Generally
use `String` for ordinary textual data, but use `Symbol` for
language reflection (metaprogramming). For example:
"""

# ╔═╡ 20ba7245-15ed-417e-b5fa-cb79ebf595ef
isdefined(Main, :z)

# ╔═╡ 542ec737-2c88-4293-91c5-524da38aa391
begin
  z = 1 + 2im
  isdefined(Main, :z)
end

# ╔═╡ 8b1e2b91-947c-4046-ad90-b4405b216771
z.im

# ╔═╡ 3dcab89a-20ca-462a-895b-997a92b731e0
fieldnames(typeof(z))

# ╔═╡ 65eb310b-82e8-4a1d-a525-e9b04a4bd246
md"Symbols are generalized by *expressions*:"

# ╔═╡ 35998a8b-6fda-4a2f-80f0-ba7781e173cf
begin
  ex = :(z == 3)
  eval(ex)
end

# ╔═╡ 2db5e586-237b-45aa-9cbc-9a2c39793333
md"If this is confusing, forget it for now."

# ╔═╡ 8b1c08d9-f8dd-4ec9-b887-2b16710e5502
md"## Dictionaries"

# ╔═╡ 4942a061-18dd-41d0-9452-5298a8a4a401
d = Dict('a' => "ant", 'z' => "zebra")

# ╔═╡ d1fb9147-4a06-44fa-b017-96f1602f2cad
d['a']

# ╔═╡ 4f4bf27c-b2f9-4c15-8be2-2a4017c45345
begin
  d['b'] = "bat"
  d
end

# ╔═╡ 29d71401-66e5-484e-a7ad-80d84f5b0070
keys(d)

# ╔═╡ 4b80c58d-646a-405b-8378-5aa686f0b407
md"The expression 'a' => \"ant\" is itself a stand-alone object:"

# ╔═╡ 44914181-9dd8-49b4-9f43-49763e8691a1
begin
  pair = 'a' => "ant"
  
  first(pair)
end

# ╔═╡ 63badfd3-c501-4d7c-bb0e-3a45761c733a
md"## Functions"

# ╔═╡ e089aa5e-8d6e-48a4-9979-7044b2f2df33
md"Three ways to define a generic function:"

# ╔═╡ c4c0e393-0c62-4e8e-b2a1-fbbde543f620
begin
  foo(x) = x^2 # METHOD 1 (inline)
  foo(3)
end

# ╔═╡ 115b6c86-a0f2-4546-910b-f8a9a217eff2
md"or"

# ╔═╡ 3c8e1237-ff55-4dd0-aa36-d2e8546da46a
3 |> foo

# ╔═╡ 115b6c86-a0f2-4546-88a1-a2bf91434413
md"or"

# ╔═╡ 169c078b-2f81-4b5e-a1cb-54e34396a855
3 |> x -> x^2 # METHOD 2 (anonymous)

# ╔═╡ 115b6c86-a0f2-4546-8037-0de5806e1a54
md"or"

# ╔═╡ 1d690f10-1e44-4e9a-9961-a09632c33fb0
begin
  function foo2(x) # METHOD 3 (verbose)
      y = x
      z = y
      w = z
      return w^2
  end
  
  foo2(3)
end

# ╔═╡ 7a568a60-5212-4c87-b7cc-46f4ef988c68
md"## Basic iteration"

# ╔═╡ 77d49aef-9644-41c2-90fb-7f2721f6fcc7
md"Here are three ways to square the integers from 1 to 10."

# ╔═╡ c3d721a1-ae10-4c0b-af65-ccd25ecb9818
md"METHOD 1 (explicit loop):"

# ╔═╡ d9016c54-9656-4684-8890-979691212d9b
begin
  squares = [] # or Int[] if performance matters
  for x in 1:10
      push!(squares, x^2)
  end
  
  squares
end

# ╔═╡ a707446f-b9f3-4405-a6fa-eaf14df5d44b
md"METHOD 2 (comprehension):"

# ╔═╡ f86cc305-d2b6-4be3-8025-5084804a9f6c
[x^2 for x in 1:10]

# ╔═╡ a0c15cdb-6294-47bc-9e90-09023d201062
md"METHOD 3 (map):"

# ╔═╡ 7d2bb0cb-fe63-443b-b7bb-2f33ef765cc0
map(x -> x^2, 1:10)

# ╔═╡ 4455b804-b818-4fa0-9625-01172c4a0081
md"METHOD 4 (broadcasting with dot syntax):"

# ╔═╡ 87188f88-6519-4ffd-af4f-11c7de9e21dd
(1:10) .^ 2

# ╔═╡ d1f615d1-644a-4358-8dba-241d9b744683
md"## Random numbers"

# ╔═╡ da033108-0b83-4ee8-a6e5-2f0b4dca5c59
typeof(2)

# ╔═╡ c494e441-4853-4a6d-8550-20498aa03ed0
rand() # sample a Float64 uniformly from interval [0, 1]

# ╔═╡ 2063cdaf-dbb9-4587-9e7b-5b943cf6b560
rand(3, 4) # do that 12 times and put in a 3 x 4 array

# ╔═╡ a2a2be72-f9fe-4e2c-bce6-0a1379cc1259
randn(3, 4) # use normal distribution instead

# ╔═╡ 6deb462e-668e-475d-9608-b5032c116833
rand(Int8) # random elment of type Int8

# ╔═╡ 112438a5-ef2f-4c5d-b473-4aa968e6937a
rand(['a', 'b', 'c'], 10) # 10 random elements from a vector

# ╔═╡ b87a9e77-1e26-4a1f-8d9e-644a1b3cc6b6
md"Some standard libraries are needed to do more, for example:"

# ╔═╡ cc2371a4-26be-4325-ac0a-23ded81445da
using Random

# ╔═╡ 9ac1f1af-bfdc-4499-8535-1a088a6a3228
randstring(30)

# ╔═╡ 3a2fb476-5685-40aa-a39f-7893c73eef39
using Statistics

# ╔═╡ 01f39450-9ce3-46c1-bcca-51a27994a151
begin
  y = rand(30)
  @show mean(y) quantile(y, 0.75);
end

# ╔═╡ bd256b23-4c27-4ca0-9b33-09b4b6661170
md"""
(Use the macro @show before stuff you want printed prefixed by
*what* it is that is being printed.)
"""

# ╔═╡ 133e6f93-bb0b-460d-b45d-88d068bb0fa2
md"""
For sampling from more general distributions we need
Distributions.jl package which is not part of the standard library.
"""

# ╔═╡ e7c2edc1-91cb-4ef1-92c8-6db3a590d963
md"## Loading packages"

# ╔═╡ ab20d999-4cfa-4104-abf5-96f457eb2bdf
md"If not in the REPL:"

# ╔═╡ c5e1e96d-691f-4366-8a60-2e0214c059f5
begin
  using Pkg                        # built-in package manager
  Pkg.activate("env", shared=true) # create a new pkg env
end

# ╔═╡ 240929b4-eb02-42a5-a38a-beb5c7157b57
md"""
Add some packages to your enviroment (latest compatible versions
added by default):
"""

# ╔═╡ fdd4c037-11f7-4777-81f5-507803ea9ed6
begin
  Pkg.add("Distributions")
  Pkg.add("Plots")
end

# ╔═╡ 64a59295-2630-40c2-9b21-6d4eb642d87e
md"To load the code for use:"

# ╔═╡ b480add5-8651-4720-b98c-3df1f31879bf
begin
  using Distributions
  using Plots
  
  N = 1000
  samples = rand(Normal(), N);   # equivalent to Julia's built-in `randn(d)`
  samples = (samples).^2;        # square element-wise
end

# ╔═╡ f618c762-a936-433f-92b7-4ceba56e97ad
g = fit(Gamma, samples)

# ╔═╡ 5db01f65-3d0f-4ba4-b122-214de244406c
@show mean(g) median(g) pdf(g, 1)

# ╔═╡ 2a96dfa7-cf5a-4e7f-8a4b-c83694978e38
md"## Plotting"

# ╔═╡ aa456fbb-e9da-44d3-a8b6-f7ff516dedc4
begin
  f(x) = pdf(g, x)
  
  x = 0:0.1:4 # floats from 0 to 4 in steps of 0.1
  y = f.(x)   # apply f element-wise to x
  
  plot(x, y, xrange=(0,4), yrange=(0,0.2))
  histogram!(samples , normalize=true, alpha=0.4)
end

# ╔═╡ 2e3fe339-a279-48e8-81e1-74ef03c2e79e
savefig("my_first_plot.png")


# Exercises

### Exercise 1

# ╔═╡ c2078856-e4c8-4777-a04e-0b76409c14a7
md"Write a function that adds all columns of its matrix input."

# ╔═╡ bd980fda-2c47-4c89-b979-3458f2f26667
### Exercise 2

# ╔═╡ ee989619-8d1b-4db0-97e3-6677afc6ca9f
md"""
Write a function that converts a named tuple to a dictionary. You
can create an empty dictionary using `Dict()`.
"""

# ╔═╡ 40b30234-8af4-4681-b10e-562ce21caa04
### Exercise 3

# ╔═╡ 2d5c47b7-4270-4b26-8f78-ab549ef1544e
md"""
Generate a 1000 random samples from the standard normal
distribution. Create a second such sample, and add the two samples
point-wise.  Compute the (sample) mean and variance of the combined
samples. In the same plot, show a histogram of the combined samples
and a plot of the pdf for normal distribution with zero mean and
variance `2`.
"""

# ╔═╡ 135dac9b-0bd9-4e1d-a8a4-a53f5149481e
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
# ╟─bc1912b8-c66a-4ab5-ba1f-6363f43ec697
# ╠═048a1195-1107-46e9-95ea-2955abd45275
# ╟─ef72056a-9321-4290-b1b3-dd47e367ba54
# ╠═af710d1b-f8c2-4219-8d7e-8e449afd1c48
# ╟─3e690f1c-4e80-4016-a949-7f3bd292fe31
# ╠═b541c5ac-3c15-4e71-8514-99938a2932db
# ╟─c00b48c5-d35b-409a-a0de-1721c1bc2df2
# ╟─3694faf5-d9a4-4089-bca8-7eec7950fd82
# ╠═cad4d998-43d7-421b-9873-1b1430e635cc
# ╟─26ce1939-e595-496a-b43e-d0ebe87da176
# ╠═d66140c7-958b-4347-9009-4cfb2012998f
# ╟─7aee99b6-3c6e-4a71-abd3-cb77d7a79683
# ╠═96c1adb9-1b29-433d-879e-dc128f3db7b3
# ╠═ef6a776c-8c63-4d30-a367-9aa3c6cf34d0
# ╟─b97d12e6-2346-410b-bf32-94657e65284e
# ╠═177a30bb-473a-4e5e-9afd-65a5b5facac9
# ╠═109564cb-ea6f-4264-b6c8-54f5ed90a964
# ╠═26714555-a4ad-49cb-9292-fe822525fc77
# ╟─d00b2507-e891-4ec5-ae5e-4b83dcbc9675
# ╠═4d1dd37a-194e-4ed2-8a29-32f11452654a
# ╠═38477997-58dd-4248-a5f1-151fcbe229a2
# ╠═e61c7ae2-8204-4a20-81bc-2d5603785a09
# ╟─d38b7040-bb41-44be-9d87-1d1fbb0e3997
# ╟─9f1e3326-b738-4b60-b950-fddef2a1fb10
# ╟─494f9e7c-e53a-4c65-951b-64cb2a36c8e3
# ╠═259bf65c-6868-47b0-b0e6-441461cc8770
# ╠═6ef57fdd-3188-4b19-8cb0-de601961bc02
# ╠═ef2473e2-bb35-4bd7-a87d-950c50fb2955
# ╠═76dc6ac8-03fe-4c6e-8448-4bcb089096cd
# ╟─5b3a3587-31f7-4a00-a012-a84240254fb6
# ╟─82f84505-336f-4845-bbdd-9799f7bb2e60
# ╠═42d147e9-cbf9-4456-97a7-88e3af4f10ee
# ╠═8c7dcea2-e879-405c-b372-8c9866e51852
# ╟─f85e0bbc-9db0-4a9f-8f3d-b82f1e7b6f7a
# ╠═dff4b531-62c4-4ccb-ab04-579e5608ae53
# ╟─166a1850-cddb-4f72-86cf-35420d9e6995
# ╠═44ef9d71-f75b-4140-a29a-8d0445351914
# ╠═ff4b5618-4be7-4111-be65-28d0fcca50a8
# ╟─fb16016a-87d7-4e9f-9a2e-c468345d87d1
# ╠═20ba7245-15ed-417e-b5fa-cb79ebf595ef
# ╠═542ec737-2c88-4293-91c5-524da38aa391
# ╠═8b1e2b91-947c-4046-ad90-b4405b216771
# ╠═3dcab89a-20ca-462a-895b-997a92b731e0
# ╟─65eb310b-82e8-4a1d-a525-e9b04a4bd246
# ╠═35998a8b-6fda-4a2f-80f0-ba7781e173cf
# ╟─2db5e586-237b-45aa-9cbc-9a2c39793333
# ╟─8b1c08d9-f8dd-4ec9-b887-2b16710e5502
# ╠═4942a061-18dd-41d0-9452-5298a8a4a401
# ╠═d1fb9147-4a06-44fa-b017-96f1602f2cad
# ╠═4f4bf27c-b2f9-4c15-8be2-2a4017c45345
# ╠═29d71401-66e5-484e-a7ad-80d84f5b0070
# ╟─4b80c58d-646a-405b-8378-5aa686f0b407
# ╠═44914181-9dd8-49b4-9f43-49763e8691a1
# ╟─63badfd3-c501-4d7c-bb0e-3a45761c733a
# ╟─e089aa5e-8d6e-48a4-9979-7044b2f2df33
# ╠═c4c0e393-0c62-4e8e-b2a1-fbbde543f620
# ╟─115b6c86-a0f2-4546-910b-f8a9a217eff2
# ╠═3c8e1237-ff55-4dd0-aa36-d2e8546da46a
# ╟─115b6c86-a0f2-4546-88a1-a2bf91434413
# ╠═169c078b-2f81-4b5e-a1cb-54e34396a855
# ╟─115b6c86-a0f2-4546-8037-0de5806e1a54
# ╠═1d690f10-1e44-4e9a-9961-a09632c33fb0
# ╟─7a568a60-5212-4c87-b7cc-46f4ef988c68
# ╟─77d49aef-9644-41c2-90fb-7f2721f6fcc7
# ╟─c3d721a1-ae10-4c0b-af65-ccd25ecb9818
# ╠═d9016c54-9656-4684-8890-979691212d9b
# ╟─a707446f-b9f3-4405-a6fa-eaf14df5d44b
# ╠═f86cc305-d2b6-4be3-8025-5084804a9f6c
# ╟─a0c15cdb-6294-47bc-9e90-09023d201062
# ╠═7d2bb0cb-fe63-443b-b7bb-2f33ef765cc0
# ╟─4455b804-b818-4fa0-9625-01172c4a0081
# ╠═87188f88-6519-4ffd-af4f-11c7de9e21dd
# ╟─d1f615d1-644a-4358-8dba-241d9b744683
# ╠═da033108-0b83-4ee8-a6e5-2f0b4dca5c59
# ╠═c494e441-4853-4a6d-8550-20498aa03ed0
# ╠═2063cdaf-dbb9-4587-9e7b-5b943cf6b560
# ╠═a2a2be72-f9fe-4e2c-bce6-0a1379cc1259
# ╠═6deb462e-668e-475d-9608-b5032c116833
# ╠═112438a5-ef2f-4c5d-b473-4aa968e6937a
# ╟─b87a9e77-1e26-4a1f-8d9e-644a1b3cc6b6
# ╠═cc2371a4-26be-4325-ac0a-23ded81445da
# ╠═9ac1f1af-bfdc-4499-8535-1a088a6a3228
# ╠═3a2fb476-5685-40aa-a39f-7893c73eef39
# ╠═01f39450-9ce3-46c1-bcca-51a27994a151
# ╟─bd256b23-4c27-4ca0-9b33-09b4b6661170
# ╟─133e6f93-bb0b-460d-b45d-88d068bb0fa2
# ╟─e7c2edc1-91cb-4ef1-92c8-6db3a590d963
# ╟─ab20d999-4cfa-4104-abf5-96f457eb2bdf
# ╠═c5e1e96d-691f-4366-8a60-2e0214c059f5
# ╟─240929b4-eb02-42a5-a38a-beb5c7157b57
# ╠═fdd4c037-11f7-4777-81f5-507803ea9ed6
# ╟─64a59295-2630-40c2-9b21-6d4eb642d87e
# ╠═b480add5-8651-4720-b98c-3df1f31879bf
# ╠═f618c762-a936-433f-92b7-4ceba56e97ad
# ╠═5db01f65-3d0f-4ba4-b122-214de244406c
# ╟─2a96dfa7-cf5a-4e7f-8a4b-c83694978e38
# ╠═aa456fbb-e9da-44d3-a8b6-f7ff516dedc4
# ╠═2e3fe339-a279-48e8-81e1-74ef03c2e79e
# ╟─c2078856-e4c8-4777-a04e-0b76409c14a7
# ╠═bd980fda-2c47-4c89-b979-3458f2f26667
# ╟─ee989619-8d1b-4db0-97e3-6677afc6ca9f
# ╠═40b30234-8af4-4681-b10e-562ce21caa04
# ╟─2d5c47b7-4270-4b26-8f78-ab549ef1544e
# ╟─135dac9b-0bd9-4e1d-a8a4-a53f5149481e
