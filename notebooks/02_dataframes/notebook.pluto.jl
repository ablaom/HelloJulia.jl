### A Pluto.jl notebook ###
# v0.16.0

using Markdown
using InteractiveUtils

# ╔═╡ 7775b104-385d-4721-9bca-7c69b794f8ce
md"# Tutorial 2"

# ╔═╡ 879229d0-fa8d-4b7d-b795-033f6f2a0674
md"An introduction to data frames"

# ╔═╡ ced52df6-0aec-456f-935f-ddf6a6bfbbdd
md"""
Loosely based on [this
tutorial](https://juliaai.github.io/DataScienceTutorials.jl/data/dataframe/)
from Data Science Tutorials.
"""

# ╔═╡ 17e21026-099b-4b8e-af2a-25235e544a31
md"""
DataFrames.jl **cheatsheets**:
[english](https://www.ahsmart.com/assets/pages/data-wrangling-with-data-frames-jl-cheat-sheet/DataFramesCheatSheet_v1.x_rev1.pdf),
[chinese](https://www.ahsmart.com/assets/pages/data-wrangling-with-data-frames-jl-cheat-sheet/DataFramesCheatSheet_v1.x_rev1_zh.pdf)
"""

# ╔═╡ 40956165-26d0-4d61-8af5-148d95ea2900
md"## Setup"

# ╔═╡ 4474fd86-9496-44c7-a6bf-47194d7e8e12
begin
  using Pkg
  Pkg.activate(joinpath(@__DIR__, "..", ".."))
  Pkg.instantiate()
end

# ╔═╡ 43248462-d1ab-44a6-828a-4cc485149963
md"## Loading some demonstration data"

# ╔═╡ 368564ee-157f-44dc-9e54-3f7b3ca87ecb
md"We'll be using [OpenML](https://www.openml.org/home) to grab datasets."

# ╔═╡ 53aa7f8d-b0c7-4446-ba1f-6363f43ec697
begin
  using OpenML
  using DataFrames
  
  table = OpenML.load(42638); # Titanic data set
  typeof(table)
end

# ╔═╡ 5aff5a3c-405a-41d8-95ea-2955abd45275
md"""
This is not a `DataFrame`. However, like
[many](https://github.com/JuliaData/Tables.jl/blob/main/INTEGRATIONS.md)
other tabular data containers in Julia, it can be converted to one in the
obvious way:
"""

# ╔═╡ 943a5fd8-56fc-420e-b1b3-dd47e367ba54
df = DataFrame(table);

# ╔═╡ fbb4977e-f176-43ed-8d7e-8e449afd1c48
md"""
A `DataFrame` is essentially just a wrapper around a number of
vectors with names, conceptualized as a table with the vectors as
columns.
"""

# ╔═╡ 7fe10a23-640b-4bf5-a949-7f3bd292fe31
md"Lets' look the first few rows (observations) of `df`:"

# ╔═╡ 33e40309-c671-4f7a-8514-99938a2932db
first(df, 4)

# ╔═╡ ce8785e8-a6e2-4e1b-a0de-1721c1bc2df2
md"Here's a summary of stats for each column:"

# ╔═╡ 33e075ab-e982-4406-bca8-7eec7950fd82
describe(df)

# ╔═╡ 0f1271de-3e98-4a5f-9873-1b1430e635cc
md"To get just the column names, use `names(df)`."

# ╔═╡ 9c0dd263-ce7f-4bea-b43e-d0ebe87da176
md"## Selecting a single entry:"

# ╔═╡ 84c95cd3-6788-4547-9009-4cfb2012998f
number = df[5, :age]   # or df[5, 4]

# ╔═╡ f45964a6-9e21-4c92-abd3-cb77d7a79683
md"## Selecting a single row:"

# ╔═╡ 32ed1ff7-1455-4084-879e-dc128f3db7b3
md"We use the wild-card `:`"

# ╔═╡ 471921ed-24c1-4d22-a367-9aa3c6cf34d0
row = df[5, :]

# ╔═╡ ca76448d-1093-46d1-bf32-94657e65284e
number2 = row.age

# ╔═╡ 751d6a10-a54b-40ab-9afd-65a5b5facac9
md"## Selecting multiple rows"

