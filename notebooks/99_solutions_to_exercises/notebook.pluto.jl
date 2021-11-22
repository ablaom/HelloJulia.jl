### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ a2a09c0b-d3ec-4b46-9bca-7c69b794f8ce
md"# Solutions to exercises"

# ╔═╡ 40956165-26d0-4d61-b795-033f6f2a0674
md"## Setup"

# ╔═╡ 197fd00e-9068-46ea-935f-ddf6a6bfbbdd
md"Inspect Julia version:"

# ╔═╡ f6d4f8c4-e441-45c4-af2a-25235e544a31
VERSION

# ╔═╡ 45740c4d-b789-45dc-8af5-148d95ea2900
md"The following instantiates a package environment."

# ╔═╡ 42b0f1e1-16c9-4238-a6bf-47194d7e8e12
md"""
The package environment has been created using **Julia 1.6** and may not
instantiate properly for other Julia versions.
"""

# ╔═╡ d09256dd-6c0d-4e28-828a-4cc485149963
begin
  using Pkg
  Pkg.activate("env")
  Pkg.instantiate()
end

# ╔═╡ 19dae74b-24bd-428f-9e54-3f7b3ca87ecb
md"## Exercise 1"

# ╔═╡ 3af8467f-4988-44dc-ba1f-6363f43ec697
md"Write a function named `total` that adds the elements of its vector input."

# ╔═╡ cd6e9fce-e54a-48c3-95ea-2955abd45275
md"### Solution"

# ╔═╡ 992f71c3-12d6-4ab6-b1b3-dd47e367ba54
function total(v)
    sum = 0.0 # better is zero(v)
    for i in 1:length(v)
        sum = sum + v[i]
    end
    return sum
end

# ╔═╡ 61304232-d701-4218-8d7e-8e449afd1c48
total(1:10)

# ╔═╡ 18960c40-199a-48fa-a949-7f3bd292fe31
md"The built-in function is called `sum`."

# ╔═╡ b04e2fdc-8f1a-4964-8514-99938a2932db
md"## Exercise 2"

# ╔═╡ 860bb453-c2f1-446d-a0de-1721c1bc2df2
md"""
Generate a 1000 random samples from the standard normal
distribution. Create a second such sample, and add the two samples
point-wise.  Compute the (sample) mean and variance of the combined
samples. In the same plot, show a frequency-normalized histogram of
the combined samples and a plot of the pdf for normal distribution
with zero mean and variance `2`.
"""

# ╔═╡ cd6e9fce-e54a-48c3-bca8-7eec7950fd82
md"### Solution"

# ╔═╡ fe0bd76b-d2bb-4f68-9873-1b1430e635cc
begin
  using Distributions, Plots, Statistics
  
  samples1 = randn(1000); # or rand(Normal(), 1000)
  samples2 = randn(1000);
  
  samples = samples1 .+ samples2;
  
  mu = mean(samples)
  var = std(samples)^2
  
  @show mu var
end

# ╔═╡ 37a8bacf-d991-42ac-b43e-d0ebe87da176
begin
  d = Normal(0, sqrt(2))
  f(x) = pdf(d, x)
  
  xs = -5:(0.1):5
  ys = f.(xs);
  
  using Plots
  
  plt = histogram(samples, normalize=true)
  plot!(xs, ys)
  plt
end

# ╔═╡ 4f939d4a-e802-4b7d-9009-4cfb2012998f
md"## Exercise 3"

# ╔═╡ 63f410ea-c37a-4761-abd3-cb77d7a79683
md"The following shows that named tuples share some behaviour with dictionaries:"

# ╔═╡ cb2c42bf-21b5-4e04-879e-dc128f3db7b3
begin
  t = (x = 1, y = "cat", z = 4.5)
  keys(t)
end

# ╔═╡ b8996fa3-c046-4fb1-a367-9aa3c6cf34d0
t[:y]

# ╔═╡ 6584c100-ffd6-4fa1-bf32-94657e65284e
md"""
Write a function called `dict` that converts a named tuple to an
actual dictionary. You can create an empty dictionary using `Dict()`.
"""

# ╔═╡ cd6e9fce-e54a-48c3-9afd-65a5b5facac9
md"### Solution"

# ╔═╡ 834576cc-c6dc-4d3e-b6c8-54f5ed90a964
function dict(t)
    d = Dict()
    for k in keys(t)
        d[k] = t[k]
    end
    return d
end

# ╔═╡ dfdc3d18-4274-491d-9292-fe822525fc77
dict(t)

# ╔═╡ a8888dc5-ef44-4ee7-ae5e-4b83dcbc9675
md"Or alternatively:"

# ╔═╡ 5b64ff6d-923b-4eab-8a29-32f11452654a
dict(t) = Dict(k => t[k] for k in keys(t))

# ╔═╡ 135dac9b-0bd9-4e1d-a5f1-151fcbe229a2
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─a2a09c0b-d3ec-4b46-9bca-7c69b794f8ce
# ╟─40956165-26d0-4d61-b795-033f6f2a0674
# ╟─197fd00e-9068-46ea-935f-ddf6a6bfbbdd
# ╠═f6d4f8c4-e441-45c4-af2a-25235e544a31
# ╟─45740c4d-b789-45dc-8af5-148d95ea2900
# ╟─42b0f1e1-16c9-4238-a6bf-47194d7e8e12
# ╠═d09256dd-6c0d-4e28-828a-4cc485149963
# ╟─19dae74b-24bd-428f-9e54-3f7b3ca87ecb
# ╟─3af8467f-4988-44dc-ba1f-6363f43ec697
# ╟─cd6e9fce-e54a-48c3-95ea-2955abd45275
# ╠═992f71c3-12d6-4ab6-b1b3-dd47e367ba54
# ╠═61304232-d701-4218-8d7e-8e449afd1c48
# ╟─18960c40-199a-48fa-a949-7f3bd292fe31
# ╟─b04e2fdc-8f1a-4964-8514-99938a2932db
# ╟─860bb453-c2f1-446d-a0de-1721c1bc2df2
# ╟─cd6e9fce-e54a-48c3-bca8-7eec7950fd82
# ╠═fe0bd76b-d2bb-4f68-9873-1b1430e635cc
# ╠═37a8bacf-d991-42ac-b43e-d0ebe87da176
# ╟─4f939d4a-e802-4b7d-9009-4cfb2012998f
# ╟─63f410ea-c37a-4761-abd3-cb77d7a79683
# ╠═cb2c42bf-21b5-4e04-879e-dc128f3db7b3
# ╠═b8996fa3-c046-4fb1-a367-9aa3c6cf34d0
# ╟─6584c100-ffd6-4fa1-bf32-94657e65284e
# ╟─cd6e9fce-e54a-48c3-9afd-65a5b5facac9
# ╠═834576cc-c6dc-4d3e-b6c8-54f5ed90a964
# ╠═dfdc3d18-4274-491d-9292-fe822525fc77
# ╟─a8888dc5-ef44-4ee7-ae5e-4b83dcbc9675
# ╠═5b64ff6d-923b-4eab-8a29-32f11452654a
# ╟─135dac9b-0bd9-4e1d-a5f1-151fcbe229a2
