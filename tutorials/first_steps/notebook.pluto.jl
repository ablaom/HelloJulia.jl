### A Pluto.jl notebook ###
# v0.17.0

using Markdown
using InteractiveUtils

# ╔═╡ c5e1e96d-691f-4366-9625-01172c4a0081
begin
  using Pkg                        # built-in package manager
  Pkg.activate("env", shared=true) # create a new pkg env
end

# ╔═╡ fdd4c037-11f7-4777-8dba-241d9b744683
begin
  Pkg.add("Distributions")
  Pkg.add("Plots")
end

# ╔═╡ b480add5-8651-4720-8550-20498aa03ed0
begin
  using Distributions
  using Plots
  
  N = 1000
  samples = rand(Normal(), N);   # equivalent to Julia's built-in `randn(d)`
  samples = (samples).^2;        # square element-wise
end

# ╔═╡ 142b62e1-364e-45d6-9bca-7c69b794f8ce
md"# Tutorial 1"

# ╔═╡ 7d6281ab-09c4-40db-b795-033f6f2a0674
md"Crash course in Julia basics."

# ╔═╡ 96774cd2-130c-4455-935f-ddf6a6bfbbdd
md"## Julia is a calculator:"

# ╔═╡ 8e8a0cbc-96b9-490c-af2a-25235e544a31
1 + 2^3

# ╔═╡ a65fb83a-f977-47ce-8af5-148d95ea2900
sqrt(1 + 2^3) # do `sqrt(ans)` in REPL

# ╔═╡ dc16182e-b6b3-47ee-a6bf-47194d7e8e12
sin(pi)

# ╔═╡ b541c5ac-3c15-4e71-828a-4cc485149963
asin(1 + 3*im)

# ╔═╡ c00b48c5-d35b-409a-9e54-3f7b3ca87ecb
md"## Arrays"

# ╔═╡ 3694faf5-d9a4-4089-ba1f-6363f43ec697
md"One dimensional vectors:"

# ╔═╡ cad4d998-43d7-421b-95ea-2955abd45275
v = [3, 5, 7]

# ╔═╡ 26ce1939-e595-496a-b1b3-dd47e367ba54
md"A \"row vector\" is a 1 x n array:"

# ╔═╡ d66140c7-958b-4347-8d7e-8e449afd1c48
row = [3 5 7]

# ╔═╡ 7aee99b6-3c6e-4a71-a949-7f3bd292fe31
md"Multiple row vectors separated by semicolons or new lines define matrices:"

# ╔═╡ 96c1adb9-1b29-433d-8514-99938a2932db
A = [3 5 7
     2 4 6
     1 3 5]

# ╔═╡ ef6a776c-8c63-4d30-a0de-1721c1bc2df2
size(A)

# ╔═╡ 0efd9664-dbb8-4ef1-bca8-7eec7950fd82
md"Accessing elements:"

# ╔═╡ 177a30bb-473a-4e5e-9873-1b1430e635cc
A[1, 2]

# ╔═╡ 109564cb-ea6f-4264-b43e-d0ebe87da176
A[1, 2] == A[2]

# ╔═╡ 26714555-a4ad-49cb-9009-4cfb2012998f
A[:, 2] # 2nd column

# ╔═╡ d00b2507-e891-4ec5-abd3-cb77d7a79683
md"Changing elements:"

# ╔═╡ 4d1dd37a-194e-4ed2-879e-dc128f3db7b3
A[1, 1] = 42

# ╔═╡ 38477997-58dd-4248-a367-9aa3c6cf34d0
inv(A) # inverse

# ╔═╡ e61c7ae2-8204-4a20-bf32-94657e65284e
isapprox(inv(A)*v, A\v) # but RHS more efficient

# ╔═╡ d38b7040-bb41-44be-9afd-65a5b5facac9
md"## \"Variables\" in Julia *point* to objects"

