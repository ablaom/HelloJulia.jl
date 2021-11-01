### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ 4dbb0300-d546-48dd-9bca-7c69b794f8ce
md"# Basic demonstration of Julia package composability"

# ╔═╡ ec6ad8e5-c854-41db-b795-033f6f2a0674
md"Instantiate package environment:"

# ╔═╡ d09256dd-6c0d-4e28-935f-ddf6a6bfbbdd
begin
  using Pkg
  Pkg.activate("env")
  Pkg.instantiate()
end

# ╔═╡ b35b6a58-0335-4dab-af2a-25235e544a31
md"The Unitiful package allows you to **bind physical units** to numerical data:"

# ╔═╡ 0256dc40-e8b0-40a8-8af5-148d95ea2900
using Unitful

# ╔═╡ a2808946-3e6a-4c31-a6bf-47194d7e8e12
a = 5.0u"m^2/s^2"

# ╔═╡ 92fe3d8a-f4c0-4de4-828a-4cc485149963
md"""
The using Measurements package allows you to **propogate uncertainties**
in numerical computations:
"""

# ╔═╡ 0f76a79f-8675-4ec1-9e54-3f7b3ca87ecb
using Measurements

# ╔═╡ bf15f7d4-5ef4-4184-ba1f-6363f43ec697
b = 5.0 ± 1.2 # or measurement(5.0, 1.2)

# ╔═╡ 4c307469-e7bd-4041-95ea-2955abd45275
sqrt(b)

# ╔═╡ 9e262366-a19c-4d4c-b1b3-dd47e367ba54
md"""
The Unitful and Measurements packages are blissfully ignorant of one
another. That, is neither package is a dependency of the other. And yet the
following "just works", as if by magic:
"""

# ╔═╡ 3b5b37ed-8098-4ede-8d7e-8e449afd1c48
sqrt(5.0u"m^2/s^2" ± 0.1u"m^2/s^2")

# ╔═╡ 135dac9b-0bd9-4e1d-a949-7f3bd292fe31
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─4dbb0300-d546-48dd-9bca-7c69b794f8ce
# ╟─ec6ad8e5-c854-41db-b795-033f6f2a0674
# ╠═d09256dd-6c0d-4e28-935f-ddf6a6bfbbdd
# ╟─b35b6a58-0335-4dab-af2a-25235e544a31
# ╠═0256dc40-e8b0-40a8-8af5-148d95ea2900
# ╠═a2808946-3e6a-4c31-a6bf-47194d7e8e12
# ╟─92fe3d8a-f4c0-4de4-828a-4cc485149963
# ╠═0f76a79f-8675-4ec1-9e54-3f7b3ca87ecb
# ╠═bf15f7d4-5ef4-4184-ba1f-6363f43ec697
# ╠═4c307469-e7bd-4041-95ea-2955abd45275
# ╟─9e262366-a19c-4d4c-b1b3-dd47e367ba54
# ╠═3b5b37ed-8098-4ede-8d7e-8e449afd1c48
# ╟─135dac9b-0bd9-4e1d-a949-7f3bd292fe31
