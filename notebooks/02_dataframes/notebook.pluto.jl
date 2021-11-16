### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ 98c09ea6-65de-4f4a-9bca-7c69b794f8ce
md"Introduction to DataFrames.jl"

# ╔═╡ 0817abb0-7133-4ef0-b795-033f6f2a0674
md"""
Based on [this
tutorial](https://juliaai.github.io/DataScienceTutorials.jl/data/dataframe/)
from Data Science Tutorials.
"""

# ╔═╡ 40956165-26d0-4d61-935f-ddf6a6bfbbdd
md"## Setup"

# ╔═╡ 197fd00e-9068-46ea-af2a-25235e544a31
md"Inspect Julia version:"

# ╔═╡ f6d4f8c4-e441-45c4-8af5-148d95ea2900
VERSION

# ╔═╡ 45740c4d-b789-45dc-a6bf-47194d7e8e12
md"The following instantiates a package environment."

# ╔═╡ 42b0f1e1-16c9-4238-828a-4cc485149963
md"""
The package environment has been created using **Julia 1.6** and may not
instantiate properly for other Julia versions.
"""

# ╔═╡ d09256dd-6c0d-4e28-9e54-3f7b3ca87ecb
begin
  using Pkg
  Pkg.activate("env")
  Pkg.instantiate()
end

# ╔═╡ 6ca20872-2853-4961-ba1f-6363f43ec697
md"## Basics"

# ╔═╡ d4f2b797-dc3e-4e25-95ea-2955abd45275
md"To start with, we will use the `Boston` dataset which is very simple."

# ╔═╡ dc79c54a-bf5c-47d4-b1b3-dd47e367ba54
begin
  using RDatasets
  using DataFrames
  
  boston = dataset("MASS", "Boston");
end

# ╔═╡ eec8487f-e9d7-4e5a-8d7e-8e449afd1c48
md"The `dataset` function returns a `DataFrame` object:"

# ╔═╡ 797433f3-8199-470d-a949-7f3bd292fe31
typeof(boston)

# ╔═╡ e03f9bf8-da22-499e-8514-99938a2932db
md"""
### Accessing data

Intuitively a DataFrame is just a wrapper around a number of
columns, each of which is a `Vector` of some type with a name"
"""

# ╔═╡ baeceda6-b91e-45a5-a0de-1721c1bc2df2
names(boston)

# ╔═╡ 861e3def-66e4-4e55-bca8-7eec7950fd82
md"You can view the first few rows using `first` and specifying a number of rows:"

# ╔═╡ ff6ecb44-4f6d-4da5-9873-1b1430e635cc
first(boston, 4)

# ╔═╡ ff48666f-712d-47b1-b43e-d0ebe87da176
md"You can access one of those columns easily using `.colname`, this returns a vector that you can access like any Julia vector:"

# ╔═╡ 42eaa1c5-0462-4410-9009-4cfb2012998f
boston.Crim[1:5]

# ╔═╡ edcaab46-e01d-4cbc-abd3-cb77d7a79683
md"You can also just access the dataframe as you would a big matrix:"

# ╔═╡ 707c9a0d-3147-4da0-879e-dc128f3db7b3
boston[3, 5]

# ╔═╡ bad9a1be-5b2b-4324-a367-9aa3c6cf34d0
md"or specifying a range of rows/columns:"

# ╔═╡ 8eda1675-607d-4c98-bf32-94657e65284e
boston[1:5, [:Crim, :Zn]]

# ╔═╡ 00a08816-2793-42da-9afd-65a5b5facac9
md"or, similarly,"

# ╔═╡ 1cb38167-5ca1-406b-b6c8-54f5ed90a964
boston[1:5, 1:2]

# ╔═╡ 3f2ebbdc-e49c-416d-9292-fe822525fc77
md"The `select` function is very convenient to get sub dataframes of interest:"

