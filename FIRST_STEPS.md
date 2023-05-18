# Installing Julia

**Important** When following the following **four steps**, be sure the version
of Julia you install is **version 1.9.x**, where **x** is any integer.

While Julia can be run in the cloud (see e.g.,
[here](https://juliahub.com/ui/Home)) we recommend installing Julia on
your machine when starting out:

1. If you are a Windows user, install [Windows
   Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=en-nz&gl=nz)
   and make sure you know how to open a new terminal process, into which you can type
   commands.

2. Install the julia compiler:
  
  - Mac: Download the appropriate the file ending in `.dmg` appropriate to your processor
    and follow [these instructions](https://julialang.org/downloads/platform/#macos).

  - Ubuntu and other Linux distributions: Follow [these
    instructions](https://ferrolho.github.io/blog/2019-01-26/how-to-install-julia-on-ubuntu)
    **but replace "1.8.5" with "1.9.0"** in all commands. 
	
  - Windows: Follow [these instructions](https://julialang.org/downloads/platform/#windows) (video below)

  **It is very strongly recommended that you add `julia` to your `PATH`**, as described in
  the instructions, so that Julia can be launched from a terminal/console. (On a Mac,
  double clicking on the Julia application icon will also do.)

  <br style="width:600px; height:480px">
    <img src="./Julia_Installation.gif" />
  </br>
  
  An new alternative I have not tried or tested myself is to use
  [juliaup](https://github.com/JuliaLang/juliaup).

3. Open the downloaded application in the usual way for your OS, or 
  type `julia` and press `return` from a terminal window. This launches a command-line
  interface for interacting with julia called the
  [REPL](https://en.wikipedia.org/wiki/Read–eval–print_loop).

4. *Testing.* At the `julia> ` prompt, type `println("Hello
  world!")` and press `enter`. The words "Hello world!" should be repeated back to you:
  
![Julia REPL screen shot](/assets/hello_world.png)

*Known issue*: If launching Julia on a Mac by clicking on the app icon, you may encounter
"Error: Not authorised to send Apple events to Terminal." Workaround: See [this
fix](https://apple.stackexchange.com/questions/393096/error-not-authorised-to-send-apple-events-to-terminal-when-starting-maxima)
or add `julia` to your `PATH` so you can launch Julia from the terminal .
