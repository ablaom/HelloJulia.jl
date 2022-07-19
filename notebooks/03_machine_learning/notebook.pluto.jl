### A Pluto.jl notebook ###
# v0.19.8

using Markdown
using InteractiveUtils

# ╔═╡ 86f5ae82-8207-416e-9e54-3f7b3ca87ecb
begin
  using MLJ
  import DataFrames
end

# ╔═╡ 5dad6a5d-e6e9-4ea0-9bca-7c69b794f8ce
md"# Tutorial 3"

# ╔═╡ 33691746-74ed-425d-b795-033f6f2a0674
md"""
An introduction to machine learning using MLJ and the Titanic
dataset. Explains how to train a simple decision tree model and
evaluate it's performance on a holdout set.
"""

# ╔═╡ aa49e638-95dc-4249-935f-ddf6a6bfbbdd
md"""
MLJ is a *multi-paradigm* machine learning toolbox (i.e., not just
deep-learning).
"""

# ╔═╡ b04c4790-59e0-42a3-af2a-25235e544a31
md"""
For other MLJ learning resources see the [Learning
MLJ](https://alan-turing-institute.github.io/MLJ.jl/dev/learning_mlj/)
section of the
[manual](https://alan-turing-institute.github.io/MLJ.jl/dev/).
"""

# ╔═╡ 6f4d110c-7f0b-4e70-828a-4cc485149963
md"## Establishing correct data representation"

# ╔═╡ e5885e24-b17b-471b-ba1f-6363f43ec697
md"""
A ["scientific
type"](https://juliaai.github.io/ScientificTypes.jl/dev/) or
*scitype* indicates how MLJ will *interpret* data (as opposed to how
it is represented on your machine). For example, while we have
"""

# ╔═╡ d225419b-a250-425e-95ea-2955abd45275
typeof(3.14)

# ╔═╡ 606143a8-2fb6-4fb9-b1b3-dd47e367ba54
md"we have"

# ╔═╡ 61e19dbd-3513-4813-8d7e-8e449afd1c48
scitype(3.14)

# ╔═╡ 76750462-191b-43ac-a949-7f3bd292fe31
md"and also"

# ╔═╡ 5c2ec910-6444-4c53-8514-99938a2932db
scitype(3.143f0)

# ╔═╡ ddaf1934-1aba-4ede-a0de-1721c1bc2df2
md"In MLJ, model data requirements are articulated using scitypes."

# ╔═╡ ca482134-299b-459a-bca8-7eec7950fd82
md"Here are common \"scalar\" scitypes:"

# ╔═╡ c7a45cde-2f9b-47c9-9873-1b1430e635cc
html"""
<div style="text-align: left";>
	<img src="https://github.com/ablaom/MLJTutorial.jl/blob/dev/notebooks/01_data_representation/scitypes.png?raw=true">
</div>
"""

# ╔═╡ 96c58ce9-9b29-4c5e-b43e-d0ebe87da176
md"""
There are also container scitypes. For example, the scitype of any
vector is `AbstractVector{S}`, where `S` is the scitype of its
elements:
"""

# ╔═╡ 9d2f0b19-2942-47ac-9009-4cfb2012998f
scitype(["cat", "mouse", "dog"])

# ╔═╡ b90f3b7b-4de2-4a5c-abd3-cb77d7a79683
md"""
We'll be using [OpenML](https://www.openml.org/home) to grab the
Titanic dataset:
"""

# ╔═╡ 4f8ae143-4f76-4d45-879e-dc128f3db7b3
begin
  table = OpenML.load(42638)
  df0 = DataFrames.DataFrame(table)
  DataFrames.describe(df0)
end

# ╔═╡ 1d18aca8-11f4-4104-a367-9aa3c6cf34d0
md"The `schema` operator summarizes the column scitypes of a table:"

# ╔═╡ accd3a09-5371-45ab-bf32-94657e65284e
schema(df0)

# ╔═╡ 45dd887b-332e-48ff-9afd-65a5b5facac9
md"Looks like we need to fix `:sibsp`, the number of siblings/spouses:"

# ╔═╡ cc239a2b-2522-42c8-b6c8-54f5ed90a964
begin
	df1 = coerce(df0, :sibsp => Count)
	schema(df1);
end