# ╔═╡ 69911bf3-90a0-43da-ae5e-4b83dcbc9675
begin
  b1 = select(boston, [:Crim, :Zn, :Indus])
  first(b1, 2)
end

# ╔═╡ c2ba34fc-6c9f-4649-8a29-32f11452654a
md"The `Not` syntax is  also very  useful:"

# ╔═╡ ca5ee80b-d0ac-4642-a5f1-151fcbe229a2
begin
  b2 = select(boston, Not(:NOx))
  first(b2, 2)
end

# ╔═╡ edc071fd-ce24-450f-81bc-2d5603785a09
md"""
Finally, if you would like to drop columns, you can use `select!`
which will mutate the dataframe in place:
"""

# ╔═╡ 44ecd2ac-88b5-4034-9d87-1d1fbb0e3997
begin
  select!(b1, Not(:Crim))
  first(b1, 2)
end

# ╔═╡ ae28516b-e30c-460d-b950-fddef2a1fb10
md"### Describing the data"

# ╔═╡ d72e7c9f-40f0-4e0d-951b-64cb2a36c8e3
md"""
`StatsBase.jl` offers a convenient `describe` function which you can
use on a DataFrame to get an overview of the data:
"""

# ╔═╡ aab5f4bd-92b0-4094-b0e6-441461cc8770
begin
  using StatsBase
  describe(boston, :min, :max, :mean, :median, :std)
end

# ╔═╡ 845881bf-8ecc-4683-8cb0-de601961bc02
md"""
You can pass a number of symbols to the `describe` function to
indicate which statistics to compute for each feature:

* `mean`, `std`, `min`, `max`, `median`, `first`, `last` are all fairly self explanatory
* `q25`, `q75` are respectively for the 25th and 75th percentile,
* `eltype`, `nunique`, `nmissing` can also be used

You can also  pass your custom function with a pair `name => function` for instance:
"""

# ╔═╡ dfae3dfa-95e6-42e9-a87d-950c50fb2955
begin
  foo(x) = sum(abs.(x)) / length(x)
  d = describe(boston, :mean, :median, foo => :foo)
  first(d, 3)
end

# ╔═╡ 9bad7d8a-b3bc-4cbc-8448-4bcb089096cd
md"""
The `describe` function returns a derived object with one row per
feature and one column per required statistic.

Further to `StatsBase`, `Statistics` offers a range of useful
functions for data analysis.
"""

# ╔═╡ 3a2fb476-5685-40aa-a012-a84240254fb6
using Statistics

# ╔═╡ 31ba633c-d2fd-4fca-bbdd-9799f7bb2e60
md"""
### Converting the data

If you want to get the content of the dataframe as one big matrix,
use `convert`:
"""

# ╔═╡ 9dbbed64-fc3b-49bd-97a7-88e3af4f10ee
begin
  mat = Matrix(boston)
  mat[1:3, 1:3]
end

# ╔═╡ ece7285a-4c76-48d7-b372-8c9866e51852
md"### Adding columns"

# ╔═╡ 3c144b2c-87bf-438a-8f3d-b82f1e7b6f7a
md"Adding a column to a dataframe is very easy:"

# ╔═╡ 877785de-1480-448e-ab04-579e5608ae53
boston.Crim_x_Zn = boston.Crim .* boston.Zn;

# ╔═╡ b8a335b5-a197-45ab-86cf-35420d9e6995
md"""
that's it! Remember also that you can drop columns or make
subselections with `select` and `select!`.
"""

# ╔═╡ d398cfc9-5884-40fc-a29a-8d0445351914
md"""
### Missing values

Let's load a dataset with missing values
"""

# ╔═╡ 5ea5a387-467b-4257-be65-28d0fcca50a8
begin
  mao = dataset("gap", "mao")
  describe(mao, :nmissing)
end

# ╔═╡ bc4265a6-22fe-43fe-9a2e-c468345d87d1
md"""
Lots of missing values...  If you wanted to compute simple functions
on columns, they may just return `missing`:
"""

