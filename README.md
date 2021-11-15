# HelloJulia.jl

UNDER CONSTRUCTION


Resources used by the author for a short *Introduction to Julia* workshop.

This page contains useful resources for starting out with Julia.

To **run demos** presented in the workshop live, click [here](NOTEBOOKS.md).

**Acknowledgements.** Some slides used in the presentation for this
workshop, and included [here](/slides), are based on material
contributed by Oliver Schultz and Sam Urmy, which is gratefully
acknowledged. Oscar Smith, Ian Butterworth, and Carsten Bauer
[helped](https://discourse.julialang.org/t/looking-for-simple-example-to-explain-ahead-of-time-compilation/71471/3)
with the just-in-time compilation demonstration.


## Is Julia for me?

- [Julia language home page](https://julialang.org) - Good for a quick
  rundown of features and introduction to the broader ecosystem
  
- [Slides for this workshop](/slides/slides.pdf)

- [Why Julia?](https://indico.cern.ch/event/1074269/contributions/4539601/attachments/2317518/3945412/why-julia%20slides.pdf) - Motivation and comparison to other languages. Slides from a talk by Oliver Schulz, Max Planck Institute for Physics.  [Alternative link](https://github.com/oschulz/Why-Julia)

- [Package search at JuliaHub](https://juliahub.com/ui/Packages) - Good for scouting out existing julia software (and communities) in your area of interest ([alternative search engine](https://juliapackages.com/packages?search=)).

- For experienced programmers: Julia is object-oriented but not in the way languages like python or C++. Rather it uses *multiple dispatch*. [This talk](https://www.youtube.com/watch?v=kc9HwsxE1OY) makes the case for this alternative paradigm.


## First steps

While Julia can be run in the cloud (see e.g.,
[here](https://juliahub.com/ui/Home)) we recommend installing Julia on
your machine when starting out:

- *Installing julia compiler:* [Ubuntu](https://ferrolho.github.io/blog/2019-01-26/how-to-install-julia-on-ubuntu) or similar; [Mac, Windows, or other](https://julialang.org/download/)


- Open the downloaded application (or run `julia` from a
  terminal/console) to launch the command-line interface for
  interacting with julia (its called the
  [REPL](https://en.wikipedia.org/wiki/Read–eval–print_loop)).

- At the `julia> ` prompt, type the obligatory `println("Hello
  world!")` to check the REPL is alive.

## Advanced setup

Once you are familiar with basic interaction using the REPL, you will want to:

- Hook your Julia installation up with an editor or integrated
  development environment (IDE) so you can efficiently edit, run and
  debug longer julia scripts. See [these
  options](https://julialang.org). If you don't have an existing
  preference I recommend VS Code. I prefer emacs, but it is much older
  and has a steeper learning curve.

- Or, interact with Julia using a notebook. Here you have two options:
  - Juptyer notebooks (used also for R and python) - follow [these
	instructions](https://github.com/JuliaLang/IJulia.jl).
  - [Pluto](https://github.com/fonsp/Pluto.jl) "reactive" notebooks (specific to Julia)


## Getting help

Popular forums for asking your julia questions are [Julia
Discourse](https://discourse.julialang.org) and the [Julia Slack
channel](https://julialang.org/slack/). Also useful:

- [Julia cheatsheet](https://juliadocs.github.io/Julia-Cheat-Sheet/).

- Get help on a command with `juia> ?some_command` at the REPL or `@doc ?some_command` in a notebook.

- `apropos("invert")` seaches for objects with "invert" in the doc string.


## Learning Julia

### If you have little or no prior programming experience

Many people use R, python or MATLAB packages with a minimum of actual
programming knowledge and the same applies to Julia. However, to start
deepening your Julia programming knowledge, you could try some of the
resources at this [Julia org page](https://julialang.org/learning/). I
have also heard that [Think
Julia](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html) is
a pretty good ab initio introduction to programming.


### If you have moderate to advanced programming experience elsewhere

My strong recommendation would be to read Aaron Christinson's tutorial
[Dispatching Design
Patterns](https://github.com/ninjaaron/dispatching-design-patterns)
which is nicely compressed in his [half-hour
video presentation](https://www.youtube.com/watch?v=n-E-1-A_rZM).

These [points of
difference](https://docs.julialang.org/en/v1/manual/noteworthy-differences/)
between Julia and other popular languages may also be useful.

Serious Julia developers will want a copy of [Hands-On Design Patterns
and Best Julia Practices with Julia](https://www.perlego.com/book/1365831/handson-design-patterns-and-best-practices-with-julia-proven-solutions-to-common-problems-in-software-design-for-julia-1x-pdf?utm_source=google&utm_medium=cpc&gclid=CjwKCAjw_L6LBhBbEiwA4c46uv-v5MDWoUCnOsWjAsPQ1OWcownNPPDrKDhhlwNbGG69_zSNFwyM5RoCMgcQAvD_BwE) by Tom Kwong. This is the book
I wished existed when I started. I learned Julia from the
[manual](https://docs.julialang.org/en/v1/) which is, however,
excellent.


## Machine learning in Julia
