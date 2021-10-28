### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ 8d80d616-4958-495e-9bca-7c69b794f8ce
md"# Test"

# ╔═╡ 4e377673-b50a-44ae-b795-033f6f2a0674
md"Dummy tutorial to test notebook generation for this repository"

# ╔═╡ bc689638-fd19-4c9f-935f-ddf6a6bfbbdd
md"### Set-up"

# ╔═╡ 197fd00e-9068-46ea-af2a-25235e544a31
md"Inspect Julia version:"

# ╔═╡ f6d4f8c4-e441-45c4-8af5-148d95ea2900
VERSION

# ╔═╡ 45740c4d-b789-45dc-a6bf-47194d7e8e12
md"The following instantiates a package environment."

# ╔═╡ 42b0f1e1-16c9-4238-828a-4cc485149963
md"""
The package environment has been created using **Julia 1.6** and may not
instantiate properly for other Julia versions.
"""

# ╔═╡ d09256dd-6c0d-4e28-9e54-3f7b3ca87ecb
begin
  using Pkg
  Pkg.activate("env")
  Pkg.instantiate()
end

# ╔═╡ dde14c8c-1423-4782-ba1f-6363f43ec697
begin
  using Plots
  x = 0:0.1:2pi
  y = sin.(x)
  plt = plot(x, y)
  savefig("my_plot.png")
  plt
end

# ╔═╡ 135dac9b-0bd9-4e1d-95ea-2955abd45275
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─8d80d616-4958-495e-9bca-7c69b794f8ce
# ╟─4e377673-b50a-44ae-b795-033f6f2a0674
# ╟─bc689638-fd19-4c9f-935f-ddf6a6bfbbdd
# ╟─197fd00e-9068-46ea-af2a-25235e544a31
# ╠═f6d4f8c4-e441-45c4-8af5-148d95ea2900
# ╟─45740c4d-b789-45dc-a6bf-47194d7e8e12
# ╟─42b0f1e1-16c9-4238-828a-4cc485149963
# ╠═d09256dd-6c0d-4e28-9e54-3f7b3ca87ecb
# ╠═dde14c8c-1423-4782-ba1f-6363f43ec697
# ╟─135dac9b-0bd9-4e1d-95ea-2955abd45275
