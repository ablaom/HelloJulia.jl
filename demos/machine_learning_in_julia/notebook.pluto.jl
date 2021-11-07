### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ bea699ca-a1c9-431e-9bca-7c69b794f8ce
md"# Lightning tour of MLJ"

# ╔═╡ d95c06bc-40e8-47b8-b795-033f6f2a0674
md"""
*For a more elementary introduction to MLJ, see [Getting
Started](https://alan-turing-institute.github.io/MLJ.jl/dev/getting_started/).*
"""

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

# ╔═╡ 82ad2fc8-f000-464d-9e54-3f7b3ca87ecb
md"""
In MLJ a *model* is just a container for hyper-parameters, and that's
all. Here we will apply several kinds of model composition before
binding the resulting "meta-model" to data in a *machine* for
evaluation, using cross-validation.
"""

# ╔═╡ 168e45b2-b4e6-4287-ba1f-6363f43ec697
md"Loading and instantiating a gradient tree-boosting model:"

# ╔═╡ 7d82d9d3-fd5e-40bd-95ea-2955abd45275
begin
  using MLJ
  MLJ.color_off()
  
  Booster = @load EvoTreeRegressor # loads code defining a model type
  booster = Booster(max_depth=2)   # specify hyper-parameter at construction
end

# ╔═╡ 68341e05-3c39-4b18-b1b3-dd47e367ba54
begin
  booster.nrounds=50               # or mutate post facto
  booster
end

# ╔═╡ 42a4e639-9b0e-4a29-8d7e-8e449afd1c48
md"""
This model is an example of an iterative model. As is stands, the
number of iterations `nrounds` is fixed.
"""

# ╔═╡ 567f3609-8129-42fb-a949-7f3bd292fe31
md"### Composition 1: Wrapping the model to make it \"self-iterating\""

# ╔═╡ ac61a2f4-74c7-41bb-8514-99938a2932db
md"""
Let's create a new model that automatically learns the number of iterations,
using the `NumberSinceBest(3)` criterion, as applied to an
out-of-sample `l1` loss:
"""

# ╔═╡ e4924922-66aa-4524-a0de-1721c1bc2df2
begin
  using MLJIteration
  iterated_booster = IteratedModel(model=booster,
                                   resampling=Holdout(fraction_train=0.8),
                                   controls=[Step(2), NumberSinceBest(3), NumberLimit(300)],
                                   measure=l1,
                                   retrain=true)
end

# ╔═╡ 3ab29fd2-7135-45c1-bca8-7eec7950fd82
md"### Composition 2: Preprocess the input features"

# ╔═╡ 707b8bd3-22ca-431a-9873-1b1430e635cc
md"Combining the model with categorical feature encoding:"

# ╔═╡ 20536869-cd1b-4123-b43e-d0ebe87da176
pipe = @pipeline ContinuousEncoder iterated_booster

# ╔═╡ 911fa0f4-9c76-4560-9009-4cfb2012998f
md"### Composition 3: Wrapping the model to make it \"self-tuning\""

# ╔═╡ c95d5b0a-afb9-46b7-abd3-cb77d7a79683
md"""
First, we define a hyper-parameter range for optimization of a
(nested) hyper-parameter:
"""

# ╔═╡ 728bb574-9d5c-4c91-879e-dc128f3db7b3
max_depth_range = range(pipe,
                        :(deterministic_iterated_model.model.max_depth),
                        lower = 1,
                        upper = 10)

# ╔═╡ b87c1224-317f-43f0-a367-9aa3c6cf34d0
md"""
Now we can wrap the pipeline model in an optimization strategy to make
it "self-tuning":
"""

# ╔═╡ 91631447-2049-41bb-bf32-94657e65284e
self_tuning_pipe = TunedModel(model=pipe,
                              tuning=RandomSearch(),
                              ranges = max_depth_range,
                              resampling=CV(nfolds=3, rng=456),
                              measure=l1,
                              acceleration=CPUThreads(),
                              n=50)

