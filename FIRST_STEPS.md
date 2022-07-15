# Installing Julia

**Important** When following the following steps, be sure the version
of Julia you install is **version 1.7.x**, where **x** is any integer.

While Julia can be run in the cloud (see e.g.,
[here](https://juliahub.com/ui/Home)) we recommend installing Julia on
your machine when starting out:

- *Install the julia compiler:*
  <br>
  <img src="./Julia_Installation.gif" width="500" height="300">
  </br>

  [Ubuntu](https://ferrolho.github.io/blog/2019-01-26/how-to-install-julia-on-ubuntu) or
  similar; [Mac,
  Windows](https://www.juliafordatascience.com/first-steps-1-installing-julia/). The Julia
  download page is [here](https://julialang.org/downloads/). *We strongly recommend you you
  add `julia` to your `PATH`*, as described in the instructions, so that Julia can be
  launched from the terminal/console.

- Open the downloaded application in the usual way for your OS, or run
  `julia` from a terminal/console. This launches a command-line
  interface for interacting with julia called the
  [REPL](https://en.wikipedia.org/wiki/Read–eval–print_loop).

- At the `julia> ` prompt, type the obligatory `println("Hello
  world!")` to check the REPL is alive and kicking.

*Known issue*: If launching Julia on a Mac by clicking on the app icon, you may encounter
"Error: Not authorised to send Apple events to Terminal." Workaround: See [this
fix](https://apple.stackexchange.com/questions/393096/error-not-authorised-to-send-apple-events-to-terminal-when-starting-maxima)
or add `julia` to your `PATH` so you can launch Julia from the terminal .
