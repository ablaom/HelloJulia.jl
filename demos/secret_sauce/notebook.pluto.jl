### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ f6b2d3ed-0205-44aa-9bca-7c69b794f8ce
md"# Brief sketch of Julia's secret sauce"

# ╔═╡ 9dc05597-c214-4e59-b795-033f6f2a0674
md"Julia's *secret sauce*"

# ╔═╡ fa3699ad-fb3c-41b9-935f-ddf6a6bfbbdd
md"""
- **Ahead-of-time compilation**
- **Multiple dispatch**
- **Abstract types**
"""

# ╔═╡ 49d7d413-b98b-4d58-af2a-25235e544a31
md"The following is not needed if running from the REPL:"

# ╔═╡ ce65b4a9-5381-42b4-8af5-148d95ea2900
begin
  using Pkg
  Pkg.activate(temp=true)
  Pkg.add("InteractiveUtils")
  using InteractiveUtils
end

# ╔═╡ b479e9f2-7327-4fac-a6bf-47194d7e8e12
md"## Just-in-time compilation"

# ╔═╡ f5dc834c-8820-465e-828a-4cc485149963
md"Here's how we define a new function in Julia:"

# ╔═╡ 848bb6b9-4d18-4cb6-9e54-3f7b3ca87ecb
add(x, y) = x + y

# ╔═╡ ec385e2c-f9e4-4990-ba1f-6363f43ec697
md"Let's see how long it takes to add two numbers:"

# ╔═╡ c522ff57-076d-42d2-95ea-2955abd45275
t = time(); add(3, 5); time() - t

# ╔═╡ c58d86e7-ed21-45d4-b1b3-dd47e367ba54
md"""
Slow!! Why? Because Julia is a *compiled* language and does not
compile new code until it knows the type of arguments you want to
use.
"""

# ╔═╡ cfc68404-2fcf-4e95-8d7e-8e449afd1c48
md"Let's try again *with the same type* of argument:"

# ╔═╡ 9c5b28a9-7505-4271-a949-7f3bd292fe31
t = time(); add(4, 7); time() - t

# ╔═╡ 3c33d5a4-74f3-45d6-8514-99938a2932db
md"""
Fast!!! Why? Because Julia caches the compiled code and the types
are the same.
"""

# ╔═╡ 0069f5ef-21f3-4362-a0de-1721c1bc2df2
md"Let's try complex numbers:"

# ╔═╡ 7b9b5a0d-ae8a-4e82-bca8-7eec7950fd82
t = time(); add(1 + 2im, 4 + 3im); time() - t

# ╔═╡ 3d947de5-b6a3-4f8f-9873-1b1430e635cc
md"Slow :-("

# ╔═╡ b0ac933a-8cca-4ef7-b43e-d0ebe87da176
t = time(); add(3 + 6im, 7 - 5im); time() - t

# ╔═╡ 7f661acf-bf32-4055-9009-4cfb2012998f
md"Fast :-)"

# ╔═╡ b502f6a1-bc47-4a24-abd3-cb77d7a79683
md"## Multiple dispatch"

# ╔═╡ b6dd9999-eba6-4c36-879e-dc128f3db7b3
y = [1 2; 3 4]

# ╔═╡ 81d7898d-7e0d-4558-a367-9aa3c6cf34d0
typeof(y)

# ╔═╡ 2fdb30e5-2db6-4e69-bf32-94657e65284e
md"""
But Julia doesn not how to apply `+` to a scalar and a
matrix. Uncomment the following line to see the error thrown:
"""

# ╔═╡ 47a7a91c-1e3d-46d8-9afd-65a5b5facac9
md"add(4, y)"

# ╔═╡ 66f9d271-772c-447a-b6c8-54f5ed90a964
md"""
So we *add* a more specialized version of our function (called a
*method*) to handle this case:
"""

# ╔═╡ 658f9270-5eca-415b-9292-fe822525fc77
add(x::Int, y::Array{Int,2}) = x .+ y

