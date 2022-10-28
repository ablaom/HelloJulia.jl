### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ e8d62020-dcf8-4e6f-9bca-7c69b794f8ce
md"""
The following block makes some third party packages available for loading, and ensurese
the *same* versions are loaded every time. Beginners do not need to understand it.
"""

# ╔═╡ 4474fd86-9496-44c7-b795-033f6f2a0674
begin
  using Pkg
  Pkg.activate(joinpath(@__DIR__, "..", ".."))
  Pkg.instantiate()
end

# ╔═╡ 135dac9b-0bd9-4e1d-935f-ddf6a6bfbbdd
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─e8d62020-dcf8-4e6f-9bca-7c69b794f8ce
# ╠═4474fd86-9496-44c7-b795-033f6f2a0674
# ╟─135dac9b-0bd9-4e1d-935f-ddf6a6bfbbdd