# ╔═╡ 4b4e8f45-6206-40f0-9292-fe822525fc77
md"""
Lets take a closer look at our target column `:survived`. Here a value `0` means that the individual didn't survive while a value of `1` indicates and individual survived.
"""

# ╔═╡ f032d069-e8f3-4fdb-b3e6-6ee8d4f82594
levels(df1.survived)

# ╔═╡ 1e99474e-2fd8-4e7d-8a29-32f11452654a
md"""
The `:cabin` feature has a lot of missing values, and low frequency
for other classes:
"""

# ╔═╡ 39a7b366-0330-4abd-a5f1-151fcbe229a2
begin
  import StatsBase
  StatsBase.countmap(df1.cabin)
end

# ╔═╡ 940f1ee2-f54d-4fa1-81bc-2d5603785a09
md"""
We'll make `missing` into a bona fide class and group all the other
classes into one:
"""

# ╔═╡ 069f1237-eb21-43cb-9d87-1d1fbb0e3997
function class(c)
    if ismissing(c)
        return "without cabin"
    else
        return "has cabin"
    end
end

# ╔═╡ 1e97e00e-d895-49d3-b950-fddef2a1fb10
md"""
Shorthand syntax would be `class(c) = ismissing(c) ? "without cabin" :
"has cabin"`. Now to transform the whole column:
"""

# ╔═╡ 9e8fab47-3c20-4524-951b-64cb2a36c8e3
begin
  df2 = DataFrames.transform(df1, :cabin=>DataFrames.ByRow(class)=>:cabin) # now a `Textual` scitype
  df3 = coerce(df1, :class => Multiclass)
  schema(df3)
end

# ╔═╡ 8644107f-4b52-41ca-b0e6-441461cc8770
md"## Splitting into train and test sets"

# ╔═╡ 4de9e07c-06b8-41a4-8cb0-de601961bc02
md"""
Here we split off 30% of our observations into a
lock-and-throw-away-the-key holdout set, called `df_test`:
"""

# ╔═╡ 0dcee734-f115-41af-a87d-950c50fb2955
begin
  df, df_test = partition(df3, 0.7, rng=123)
  DataFrames.nrow(df)
end

# ╔═╡ 30eb5d8f-e6c4-4a50-8448-4bcb089096cd
DataFrames.nrow(df_test)

# ╔═╡ 937fe069-98c9-45dd-a012-a84240254fb6
md"## Cleaning the data"

# ╔═╡ fe8a8726-5047-4826-bbdd-9799f7bb2e60
md"Let's constructor an MLJ model to impute missing data using default hyper-parameters:"

# ╔═╡ f49bb16f-aeeb-4fcd-97a7-88e3af4f10ee
cleaner = FillImputer()

# ╔═╡ f94cdf23-d113-4386-b372-8c9866e51852
md"""
In MLJ a *model* is just a container for hyper-parameters associated
with some ML algorithm. It does not store learned parameters (unlike
scikit-learn "estimators").
"""

# ╔═╡ bde9148b-79c2-4033-8f3d-b82f1e7b6f7a
md"We now bind the model with training data in a *machine*:"

# ╔═╡ de5e2209-020b-4bce-ab04-579e5608ae53
machc = machine(cleaner, df)

# ╔═╡ 3ac76fef-0379-4d32-86cf-35420d9e6995
md"""
And train the machine to store learned parameters there (the column
modes and medians to be used to impute missings):
"""

# ╔═╡ e8a268a3-24f5-466d-a29a-8d0445351914
fit!(machc);

# ╔═╡ fb2540dd-9ec2-4a81-be65-28d0fcca50a8
md"We can inspect the learned parameters if we want:"

# ╔═╡ 201cbbfd-dcd2-457c-9a2e-c468345d87d1
fitted_params(machc).filler_given_feature

# ╔═╡ 5e39018e-ab09-41a2-b5fa-cb79ebf595ef
md"Next, we apply the learned transformation on our data:"

# ╔═╡ c1f700b7-6155-43db-91c5-524da38aa391
begin
  dfc     =  transform(machc, df)
  dfc_test = transform(machc, df_test)
  schema(dfc)
end

# ╔═╡ d5531602-881e-412d-ad90-b4405b216771
md"## Split the data into input features and target"