# ╔═╡ ec08acbb-5359-412c-b5fa-cb79ebf595ef
std(mao.Age)

# ╔═╡ f60c7c6d-b6f3-4197-91c5-524da38aa391
md"The `skipmissing` function can help counter this  easily:"

# ╔═╡ 217ea405-d6de-4749-ad90-b4405b216771
std(skipmissing(mao.Age))

# ╔═╡ 2c34e1f6-75b5-43ca-895b-997a92b731e0
md"""
## Split-Apply-Combine

This is a shorter version of the [DataFrames.jl
tutorial](http://juliadata.github.io/DataFrames.jl/latest/man/split_apply_combine/).
"""

# ╔═╡ cf100322-57f3-41b6-a525-e9b04a4bd246
begin
  iris = dataset("datasets", "iris")
  first(iris, 3)
end

# ╔═╡ c8c4d310-3a27-43c2-80f0-ba7781e173cf
md"""
### `groupby`

The `groupby` function allows to form "sub-dataframes" corresponding
to groups of rows.  This can be very convenient to run specific
analyses for specific groups without copying the data.

The basic usage is `groupby(df, cols)` where `cols` specifies one or
several columns to use for the grouping.

Consider a simple example: in `iris` there is a `Species` column
with 3 species:
"""

# ╔═╡ c768a6ec-082b-4ece-9cbc-9a2c39793333
unique(iris.Species)

# ╔═╡ cd771149-a832-42a7-b887-2b16710e5502
md"We can form views for each of these:"

# ╔═╡ fcd07644-9c52-4802-9452-5298a8a4a401
gdf = groupby(iris, :Species);

# ╔═╡ cc408f2c-3f9a-4d47-b017-96f1602f2cad
md"""
The `gdf` object now corresponds to **views** of the original
dataframe for each of the 3 species; the first species is `"setosa"`
with:
"""

# ╔═╡ fcc4c080-f321-45a5-8be2-2a4017c45345
begin
  subdf_setosa = gdf[1]
  describe(subdf_setosa, :min, :mean, :max)
end

# ╔═╡ 7d63a44b-9010-4e46-a7ad-80d84f5b0070
md"""
Note that `subdf_setosa` is a `SubDataFrame` meaning that it is just
a view of the parent dataframe `iris`; if you modify that parent
dataframe then the sub dataframe is also modified.

See `?groupby` for more information.

### `combine`

The `combine` function allows to derive a new dataframe out of
transformations of an existing one.  Here's an example taken from
the official doc (see `?combine`):
"""

# ╔═╡ 9999e33c-c16d-441d-8378-5aa686f0b407
begin
  df = DataFrame(a=1:3, b=4:6)
  combine(df, :a => sum, nrow)
end

# ╔═╡ 33ef5d5c-83b9-4638-9f43-49763e8691a1
md"""
what happened here is that the derived DataFrame has two columns
obtained respectively by (1) computing the sum of the first column
and (2) applying the `nrow` function on the `df`.

The transformation can produce one or several values, `combine` will
try to concatenate these columns as it can, for instance:
"""

# ╔═╡ 40688190-42e3-4d1e-bb0e-3a45761c733a
begin
  foo(v) = v[1:2]
  combine(df, :a => maximum, :b => foo)
end

# ╔═╡ 8889c821-7054-46eb-9979-7044b2f2df33
md"""
here the maximum value of `a` is copied twice so that the two
columns have the same number of rows.
"""

# ╔═╡ 30bb3ec6-b150-4f7c-b2a1-fbbde543f620
begin
  bar(v) = v[end-1:end]
  combine(df, :a => foo, :b => bar)
end

# ╔═╡ eecfde6b-abef-4033-910b-f8a9a217eff2
md"""
### `combine` with `groupby`

Combining `groupby` with `combine` is very useful.  For instance you
might want to compute statistics across groups for different
variables:
"""