# ╔═╡ a3ca3a32-7e5c-40b8-b6c8-54f5ed90a964
md"By index:"

# ╔═╡ df5115b8-8016-4a89-9292-fe822525fc77
small_df = df[3:7, :]

# ╔═╡ bb39ed78-995c-4c55-ae5e-4b83dcbc9675
md"By applying some criterion:"

# ╔═╡ a4538666-3731-42bd-8a29-32f11452654a
df2 = filter(df) do row
    row.age > 60 && row.survived == "1"
end

# ╔═╡ 948970bb-8143-43aa-a5f1-151fcbe229a2
md"""
(Alternatively, one can use `subset` or Boolean indexing; see the
[cheatsheet](https://www.ahsmart.com/assets/pages/data-wrangling-with-data-frames-jl-cheat-sheet/DataFramesCheatSheet_v1.x_rev1.pdf).)
"""

# ╔═╡ d16757ef-8df0-420a-81bc-2d5603785a09
md"## Selecting a single column"

# ╔═╡ 44d02e0d-3629-4167-9d87-1d1fbb0e3997
md"Here's how I get the column named \"Age\":"

# ╔═╡ 63d6930c-1083-414b-b950-fddef2a1fb10
df2.age

# ╔═╡ 5de191d8-a55f-4333-951b-64cb2a36c8e3
md"Since this is just a vector, I can restrict the rows as usual:"

# ╔═╡ 8d660025-9145-4a42-b0e6-441461cc8770
df2.age[2:5]  # but same as df2[2:5, :Age]

# ╔═╡ d4e8b6b8-8c6c-4d25-8cb0-de601961bc02
md"## Selecting multiple columns - `select`"

# ╔═╡ 9d2b7153-c065-45f9-a87d-950c50fb2955
md"The following wraps `df.age` as a single-column `DataFrame`:"

# ╔═╡ 2f3d2b72-5143-4c83-8448-4bcb089096cd
select(df2, :age)

# ╔═╡ 191b7bac-2207-4f64-a012-a84240254fb6
md"... which generalizes to multiple columns:"

# ╔═╡ cd3825dc-b8eb-4ca5-bbdd-9799f7bb2e60
select(df2, [:age, :sex])

# ╔═╡ 39d3e973-26e9-47c2-97a7-88e3af4f10ee
select(df2, Not(:age))

# ╔═╡ 55558e47-bde1-48de-b372-8c9866e51852
select(df2, Between(:sex, :fare))

# ╔═╡ 3ab22ed6-2790-4c04-8f3d-b82f1e7b6f7a
md"## Copies or views of the data?"

# ╔═╡ cdeebfb4-be3c-4477-ab04-579e5608ae53
md"""
So far, all the selection mechanisms discussed so far return a new
`DataFrame` object, with these exceptions:
"""

# ╔═╡ 199fa164-d3b2-48e8-86cf-35420d9e6995
md"""
* selecting a single row, as in `df[3,:]` - this returns a `DataFrameRow`.
* selecting a single column as a vector, as in `df.age` - this returns a vector
"""

# ╔═╡ 9430657d-9814-4114-a29a-8d0445351914
md"""
These exceptions are *views* of the original `DataFrame`, in the
sense that no data is copied and mutating the view mutates the
original `DataFrame`:
"""

# ╔═╡ d4896e0b-04d7-4226-be65-28d0fcca50a8
begin
  v = df.age;
  v[1] = 1000
  df[1, :age]
end

# ╔═╡ 92548b3b-9cb7-48ab-9a2e-c468345d87d1
md"""
Mutating the output of all the other selection mechanisms will not
touch the original `DataFrame`, as data is copied in those cases.
"""

# ╔═╡ 7e263c4e-e76e-4a0a-b5fa-cb79ebf595ef
md"""
Use `select!` to make "in-place" column selections which mutate the
original `DataFrame`. For example, the following permanently drops a
column from `df`:
"""

# ╔═╡ 5cbca2d2-26fe-4353-91c5-524da38aa391
begin
  select!(df, Not(:cabin));
  first(df, 2)
end

# ╔═╡ bcbe0dae-2138-40ac-ad90-b4405b216771
md"""
In addition to row and column views of a `DataFrame` we can construct
larger views, of type `SubDataFrame`, which share most of the
behviour of an ordinary `DataFrame`, except they only *point* to
data in the parent `DataFrame`, rather than duplicate it:
"""