# ╔═╡ 8cdfa1e2-7881-42bf-895b-997a92b731e0
md"""
The following method puts the column with name equal to `:survived`
into the vector `y`, and everything else into a table (`DataFrame`)
called `X`.
"""

# ╔═╡ 8d7d9cdb-4dcf-407a-a525-e9b04a4bd246
begin
  y, X = unpack(dfc, ==(:survived));
  scitype(y)
end

# ╔═╡ 29bbd36f-5d25-43b6-80f0-ba7781e173cf
md"While we're here, we'll do the same for the holdout test set:"

# ╔═╡ 103d62ac-e7d0-4fd3-9cbc-9a2c39793333
y_test, X_test = unpack(dfc_test, ==(:survived));

# ╔═╡ 5fb0d820-3f4a-4974-b887-2b16710e5502
md"## Choosing an supervised model:"

# ╔═╡ 2ca455ea-0a5d-40c8-9452-5298a8a4a401
md"""
There are not many models that can directly handle a mixture of
scitypes, as we have here:
"""

# ╔═╡ db2d9ba2-1fc4-4a7f-b017-96f1602f2cad
models(matching(X, y))

# ╔═╡ 9e70bac7-6c1c-4fe4-8be2-2a4017c45345
md"""
This can be mitigated with further pre-processing (such as one-hot
encoding) but we'll settle for one the above models here:
"""

# ╔═╡ b517f63a-5d15-497c-a7ad-80d84f5b0070
doc("DecisionTreeClassifier", pkg="BetaML")

# ╔═╡ 01daecc9-68be-4f98-8378-5aa686f0b407
begin
  Tree = @load DecisionTreeClassifier pkg=BetaML  # model type
  tree = Tree()                                   # default instance
end

# ╔═╡ 187f489f-0d7e-4f8c-9f43-49763e8691a1
md"""
Notice that by calling `Tree` with no arguments we get default
values for the various hyperparameters that control how the tree is
trained. We specify keyword arguments to overide these defaults. For example:
"""

# ╔═╡ e9c248f5-559d-40d7-bb0e-3a45761c733a
small_tree = Tree(maxDepth=3)

# ╔═╡ edd14491-9fc4-4d0d-9979-7044b2f2df33
md"""
A decision tree is frequently not the best performing model, but it
is easy to interpret (and the algorithm is relatively easy to
explain). For example, here's an diagramatic representation of a
tree trained on (some part of) the Titanic data set, which suggests
how prediction works:
"""

# ╔═╡ 78c34e59-26f0-4bf8-b2a1-fbbde543f620
html"""
<div style="text-align: left";>
	<img src="https://upload.wikimedia.org/wikipedia/commons/5/58/Decision_Tree_-_survival_of_passengers_on_the_Titanic.jpg">
</div>
"""

# ╔═╡ 8674f741-da03-46f5-910b-f8a9a217eff2
md"## The fit/predict worflow"

# ╔═╡ 5879a6ad-8c92-4516-aa36-d2e8546da46a
md"""
We now the bind data to used for training and evaluation to the model
in a machine, just like we did for missing value imputation. In this
case, however, we also need to specify the training target `y`:
"""

# ╔═╡ 487955f9-4158-4f5e-88a1-a2bf91434413
macht = machine(tree, X, y)

# ╔═╡ f55550b3-b0eb-4ae7-a1cb-54e34396a855
md"To train using *all* the bound data:"

# ╔═╡ 890a342e-c900-4b6c-8037-0de5806e1a54
fit!(macht)

# ╔═╡ 44dfc2c1-45a6-4056-9961-a09632c33fb0
md"And get predictions on the holdout set:"

# ╔═╡ e056d831-fac2-4b79-b7cc-46f4ef988c68
p = predict(macht, X_test);

# ╔═╡ ddafd6fe-1c34-447d-90fb-7f2721f6fcc7
md"These are *probabilistic* predictions:"

# ╔═╡ a2741d2d-695b-457e-af65-ccd25ecb9818
p[3]

# ╔═╡ b8f0b521-794e-41ea-8890-979691212d9b
pdf(p[3], "0")

# ╔═╡ 3a3c9911-75b3-406d-a6fa-eaf14df5d44b
md"We can also get \"point\" predictions:"

# ╔═╡ fc5c195f-7ed5-4b56-8025-5084804a9f6c
yhat = mode.(p)