# ╔═╡ 1b9c4e31-0501-4c7a-aa36-d2e8546da46a
combine(groupby(iris, :Species), :PetalLength => mean)

# ╔═╡ e4d1b78c-4510-4aab-88a1-a2bf91434413
md"""
let's decompose that:

1. the `groupby(iris, :Species)` creates groups using the `:Species` column (which has values `setosa`, `versicolor`, `virginica`)
2. the `combine` creates a derived dataframe by applying the `mean` function to the `:PetalLength` column
3. since there are three groups, we get one column (mean of `PetalLength`) and three rows (one per group).


You can do this for several columns/statistics at the time and give
new column names to the results:
"""

# ╔═╡ 06dcaea8-0e78-47da-a1cb-54e34396a855
begin
  gdf = groupby(iris, :Species)
  combine(gdf, :PetalLength => mean => :MPL, :PetalLength => std => :SPL)
end

# ╔═╡ 7a14a919-7da7-4b31-8037-0de5806e1a54
md"""
so here we assign the names `:MPL` and `:SPL` to the derived
columns.  If you want to apply something on all columns apart from
the grouping one, using `names` and `Not` comes in handy:
"""

# ╔═╡ 42c0b37d-7c85-48ea-9961-a09632c33fb0
combine(gdf, names(iris, Not(:Species)) .=> std)

# ╔═╡ 4e465d5d-3ae8-4ddb-b7cc-46f4ef988c68
md"where"

# ╔═╡ fed0b145-e9c1-4eb6-90fb-7f2721f6fcc7
names(iris, Not(:Species))

# ╔═╡ c2e1abd9-f664-41cd-af65-ccd25ecb9818
md"""
and note the use of `.` in `.=>` to indicate that we broadcast the
function over each column.
"""