# ╔═╡ 8a59bfae-158d-4632-ae5e-4b83dcbc9675
md"""
Here we are using the built-in broadcasted version of `+` which adds
the scalar `x` to each element of `y`. Now this works:
"""

# ╔═╡ 0b64f309-47bf-4a30-8a29-32f11452654a
add(4, y)

# ╔═╡ 0fcf0345-8ccd-4ae8-a5f1-151fcbe229a2
md"""
This is essentially what multiple dispatch is about. We use *all*
the arguments of a function to determine what specific method to
call. In a traditional object oriented language methods are owned by
objects (data structures) and we see syntax like `x.add(y)` which is
*single* dispatch on `x`.
"""

# ╔═╡ 14da5cb7-2470-4d92-81bc-2d5603785a09
md"In Julia *functions*, not objects, own *methods*:"

# ╔═╡ 4a0d9a26-63d1-4e9c-9d87-1d1fbb0e3997
methods(add)

# ╔═╡ ab84efb1-244a-4545-b950-fddef2a1fb10
md"""
Or, stated differently, there is less conflation of *structure* and
*behaviour* in Julia!
"""

# ╔═╡ 87323275-2318-4587-951b-64cb2a36c8e3
md"""
But, we're not out of the woods yet. Uncomment to see a new error
thrown:
"""

# ╔═╡ bc6b5324-3067-4e08-b0e6-441461cc8770
md"add(4.0, y)"

# ╔═╡ 61e9eb8d-7c51-46cc-8cb0-de601961bc02
md"""
Oh dear. Do we need to write a special method for every kind of
scalar and matrix???!
"""

# ╔═╡ 3645fdc2-5739-4cb0-a87d-950c50fb2955
md"No, because abstract types come to the rescue..."

# ╔═╡ 0553da4d-58d7-4d4c-8448-4bcb089096cd
md"## Abstract types"

# ╔═╡ 87fecfb3-8c1e-4d22-a012-a84240254fb6
md"Everything in Julia has a type:"

# ╔═╡ 58047fc3-2773-4979-bbdd-9799f7bb2e60
typeof(1 + 2im)

# ╔═╡ e38e2f65-cc4e-49b8-97a7-88e3af4f10ee
typeof(rand(2,3))

# ╔═╡ 56d24bdb-fe6d-478c-b372-8c9866e51852
md"""
These are examples of *concrete* types. But concrete types are
*organized* through the use of *abstract types*, in a type
heirarchy:
"""

# ╔═╡ f00a74c6-f29b-4fd5-8f3d-b82f1e7b6f7a
supertype(Int)

# ╔═╡ 37b26b0a-ece2-45f3-ab04-579e5608ae53
supertype(Signed)

# ╔═╡ f602d1f0-c159-42c3-86cf-35420d9e6995
supertype(Integer)

# ╔═╡ 22deab2f-1ec6-451e-a29a-8d0445351914
subtypes(Real)

# ╔═╡ 18f26303-e83f-45c3-be65-28d0fcca50a8
4 isa Real

# ╔═╡ 0be288d9-2ae2-49db-9a2e-c468345d87d1
Bool <: Integer

# ╔═╡ 26b59f93-6cf1-4e7c-b5fa-cb79ebf595ef
String <: Integer

# ╔═╡ 2ff4abaa-f1fb-4981-91c5-524da38aa391
md"""
Now we can solve our problem: How to extend our `add` function to
arbitrary scalars and matrices:
"""

# ╔═╡ 43f8f733-eb9b-412d-ad90-b4405b216771
add(x::Real, y::Matrix) = x .+ y

# ╔═╡ b6b617cc-bbb7-4235-895b-997a92b731e0
add(4.0, rand(Bool, 2, 3))