# ╔═╡ 9f1e3326-b738-4b60-b6c8-54f5ed90a964
md"Corollary: all passing of function arguments is pass by reference"

# ╔═╡ 494f9e7c-e53a-4c65-9292-fe822525fc77
md"Like Python; Unlike R, C or FORTRAN."

# ╔═╡ 259bf65c-6868-47b0-ae5e-4b83dcbc9675
begin
  w = v
  
  w
end

# ╔═╡ 6ef57fdd-3188-4b19-8a29-32f11452654a
v[1] = 42

# ╔═╡ ef2473e2-bb35-4bd7-a5f1-151fcbe229a2
v

# ╔═╡ 76dc6ac8-03fe-4c6e-81bc-2d5603785a09
w

# ╔═╡ 5b3a3587-31f7-4a00-9d87-1d1fbb0e3997
md"## Tuples"

# ╔═╡ 82f84505-336f-4845-b950-fddef2a1fb10
md"Similar to vectors but of fixed length and immutable (cannot be changed)"

# ╔═╡ 42d147e9-cbf9-4456-951b-64cb2a36c8e3
begin
  t = (1, 2.0, "cat")
  typeof(t)
end

# ╔═╡ 8c7dcea2-e879-405c-b0e6-441461cc8770
t[3]

# ╔═╡ 8d6006ac-53bb-4b5d-8cb0-de601961bc02
md"## Strings"

# ╔═╡ 44ef9d71-f75b-4140-a87d-950c50fb2955
begin
  a_string = "the cat"
  a_character = 't'
  a_symbol = :t
end

# ╔═╡ ff4b5618-4be7-4111-8448-4bcb089096cd
a_string[1] == a_character

# ╔═╡ fb16016a-87d7-4e9f-a012-a84240254fb6
md"""
A `Symbol` is string-like but
[interned](https://en.wikipedia.org/wiki/String_interning). Generally
use `String` for ordinary textual data, but use `Symbol` for
language reflection (metaprogramming). For example:
"""

# ╔═╡ 20ba7245-15ed-417e-bbdd-9799f7bb2e60
isdefined(Main, :z)

# ╔═╡ 542ec737-2c88-4293-97a7-88e3af4f10ee
begin
  z = 1 + 2im
  isdefined(Main, :z)
end

# ╔═╡ 8b1e2b91-947c-4046-b372-8c9866e51852
z.im

# ╔═╡ 3dcab89a-20ca-462a-8f3d-b82f1e7b6f7a
fieldnames(typeof(z))

# ╔═╡ 65eb310b-82e8-4a1d-ab04-579e5608ae53
md"Symbols are generalized by *expressions*:"

# ╔═╡ 35998a8b-6fda-4a2f-86cf-35420d9e6995
begin
  ex = :(z == 3)
  eval(ex)
end

# ╔═╡ 2db5e586-237b-45aa-a29a-8d0445351914
md"If this is confusing, forget it for now."

# ╔═╡ 8b1c08d9-f8dd-4ec9-be65-28d0fcca50a8
md"## Dictionaries"

# ╔═╡ 4942a061-18dd-41d0-9a2e-c468345d87d1
d = Dict('a' => "ant", 'z' => "zebra")

# ╔═╡ d1fb9147-4a06-44fa-b5fa-cb79ebf595ef
d['a']

# ╔═╡ 4f4bf27c-b2f9-4c15-91c5-524da38aa391
begin
  d['b'] = "bat"
  d
end

# ╔═╡ 29d71401-66e5-484e-ad90-b4405b216771
keys(d)

# ╔═╡ 4b80c58d-646a-405b-895b-997a92b731e0
md"The expression 'a' => \"ant\" is itself a stand-alone object:"

# ╔═╡ 44914181-9dd8-49b4-a525-e9b04a4bd246
begin
  pair = 'a' => "ant"
  
  first(pair)
end

# ╔═╡ c3d08392-8bbc-45f1-80f0-ba7781e173cf
pairs = [x => x^2 for x in 1:5]

