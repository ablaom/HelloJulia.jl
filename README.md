## &#10024; Participating in ResBaz 2022?

Start [here](https://github.com/ablaom/HelloJulia.jl/wiki/Preparing-for-your-ResBaz-2023-Julia-workshop) either of these workshops:

- **Getting Started With the Julia Programming Language** 
- **Introduction to Using Julia for Machine Learning**

---

## Participating in JuliaCon 2023?

Start [here](https://github.com/ablaom/HelloJulia.jl/wiki/JuliaCon-2022-workshop:-Getting-started-with-Julia-and-MLJ) for the workshop **Getting started with Julia and machine learning**.

---

# HelloJulia.jl

Resources used by the author for a short *Introduction to Julia*
workshop, and a longer *Getting started with Julia and machine
learning* workshop. Tutorials 1 and 2, and some of the demos, are
suitable for a one-hour workshop. Add the remaining material for a 3
hour workshop. 

Users are not assumed to have any familiarity with Julia but should be
know some basic linear algebra and statistics (especially for the
extended version).

This README page summarizes some useful resources for starting out with Julia.

To **run demos and tutorials** presented in the workshop:

[![here](https://img.shields.io/badge/run-demos%2Ftutorials-informational)](INSTALLATION.md)


## Is Julia for me?

- [Julia language home page](https://julialang.org) - Good for a quick
  rundown of features and introduction to the broader ecosystem
  
- [Slides for this workshop](/slides/slides.pdf)

- [Why Julia?](https://indico.cern.ch/event/1074269/contributions/4539601/attachments/2317518/3945412/why-julia%20slides.pdf) - Motivation and comparison to other languages. Slides from a talk by Oliver Schulz, Max Planck Institute for Physics.  [Alternative link](https://github.com/oschulz/Why-Julia)

- [Package search at JuliaHub](https://juliahub.com/ui/Packages) - Good for scouting out existing julia software (and communities) in your area of interest ([alternative search engine](https://juliapackages.com/packages?search=)).

- For experienced programmers: Julia is object-oriented but not in the way languages like python or C++. Rather it uses *multiple dispatch*. [This talk](https://www.youtube.com/watch?v=kc9HwsxE1OY) makes the case for this alternative paradigm.


## First steps

See [here](/FIRST_STEPS.md) on how to install Julia on your
computer. To install and run the demos and tutorials in this
respository, click [here](INSTALLATION.md)


## Advanced setup

Once you are familiar with basic interaction using the REPL, you will want to:

- Hook your Julia installation up with an editor or integrated
  development environment (IDE) so you can efficiently edit, run and
  debug longer julia scripts. See [these
  options](https://julialang.org) (scroll down to "Editors and IDEs"
  and "Essential Tools"). If you don't have an existing preference I
  recommend VS Code. I prefer emacs, but it is much older and has a
  steeper learning curve.

- Or, interact with Julia using a notebook. Here you have two options:
  - Juptyer notebooks (used also for R and python) - follow [these
	instructions](https://github.com/JuliaLang/IJulia.jl).
  - [Pluto](https://github.com/fonsp/Pluto.jl) "reactive" notebooks (specific to Julia)


## Getting help

Popular forums for asking your julia questions are [Julia
Discourse](https://discourse.julialang.org) and the [Julia Slack
channel](https://julialang.org/slack/). Also useful:

- [Julia cheatsheet](https://juliadocs.github.io/Julia-Cheat-Sheet/).

- [DataFrames cheatsheet](https://ahsmart.com/pub/data-wrangling-with-data-frames-jl-cheat-sheet/index.html)

- [MLJ cheatsheet](https://alan-turing-institute.github.io/MLJ.jl/dev/mlj_cheatsheet/)

- Get help on a command with `juia> ?some_command` at the REPL or `@doc ?some_command` in a notebook.

- `apropos("invert")` seaches for objects with "invert" in the doc string.


## Learning Julia

### If you have little or no prior programming experience

Many people use R, python or MATLAB packages with a minimum of actual
programming knowledge and the same applies to Julia. However, to start
deepening your Julia programming knowledge, you could try some of the
resources at this [Julia org page](https://julialang.org/learning/)
(e.g., [juliaAcademy](https://juliaacademy.com)). I have also heard
that the book [Think
Julia](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html) is
a pretty good ab initio introduction to programming.


### If you have moderate to advanced programming experience elsewhere

If you are already python proficient, check out
[this](https://colab.research.google.com/drive/1G04w8tTl074180DP_Ka9X44r_pndUYxq?usp=sharing#scrollTo=9at61Y3LLJWX)
Colab notebook.

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

**Acknowledgements.** Some slides used in the presentation for this
workshop, and included [here](/slides), are based on material
contributed by Oliver Schultz and Sam Urmy, which is gratefully
acknowledged. Oscar Smith, Ian Butterworth, and Carsten Bauer
[helped](https://discourse.julialang.org/t/looking-for-simple-example-to-explain-ahead-of-time-compilation/71471/3)
with the just-in-time compilation demonstration. The live tutorial deployment is based on [PrecompilePlutoCourse.jl](https://github.com/jbrea/PrecompilePlutoCourse.jl).
