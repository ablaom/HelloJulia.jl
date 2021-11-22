### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ a2a09c0b-d3ec-4b46-9bca-7c69b794f8ce
md"# Solutions to exercises"

# ╔═╡ 19dae74b-24bd-428f-b795-033f6f2a0674
md"## Exercise 1"

# ╔═╡ 3af8467f-4988-44dc-935f-ddf6a6bfbbdd
md"Write a function named `total` that adds the elements of its vector input."

# ╔═╡ cd6e9fce-e54a-48c3-af2a-25235e544a31
md"### Solution"

# ╔═╡ 992f71c3-12d6-4ab6-8af5-148d95ea2900
function total(v)
    sum = 0.0 # better is zero(v)
    for i in 1:length(v)
        sum = sum + v[i]
    end
    return sum
end

# ╔═╡ 61304232-d701-4218-a6bf-47194d7e8e12
total(1:10)

# ╔═╡ 18960c40-199a-48fa-828a-4cc485149963
md"The built-in function is called `sum`."

# ╔═╡ b04e2fdc-8f1a-4964-9e54-3f7b3ca87ecb
md"## Exercise 2"

# ╔═╡ 860bb453-c2f1-446d-ba1f-6363f43ec697
md"""
Generate a 1000 random samples from the standard normal
distribution. Create a second such sample, and add the two samples
point-wise.  Compute the (sample) mean and variance of the combined
samples. In the same plot, show a frequency-normalized histogram of
the combined samples and a plot of the pdf for normal distribution
with zero mean and variance `2`.
"""

# ╔═╡ 4f939d4a-e802-4b7d-95ea-2955abd45275
md"## Exercise 3"

# ╔═╡ 63f410ea-c37a-4761-b1b3-dd47e367ba54
md"The following shows that named tuples share some behaviour with dictionaries:"

# ╔═╡ cb2c42bf-21b5-4e04-8d7e-8e449afd1c48
begin
  t = (x = 1, y = "cat", z = 4.5)
  keys(t)
end

# ╔═╡ b8996fa3-c046-4fb1-a949-7f3bd292fe31
t[:y]

# ╔═╡ 6584c100-ffd6-4fa1-8514-99938a2932db
md"""
Write a function called `dict` that converts a named tuple to an
actual dictionary. You can create an empty dictionary using `Dict()`.
"""

# ╔═╡ cd6e9fce-e54a-48c3-a0de-1721c1bc2df2
md"### Solution"

# ╔═╡ 834576cc-c6dc-4d3e-bca8-7eec7950fd82
function dict(t)
    d = Dict()
    for k in keys(t)
        d[k] = t[k]
    end
    return d
end

# ╔═╡ dfdc3d18-4274-491d-9873-1b1430e635cc
dict(t)

# ╔═╡ a8888dc5-ef44-4ee7-b43e-d0ebe87da176
md"Or alternatively:"

# ╔═╡ 5b64ff6d-923b-4eab-9009-4cfb2012998f
dict(t) = Dict(k => t[k] for k in keys(t))

# ╔═╡ 135dac9b-0bd9-4e1d-abd3-cb77d7a79683
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─a2a09c0b-d3ec-4b46-9bca-7c69b794f8ce
# ╟─19dae74b-24bd-428f-b795-033f6f2a0674
# ╟─3af8467f-4988-44dc-935f-ddf6a6bfbbdd
# ╟─cd6e9fce-e54a-48c3-af2a-25235e544a31
# ╠═992f71c3-12d6-4ab6-8af5-148d95ea2900
# ╠═61304232-d701-4218-a6bf-47194d7e8e12
# ╟─18960c40-199a-48fa-828a-4cc485149963
# ╟─b04e2fdc-8f1a-4964-9e54-3f7b3ca87ecb
# ╟─860bb453-c2f1-446d-ba1f-6363f43ec697
# ╟─4f939d4a-e802-4b7d-95ea-2955abd45275
# ╟─63f410ea-c37a-4761-b1b3-dd47e367ba54
# ╠═cb2c42bf-21b5-4e04-8d7e-8e449afd1c48
# ╠═b8996fa3-c046-4fb1-a949-7f3bd292fe31
# ╟─6584c100-ffd6-4fa1-8514-99938a2932db
# ╟─cd6e9fce-e54a-48c3-a0de-1721c1bc2df2
# ╠═834576cc-c6dc-4d3e-bca8-7eec7950fd82
# ╠═dfdc3d18-4274-491d-9873-1b1430e635cc
# ╟─a8888dc5-ef44-4ee7-b43e-d0ebe87da176
# ╠═5b64ff6d-923b-4eab-9009-4cfb2012998f
# ╟─135dac9b-0bd9-4e1d-abd3-cb77d7a79683