# ╔═╡ 6f02f83c-1aa6-4e90-9e90-09023d201062
md"We can evaluate performance using a probabilistic measure, as in"

# ╔═╡ 4fd67e05-c4d0-4858-b7bb-2f33ef765cc0
log_loss(p, y_test) |> mean

# ╔═╡ 7f127360-5da1-4bee-9625-01172c4a0081
md"Or using a deterministic measure:"

# ╔═╡ e5134375-cde5-41de-af4f-11c7de9e21dd
accuracy(yhat, y_test)

# ╔═╡ 9fbdd706-c10a-4634-8dba-241d9b744683
md"""
List all performance measures with `measures()`. Naturally, MLJ
includes functions to automate this kind of performance evaluation,
but this is beyond the scope of this tutorial. See, eg,
[here](https://alan-turing-institute.github.io/MLJ.jl/dev/getting_started/#Getting-Started).
"""

# ╔═╡ 3e2e6de9-bfd4-4629-a6e5-2f0b4dca5c59
md"## Learning more"

# ╔═╡ 72066eb3-9b46-4fa8-8550-20498aa03ed0
md"""
Some suggestions for next steps are
[here](https://alan-turing-institute.github.io/MLJ.jl/dev/getting_started/#Getting-Started).
"""

# ╔═╡ 135dac9b-0bd9-4e1d-9e7b-5b943cf6b560
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
MLJ = "add582a8-e3ab-11e8-2d5e-e98b27df1bc7"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"

[compat]
DataFrames = "~1.3.4"
MLJ = "~0.18.4"
StatsBase = "~0.33.19"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[[deps.ARFFFiles]]
deps = ["CategoricalArrays", "Dates", "Parsers", "Tables"]
git-tree-sha1 = "e8c8e0a2be6eb4f56b1672e46004463033daa409"
uuid = "da404889-ca92-49ff-9e8b-0aa6b4d38dc8"
version = "1.4.1"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "af92965fb30777147966f58acb05da51c5616b5f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.CEnum]]
git-tree-sha1 = "eb4cb44a499229b3b8426dcfb5dd85333951ff90"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.2"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.CategoricalArrays]]
deps = ["DataAPI", "Future", "Missings", "Printf", "Requires", "Statistics", "Unicode"]
git-tree-sha1 = "5f5a975d996026a8dd877c35fe26a7b8179c02ba"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.6"

[[deps.CategoricalDistributions]]
deps = ["CategoricalArrays", "Distributions", "Missings", "OrderedCollections", "Random", "ScientificTypes", "UnicodePlots"]
git-tree-sha1 = "8b35ae165075f95415b15ff6f3c31e879affe977"
uuid = "af321ab8-2d2e-40a6-b165-3d674595d28e"
version = "0.1.7"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "80ca332f6dcb2508adba68f22f551adb2d00a624"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.3"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "38f7a08f19d8810338d4f5085211c7dfa5d5bdd8"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.4"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "1fd869cc3875b57347f7027521f561cf46d1fcd8"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.19.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "d08c20eef1f2cbc6e60fd3612ac4340b89fea322"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.9"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "9be8be1d8a6f44b96482c8af52238ea7987da3e3"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.45.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.ComputationalResources]]
git-tree-sha1 = "52cb3ec90e8a8bea0e62e275ba577ad0f74821f7"
uuid = "ed09eef8-17a6-5b46-8889-db040fac31e3"
version = "0.3.2"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "59d00b3139a9de4eb961057eabb65ac6522be954"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.4.0"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "fb5f5316dd3fd4c5e7c30a24d50643b73e37cd40"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.10.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "daa21eb85147f72e41f6352a57fccea377e310a9"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.3.4"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DensityInterface]]
deps = ["InverseFunctions", "Test"]
git-tree-sha1 = "80c3e8639e3353e5d2912fb3a1916b8455e2494b"
uuid = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
version = "0.4.0"

