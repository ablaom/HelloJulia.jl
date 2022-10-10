### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ f6b2d3ed-0205-44aa-9bca-7c69b794f8ce
md"# Brief sketch of Julia's secret sauce"

# ╔═╡ eb23f2c6-61f4-4a82-b795-033f6f2a0674
md"Notebook from [HelloJulia.jl](https://github.com/ablaom/HelloJulia.jl)"

# ╔═╡ 2d95e9db-a2b9-48b6-935f-ddf6a6bfbbdd
md"Julia's *secret sauce:*"

# ╔═╡ 9d38b890-85c6-4768-af2a-25235e544a31
md"""
- **Just-in-time compilation**
- **Multiple dispatch**
- **Abstract types**
"""

# ╔═╡ d24d673c-e037-49a8-8af5-148d95ea2900
md"""
If your just copying code into Julia's REPL, then you can ignore the
next line:
"""

# ╔═╡ e415e89d-f149-45c6-a6bf-47194d7e8e12
using InteractiveUtils

# ╔═╡ b479e9f2-7327-4fac-828a-4cc485149963
md"## Just-in-time compilation"

# ╔═╡ f5dc834c-8820-465e-9e54-3f7b3ca87ecb
md"Here's how we define a new function in Julia:"

# ╔═╡ 848bb6b9-4d18-4cb6-ba1f-6363f43ec697
add(x, y) = x + y

# ╔═╡ ec385e2c-f9e4-4990-95ea-2955abd45275
md"Let's see how long it takes to add two numbers:"

# ╔═╡ ea340fab-cb94-4396-b1b3-dd47e367ba54
@time @eval add(3, 5)

# ╔═╡ 7d473844-ea0a-4586-8d7e-8e449afd1c48
md"""
Slow!! Why? Because Julia is a *compiled* language and does not
compile new code until it knows the type of arguments you want to
use. (The use of the macro `@eval` helps us to include this
compilation time in the total measurement, since `@time` is designed
to cleverly exclude it in recent Julia versions.)
"""

# ╔═╡ cfc68404-2fcf-4e95-a949-7f3bd292fe31
md"Let's try again *with the same type* of argument:"

# ╔═╡ 8f285628-3b0a-4ed6-8514-99938a2932db
@time @eval add(4, 7)

# ╔═╡ 90354dfd-148c-4590-a0de-1721c1bc2df2
md"""
Fast!!! Why? Because Julia caches the compiled code and the types
are the same. We can even inpsect an annotated version of this
compiled code:
"""

# ╔═╡ bfc1b998-468b-45e6-bca8-7eec7950fd82
@code_llvm add(4, 7)

# ╔═╡ 3b854215-32d8-4762-9873-1b1430e635cc
md"This code is indistinguishable from analogous C code (if using the `clang` compiler)."

# ╔═╡ 443d2ffa-0827-4af1-b43e-d0ebe87da176
md"Let's try vectors:"

# ╔═╡ 6e54ee9b-7520-4b2e-9009-4cfb2012998f
begin
  x = rand(3)
  y = rand(3)
end

# ╔═╡ c6da4b34-81e0-43de-abd3-cb77d7a79683
@time @eval add(x, y)

# ╔═╡ 3d947de5-b6a3-4f8f-879e-dc128f3db7b3
md"Slow :-("

# ╔═╡ 3d815cad-be9a-40eb-a367-9aa3c6cf34d0
@time @eval add(y, x)

# ╔═╡ 97317766-2964-4bda-bf32-94657e65284e
md"Fast :-)."

# ╔═╡ 6be383da-149a-46ee-9afd-65a5b5facac9
md"Just-in-time compilation exists in other languages (eg, Java)."

# ╔═╡ b502f6a1-bc47-4a24-b6c8-54f5ed90a964
md"## Multiple dispatch"

# ╔═╡ d4ba5f00-1e8c-4233-9292-fe822525fc77
A = [1 2; 3 4]

# ╔═╡ 3661cc0f-c5bc-45b6-ae5e-4b83dcbc9675
typeof(A)

# ╔═╡ ed7d0eab-0577-40de-8a29-32f11452654a
md"""
Julia doesn't know how to apply `+` to a scalar and a
matrix. Uncomment the following line (by removing the "#" symbol) to
see the error thrown:
"""

# ╔═╡ 1de1a136-ad29-4178-a5f1-151fcbe229a2
# add(4, A)

# ╔═╡ 9e999f31-7659-4d0d-81bc-2d5603785a09
md"""
So we add a more specialized version of our function (called a
*method*) to handle this case:
"""

# ╔═╡ bdf46021-f4d3-45c6-9d87-1d1fbb0e3997
add(x::Int64, y::Matrix{Int64}) = x .+ y

