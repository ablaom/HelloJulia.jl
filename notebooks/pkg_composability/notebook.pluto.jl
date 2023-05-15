### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ 4474fd86-9496-44c7-af2a-25235e544a31
begin
  using Pkg
  Pkg.activate(joinpath(@__DIR__, "..", ".."))
  Pkg.instantiate()
end

# ╔═╡ 0256dc40-e8b0-40a8-a6bf-47194d7e8e12
using Unitful

# ╔═╡ 0f76a79f-8675-4ec1-95ea-2955abd45275
using Measurements

# ╔═╡ 4dbb0300-d546-48dd-9bca-7c69b794f8ce
md"# Basic demonstration of Julia package composability"

# ╔═╡ eb23f2c6-61f4-4a82-b795-033f6f2a0674
md"Notebook from [HelloJulia.jl](https://github.com/ablaom/HelloJulia.jl)"

# ╔═╡ ec6ad8e5-c854-41db-935f-ddf6a6bfbbdd
md"Instantiate package environment:"

# ╔═╡ b35b6a58-0335-4dab-8af5-148d95ea2900
md"The Unitiful package allows you to **bind physical units** to numerical data:"

# ╔═╡ 9f8b2438-cea9-4870-828a-4cc485149963
A = 5.0u"m^2/s^2"

# ╔═╡ 00cbdf0e-23f6-403f-9e54-3f7b3ca87ecb
sqrt(A)

# ╔═╡ 92fe3d8a-f4c0-4de4-ba1f-6363f43ec697
md"""
The using Measurements package allows you to **propogate uncertainties**
in numerical computations:
"""

# ╔═╡ bf15f7d4-5ef4-4184-b1b3-dd47e367ba54
b = 5.0 ± 1.2 # or measurement(5.0, 1.2)

# ╔═╡ 4c307469-e7bd-4041-8d7e-8e449afd1c48
sqrt(b)

# ╔═╡ 9e262366-a19c-4d4c-a949-7f3bd292fe31
md"""
The Unitful and Measurements packages are blissfully ignorant of one
another. That, is neither package is a dependency of the other. And yet the
following "just works", as if by magic:
"""

# ╔═╡ cddcd722-2cd4-4d95-8514-99938a2932db
c = 5.0u"m^2/s^2" ± 0.1u"m^2/s^2"

# ╔═╡ 76009ff9-a8ba-4cba-a0de-1721c1bc2df2
sqrt(c)

# ╔═╡ 135dac9b-0bd9-4e1d-bca8-7eec7950fd82
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─4dbb0300-d546-48dd-9bca-7c69b794f8ce
# ╟─eb23f2c6-61f4-4a82-b795-033f6f2a0674
# ╟─ec6ad8e5-c854-41db-935f-ddf6a6bfbbdd
# ╠═4474fd86-9496-44c7-af2a-25235e544a31
# ╟─b35b6a58-0335-4dab-8af5-148d95ea2900
# ╠═0256dc40-e8b0-40a8-a6bf-47194d7e8e12
# ╠═9f8b2438-cea9-4870-828a-4cc485149963
# ╠═00cbdf0e-23f6-403f-9e54-3f7b3ca87ecb
# ╟─92fe3d8a-f4c0-4de4-ba1f-6363f43ec697
# ╠═0f76a79f-8675-4ec1-95ea-2955abd45275
# ╠═bf15f7d4-5ef4-4184-b1b3-dd47e367ba54
# ╠═4c307469-e7bd-4041-8d7e-8e449afd1c48
# ╟─9e262366-a19c-4d4c-a949-7f3bd292fe31
# ╠═cddcd722-2cd4-4d95-8514-99938a2932db
# ╠═76009ff9-a8ba-4cba-a0de-1721c1bc2df2
# ╟─135dac9b-0bd9-4e1d-bca8-7eec7950fd82