# ╔═╡ 1009b0d8-e299-4f37-9cbc-9a2c39793333
Dict(pairs)

# ╔═╡ 63badfd3-c501-4d7c-b887-2b16710e5502
md"## Functions"

# ╔═╡ e089aa5e-8d6e-48a4-9452-5298a8a4a401
md"Three ways to define a generic function:"

# ╔═╡ c4c0e393-0c62-4e8e-b017-96f1602f2cad
begin
  foo(x) = x^2 # METHOD 1 (inline)
  foo(3)
end

# ╔═╡ 115b6c86-a0f2-4546-8be2-2a4017c45345
md"or"

# ╔═╡ 3c8e1237-ff55-4dd0-a7ad-80d84f5b0070
3 |> foo

# ╔═╡ 115b6c86-a0f2-4546-8378-5aa686f0b407
md"or"

# ╔═╡ 169c078b-2f81-4b5e-9f43-49763e8691a1
3 |> x -> x^2 # METHOD 2 (anonymous)

# ╔═╡ 115b6c86-a0f2-4546-bb0e-3a45761c733a
md"or"

# ╔═╡ 1d690f10-1e44-4e9a-9979-7044b2f2df33
begin
  function foo2(x) # METHOD 3 (verbose)
      y = x
      z = y
      w = z
      return w^2
  end
  
  foo2(3)
end

# ╔═╡ 7a568a60-5212-4c87-b2a1-fbbde543f620
md"## Basic iteration"

# ╔═╡ 77d49aef-9644-41c2-910b-f8a9a217eff2
md"Here are three ways to square the integers from 1 to 10."

# ╔═╡ c3d721a1-ae10-4c0b-aa36-d2e8546da46a
md"METHOD 1 (explicit loop):"

# ╔═╡ d9016c54-9656-4684-88a1-a2bf91434413
begin
  squares = [] # or Int[] if performance matters
  for x in 1:10
      push!(squares, x^2)
  end
  
  squares
end

# ╔═╡ a707446f-b9f3-4405-a1cb-54e34396a855
md"METHOD 2 (comprehension):"

# ╔═╡ f86cc305-d2b6-4be3-8037-0de5806e1a54
[x^2 for x in 1:10]

# ╔═╡ e2124d81-d983-4ab2-9961-a09632c33fb0
md"METHOD 3 (delayed comprension):"

# ╔═╡ 46a41f6a-293a-41b9-b7cc-46f4ef988c68
squares2 = (x^2 for x in 1:10)

# ╔═╡ 92a07c40-18a1-491d-90fb-7f2721f6fcc7
collect(squares2)

# ╔═╡ 876f0160-69a3-43e3-af65-ccd25ecb9818
md"METHOD 4 (map):"

# ╔═╡ 7d2bb0cb-fe63-443b-8890-979691212d9b
map(x -> x^2, 1:10)

# ╔═╡ 7a168f53-f883-456e-a6fa-eaf14df5d44b
md"METHOD 5 (broadcasting with dot syntax):"

# ╔═╡ 87188f88-6519-4ffd-8025-5084804a9f6c
(1:10) .^ 2

# ╔═╡ e7c2edc1-91cb-4ef1-9e90-09023d201062
md"## Loading packages"

# ╔═╡ ab20d999-4cfa-4104-b7bb-2f33ef765cc0
md"If not in the REPL:"

# ╔═╡ 240929b4-eb02-42a5-af4f-11c7de9e21dd
md"""
Add some packages to your enviroment (latest compatible versions
added by default):
"""

# ╔═╡ 64a59295-2630-40c2-a6e5-2f0b4dca5c59
md"To load the code for use:"

# ╔═╡ f618c762-a936-433f-9e7b-5b943cf6b560
g = fit(Gamma, samples)

# ╔═╡ 5db01f65-3d0f-4ba4-bce6-0a1379cc1259
@show mean(g) median(g) pdf(g, 1)