# ╔═╡ d498c5b6-6da2-47d4-895b-997a92b731e0
begin
  df_copy = df[1:3, [:fare, :age]]       # this is copy
  df_view = @view df[1:3, [:fare, :age]] # this is a view
end

# ╔═╡ 07ab3f64-2053-4a61-a525-e9b04a4bd246
begin
  df_view[1, :age] = 4000
  df[1, :age]
end

# ╔═╡ 93c8de49-ab53-40d1-80f0-ba7781e173cf
df_copy[1, :age]

# ╔═╡ 9ccfcf16-e0d9-449a-9cbc-9a2c39793333
md"## Describing the data"

# ╔═╡ 9b14c716-41ca-404e-b887-2b16710e5502
md"""
To broaden the summary provided by `describe(df)` we can pass a
number of symbols to indicate the statistics we are after:
"""

# ╔═╡ c0fcd414-a37f-4e48-9452-5298a8a4a401
describe(df, :min, :max, :mean, :median, :std)

# ╔═╡ 95e50de2-775d-4457-b017-96f1602f2cad
md"""
The following are all supported:
* `mean`, `std`, `min`, `max`, `median`, `first`, `last` are all fairly self explanatory
* `q25`, `q75` are respectively for the 25th and 75th percentile,
* `eltype`, `nunique`, `nmissing` can also be used
"""

# ╔═╡ 964ea710-9e32-4706-8be2-2a4017c45345
md"""
You can also pass your custom function with a pair `function =>
:name` for instance:
"""

# ╔═╡ ba1b1b96-46b0-4cf8-a7ad-80d84f5b0070
begin
  using Statistics # to get functions like `mean` and `std`
  foo(v) = mean(abs.(v))
  d = describe(df, :mean, :median, foo => :mae)
  first(d, 3)
end

# ╔═╡ 3e50f94b-94c4-4fb3-8378-5aa686f0b407
md"Note that the object returned by `describe` is itself a `DataFrame`:"

# ╔═╡ 947b4436-1432-4110-9f43-49763e8691a1
select(d, [:variable, :mean])

# ╔═╡ 91880b82-ffab-4c52-bb0e-3a45761c733a
md"""
## Materializing as a matrix

To convert the content of the dataframe as one big matrix do this:
use `convert`:
"""

# ╔═╡ d92e2ff5-948d-47b3-9979-7044b2f2df33
begin
  mat = Matrix(df)
  mat[1:3, 1:3]
end

# ╔═╡ 8214a5ed-990e-4a79-b2a1-fbbde543f620
md"## Adding columns"

# ╔═╡ 3c144b2c-87bf-438a-910b-f8a9a217eff2
md"Adding a column to a dataframe is very easy:"

# ╔═╡ 2616d636-de3e-4c05-aa36-d2e8546da46a
begin
  df.weird = df.fare ./ df.age;
  first(df, 3)
end

# ╔═╡ e38109ec-ebf4-423a-88a1-a2bf91434413
md"""
That's it! Remember also that you can drop columns or make
subselections with `select` and `select!`.
"""

# ╔═╡ 8fb350ab-8631-4335-a1cb-54e34396a855
md"""
The remainder of this tutorial is an abbreviated version of a
[DataFrames.jl
tutorial](http://juliadata.github.io/DataFrames.jl/latest/man/split_apply_combine/).
"""

# ╔═╡ c23a0e49-62ee-4eba-8037-0de5806e1a54
begin
  iris = OpenML.load(61) |> DataFrame;
  first(iris, 3)
end

# ╔═╡ 6d10c87e-5886-41ee-9961-a09632c33fb0
md"""
## `groupby`

The `groupby` function allows to form "sub-dataframes" corresponding
to groups of rows.  This can be very convenient to run specific
analyses for specific groups without copying the data.
"""

# ╔═╡ 9d0800b7-fa7a-4c4b-b7cc-46f4ef988c68
md"""
The basic usage is `groupby(df, cols)` where `cols` specifies one or
several columns to use for the grouping.
"""

# ╔═╡ 3414a5db-2bd9-4df4-90fb-7f2721f6fcc7
md"""
Consider a simple example: in `iris` there is a `Species` column
with 3 species:
"""