# ╔═╡ 8a59bfae-158d-4632-b950-fddef2a1fb10
md"""
Here we are using the built-in broadcasted version of `+` which adds
the scalar `x` to each element of `y`. Now this works:
"""

# ╔═╡ da4868c0-2d93-4dd9-951b-64cb2a36c8e3
add(4, A)

# ╔═╡ 0fcf0345-8ccd-4ae8-b0e6-441461cc8770
md"""
This is essentially what multiple dispatch is about. We use *all*
the arguments of a function to determine what specific method to
call. In a traditional object oriented language methods are owned by
objects (data structures) and we see syntax like `x.add(y)` which is
*single* dispatch on `x`.
"""

# ╔═╡ 1fb4c0ce-f140-408a-8cb0-de601961bc02
md"""
Multiple dispatch is not used in any widely used languages. Dylan is
the most well-known example.
"""

# ╔═╡ fee6b15a-0c87-497b-a87d-950c50fb2955
md"""
If you are coming from a traditional object oriented language like
Python, then you're used to thinking of objects "owning" methods. In
Julia *functions*, not objects, own *methods*:
"""

# ╔═╡ 4a0d9a26-63d1-4e9c-8448-4bcb089096cd
methods(add)

# ╔═╡ ab84efb1-244a-4545-a012-a84240254fb6
md"""
Or, stated differently, there is less conflation of *structure* and
*behaviour* in Julia!
"""

# ╔═╡ 87323275-2318-4587-bbdd-9799f7bb2e60
md"""
But, we're not out of the woods yet. Uncomment to see a new error
thrown:
"""

# ╔═╡ 9b41264c-c8d2-4872-97a7-88e3af4f10ee
# add(4.0, A)

# ╔═╡ 61e9eb8d-7c51-46cc-b372-8c9866e51852
md"""
Oh dear. Do we need to write a special method for every kind of
scalar and matrix???!
"""

# ╔═╡ 3645fdc2-5739-4cb0-8f3d-b82f1e7b6f7a
md"No, because abstract types come to the rescue..."

# ╔═╡ 0553da4d-58d7-4d4c-ab04-579e5608ae53
md"## Abstract types"

# ╔═╡ 87fecfb3-8c1e-4d22-86cf-35420d9e6995
md"Everything in Julia has a type:"

# ╔═╡ 58047fc3-2773-4979-a29a-8d0445351914
typeof(1 + 2im)

# ╔═╡ e38e2f65-cc4e-49b8-be65-28d0fcca50a8
typeof(rand(2,3))

# ╔═╡ 6674ce39-d112-4307-9a2e-c468345d87d1
md"""
These are examples of *concrete* types. But concrete types have
*supertypes*, which are *abstract*:
"""

# ╔═╡ 1cf1fc9e-208e-4689-b5fa-cb79ebf595ef
supertype(Int64)

# ╔═╡ 37b26b0a-ece2-45f3-91c5-524da38aa391
supertype(Signed)

# ╔═╡ f602d1f0-c159-42c3-ad90-b4405b216771
supertype(Integer)

# ╔═╡ d550f1fc-fd5d-48ec-895b-997a92b731e0
md"And we can travel in the other direction:"

# ╔═╡ 22deab2f-1ec6-451e-a525-e9b04a4bd246
subtypes(Real)

# ╔═╡ 18f26303-e83f-45c3-80f0-ba7781e173cf
4 isa Real

# ╔═╡ 0be288d9-2ae2-49db-9cbc-9a2c39793333
Bool <: Integer

# ╔═╡ 26b59f93-6cf1-4e7c-b887-2b16710e5502
String <: Integer

# ╔═╡ 2ff4abaa-f1fb-4981-9452-5298a8a4a401
md"""
Now we can solve our problem: How to extend our `add` function to
arbitrary scalars and matrices:
"""

# ╔═╡ 43f8f733-eb9b-412d-b017-96f1602f2cad
add(x::Real, y::Matrix) = x .+ y

# ╔═╡ b6b617cc-bbb7-4235-8be2-2a4017c45345
add(4.0, rand(Bool, 2, 3))

# ╔═╡ 65028960-b00a-4216-a7ad-80d84f5b0070
md"""
Note that abstract types have no instances. The only "information"
in an abstract type is what its supertype and subtypes
are. Collectively, abstract types and concrete types constitute a
tree structure, with the concrete types as leaves. This structure
exists to *organize* the concrete types in a way that facilitates
extension of functionality. This tree is not static, but can be
extended by the programmer.
"""