[[deps.Distances]]
deps = ["LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "3258d0659f812acde79e8a74b11f17ac06d0ca04"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.7"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["ChainRulesCore", "DensityInterface", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "429077fd74119f5ac495857fd51f4120baf36355"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.65"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3f3a2501fa7236e9b911e0f7a588c657e822bb6d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.3+0"

[[deps.EarlyStopping]]
deps = ["Dates", "Statistics"]
git-tree-sha1 = "98fdf08b707aaf69f524a6cd0a67858cefe0cfb6"
uuid = "792122b4-ca99-40de-a6bc-6742525f08b6"
version = "0.3.0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "9267e5f50b0e12fdfd5a2455534345c4cf2c7f7a"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.14.0"

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "246621d23d1f43e3b9c368bf3b72b2331a27c286"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.2"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType]]
deps = ["CEnum", "FreeType2_jll"]
git-tree-sha1 = "cabd77ab6a6fdff49bfd24af2ebe76e6e018a2b4"
uuid = "b38be410-82b0-50bf-ab77-7b57e271db43"
version = "4.0.0"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FreeTypeAbstraction]]
deps = ["ColorVectorSpace", "Colors", "FreeType", "GeometryBasics"]
git-tree-sha1 = "38a92e40157100e796690421e34a11c107205c86"
uuid = "663a7486-cb36-511b-a19d-713bb74d65c9"
version = "0.10.0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "83ea630384a13fc4f002b77690bc0afeb4255ac9"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.2"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "OpenLibm_jll", "SpecialFunctions", "Test"]
git-tree-sha1 = "709d864e3ed6e3545230601f94e11ebc65994641"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.11"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "b3364212fb5d870f724876ffcd34dd8ec6d98918"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.7"

[[deps.InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IterationControl]]
deps = ["EarlyStopping", "InteractiveUtils"]
git-tree-sha1 = "d7df9a6fdd82a8cfdfe93a94fcce35515be634da"
uuid = "b3c1a2ee-3fec-4384-bf48-272ea71de57c"
version = "0.5.3"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.LatinHypercubeSampling]]
deps = ["Random", "StableRNGs", "StatsBase", "Test"]
git-tree-sha1 = "42938ab65e9ed3c3029a8d2c58382ca75bdab243"
uuid = "a5e1c1ea-c99a-51d3-a14d-a9a37257b02d"
version = "1.8.0"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "09e4b894ce6a976c354a69041a04748180d43637"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.15"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LossFunctions]]
deps = ["InteractiveUtils", "Markdown", "RecipesBase"]
git-tree-sha1 = "53cd63a12f06a43eef6f4aafb910ac755c122be7"
uuid = "30fc2ffe-d236-52d8-8643-a9d8f7c094a7"
version = "0.8.0"

[[deps.MLJ]]
deps = ["CategoricalArrays", "ComputationalResources", "Distributed", "Distributions", "LinearAlgebra", "MLJBase", "MLJEnsembles", "MLJIteration", "MLJModels", "MLJTuning", "OpenML", "Pkg", "ProgressMeter", "Random", "ScientificTypes", "Statistics", "StatsBase", "Tables"]
git-tree-sha1 = "4199f3ff372222dbdc8602b70f8eefcd1aa06606"
uuid = "add582a8-e3ab-11e8-2d5e-e98b27df1bc7"
version = "0.18.4"

[[deps.MLJBase]]
deps = ["CategoricalArrays", "CategoricalDistributions", "ComputationalResources", "Dates", "DelimitedFiles", "Distributed", "Distributions", "InteractiveUtils", "InvertedIndices", "LinearAlgebra", "LossFunctions", "MLJModelInterface", "Missings", "OrderedCollections", "Parameters", "PrettyTables", "ProgressMeter", "Random", "ScientificTypes", "Serialization", "StatisticalTraits", "Statistics", "StatsBase", "Tables"]
git-tree-sha1 = "a718fede54631e4afb7edcf93741e27188af74a0"
uuid = "a7f614a8-145f-11e9-1d2a-a57a1082229d"
version = "0.20.14"

[[deps.MLJEnsembles]]
deps = ["CategoricalArrays", "CategoricalDistributions", "ComputationalResources", "Distributed", "Distributions", "MLJBase", "MLJModelInterface", "ProgressMeter", "Random", "ScientificTypesBase", "StatsBase"]
git-tree-sha1 = "ed2f724be26d0023cade9d59b55da93f528c3f26"
uuid = "50ed68f4-41fd-4504-931a-ed422449fee0"
version = "0.3.1"

