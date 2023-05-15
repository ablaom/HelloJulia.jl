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

# ╔═╡ 912dc07c-b98e-45fb-a6bf-47194d7e8e12
begin
  using CairoMakie
  CairoMakie.activate!(type = "png")
end

# ╔═╡ eb79ecc5-d91f-45d2-9bca-7c69b794f8ce
md"# Fractals using Julia"

# ╔═╡ eb23f2c6-61f4-4a82-b795-033f6f2a0674
md"Notebook from [HelloJulia.jl](https://github.com/ablaom/HelloJulia.jl)"

# ╔═╡ ec6ad8e5-c854-41db-935f-ddf6a6bfbbdd
md"Instantiate package environment:"

# ╔═╡ e2dd3622-41bb-4ec7-8af5-148d95ea2900
md"Load plotting package and set in-line display type:"

# ╔═╡ 442d865d-b88e-467d-828a-4cc485149963
md"""
To plot the famous Mandelbrot set, we need to apply the following function millions of
times:
"""

# ╔═╡ 0acdb4d2-3952-40df-9e54-3f7b3ca87ecb
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

# ╔═╡ f7df7e44-30cb-44c8-ba1f-6363f43ec697
md"Let's see how long it takes to apply it just once:"

# ╔═╡ bedc096f-0f59-47fe-95ea-2955abd45275
@time @eval mandelbrot(0.5)

# ╔═╡ 7d473844-ea0a-4586-b1b3-dd47e367ba54
md"""
Slow!! Why? Because Julia is a *compiled* language and does not
compile new code until it knows the type of arguments you want to
use. (The use of the macro `@eval` helps us to include this
compilation time in the total measurement, since `@time` is designed
to cleverly exclude it in recent Julia versions.)
"""

# ╔═╡ cfc68404-2fcf-4e95-8d7e-8e449afd1c48
md"Let's try again *with the same type* of argument:"

# ╔═╡ 58f2a55f-58bc-4f4e-a949-7f3bd292fe31
@time @eval mandelbrot(0.6)

# ╔═╡ 3c33d5a4-74f3-45d6-8514-99938a2932db
md"""
Fast!!! Why? Because Julia caches the compiled code and the types
are the same.
"""

# ╔═╡ 8bcc402a-4b51-48d5-a0de-1721c1bc2df2
md"""
If we call with a new argument type (complex instead of float) we'll incur a compilation
delay once more:
"""

# ╔═╡ 799cc3ca-293e-4c75-bca8-7eec7950fd82
@time @eval mandelbrot(0.6 + im*0.1)

# ╔═╡ ef1f39ed-5a24-4b57-9873-1b1430e635cc
begin
  xs = -2.5:0.01:0.75
  ys = -1.5:0.01:1.5
  
  fig = heatmap(xs, ys, (x, y) -> mandelbrot(x + im*y),
          colormap = Reverse(:deep))
end

# ╔═╡ efbca6b5-a003-4742-b43e-d0ebe87da176
save("mandelbrot.png", fig);

# ╔═╡ 07d7034c-163f-4be0-9009-4cfb2012998f
md"![](mandelbrot.png)"

# ╔═╡ 135dac9b-0bd9-4e1d-abd3-cb77d7a79683
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
# ╠═912dc07c-b98e-45fb-a6bf-47194d7e8e12
# ╟─442d865d-b88e-467d-828a-4cc485149963
# ╠═0acdb4d2-3952-40df-9e54-3f7b3ca87ecb
# ╟─f7df7e44-30cb-44c8-ba1f-6363f43ec697
# ╠═bedc096f-0f59-47fe-95ea-2955abd45275
# ╟─7d473844-ea0a-4586-b1b3-dd47e367ba54
# ╟─cfc68404-2fcf-4e95-8d7e-8e449afd1c48
# ╠═58f2a55f-58bc-4f4e-a949-7f3bd292fe31
# ╟─3c33d5a4-74f3-45d6-8514-99938a2932db
# ╟─8bcc402a-4b51-48d5-a0de-1721c1bc2df2
# ╠═799cc3ca-293e-4c75-bca8-7eec7950fd82
# ╠═ef1f39ed-5a24-4b57-9873-1b1430e635cc
# ╠═efbca6b5-a003-4742-b43e-d0ebe87da176
# ╟─07d7034c-163f-4be0-9009-4cfb2012998f
# ╟─135dac9b-0bd9-4e1d-abd3-cb77d7a79683