# ╔═╡ 135dac9b-0bd9-4e1d-8378-5aa686f0b407
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─f6b2d3ed-0205-44aa-9bca-7c69b794f8ce
# ╟─eb23f2c6-61f4-4a82-b795-033f6f2a0674
# ╟─2d95e9db-a2b9-48b6-935f-ddf6a6bfbbdd
# ╟─9d38b890-85c6-4768-af2a-25235e544a31
# ╟─d24d673c-e037-49a8-8af5-148d95ea2900
# ╠═e415e89d-f149-45c6-a6bf-47194d7e8e12
# ╟─b479e9f2-7327-4fac-828a-4cc485149963
# ╟─f5dc834c-8820-465e-9e54-3f7b3ca87ecb
# ╠═848bb6b9-4d18-4cb6-ba1f-6363f43ec697
# ╟─ec385e2c-f9e4-4990-95ea-2955abd45275
# ╠═ea340fab-cb94-4396-b1b3-dd47e367ba54
# ╟─7d473844-ea0a-4586-8d7e-8e449afd1c48
# ╟─cfc68404-2fcf-4e95-a949-7f3bd292fe31
# ╠═8f285628-3b0a-4ed6-8514-99938a2932db
# ╟─90354dfd-148c-4590-a0de-1721c1bc2df2
# ╠═bfc1b998-468b-45e6-bca8-7eec7950fd82
# ╟─3b854215-32d8-4762-9873-1b1430e635cc
# ╟─443d2ffa-0827-4af1-b43e-d0ebe87da176
# ╠═6e54ee9b-7520-4b2e-9009-4cfb2012998f
# ╠═c6da4b34-81e0-43de-abd3-cb77d7a79683
# ╟─3d947de5-b6a3-4f8f-879e-dc128f3db7b3
# ╠═3d815cad-be9a-40eb-a367-9aa3c6cf34d0
# ╟─97317766-2964-4bda-bf32-94657e65284e
# ╟─6be383da-149a-46ee-9afd-65a5b5facac9
# ╟─b502f6a1-bc47-4a24-b6c8-54f5ed90a964
# ╠═d4ba5f00-1e8c-4233-9292-fe822525fc77
# ╠═3661cc0f-c5bc-45b6-ae5e-4b83dcbc9675
# ╟─ed7d0eab-0577-40de-8a29-32f11452654a
# ╠═1de1a136-ad29-4178-a5f1-151fcbe229a2
# ╟─9e999f31-7659-4d0d-81bc-2d5603785a09
# ╠═bdf46021-f4d3-45c6-9d87-1d1fbb0e3997
# ╟─8a59bfae-158d-4632-b950-fddef2a1fb10
# ╠═da4868c0-2d93-4dd9-951b-64cb2a36c8e3
# ╟─0fcf0345-8ccd-4ae8-b0e6-441461cc8770
# ╟─1fb4c0ce-f140-408a-8cb0-de601961bc02
# ╟─fee6b15a-0c87-497b-a87d-950c50fb2955
# ╠═4a0d9a26-63d1-4e9c-8448-4bcb089096cd
# ╟─ab84efb1-244a-4545-a012-a84240254fb6
# ╟─87323275-2318-4587-bbdd-9799f7bb2e60
# ╠═9b41264c-c8d2-4872-97a7-88e3af4f10ee
# ╟─61e9eb8d-7c51-46cc-b372-8c9866e51852
# ╟─3645fdc2-5739-4cb0-8f3d-b82f1e7b6f7a
# ╟─0553da4d-58d7-4d4c-ab04-579e5608ae53
# ╟─87fecfb3-8c1e-4d22-86cf-35420d9e6995
# ╠═58047fc3-2773-4979-a29a-8d0445351914
# ╠═e38e2f65-cc4e-49b8-be65-28d0fcca50a8
# ╟─6674ce39-d112-4307-9a2e-c468345d87d1
# ╠═1cf1fc9e-208e-4689-b5fa-cb79ebf595ef
# ╠═37b26b0a-ece2-45f3-91c5-524da38aa391
# ╠═f602d1f0-c159-42c3-ad90-b4405b216771
# ╟─d550f1fc-fd5d-48ec-895b-997a92b731e0
# ╠═22deab2f-1ec6-451e-a525-e9b04a4bd246
# ╠═18f26303-e83f-45c3-80f0-ba7781e173cf
# ╠═0be288d9-2ae2-49db-9cbc-9a2c39793333
# ╠═26b59f93-6cf1-4e7c-b887-2b16710e5502
# ╟─2ff4abaa-f1fb-4981-9452-5298a8a4a401
# ╠═43f8f733-eb9b-412d-b017-96f1602f2cad
# ╠═b6b617cc-bbb7-4235-8be2-2a4017c45345
# ╟─65028960-b00a-4216-a7ad-80d84f5b0070
# ╟─135dac9b-0bd9-4e1d-8378-5aa686f0b407