[[deps.MLJIteration]]
deps = ["IterationControl", "MLJBase", "Random", "Serialization"]
git-tree-sha1 = "024d0bd22bf4a5b273f626e89d742a9db95285ef"
uuid = "614be32b-d00c-4edb-bd02-1eb411ab5e55"
version = "0.5.0"

[[deps.MLJModelInterface]]
deps = ["Random", "ScientificTypesBase", "StatisticalTraits"]
git-tree-sha1 = "16fa7c2e14aa5b3854bc77ab5f1dbe2cdc488903"
uuid = "e80e1ace-859a-464e-9ed9-23947d8ae3ea"
version = "1.6.0"

[[deps.MLJModels]]
deps = ["CategoricalArrays", "CategoricalDistributions", "Dates", "Distances", "Distributions", "InteractiveUtils", "LinearAlgebra", "MLJModelInterface", "Markdown", "OrderedCollections", "Parameters", "Pkg", "PrettyPrinting", "REPL", "Random", "ScientificTypes", "StatisticalTraits", "Statistics", "StatsBase", "Tables"]
git-tree-sha1 = "8291b42d6bf744dda0bfb16b6f0befbae232a1fa"
uuid = "d491faf4-2d78-11e9-2867-c94bc002c0b7"
version = "0.15.9"

[[deps.MLJTuning]]
deps = ["ComputationalResources", "Distributed", "Distributions", "LatinHypercubeSampling", "MLJBase", "ProgressMeter", "Random", "RecipesBase"]
git-tree-sha1 = "e1d0220d8bf5c17270cef41835ed57f88d63579d"
uuid = "03970b2e-30c4-11ea-3135-d1576263f10f"
version = "0.7.2"

[[deps.MarchingCubes]]
deps = ["StaticArrays"]
git-tree-sha1 = "3bf4baa9df7d1367168ebf60ed02b0379ea91099"
uuid = "299715c1-40a9-479a-aaf9-4a633d36f717"
version = "0.1.3"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "9f4f5a42de3300439cb8300236925670f844a555"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.1"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "a7c3d1da1189a1c2fe843a3bfa04d18d20eb3211"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[deps.OpenML]]
deps = ["ARFFFiles", "HTTP", "JSON", "Markdown", "Pkg"]
git-tree-sha1 = "06080992e86a93957bfe2e12d3181443cedf2400"
uuid = "8b6db2d4-7670-4922-a472-f9537c81ab66"
version = "0.2.0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "cf494dca75a69712a72b80bc48f59dcf3dea63ec"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.16"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "0044b23da09b5608b4ecacb4e5e6c6332f833a7e"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.3.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "a6062fe4063cdafe78f4a0a81cfffb89721b30e7"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.2"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.PrettyPrinting]]
git-tree-sha1 = "4be53d093e9e37772cc89e1009e8f6ad10c4681b"
uuid = "54e16d92-306c-5ea0-a30b-337be88ac337"
version = "0.4.0"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "dfb54c4e414caa595a1f2ed759b160f5a3ddcba5"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.3.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "d7a7aef8f8f2d537104f170139553b14dfe39fe9"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.7.2"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "78aadffb3efd2155af139781b8a8df1ef279ea39"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.4.2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
git-tree-sha1 = "6bf3f380ff52ce0832ddd3a2a7b9538ed1bcca7d"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.2.1"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "bf3188feca147ce108c76ad82c2792c57abe7b1f"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "68db32dff12bb6127bac73c209881191bf0efbb7"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.3.0+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.ScientificTypes]]
deps = ["CategoricalArrays", "ColorTypes", "Dates", "Distributions", "PrettyTables", "Reexport", "ScientificTypesBase", "StatisticalTraits", "Tables"]
git-tree-sha1 = "ba70c9a6e4c81cc3634e3e80bb8163ab5ef57eb8"
uuid = "321657f4-b219-11e9-178b-2701a2544e81"
version = "3.0.0"

[[deps.ScientificTypesBase]]
git-tree-sha1 = "a8e18eb383b5ecf1b5e6fc237eb39255044fd92b"
uuid = "30f210dd-8aff-4c5f-94ba-8e64358c1161"
version = "3.0.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "d75bda01f8c31ebb72df80a46c88b25d1c79c56d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.7"