# ╔═╡ 135dac9b-0bd9-4e1d-8890-979691212d9b
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─98c09ea6-65de-4f4a-9bca-7c69b794f8ce
# ╟─0817abb0-7133-4ef0-b795-033f6f2a0674
# ╟─40956165-26d0-4d61-935f-ddf6a6bfbbdd
# ╟─197fd00e-9068-46ea-af2a-25235e544a31
# ╠═f6d4f8c4-e441-45c4-8af5-148d95ea2900
# ╟─45740c4d-b789-45dc-a6bf-47194d7e8e12
# ╟─42b0f1e1-16c9-4238-828a-4cc485149963
# ╠═d09256dd-6c0d-4e28-9e54-3f7b3ca87ecb
# ╟─6ca20872-2853-4961-ba1f-6363f43ec697
# ╟─d4f2b797-dc3e-4e25-95ea-2955abd45275
# ╠═dc79c54a-bf5c-47d4-b1b3-dd47e367ba54
# ╟─eec8487f-e9d7-4e5a-8d7e-8e449afd1c48
# ╠═797433f3-8199-470d-a949-7f3bd292fe31
# ╟─e03f9bf8-da22-499e-8514-99938a2932db
# ╠═baeceda6-b91e-45a5-a0de-1721c1bc2df2
# ╟─861e3def-66e4-4e55-bca8-7eec7950fd82
# ╠═ff6ecb44-4f6d-4da5-9873-1b1430e635cc
# ╟─ff48666f-712d-47b1-b43e-d0ebe87da176
# ╠═42eaa1c5-0462-4410-9009-4cfb2012998f
# ╟─edcaab46-e01d-4cbc-abd3-cb77d7a79683
# ╠═707c9a0d-3147-4da0-879e-dc128f3db7b3
# ╟─bad9a1be-5b2b-4324-a367-9aa3c6cf34d0
# ╠═8eda1675-607d-4c98-bf32-94657e65284e
# ╟─00a08816-2793-42da-9afd-65a5b5facac9
# ╠═1cb38167-5ca1-406b-b6c8-54f5ed90a964
# ╟─3f2ebbdc-e49c-416d-9292-fe822525fc77
# ╠═69911bf3-90a0-43da-ae5e-4b83dcbc9675
# ╟─c2ba34fc-6c9f-4649-8a29-32f11452654a
# ╠═ca5ee80b-d0ac-4642-a5f1-151fcbe229a2
# ╟─edc071fd-ce24-450f-81bc-2d5603785a09
# ╠═44ecd2ac-88b5-4034-9d87-1d1fbb0e3997
# ╟─ae28516b-e30c-460d-b950-fddef2a1fb10
# ╟─d72e7c9f-40f0-4e0d-951b-64cb2a36c8e3
# ╠═aab5f4bd-92b0-4094-b0e6-441461cc8770
# ╟─845881bf-8ecc-4683-8cb0-de601961bc02
# ╠═dfae3dfa-95e6-42e9-a87d-950c50fb2955
# ╟─9bad7d8a-b3bc-4cbc-8448-4bcb089096cd
# ╠═3a2fb476-5685-40aa-a012-a84240254fb6
# ╟─31ba633c-d2fd-4fca-bbdd-9799f7bb2e60
# ╠═9dbbed64-fc3b-49bd-97a7-88e3af4f10ee
# ╟─ece7285a-4c76-48d7-b372-8c9866e51852
# ╟─3c144b2c-87bf-438a-8f3d-b82f1e7b6f7a
# ╠═877785de-1480-448e-ab04-579e5608ae53
# ╟─b8a335b5-a197-45ab-86cf-35420d9e6995
# ╟─d398cfc9-5884-40fc-a29a-8d0445351914
# ╠═5ea5a387-467b-4257-be65-28d0fcca50a8
# ╟─bc4265a6-22fe-43fe-9a2e-c468345d87d1
# ╠═ec08acbb-5359-412c-b5fa-cb79ebf595ef
# ╟─f60c7c6d-b6f3-4197-91c5-524da38aa391
# ╠═217ea405-d6de-4749-ad90-b4405b216771
# ╟─2c34e1f6-75b5-43ca-895b-997a92b731e0
# ╠═cf100322-57f3-41b6-a525-e9b04a4bd246
# ╟─c8c4d310-3a27-43c2-80f0-ba7781e173cf
# ╠═c768a6ec-082b-4ece-9cbc-9a2c39793333
# ╟─cd771149-a832-42a7-b887-2b16710e5502
# ╠═fcd07644-9c52-4802-9452-5298a8a4a401
# ╟─cc408f2c-3f9a-4d47-b017-96f1602f2cad
# ╠═fcc4c080-f321-45a5-8be2-2a4017c45345
# ╟─7d63a44b-9010-4e46-a7ad-80d84f5b0070
# ╠═9999e33c-c16d-441d-8378-5aa686f0b407
# ╟─33ef5d5c-83b9-4638-9f43-49763e8691a1
# ╠═40688190-42e3-4d1e-bb0e-3a45761c733a
# ╟─8889c821-7054-46eb-9979-7044b2f2df33
# ╠═30bb3ec6-b150-4f7c-b2a1-fbbde543f620
# ╟─eecfde6b-abef-4033-910b-f8a9a217eff2
# ╠═1b9c4e31-0501-4c7a-aa36-d2e8546da46a
# ╟─e4d1b78c-4510-4aab-88a1-a2bf91434413
# ╠═06dcaea8-0e78-47da-a1cb-54e34396a855
# ╟─7a14a919-7da7-4b31-8037-0de5806e1a54
# ╠═42c0b37d-7c85-48ea-9961-a09632c33fb0
# ╟─4e465d5d-3ae8-4ddb-b7cc-46f4ef988c68
# ╠═fed0b145-e9c1-4eb6-90fb-7f2721f6fcc7
# ╟─c2e1abd9-f664-41cd-af65-ccd25ecb9818
# ╟─135dac9b-0bd9-4e1d-8890-979691212d9b
