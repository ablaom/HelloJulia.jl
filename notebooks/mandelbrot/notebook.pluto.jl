### A Pluto.jl notebook ###
# v0.19.8

using Markdown
using InteractiveUtils

# ╔═╡ 4474fd86-9496-44c7-af2a-25235e544a31
begin
  using Pkg
  Pkg.activate(joinpath(@__DIR__, "..", ".."))
  Pkg.instantiate()
end

# ╔═╡ fd21ac37-974b-452a-a6bf-47194d7e8e12
begin
  using CairoMakie
  CairoMakie.activate!(type = "svg")
end

# ╔═╡ eb79ecc5-d91f-45d2-9bca-7c69b794f8ce
md"# Fractals using Julia"

# ╔═╡ eb23f2c6-61f4-4a82-b795-033f6f2a0674
md"Notebook from [HelloJulia.jl](https://github.com/ablaom/HelloJulia.jl)"

# ╔═╡ ec6ad8e5-c854-41db-935f-ddf6a6bfbbdd
md"Instantiate package environment:"

# ╔═╡ e2dd3622-41bb-4ec7-8af5-148d95ea2900
md"Load plotting package and set in-line display type:"

# ╔═╡ 0acdb4d2-3952-40df-828a-4cc485149963
function mandelbrot(z)
    c = z     # starting value and constant shift
    max_iterations = 20
    for n = 1:max_iterations
        if abs(z) > 2
            return n-1
        end
        z = z^2 + c
    end
    return max_iterations
end

# ╔═╡ ef1f39ed-5a24-4b57-9e54-3f7b3ca87ecb
begin
  xs = -2.5:0.01:0.75
  ys = -1.5:0.01:1.5
  
  fig = heatmap(xs, ys, (x, y) -> mandelbrot(x + im*y),
          colormap = Reverse(:deep))
end

# ╔═╡ b7dc0b70-d371-4289-ba1f-6363f43ec697
save("mandelbrot.svg", fig);

# ╔═╡ d734e051-6c92-4296-95ea-2955abd45275
md"![](mandelbrot.svg)"

# ╔═╡ 135dac9b-0bd9-4e1d-b1b3-dd47e367ba54
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─eb79ecc5-d91f-45d2-9bca-7c69b794f8ce
# ╟─eb23f2c6-61f4-4a82-b795-033f6f2a0674
# ╟─ec6ad8e5-c854-41db-935f-ddf6a6bfbbdd
# ╠═4474fd86-9496-44c7-af2a-25235e544a31
# ╟─e2dd3622-41bb-4ec7-8af5-148d95ea2900
# ╠═fd21ac37-974b-452a-a6bf-47194d7e8e12
# ╠═0acdb4d2-3952-40df-828a-4cc485149963
# ╠═ef1f39ed-5a24-4b57-9e54-3f7b3ca87ecb
# ╠═b7dc0b70-d371-4289-ba1f-6363f43ec697
# ╟─d734e051-6c92-4296-95ea-2955abd45275
# ╟─135dac9b-0bd9-4e1d-b1b3-dd47e367ba54