[[deps.StableRNGs]]
deps = ["Random", "Test"]
git-tree-sha1 = "3be7d49667040add7ee151fefaf1f8c04c8c8276"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.0"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "e972716025466461a3dc1588d9168334b71aafff"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.5.1"

[[deps.StaticArraysCore]]
git-tree-sha1 = "66fe9eb253f910fe8cf161953880cfdaef01cdf0"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.0.1"

[[deps.StatisticalTraits]]
deps = ["ScientificTypesBase"]
git-tree-sha1 = "30b9236691858e13f167ce829490a68e1a597782"
uuid = "64bff920-2084-43da-a3e6-9bb72801c0c9"
version = "3.2.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "2c11d7290036fe7aac9038ff312d3b3a2a5bf89e"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.4.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "472d044a1c8df2b062b23f222573ad6837a615ba"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.19"

[[deps.StatsFuns]]
deps = ["ChainRulesCore", "HypergeometricFunctions", "InverseFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "5783b877201a82fc0014cbf381e7e6eb130473a4"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.0.1"

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "ec47fb6069c57f1cee2f67541bf8f23415146de7"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.11"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "5ce79ce186cc678bbb5c5681ca3379d1ddae11a1"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.7.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.URIs]]
git-tree-sha1 = "e59ecc5a41b000fa94423a578d29290c7266fc10"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodePlots]]
deps = ["ColorSchemes", "ColorTypes", "Contour", "Crayons", "Dates", "FileIO", "FreeTypeAbstraction", "LazyModules", "LinearAlgebra", "MarchingCubes", "NaNMath", "Printf", "SparseArrays", "StaticArrays", "StatsBase", "Unitful"]
git-tree-sha1 = "a2a83d67213fceb792b5f265b939e0049a26c76d"
uuid = "b8865327-cd53-5732-bb35-84acbb429228"
version = "3.0.4"

