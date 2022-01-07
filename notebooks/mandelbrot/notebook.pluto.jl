### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ e7a4bf7b-f5f5-4564-9bca-7c69b794f8ce
md"# Generate a Mandelbrot set with Julia"

# ╔═╡ eb23f2c6-61f4-4a82-b795-033f6f2a0674
md"Notebook from [HelloJulia.jl](https://github.com/ablaom/HelloJulia.jl)"

# ╔═╡ ec6ad8e5-c854-41db-935f-ddf6a6bfbbdd
md"Instantiate package environment:"

# ╔═╡ 754d60ac-4cb0-443a-af2a-25235e544a31
begin
  using Pkg
  Pkg.activate(@__DIR__)
  Pkg.instantiate()
end

# ╔═╡ 045ab7e2-eb64-4301-8af5-148d95ea2900
begin
  using Plots
  plotly() # choose plotting backend
end

# ╔═╡ e6ca23dc-5cc4-4ec0-a6bf-47194d7e8e12
function mandel(z)
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

# ╔═╡ 9c765694-8292-4f26-828a-4cc485149963
begin
  xs = -2.5:0.005:0.75
  ys = -1.5:0.005:1.5
  z = [mandel(x + im*y) for y in ys, x in xs]
  heatmap(xs, ys, z)
end

# ╔═╡ da7f8fbf-e71a-48d6-9e54-3f7b3ca87ecb
savefig("mandelbrot.html")

# ╔═╡ 135dac9b-0bd9-4e1d-ba1f-6363f43ec697
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─e7a4bf7b-f5f5-4564-9bca-7c69b794f8ce
# ╟─eb23f2c6-61f4-4a82-b795-033f6f2a0674
# ╟─ec6ad8e5-c854-41db-935f-ddf6a6bfbbdd
# ╠═754d60ac-4cb0-443a-af2a-25235e544a31
# ╠═045ab7e2-eb64-4301-8af5-148d95ea2900
# ╠═e6ca23dc-5cc4-4ec0-a6bf-47194d7e8e12
# ╠═9c765694-8292-4f26-828a-4cc485149963
# ╠═da7f8fbf-e71a-48d6-9e54-3f7b3ca87ecb
# ╟─135dac9b-0bd9-4e1d-ba1f-6363f43ec697