# ╔═╡ fbdc3ba2-fd93-473e-af65-ccd25ecb9818
unique(iris.class)

# ╔═╡ cd771149-a832-42a7-8890-979691212d9b
md"We can form views for each of these:"

# ╔═╡ bc514532-ebc5-49b7-a6fa-eaf14df5d44b
gdf = groupby(iris, :class);

# ╔═╡ 93fdfcf8-9592-4133-8025-5084804a9f6c
md"""
The `gdf` object now corresponds to **views** of the original
dataframe for each of the 3 species; the first species
is `"Iris-setosa"` with:
"""

# ╔═╡ 7a10d4a6-bcf4-4500-9e90-09023d201062
begin
  subdf_setosa = gdf[1];
  typeof(subdf_setosa)
end

# ╔═╡ 0add26cb-530d-4375-b7bb-2f33ef765cc0
describe(subdf_setosa, :min, :mean, :max)

# ╔═╡ c04bf75a-cb47-463a-9625-01172c4a0081
md"""
Recall that this means modifying `subdf_setosa` also modifies its
parent `iris`.
"""

# ╔═╡ ca52a424-87bf-4394-af4f-11c7de9e21dd
md"Do `?groupby` for more information."

# ╔═╡ 23f3a8cd-3f38-4b9e-8dba-241d9b744683
md"## `combine`"

# ╔═╡ ef382b74-3247-45a4-a6e5-2f0b4dca5c59
md"""
The `combine` function allows to derive a new dataframe out of
transformations of an existing one.  Here's an example taken from
the official doc (see `?combine`):
"""

# ╔═╡ 81a9302f-431b-417e-8550-20498aa03ed0
df3 = DataFrame(a=1:3, b=4:6)

# ╔═╡ 8a900763-3658-4074-9e7b-5b943cf6b560
combine(df3, :a => sum, nrow)

# ╔═╡ ab07e4d8-f7be-415c-bce6-0a1379cc1259
md"""
What happened here is that the derived DataFrame has two columns
obtained respectively by (1) computing the sum of the first column
and (2) applying the `nrow` function on the `df`.

The transformation can produce one or several values, and `combine` will
try to accomodate this with appropriate packing:
"""

# ╔═╡ b985d3fb-2b57-42d2-9608-b5032c116833
begin
  goo(v) = v[1:2]
  combine(df3, :a => maximum, :b => goo)
end

# ╔═╡ d494e8d7-6fe8-4693-b473-4aa968e6937a
md"""
Here the maximum value of `a` is copied twice so that the two
columns have the same number of rows.
"""

# ╔═╡ 4559184a-36ef-4e6b-8d9e-644a1b3cc6b6
begin
  bar(v) = v[end-1:end]
  combine(df3, :a => goo, :b => bar)
end

# ╔═╡ e87aa3fa-0db2-4734-ac0a-23ded81445da
md"""
## `combine` with `groupby`

Combining `groupby` with `combine` is very useful.  For instance you
might want to compute statistics across groups for different
variables:
"""

# ╔═╡ c17b5bb3-4f9f-4f0f-8535-1a088a6a3228
combine(groupby(iris, :class), :petallength => mean)

# ╔═╡ 6765732d-45d5-4468-a39f-7893c73eef39
md"""
Let's break this operatioin down:

1. The `groupby(iris, :class)` creates groups using the `:class` column (which has values `Iris-setosa`, `Iris-versicolor`, `Iris-virginica`)
2. The `combine` creates a derived dataframe by applying the `mean` function to the `:petallength` column
3. Since there are three groups, we get one column (mean of `petallength`) and three rows (one per group).


You can do this for several columns/statistics at the time and give
new column names to the results:
"""

# ╔═╡ b59c860d-0212-4d53-bcca-51a27994a151
begin
  gdf3 = groupby(iris, :class)
  combine(gdf3, :petallength => mean => :MPL, :petallength => std => :SPL)
end

# ╔═╡ b1bcbde6-ffdc-4dc1-9b33-09b4b6661170
md"""
So here we assign the names `:MPL` and `:SPL` to the derived
columns.  If you want to apply something on all columns apart from
the grouping one, using `names` and `Not` comes in handy:
"""