[[deps.Unitful]]
deps = ["ConstructionBase", "Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "b649200e887a487468b71821e2644382699f1b0f"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═5dad6a5d-e6e9-4ea0-9bca-7c69b794f8ce
# ╟─33691746-74ed-425d-b795-033f6f2a0674
# ╟─aa49e638-95dc-4249-935f-ddf6a6bfbbdd
# ╟─b04c4790-59e0-42a3-af2a-25235e544a31
# ╟─6f4d110c-7f0b-4e70-828a-4cc485149963
# ╠═86f5ae82-8207-416e-9e54-3f7b3ca87ecb
# ╟─e5885e24-b17b-471b-ba1f-6363f43ec697
# ╠═d225419b-a250-425e-95ea-2955abd45275
# ╟─606143a8-2fb6-4fb9-b1b3-dd47e367ba54
# ╠═61e19dbd-3513-4813-8d7e-8e449afd1c48
# ╟─76750462-191b-43ac-a949-7f3bd292fe31
# ╠═5c2ec910-6444-4c53-8514-99938a2932db
# ╟─ddaf1934-1aba-4ede-a0de-1721c1bc2df2
# ╟─ca482134-299b-459a-bca8-7eec7950fd82
# ╟─c7a45cde-2f9b-47c9-9873-1b1430e635cc
# ╟─96c58ce9-9b29-4c5e-b43e-d0ebe87da176
# ╠═9d2f0b19-2942-47ac-9009-4cfb2012998f
# ╟─b90f3b7b-4de2-4a5c-abd3-cb77d7a79683
# ╠═4f8ae143-4f76-4d45-879e-dc128f3db7b3
# ╟─1d18aca8-11f4-4104-a367-9aa3c6cf34d0
# ╠═accd3a09-5371-45ab-bf32-94657e65284e
# ╟─45dd887b-332e-48ff-9afd-65a5b5facac9
# ╠═cc239a2b-2522-42c8-b6c8-54f5ed90a964
# ╟─4b4e8f45-6206-40f0-9292-fe822525fc77
# ╠═f032d069-e8f3-4fdb-b3e6-6ee8d4f82594
# ╟─1e99474e-2fd8-4e7d-8a29-32f11452654a
# ╠═39a7b366-0330-4abd-a5f1-151fcbe229a2
# ╟─940f1ee2-f54d-4fa1-81bc-2d5603785a09
# ╠═069f1237-eb21-43cb-9d87-1d1fbb0e3997
# ╟─1e97e00e-d895-49d3-b950-fddef2a1fb10
# ╠═9e8fab47-3c20-4524-951b-64cb2a36c8e3
# ╟─8644107f-4b52-41ca-b0e6-441461cc8770
# ╟─4de9e07c-06b8-41a4-8cb0-de601961bc02
# ╠═0dcee734-f115-41af-a87d-950c50fb2955
# ╠═30eb5d8f-e6c4-4a50-8448-4bcb089096cd
# ╟─937fe069-98c9-45dd-a012-a84240254fb6
# ╟─fe8a8726-5047-4826-bbdd-9799f7bb2e60
# ╠═f49bb16f-aeeb-4fcd-97a7-88e3af4f10ee
# ╟─f94cdf23-d113-4386-b372-8c9866e51852
# ╟─bde9148b-79c2-4033-8f3d-b82f1e7b6f7a
# ╠═de5e2209-020b-4bce-ab04-579e5608ae53
# ╟─3ac76fef-0379-4d32-86cf-35420d9e6995
# ╠═e8a268a3-24f5-466d-a29a-8d0445351914
# ╟─fb2540dd-9ec2-4a81-be65-28d0fcca50a8
# ╠═201cbbfd-dcd2-457c-9a2e-c468345d87d1
# ╟─5e39018e-ab09-41a2-b5fa-cb79ebf595ef
# ╠═c1f700b7-6155-43db-91c5-524da38aa391
# ╟─d5531602-881e-412d-ad90-b4405b216771
# ╟─8cdfa1e2-7881-42bf-895b-997a92b731e0
# ╠═8d7d9cdb-4dcf-407a-a525-e9b04a4bd246
# ╟─29bbd36f-5d25-43b6-80f0-ba7781e173cf
# ╠═103d62ac-e7d0-4fd3-9cbc-9a2c39793333
# ╟─5fb0d820-3f4a-4974-b887-2b16710e5502
# ╟─2ca455ea-0a5d-40c8-9452-5298a8a4a401
# ╠═db2d9ba2-1fc4-4a7f-b017-96f1602f2cad
# ╟─9e70bac7-6c1c-4fe4-8be2-2a4017c45345
# ╠═b517f63a-5d15-497c-a7ad-80d84f5b0070
# ╠═01daecc9-68be-4f98-8378-5aa686f0b407
# ╟─187f489f-0d7e-4f8c-9f43-49763e8691a1
# ╠═e9c248f5-559d-40d7-bb0e-3a45761c733a
# ╟─edd14491-9fc4-4d0d-9979-7044b2f2df33
# ╟─78c34e59-26f0-4bf8-b2a1-fbbde543f620
# ╟─8674f741-da03-46f5-910b-f8a9a217eff2
# ╟─5879a6ad-8c92-4516-aa36-d2e8546da46a
# ╠═487955f9-4158-4f5e-88a1-a2bf91434413
# ╟─f55550b3-b0eb-4ae7-a1cb-54e34396a855
# ╠═890a342e-c900-4b6c-8037-0de5806e1a54
# ╟─44dfc2c1-45a6-4056-9961-a09632c33fb0
# ╠═e056d831-fac2-4b79-b7cc-46f4ef988c68
# ╟─ddafd6fe-1c34-447d-90fb-7f2721f6fcc7
# ╠═a2741d2d-695b-457e-af65-ccd25ecb9818
# ╠═b8f0b521-794e-41ea-8890-979691212d9b
# ╟─3a3c9911-75b3-406d-a6fa-eaf14df5d44b
# ╠═fc5c195f-7ed5-4b56-8025-5084804a9f6c
# ╟─6f02f83c-1aa6-4e90-9e90-09023d201062
# ╠═4fd67e05-c4d0-4858-b7bb-2f33ef765cc0
# ╟─7f127360-5da1-4bee-9625-01172c4a0081
# ╠═e5134375-cde5-41de-af4f-11c7de9e21dd
# ╟─9fbdd706-c10a-4634-8dba-241d9b744683
# ╟─3e2e6de9-bfd4-4629-a6e5-2f0b4dca5c59
# ╟─72066eb3-9b46-4fa8-8550-20498aa03ed0
# ╟─135dac9b-0bd9-4e1d-9e7b-5b943cf6b560
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
