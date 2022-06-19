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

# ╔═╡ 2da628f3-c301-4e4d-8514-99938a2932db
begin
  using Distributions, Statistics
  
  samples1 = randn(1000); # or rand(Normal(), 1000)
  samples2 = randn(1000);
  
  samples = samples1 .+ samples2;
  
  mu = mean(samples)
  var = std(samples)^2
  
  @show mu var
end

# ╔═╡ f5122507-66bb-49ea-a0de-1721c1bc2df2
begin
  d = Normal(0, sqrt(2))
  f(x) = pdf(d, x)
  
  xs = -5:(0.1):5
  ys = f.(xs);
  
  using CairoMakie
  CairoMakie.activate!(type = "svg")
  
  fig = hist(samples, normalization=:pdf)
  lines!(xs, ys)
  current_figure()
end

# ╔═╡ a2a09c0b-d3ec-4b46-9bca-7c69b794f8ce
md"# Solutions to exercises"

# ╔═╡ 40956165-26d0-4d61-b795-033f6f2a0674
md"## Setup"

# ╔═╡ 45740c4d-b789-45dc-935f-ddf6a6bfbbdd
md"The following instantiates a package environment."

# ╔═╡ 19dae74b-24bd-428f-8af5-148d95ea2900
md"## Exercise 1"

# ╔═╡ 3af8467f-4988-44dc-a6bf-47194d7e8e12
md"Write a function named `total` that adds the elements of its vector input."

# ╔═╡ cd6e9fce-e54a-48c3-828a-4cc485149963
md"### Solution"

# ╔═╡ 992f71c3-12d6-4ab6-9e54-3f7b3ca87ecb
function total(v)
    sum = 0.0 # better is zero(v)
    for i in 1:length(v)
        sum = sum + v[i]
    end
    return sum
end

# ╔═╡ 61304232-d701-4218-ba1f-6363f43ec697
total(1:10)

# ╔═╡ 18960c40-199a-48fa-95ea-2955abd45275
md"The built-in function is called `sum`."

# ╔═╡ b04e2fdc-8f1a-4964-b1b3-dd47e367ba54
md"## Exercise 2"

# ╔═╡ 860bb453-c2f1-446d-8d7e-8e449afd1c48
md"""
Generate a 1000 random samples from the standard normal
distribution. Create a second such sample, and add the two samples
point-wise.  Compute the (sample) mean and variance of the combined
samples. In the same plot, show a frequency-normalized histogram of
the combined samples and a plot of the pdf for normal distribution
with zero mean and variance `2`.
"""

# ╔═╡ cd6e9fce-e54a-48c3-a949-7f3bd292fe31
md"### Solution"

# ╔═╡ 4f939d4a-e802-4b7d-bca8-7eec7950fd82
md"## Exercise 3"

# ╔═╡ 63f410ea-c37a-4761-9873-1b1430e635cc
md"The following shows that named tuples share some behaviour with dictionaries:"

# ╔═╡ cb2c42bf-21b5-4e04-b43e-d0ebe87da176
begin
  t = (x = 1, y = "cat", z = 4.5)
  keys(t)
end

# ╔═╡ b8996fa3-c046-4fb1-9009-4cfb2012998f
t[:y]

# ╔═╡ 6584c100-ffd6-4fa1-abd3-cb77d7a79683
md"""
Write a function called `dict` that converts a named tuple to an
actual dictionary. You can create an empty dictionary using `Dict()`.
"""

# ╔═╡ cd6e9fce-e54a-48c3-879e-dc128f3db7b3
md"### Solution"

# ╔═╡ 834576cc-c6dc-4d3e-a367-9aa3c6cf34d0
function dict(t)
    d = Dict()
    for k in keys(t)
        d[k] = t[k]
    end
    return d
end

# ╔═╡ dfdc3d18-4274-491d-bf32-94657e65284e
dict(t)

# ╔═╡ e985417e-6d29-4efe-9afd-65a5b5facac9
md"A slicker way to do the same thing is:"

# ╔═╡ 98886fd7-5cda-40e1-b6c8-54f5ed90a964
dict2(t) = Dict(k => t[k] for k in keys(t))

# ╔═╡ 135dac9b-0bd9-4e1d-9292-fe822525fc77
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─a2a09c0b-d3ec-4b46-9bca-7c69b794f8ce
# ╟─40956165-26d0-4d61-b795-033f6f2a0674
# ╟─45740c4d-b789-45dc-935f-ddf6a6bfbbdd
# ╠═4474fd86-9496-44c7-af2a-25235e544a31
# ╟─19dae74b-24bd-428f-8af5-148d95ea2900
# ╟─3af8467f-4988-44dc-a6bf-47194d7e8e12
# ╟─cd6e9fce-e54a-48c3-828a-4cc485149963
# ╠═992f71c3-12d6-4ab6-9e54-3f7b3ca87ecb
# ╠═61304232-d701-4218-ba1f-6363f43ec697
# ╟─18960c40-199a-48fa-95ea-2955abd45275
# ╟─b04e2fdc-8f1a-4964-b1b3-dd47e367ba54
# ╟─860bb453-c2f1-446d-8d7e-8e449afd1c48
# ╟─cd6e9fce-e54a-48c3-a949-7f3bd292fe31
# ╠═2da628f3-c301-4e4d-8514-99938a2932db
# ╠═f5122507-66bb-49ea-a0de-1721c1bc2df2
# ╟─4f939d4a-e802-4b7d-bca8-7eec7950fd82
# ╟─63f410ea-c37a-4761-9873-1b1430e635cc
# ╠═cb2c42bf-21b5-4e04-b43e-d0ebe87da176
# ╠═b8996fa3-c046-4fb1-9009-4cfb2012998f
# ╟─6584c100-ffd6-4fa1-abd3-cb77d7a79683
# ╟─cd6e9fce-e54a-48c3-879e-dc128f3db7b3
# ╠═834576cc-c6dc-4d3e-a367-9aa3c6cf34d0
# ╠═dfdc3d18-4274-491d-bf32-94657e65284e
# ╟─e985417e-6d29-4efe-9afd-65a5b5facac9
# ╠═98886fd7-5cda-40e1-b6c8-54f5ed90a964
# ╟─135dac9b-0bd9-4e1d-9292-fe822525fc77