# ╔═╡ 135dac9b-0bd9-4e1d-a525-e9b04a4bd246
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─f6b2d3ed-0205-44aa-9bca-7c69b794f8ce
# ╟─9dc05597-c214-4e59-b795-033f6f2a0674
# ╟─fa3699ad-fb3c-41b9-935f-ddf6a6bfbbdd
# ╟─49d7d413-b98b-4d58-af2a-25235e544a31
# ╠═ce65b4a9-5381-42b4-8af5-148d95ea2900
# ╟─b479e9f2-7327-4fac-a6bf-47194d7e8e12
# ╟─f5dc834c-8820-465e-828a-4cc485149963
# ╠═848bb6b9-4d18-4cb6-9e54-3f7b3ca87ecb
# ╟─ec385e2c-f9e4-4990-ba1f-6363f43ec697
# ╠═c522ff57-076d-42d2-95ea-2955abd45275
# ╟─c58d86e7-ed21-45d4-b1b3-dd47e367ba54
# ╟─cfc68404-2fcf-4e95-8d7e-8e449afd1c48
# ╠═9c5b28a9-7505-4271-a949-7f3bd292fe31
# ╟─3c33d5a4-74f3-45d6-8514-99938a2932db
# ╟─0069f5ef-21f3-4362-a0de-1721c1bc2df2
# ╠═7b9b5a0d-ae8a-4e82-bca8-7eec7950fd82
# ╟─3d947de5-b6a3-4f8f-9873-1b1430e635cc
# ╠═b0ac933a-8cca-4ef7-b43e-d0ebe87da176
# ╟─7f661acf-bf32-4055-9009-4cfb2012998f
# ╟─b502f6a1-bc47-4a24-abd3-cb77d7a79683
# ╠═b6dd9999-eba6-4c36-879e-dc128f3db7b3
# ╠═81d7898d-7e0d-4558-a367-9aa3c6cf34d0
# ╟─2fdb30e5-2db6-4e69-bf32-94657e65284e
# ╟─47a7a91c-1e3d-46d8-9afd-65a5b5facac9
# ╟─66f9d271-772c-447a-b6c8-54f5ed90a964
# ╠═658f9270-5eca-415b-9292-fe822525fc77
# ╟─8a59bfae-158d-4632-ae5e-4b83dcbc9675
# ╠═0b64f309-47bf-4a30-8a29-32f11452654a
# ╟─0fcf0345-8ccd-4ae8-a5f1-151fcbe229a2
# ╟─14da5cb7-2470-4d92-81bc-2d5603785a09
# ╠═4a0d9a26-63d1-4e9c-9d87-1d1fbb0e3997
# ╟─ab84efb1-244a-4545-b950-fddef2a1fb10
# ╟─87323275-2318-4587-951b-64cb2a36c8e3
# ╟─bc6b5324-3067-4e08-b0e6-441461cc8770
# ╟─61e9eb8d-7c51-46cc-8cb0-de601961bc02
# ╟─3645fdc2-5739-4cb0-a87d-950c50fb2955
# ╟─0553da4d-58d7-4d4c-8448-4bcb089096cd
# ╟─87fecfb3-8c1e-4d22-a012-a84240254fb6
# ╠═58047fc3-2773-4979-bbdd-9799f7bb2e60
# ╠═e38e2f65-cc4e-49b8-97a7-88e3af4f10ee
# ╟─56d24bdb-fe6d-478c-b372-8c9866e51852
# ╠═f00a74c6-f29b-4fd5-8f3d-b82f1e7b6f7a
# ╠═37b26b0a-ece2-45f3-ab04-579e5608ae53
# ╠═f602d1f0-c159-42c3-86cf-35420d9e6995
# ╠═22deab2f-1ec6-451e-a29a-8d0445351914
# ╠═18f26303-e83f-45c3-be65-28d0fcca50a8
# ╠═0be288d9-2ae2-49db-9a2e-c468345d87d1
# ╠═26b59f93-6cf1-4e7c-b5fa-cb79ebf595ef
# ╟─2ff4abaa-f1fb-4981-91c5-524da38aa391
# ╠═43f8f733-eb9b-412d-ad90-b4405b216771
# ╠═b6b617cc-bbb7-4235-895b-997a92b731e0
# ╟─135dac9b-0bd9-4e1d-a525-e9b04a4bd246