# ╔═╡ 2a96dfa7-cf5a-4e7f-9608-b5032c116833
md"## Plotting"

# ╔═╡ aa456fbb-e9da-44d3-b473-4aa968e6937a
begin
  f(x) = pdf(g, x)
  
  x = 0:0.1:4 # floats from 0 to 4 in steps of 0.1
  y = f.(x)   # apply f element-wise to x
  
  plot(x, y, xrange=(0,4), yrange=(0,0.2))
  histogram!(samples , normalize=true, alpha=0.4)
end

# ╔═╡ ebe6467e-e767-481b-8d9e-644a1b3cc6b6
savefig("my_first_plot.png")

# ╔═╡ 135dac9b-0bd9-4e1d-ac0a-23ded81445da
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─142b62e1-364e-45d6-9bca-7c69b794f8ce
# ╟─7d6281ab-09c4-40db-b795-033f6f2a0674
# ╟─96774cd2-130c-4455-935f-ddf6a6bfbbdd
# ╠═8e8a0cbc-96b9-490c-af2a-25235e544a31
# ╠═a65fb83a-f977-47ce-8af5-148d95ea2900
# ╠═dc16182e-b6b3-47ee-a6bf-47194d7e8e12
# ╠═b541c5ac-3c15-4e71-828a-4cc485149963
# ╟─c00b48c5-d35b-409a-9e54-3f7b3ca87ecb
# ╟─3694faf5-d9a4-4089-ba1f-6363f43ec697
# ╠═cad4d998-43d7-421b-95ea-2955abd45275
# ╟─26ce1939-e595-496a-b1b3-dd47e367ba54
# ╠═d66140c7-958b-4347-8d7e-8e449afd1c48
# ╟─7aee99b6-3c6e-4a71-a949-7f3bd292fe31
# ╠═96c1adb9-1b29-433d-8514-99938a2932db
# ╠═ef6a776c-8c63-4d30-a0de-1721c1bc2df2
# ╟─0efd9664-dbb8-4ef1-bca8-7eec7950fd82
# ╠═177a30bb-473a-4e5e-9873-1b1430e635cc
# ╠═109564cb-ea6f-4264-b43e-d0ebe87da176
# ╠═26714555-a4ad-49cb-9009-4cfb2012998f
# ╟─d00b2507-e891-4ec5-abd3-cb77d7a79683
# ╠═4d1dd37a-194e-4ed2-879e-dc128f3db7b3
# ╠═38477997-58dd-4248-a367-9aa3c6cf34d0
# ╠═e61c7ae2-8204-4a20-bf32-94657e65284e
# ╟─d38b7040-bb41-44be-9afd-65a5b5facac9
# ╟─9f1e3326-b738-4b60-b6c8-54f5ed90a964
# ╟─494f9e7c-e53a-4c65-9292-fe822525fc77
# ╠═259bf65c-6868-47b0-ae5e-4b83dcbc9675
# ╠═6ef57fdd-3188-4b19-8a29-32f11452654a
# ╠═ef2473e2-bb35-4bd7-a5f1-151fcbe229a2
# ╠═76dc6ac8-03fe-4c6e-81bc-2d5603785a09
# ╟─5b3a3587-31f7-4a00-9d87-1d1fbb0e3997
# ╟─82f84505-336f-4845-b950-fddef2a1fb10
# ╠═42d147e9-cbf9-4456-951b-64cb2a36c8e3
# ╠═8c7dcea2-e879-405c-b0e6-441461cc8770
# ╟─8d6006ac-53bb-4b5d-8cb0-de601961bc02
# ╠═44ef9d71-f75b-4140-a87d-950c50fb2955
# ╠═ff4b5618-4be7-4111-8448-4bcb089096cd
# ╟─fb16016a-87d7-4e9f-a012-a84240254fb6
# ╠═20ba7245-15ed-417e-bbdd-9799f7bb2e60
# ╠═542ec737-2c88-4293-97a7-88e3af4f10ee
# ╠═8b1e2b91-947c-4046-b372-8c9866e51852
# ╠═3dcab89a-20ca-462a-8f3d-b82f1e7b6f7a
# ╟─65eb310b-82e8-4a1d-ab04-579e5608ae53
# ╠═35998a8b-6fda-4a2f-86cf-35420d9e6995
# ╟─2db5e586-237b-45aa-a29a-8d0445351914
# ╟─8b1c08d9-f8dd-4ec9-be65-28d0fcca50a8
# ╠═4942a061-18dd-41d0-9a2e-c468345d87d1
# ╠═d1fb9147-4a06-44fa-b5fa-cb79ebf595ef
# ╠═4f4bf27c-b2f9-4c15-91c5-524da38aa391
# ╠═29d71401-66e5-484e-ad90-b4405b216771
# ╟─4b80c58d-646a-405b-895b-997a92b731e0
# ╠═44914181-9dd8-49b4-a525-e9b04a4bd246
# ╠═c3d08392-8bbc-45f1-80f0-ba7781e173cf
# ╠═1009b0d8-e299-4f37-9cbc-9a2c39793333
# ╟─63badfd3-c501-4d7c-b887-2b16710e5502
# ╟─e089aa5e-8d6e-48a4-9452-5298a8a4a401
# ╠═c4c0e393-0c62-4e8e-b017-96f1602f2cad
# ╟─115b6c86-a0f2-4546-8be2-2a4017c45345
# ╠═3c8e1237-ff55-4dd0-a7ad-80d84f5b0070
# ╟─115b6c86-a0f2-4546-8378-5aa686f0b407
# ╠═169c078b-2f81-4b5e-9f43-49763e8691a1
# ╟─115b6c86-a0f2-4546-bb0e-3a45761c733a
# ╠═1d690f10-1e44-4e9a-9979-7044b2f2df33
# ╟─7a568a60-5212-4c87-b2a1-fbbde543f620
# ╟─77d49aef-9644-41c2-910b-f8a9a217eff2
# ╟─c3d721a1-ae10-4c0b-aa36-d2e8546da46a
# ╠═d9016c54-9656-4684-88a1-a2bf91434413
# ╟─a707446f-b9f3-4405-a1cb-54e34396a855
# ╠═f86cc305-d2b6-4be3-8037-0de5806e1a54
# ╟─e2124d81-d983-4ab2-9961-a09632c33fb0
# ╠═46a41f6a-293a-41b9-b7cc-46f4ef988c68
# ╠═92a07c40-18a1-491d-90fb-7f2721f6fcc7
# ╟─876f0160-69a3-43e3-af65-ccd25ecb9818
# ╠═7d2bb0cb-fe63-443b-8890-979691212d9b
# ╟─7a168f53-f883-456e-a6fa-eaf14df5d44b
# ╠═87188f88-6519-4ffd-8025-5084804a9f6c
# ╟─e7c2edc1-91cb-4ef1-9e90-09023d201062
# ╟─ab20d999-4cfa-4104-b7bb-2f33ef765cc0
# ╠═c5e1e96d-691f-4366-9625-01172c4a0081
# ╟─240929b4-eb02-42a5-af4f-11c7de9e21dd
# ╠═fdd4c037-11f7-4777-8dba-241d9b744683
# ╟─64a59295-2630-40c2-a6e5-2f0b4dca5c59
# ╠═b480add5-8651-4720-8550-20498aa03ed0
# ╠═f618c762-a936-433f-9e7b-5b943cf6b560
# ╠═5db01f65-3d0f-4ba4-bce6-0a1379cc1259
# ╟─2a96dfa7-cf5a-4e7f-9608-b5032c116833
# ╠═aa456fbb-e9da-44d3-b473-4aa968e6937a
# ╠═ebe6467e-e767-481b-8d9e-644a1b3cc6b6
# ╟─135dac9b-0bd9-4e1d-ac0a-23ded81445da