# ╔═╡ baee6796-e3a6-4c76-b45d-88d068bb0fa2
combine(gdf3, names(iris, Not(:class)) .=> std)

# ╔═╡ 4e465d5d-3ae8-4ddb-92c8-6db3a590d963
md"where"

# ╔═╡ d5a2cc3d-dad7-48b0-abf5-96f457eb2bdf
names(iris, Not(:class))

# ╔═╡ c2e1abd9-f664-41cd-8a60-2e0214c059f5
md"""
and note the use of `.` in `.=>` to indicate that we broadcast the
function over each column.
"""

# ╔═╡ 135dac9b-0bd9-4e1d-a38a-beb5c7157b57
md"""
---

*This notebook was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
"""

# ╔═╡ Cell order:
# ╟─7775b104-385d-4721-9bca-7c69b794f8ce
# ╟─879229d0-fa8d-4b7d-b795-033f6f2a0674
# ╟─ced52df6-0aec-456f-935f-ddf6a6bfbbdd
# ╟─17e21026-099b-4b8e-af2a-25235e544a31
# ╟─40956165-26d0-4d61-8af5-148d95ea2900
# ╠═4474fd86-9496-44c7-a6bf-47194d7e8e12
# ╟─43248462-d1ab-44a6-828a-4cc485149963
# ╟─368564ee-157f-44dc-9e54-3f7b3ca87ecb
# ╠═53aa7f8d-b0c7-4446-ba1f-6363f43ec697
# ╟─5aff5a3c-405a-41d8-95ea-2955abd45275
# ╠═943a5fd8-56fc-420e-b1b3-dd47e367ba54
# ╟─fbb4977e-f176-43ed-8d7e-8e449afd1c48
# ╟─7fe10a23-640b-4bf5-a949-7f3bd292fe31
# ╠═33e40309-c671-4f7a-8514-99938a2932db
# ╟─ce8785e8-a6e2-4e1b-a0de-1721c1bc2df2
# ╠═33e075ab-e982-4406-bca8-7eec7950fd82
# ╟─0f1271de-3e98-4a5f-9873-1b1430e635cc
# ╟─9c0dd263-ce7f-4bea-b43e-d0ebe87da176
# ╠═84c95cd3-6788-4547-9009-4cfb2012998f
# ╟─f45964a6-9e21-4c92-abd3-cb77d7a79683
# ╟─32ed1ff7-1455-4084-879e-dc128f3db7b3
# ╠═471921ed-24c1-4d22-a367-9aa3c6cf34d0
# ╠═ca76448d-1093-46d1-bf32-94657e65284e
# ╟─751d6a10-a54b-40ab-9afd-65a5b5facac9
# ╟─a3ca3a32-7e5c-40b8-b6c8-54f5ed90a964
# ╠═df5115b8-8016-4a89-9292-fe822525fc77
# ╟─bb39ed78-995c-4c55-ae5e-4b83dcbc9675
# ╠═a4538666-3731-42bd-8a29-32f11452654a
# ╟─948970bb-8143-43aa-a5f1-151fcbe229a2
# ╟─d16757ef-8df0-420a-81bc-2d5603785a09
# ╟─44d02e0d-3629-4167-9d87-1d1fbb0e3997
# ╠═63d6930c-1083-414b-b950-fddef2a1fb10
# ╟─5de191d8-a55f-4333-951b-64cb2a36c8e3
# ╠═8d660025-9145-4a42-b0e6-441461cc8770
# ╟─d4e8b6b8-8c6c-4d25-8cb0-de601961bc02
# ╟─9d2b7153-c065-45f9-a87d-950c50fb2955
# ╠═2f3d2b72-5143-4c83-8448-4bcb089096cd
# ╟─191b7bac-2207-4f64-a012-a84240254fb6
# ╠═cd3825dc-b8eb-4ca5-bbdd-9799f7bb2e60
# ╠═39d3e973-26e9-47c2-97a7-88e3af4f10ee
# ╠═55558e47-bde1-48de-b372-8c9866e51852
# ╟─3ab22ed6-2790-4c04-8f3d-b82f1e7b6f7a
# ╟─cdeebfb4-be3c-4477-ab04-579e5608ae53
# ╟─199fa164-d3b2-48e8-86cf-35420d9e6995
# ╟─9430657d-9814-4114-a29a-8d0445351914
# ╠═d4896e0b-04d7-4226-be65-28d0fcca50a8
# ╟─92548b3b-9cb7-48ab-9a2e-c468345d87d1
# ╟─7e263c4e-e76e-4a0a-b5fa-cb79ebf595ef
# ╠═5cbca2d2-26fe-4353-91c5-524da38aa391
# ╟─bcbe0dae-2138-40ac-ad90-b4405b216771
# ╠═d498c5b6-6da2-47d4-895b-997a92b731e0
# ╠═07ab3f64-2053-4a61-a525-e9b04a4bd246
# ╠═93c8de49-ab53-40d1-80f0-ba7781e173cf
# ╟─9ccfcf16-e0d9-449a-9cbc-9a2c39793333
# ╟─9b14c716-41ca-404e-b887-2b16710e5502
# ╠═c0fcd414-a37f-4e48-9452-5298a8a4a401
# ╟─95e50de2-775d-4457-b017-96f1602f2cad
# ╟─964ea710-9e32-4706-8be2-2a4017c45345
# ╠═ba1b1b96-46b0-4cf8-a7ad-80d84f5b0070
# ╟─3e50f94b-94c4-4fb3-8378-5aa686f0b407
# ╠═947b4436-1432-4110-9f43-49763e8691a1
# ╟─91880b82-ffab-4c52-bb0e-3a45761c733a
# ╠═d92e2ff5-948d-47b3-9979-7044b2f2df33
# ╟─8214a5ed-990e-4a79-b2a1-fbbde543f620
# ╟─3c144b2c-87bf-438a-910b-f8a9a217eff2
# ╠═2616d636-de3e-4c05-aa36-d2e8546da46a
# ╟─e38109ec-ebf4-423a-88a1-a2bf91434413
# ╟─8fb350ab-8631-4335-a1cb-54e34396a855
# ╠═c23a0e49-62ee-4eba-8037-0de5806e1a54
# ╟─6d10c87e-5886-41ee-9961-a09632c33fb0
# ╟─9d0800b7-fa7a-4c4b-b7cc-46f4ef988c68
# ╟─3414a5db-2bd9-4df4-90fb-7f2721f6fcc7
# ╠═fbdc3ba2-fd93-473e-af65-ccd25ecb9818
# ╟─cd771149-a832-42a7-8890-979691212d9b
# ╠═bc514532-ebc5-49b7-a6fa-eaf14df5d44b
# ╟─93fdfcf8-9592-4133-8025-5084804a9f6c
# ╠═7a10d4a6-bcf4-4500-9e90-09023d201062
# ╠═0add26cb-530d-4375-b7bb-2f33ef765cc0
# ╟─c04bf75a-cb47-463a-9625-01172c4a0081
# ╟─ca52a424-87bf-4394-af4f-11c7de9e21dd
# ╟─23f3a8cd-3f38-4b9e-8dba-241d9b744683
# ╟─ef382b74-3247-45a4-a6e5-2f0b4dca5c59
# ╠═81a9302f-431b-417e-8550-20498aa03ed0
# ╠═8a900763-3658-4074-9e7b-5b943cf6b560
# ╟─ab07e4d8-f7be-415c-bce6-0a1379cc1259
# ╠═b985d3fb-2b57-42d2-9608-b5032c116833
# ╟─d494e8d7-6fe8-4693-b473-4aa968e6937a
# ╠═4559184a-36ef-4e6b-8d9e-644a1b3cc6b6
# ╟─e87aa3fa-0db2-4734-ac0a-23ded81445da
# ╠═c17b5bb3-4f9f-4f0f-8535-1a088a6a3228
# ╟─6765732d-45d5-4468-a39f-7893c73eef39
# ╠═b59c860d-0212-4d53-bcca-51a27994a151
# ╟─b1bcbde6-ffdc-4dc1-9b33-09b4b6661170
# ╠═baee6796-e3a6-4c76-b45d-88d068bb0fa2
# ╟─4e465d5d-3ae8-4ddb-92c8-6db3a590d963
# ╠═d5a2cc3d-dad7-48b0-abf5-96f457eb2bdf
# ╟─c2e1abd9-f664-41cd-8a60-2e0214c059f5
# ╟─135dac9b-0bd9-4e1d-a38a-beb5c7157b57
