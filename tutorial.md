# ducttape: A Crash Course
### [Nathan Schneider](http://nathan.cl)
### 2012-01-12

This is a tutorial for **[ducttape](https://github.com/jhclark/ducttape/)**, a workflow management tool by [Jonathan Clark](http://www.cs.cmu.edu/~jhclark/). Parts are based on his [original tutorial](https://github.com/jhclark/ducttape/blob/master/tutorial/TUTORIAL.md). It was created with the [Mou](http://mouapp.com/) editor; Markdown and [Graphviz](http://www.graphviz.org/) dot sources are [on GitHub](https://github.com/nschneid/ducttape-crash-course).

Cat pictures are from the Internet.

## Is ducttape right for you?

<p style="position: relative;"><img src="cats/ducttape.jpg" style="position: absolute; left: 101%; height: 120px;" /></p>

Do you suffer from Bash Bookkeeping Beleaguerment? Symptoms include:

  - wading through a jungle of scripts that perform similar or related tasks
  - assigning insanely long filenames with all sorts of parameters in them[^fn1]
  - having to add experimental parameters or steps that render previous scripts & data obsolete
  - losing time to silent failures of intermediate steps
  - sleuthing to determine the precise configurations required to replicate a result
  - dreading having to share code with others because that would require explaining how to run it

[^fn1]: Actual example: `10neigh.sym.awnHeuristicScores.lp_1e-2_1e-2.vertices.indexed`

In a nutshell, ducttape cures these by formalizing each project as a series of modular steps, or __tasks__, organized in a [__workflow__](tutorial1.html) describing inter-task dependencies.

 - Tasks run when they are ready (all dependencies are satisfied). If multiple tasks are ready at once they can be run in parallel.
 - Each task specifies prerequisites, outputs, and a bash script body. Missing prerequisites, missing outputs, and failed bash commands cause a task to fail. The next time ducttape is invoked it will try again.
 - Each task has its own output directory. The inputs and outputs use local variables, eliminating the need for long filenames or arbitrarily numbered arguments.
 - Tasks can be submitted as jobs to a [scheduler](tutorial3.html), with defined runtime requirements.

[Variants](tutorial2.html) on a workflow (e.g., for tuning parameters or running the same processing on multiple datasets) can be specified with __branch points__. These variants can be run side-by-side.

   * New branches or branch points can be introduced at any time.
   * The branch is specified in the directory hierarchy, so outputs are organized under the relevant branch.

With [version control integration](tutorial4.html), each experimental result remembers which version of the code produced it.

Open source and written in Scala, ducttape is free and runs on any machine with a Java VM.

<small>Side effects may include unexpected free time, increased productivity, and spontaneous happy dances.</small>

## Contents

* _[Installation](https://github.com/jhclark/ducttape/blob/master/README.md#quick-start)_
* [1. Simple Workflows: Tasks and Dependencies](tutorial1.html) **[draft]**
* [2. HyperWorkflows: Branching and Plans](tutorial2.html) **[draft]**
* [3. Submitters](tutorial3.html) [TODO. wait until syntax stabilizes?]
* [4. Versioning & Packages](tutorial4.html) [TODO]
* [5. Grab Bag](tutorial5.html) **[draft]**
* [6. Advanced Example](tutorial6.html) [TODO]
  - a preprocessing pipeline that can be run with different starting/ending points, in a scheduler?
* [7. Reference: Command Line Interface](tutorial7.html) [TODO]
* Maybe: a section on modifying workflows after they've been run, including use of `invalidate` and `mark_valid`. What kinds of changes can ducttape cope with? Which changes would screw things up?
  - OK: adding new tasks that are not ancestors of current tasks; adding new branches after existing ones; adding new branch points where the first branch reflects current behavior; adding/modifying/removing plans
  - Bad: renaming a task—it is treated as an entirely new task; removing branch points/branches that have been executed; changing whether an existing task is associated with an existing branch point
  - OK with `invalidate`: change the body of a task; change the inputs, outputs, or parameters of a task
      * if a realization is invalidated, are all realizations that depend on it invalidated as well?
  - ??: changing values for a task variable, with or without a branch point; inserting a task between two existing tasks in the dependency graph
  - modifying a workflow while it is running
* _[Syntax Highlighting Plugins](https://github.com/jhclark/ducttape/blob/master/README.md#emacs-mode)_
* _[Mailing Lists](https://github.com/jhclark/ducttape/blob/master/README.md#updates)_
* _[ducttape Development](https://github.com/jhclark/ducttape/blob/master/HACKING.md)_

Sections [1](tutorial1.html) and [2](tutorial2.html) present the core concepts and features of ducttape. Read these first after installing ducttape on your system. The remaining sections can be consulted independently; they are in no particular order.