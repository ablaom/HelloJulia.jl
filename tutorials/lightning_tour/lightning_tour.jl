### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ fa76afc8-e417-405c-af2a-25235e544a31
begin
  using Pkg
  DIR = joinpath(@__DIR__, "src")
  Pkg.activate(DIR)
  include(joinpath(DIR, "instantiate.jl"))
end

# ╔═╡ 7d82d9d3-fd5e-40bd-828a-4cc485149963
begin
  using MLJ
  MLJ.color_off()
  
  Booster = @load EvoTreeRegressor # loads code defining a model type
  booster = Booster(max_depth=2)   # specify hyper-parameter at construction
end

# ╔═╡ e4924922-66aa-4524-8d7e-8e449afd1c48
begin
  using MLJIteration
  iterated_booster = IteratedModel(model=booster,
                                   resampling=Holdout(fraction_train=0.8),
                                   controls=[Step(2), NumberSinceBest(3), NumberLimit(300)],
                                   measure=l1,
                                   retrain=true)
end

# ╔═╡ bea699ca-a1c9-431e-9bca-7c69b794f8ce
md"# Lightning tour of MLJ"

# ╔═╡ d95c06bc-40e8-47b8-b795-033f6f2a0674
md"""
*For a more elementary introduction to MLJ, see [Getting
Started](https://alan-turing-institute.github.io/MLJ.jl/dev/getting_started/).*
"""

# ╔═╡ b947435a-ac53-4b66-935f-ddf6a6bfbbdd
md"""
Install required packages (beginners needn't worry about
understanding this cell):
"""

# ╔═╡ 82ad2fc8-f000-464d-8af5-148d95ea2900
md"""
In MLJ a *model* is just a container for hyper-parameters, and that's
all. Here we will apply several kinds of model composition before
binding the resulting "meta-model" to data in a *machine* for
evaluation, using cross-validation.
"""

# ╔═╡ 168e45b2-b4e6-4287-a6bf-47194d7e8e12
md"Loading and instantiating a gradient tree-boosting model:"

# ╔═╡ 68341e05-3c39-4b18-9e54-3f7b3ca87ecb
begin
  booster.nrounds=50               # or mutate post facto
  booster
end

# ╔═╡ 42a4e639-9b0e-4a29-ba1f-6363f43ec697
md"""
This model is an example of an iterative model. As is stands, the
number of iterations `nrounds` is fixed.
"""

# ╔═╡ 567f3609-8129-42fb-95ea-2955abd45275
md"### Composition 1: Wrapping the model to make it \"self-iterating\""

# ╔═╡ ac61a2f4-74c7-41bb-b1b3-dd47e367ba54
md"""
Let's create a new model that automatically learns the number of iterations,
using the `NumberSinceBest(3)` criterion, as applied to an
out-of-sample `l1` loss:
"""

# ╔═╡ 3ab29fd2-7135-45c1-a949-7f3bd292fe31
md"### Composition 2: Preprocess the input features"

# ╔═╡ 707b8bd3-22ca-431a-8514-99938a2932db
md"Combining the model with categorical feature encoding:"

# ╔═╡ 20536869-cd1b-4123-a0de-1721c1bc2df2
pipe = @pipeline ContinuousEncoder iterated_booster

# ╔═╡ 911fa0f4-9c76-4560-bca8-7eec7950fd82
md"### Composition 3: Wrapping the model to make it \"self-tuning\""

# ╔═╡ c95d5b0a-afb9-46b7-9873-1b1430e635cc
md"""
First, we define a hyper-parameter range for optimization of a
(nested) hyper-parameter:
"""

# ╔═╡ 728bb574-9d5c-4c91-b43e-d0ebe87da176
max_depth_range = range(pipe,
                        :(deterministic_iterated_model.model.max_depth),
                        lower = 1,
                        upper = 10)

# ╔═╡ b87c1224-317f-43f0-9009-4cfb2012998f
md"""
Now we can wrap the pipeline model in an optimization strategy to make
it "self-tuning":
"""

