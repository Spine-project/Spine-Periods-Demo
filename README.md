## TODO list
This is all assuming I've got this to work.
* Add python environment setup
* Add SpinePeriods to the Spine Julia Registry once release is done (Manuel).
* Set up a proper `init.jl` file, i.e., specifying git commits and or versions (not necessary for Toolbox, just specify in README).
* Finish for use of the demo.

SpinePeriods Demo
------------------

This is an example of how to use `SpinePeriods.jl` in conjunction with `SpineOpt.jl` to optimize the operation of a battery storage unit for a year. Computational speed up is achieved by limiting dispatch decisions to only 12 representative days, while the state of charge is defined for the whole year. This is of course more interesting for an investment rather than an operational problem.

Requirements
------------

* Spine Toolbox v0.5.36 or later (see https://github.com/Spine-project/Spine-Toolbox)
* Julia 1.5 or later (see https://julialang.org/)

Getting started
---------------

1\. Download or clone the files to your computer, e.g.:

    > git clone git@github.com:Spine-project/Spine-Periods-Demo.git

   (The recommended folder is the folder you store your spine projects in, but can be anywhere, for example your desktop.)

2\. Change the current directory to spine project "spine-periods-demo":

    > cd Spine-Periods-Demo
	
3\. Install required Python packages:
	
	> NOT DONE YET

4\. Install required Julia packages:

    > julia init.jl
    
5\. Run the demo:

    > julia run_demo.jl

6\. Open SpineToolbox:

    > python -m spinetoolbox

7\. Open project "spine-project-demo": 

   `File --> Open Project... --> spine-project-demo`

8\. Open the results of the optimisation by double clicking on `Opt output`

9\. You can inspect e.g. the battery state of charge by clicking on ...
