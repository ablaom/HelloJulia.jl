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

# ╔═╡ ff5b5d9f-f008-43de-a6bf-47194d7e8e12
# Just-in-time compilation

# ╔═╡ 6ab83b44-e91b-4c3d-828a-4cc485149963
md"""
**Note.** Because of some more recent fancy optimizations, this demo only
works on Julia versions 1.3 and older.
"""

# ╔═╡ f9ef73f1-8630-49a5-9e54-3f7b3ca87ecb
2 + 2

# ╔═╡ 043c3d71-4f68-4b1c-ba1f-6363f43ec697
typeof(42.0)

# ╔═╡ b479e9f2-7327-4fac-95ea-2955abd45275
md"## Just-in-time compilation"

# ╔═╡ e282bf4d-a37b-446c-b1b3-dd47e367ba54
begin
  add(x, y) = x + y
  
  @elapsed add(3, 5)
end

# ╔═╡ efd473a7-9c0a-4ac0-8d7e-8e449afd1c48
@elapsed add(2, 4)

# ╔═╡ 09536b7d-a1e0-4370-a949-7f3bd292fe31
@elapsed add(1 + 2im, 4 + 3im)

# ╔═╡ 2677e63c-d4f1-457b-8514-99938a2932db
@elapsed add(3 + 6im, 7 - 5im)

# ╔═╡ b502f6a1-bc47-4a24-a0de-1721c1bc2df2
md"## Multiple dispatch"

# ╔═╡ ea1447f8-65ba-426f-bca8-7eec7950fd82
md"Objects don't own methods, functions do:"

# ╔═╡ b6dd9999-eba6-4c36-9873-1b1430e635cc
y = [1 2; 3 4]

# ╔═╡ 81d7898d-7e0d-4558-b43e-d0ebe87da176
typeof(y)

# ╔═╡ 2f69ea56-7e61-4b81-9009-4cfb2012998f
md"Uncomment to see error thrown:"

# ╔═╡ 47a7a91c-1e3d-46d8-abd3-cb77d7a79683
md"add(4, y)"

# ╔═╡ 658f9270-5eca-415b-879e-dc128f3db7b3
add(x::Int, y::Array{Int,2}) = x .+ y

# ╔═╡ 0b64f309-47bf-4a30-a367-9aa3c6cf34d0
add(4, y)

# ╔═╡ 4a0d9a26-63d1-4e9c-bf32-94657e65284e
methods(add)

# ╔═╡ 2f69ea56-7e61-4b81-9afd-65a5b5facac9
md"Uncomment to see error thrown:"

# ╔═╡ bc6b5324-3067-4e08-b6c8-54f5ed90a964
md"add(4.0, y)"

# ╔═╡ 0553da4d-58d7-4d4c-9292-fe822525fc77
md"## Abstract types"

# ╔═╡ f00a74c6-f29b-4fd5-ae5e-4b83dcbc9675
supertype(Int)

# ╔═╡ 37b26b0a-ece2-45f3-8a29-32f11452654a
supertype(Signed)

# ╔═╡ f602d1f0-c159-42c3-a5f1-151fcbe229a2
supertype(Integer)

# ╔═╡ 22deab2f-1ec6-451e-81bc-2d5603785a09
subtypes(Real)

# ╔═╡ 18f26303-e83f-45c3-9d87-1d1fbb0e3997
4 isa Real

# ╔═╡ 0be288d9-2ae2-49db-b950-fddef2a1fb10
Bool <: Integer

# ╔═╡ 26b59f93-6cf1-4e7c-951b-64cb2a36c8e3
String <: Integer

# ╔═╡ 43f8f733-eb9b-412d-b0e6-441461cc8770
add(x::Real, y::Matrix) = x .+ y

# ╔═╡ b6b617cc-bbb7-4235-8cb0-de601961bc02
add(4.0, rand(Bool, 2, 3))

# ╔═╡ 135dac9b-0bd9-4e1d-a87d-950c50fb2955
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
# ╠═ff5b5d9f-f008-43de-a6bf-47194d7e8e12
# ╟─6ab83b44-e91b-4c3d-828a-4cc485149963
# ╠═f9ef73f1-8630-49a5-9e54-3f7b3ca87ecb
# ╠═043c3d71-4f68-4b1c-ba1f-6363f43ec697
# ╟─b479e9f2-7327-4fac-95ea-2955abd45275
# ╠═e282bf4d-a37b-446c-b1b3-dd47e367ba54
# ╠═efd473a7-9c0a-4ac0-8d7e-8e449afd1c48
# ╠═09536b7d-a1e0-4370-a949-7f3bd292fe31
# ╠═2677e63c-d4f1-457b-8514-99938a2932db
# ╟─b502f6a1-bc47-4a24-a0de-1721c1bc2df2
# ╟─ea1447f8-65ba-426f-bca8-7eec7950fd82
# ╠═b6dd9999-eba6-4c36-9873-1b1430e635cc
# ╠═81d7898d-7e0d-4558-b43e-d0ebe87da176
# ╟─2f69ea56-7e61-4b81-9009-4cfb2012998f
# ╟─47a7a91c-1e3d-46d8-abd3-cb77d7a79683
# ╠═658f9270-5eca-415b-879e-dc128f3db7b3
# ╠═0b64f309-47bf-4a30-a367-9aa3c6cf34d0
# ╠═4a0d9a26-63d1-4e9c-bf32-94657e65284e
# ╟─2f69ea56-7e61-4b81-9afd-65a5b5facac9
# ╟─bc6b5324-3067-4e08-b6c8-54f5ed90a964
# ╟─0553da4d-58d7-4d4c-9292-fe822525fc77
# ╠═f00a74c6-f29b-4fd5-ae5e-4b83dcbc9675
# ╠═37b26b0a-ece2-45f3-8a29-32f11452654a
# ╠═f602d1f0-c159-42c3-a5f1-151fcbe229a2
# ╠═22deab2f-1ec6-451e-81bc-2d5603785a09
# ╠═18f26303-e83f-45c3-9d87-1d1fbb0e3997
# ╠═0be288d9-2ae2-49db-b950-fddef2a1fb10
# ╠═26b59f93-6cf1-4e7c-951b-64cb2a36c8e3
# ╠═43f8f733-eb9b-412d-b0e6-441461cc8770
# ╠═b6b617cc-bbb7-4235-8cb0-de601961bc02
# ╟─135dac9b-0bd9-4e1d-a87d-950c50fb2955