# ╔═╡ f208b587-89d4-4d2e-9afd-65a5b5facac9
md"### Binding to data and evaluating performance"

# ╔═╡ 0a1cf6fc-b4ce-4f91-b6c8-54f5ed90a964
md"Creating some synthetic features and labels:"

# ╔═╡ 8e35399a-ac08-4833-9292-fe822525fc77
X, y = make_regression();

# ╔═╡ 4cc252e7-8d25-4531-ae5e-4b83dcbc9675
md"""
Binding the "self-tuning" pipeline model to data in a *machine* (which
will additionally store *learned* parameters):
"""

# ╔═╡ b075d51c-b0cc-4393-8a29-32f11452654a
mach = machine(self_tuning_pipe, X, y)

# ╔═╡ bfdd3890-e469-44d5-a5f1-151fcbe229a2
md"""
Evaluating the "self-tuning" pipeline model's performance using 5-fold
cross-validation (implies multiple layers of nested resampling):
"""

# ╔═╡ a3237b4f-09c2-49a3-81bc-2d5603785a09
evaluate!(mach,
          measures=[l1, l2],
          resampling=CV(nfolds=5, rng=123),
          acceleration=CPUThreads())

# ╔═╡ 135dac9b-0bd9-4e1d-9d87-1d1fbb0e3997
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─bea699ca-a1c9-431e-9bca-7c69b794f8ce
# ╟─d95c06bc-40e8-47b8-b795-033f6f2a0674
# ╟─197fd00e-9068-46ea-935f-ddf6a6bfbbdd
# ╠═f6d4f8c4-e441-45c4-af2a-25235e544a31
# ╟─45740c4d-b789-45dc-8af5-148d95ea2900
# ╟─42b0f1e1-16c9-4238-a6bf-47194d7e8e12
# ╠═d09256dd-6c0d-4e28-828a-4cc485149963
# ╟─82ad2fc8-f000-464d-9e54-3f7b3ca87ecb
# ╟─168e45b2-b4e6-4287-ba1f-6363f43ec697
# ╠═7d82d9d3-fd5e-40bd-95ea-2955abd45275
# ╠═68341e05-3c39-4b18-b1b3-dd47e367ba54
# ╟─42a4e639-9b0e-4a29-8d7e-8e449afd1c48
# ╟─567f3609-8129-42fb-a949-7f3bd292fe31
# ╟─ac61a2f4-74c7-41bb-8514-99938a2932db
# ╠═e4924922-66aa-4524-a0de-1721c1bc2df2
# ╟─3ab29fd2-7135-45c1-bca8-7eec7950fd82
# ╟─707b8bd3-22ca-431a-9873-1b1430e635cc
# ╠═20536869-cd1b-4123-b43e-d0ebe87da176
# ╟─911fa0f4-9c76-4560-9009-4cfb2012998f
# ╟─c95d5b0a-afb9-46b7-abd3-cb77d7a79683
# ╠═728bb574-9d5c-4c91-879e-dc128f3db7b3
# ╟─b87c1224-317f-43f0-a367-9aa3c6cf34d0
# ╠═91631447-2049-41bb-bf32-94657e65284e
# ╟─f208b587-89d4-4d2e-9afd-65a5b5facac9
# ╟─0a1cf6fc-b4ce-4f91-b6c8-54f5ed90a964
# ╠═8e35399a-ac08-4833-9292-fe822525fc77
# ╟─4cc252e7-8d25-4531-ae5e-4b83dcbc9675
# ╠═b075d51c-b0cc-4393-8a29-32f11452654a
# ╟─bfdd3890-e469-44d5-a5f1-151fcbe229a2
# ╠═a3237b4f-09c2-49a3-81bc-2d5603785a09
# ╟─135dac9b-0bd9-4e1d-9d87-1d1fbb0e3997