# ╔═╡ 91631447-2049-41bb-abd3-cb77d7a79683
self_tuning_pipe = TunedModel(model=pipe,
                              tuning=RandomSearch(),
                              ranges = max_depth_range,
                              resampling=CV(nfolds=3, rng=456),
                              measure=l1,
                              acceleration=CPUThreads(),
                              n=50)

# ╔═╡ f208b587-89d4-4d2e-879e-dc128f3db7b3
md"### Binding to data and evaluating performance"

# ╔═╡ 648ee96d-de93-4de5-a367-9aa3c6cf34d0
md"""
Loading a selection of features and labels from the Ames
House Price dataset:
"""

# ╔═╡ 8e35399a-ac08-4833-bf32-94657e65284e
X, y = make_regression();

# ╔═╡ 4cc252e7-8d25-4531-9afd-65a5b5facac9
md"""
Binding the "self-tuning" pipeline model to data in a *machine* (which
will additionally store *learned* parameters):
"""

# ╔═╡ b075d51c-b0cc-4393-b6c8-54f5ed90a964
mach = machine(self_tuning_pipe, X, y)

# ╔═╡ bfdd3890-e469-44d5-9292-fe822525fc77
md"""
Evaluating the "self-tuning" pipeline model's performance using 5-fold
cross-validation (implies multiple layers of nested resampling):
"""

# ╔═╡ a3237b4f-09c2-49a3-ae5e-4b83dcbc9675
evaluate!(mach,
          measures=[l1, l2],
          resampling=CV(nfolds=5, rng=123),
          acceleration=CPUThreads())

# ╔═╡ 135dac9b-0bd9-4e1d-8a29-32f11452654a
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─bea699ca-a1c9-431e-9bca-7c69b794f8ce
# ╟─d95c06bc-40e8-47b8-b795-033f6f2a0674
# ╟─b947435a-ac53-4b66-935f-ddf6a6bfbbdd
# ╠═fa76afc8-e417-405c-af2a-25235e544a31
# ╟─82ad2fc8-f000-464d-8af5-148d95ea2900
# ╟─168e45b2-b4e6-4287-a6bf-47194d7e8e12
# ╠═7d82d9d3-fd5e-40bd-828a-4cc485149963
# ╠═68341e05-3c39-4b18-9e54-3f7b3ca87ecb
# ╟─42a4e639-9b0e-4a29-ba1f-6363f43ec697
# ╟─567f3609-8129-42fb-95ea-2955abd45275
# ╟─ac61a2f4-74c7-41bb-b1b3-dd47e367ba54
# ╠═e4924922-66aa-4524-8d7e-8e449afd1c48
# ╟─3ab29fd2-7135-45c1-a949-7f3bd292fe31
# ╟─707b8bd3-22ca-431a-8514-99938a2932db
# ╠═20536869-cd1b-4123-a0de-1721c1bc2df2
# ╟─911fa0f4-9c76-4560-bca8-7eec7950fd82
# ╟─c95d5b0a-afb9-46b7-9873-1b1430e635cc
# ╠═728bb574-9d5c-4c91-b43e-d0ebe87da176
# ╟─b87c1224-317f-43f0-9009-4cfb2012998f
# ╠═91631447-2049-41bb-abd3-cb77d7a79683
# ╟─f208b587-89d4-4d2e-879e-dc128f3db7b3
# ╟─648ee96d-de93-4de5-a367-9aa3c6cf34d0
# ╠═8e35399a-ac08-4833-bf32-94657e65284e
# ╟─4cc252e7-8d25-4531-9afd-65a5b5facac9
# ╠═b075d51c-b0cc-4393-b6c8-54f5ed90a964
# ╟─bfdd3890-e469-44d5-9292-fe822525fc77
# ╠═a3237b4f-09c2-49a3-ae5e-4b83dcbc9675
# ╟─135dac9b-0bd9-4e1d-8a29-32f11452654a
