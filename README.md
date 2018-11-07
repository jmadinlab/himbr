# Introduction to R and RStudio

### Installation instructions
 
1. Install R
 
If you don't have R you'll need to install it. If you have an older version of R you should upgrade it anyway.  If your version of R is 2.11.0 or older, you won't be able to use RStudio. Please upgrade if you are at all unsure.
 
To download R, go to https://cran.cnr.berkeley.edu and click on one of the first three links (download R for Linux, Mac or Windows) as appropriate. In the unlikely even that that doesn't work, then go through http://www.r-project.org/ and pick a different mirror.

- Direct links for Windows users: https://cran.cnr.berkeley.edu/bin/windows/base/
- And for Mac users: https://cran.cnr.berkeley.edu/bin/macosx/


2. RStudio needs to be installed after R
 
To install RStudio, go to: http://www.rstudio.com/

The direct link for downloads is here: https://www.rstudio.com/products/rstudio/download/
 
Install the `FREE` version (Remember: RStudio should be installed after R).
 
3. Check that it all works!

Open RStudio, which should be in your applications/programs directory.

4. If you have a trouble...

Email: jmadin@hawaii.edu

### Learning R can be frustrating

- Learning R is not necessarily hard, but not necessarily easy either. Different people will make the logical connections faster than others, and until it "clicks" it may seem like a battle.
- Ask questions as soon as you're unclear. It will help make those connections faster.
- It is a programming language
    - Don't think of it a statistical program that you use from a command line
    - Think of it as a programming language that happens to have a lot of statistical functions.
- It is easy to underestimate how precise instructions need to be. It will drive you mad.

### RStudio

RStudio is good for two reasons:

1. **It makes my life easier**: You are all using the same tools and so easier to solve problems.
2. **It will make your life easier**: It's got lots of features that help people, especially beginners.  It will help you organise your work, develop good workflows. On the other hand, it's not very intrusive and if you use a different interface (such as the plain R interface that you installed) it will feel very similar.

### Getting started with RStudio

Open R studio, however you do that on your platform.

RStudio has four panes:

1. **Bottom left**: This is the R interpreter.  If you type code here, it is "evaluated" so that you get an answer.
2. **Top left**: Editor for writing longer pieces of code.
3. **Top right**: Will tell you things about objects in the workspace. We'll get to this soon, but this will be things like data objects, or functions that will process them.  It is completely unrelated to the file system. The "History" tab will keep an eye on what you've done.
4. **Bottom right**: Will display files, plots, packages, and help information, usually as needed.

We'll do everything in a project, as that will help when we get some data.

- `File` -> `New Project...`
- Choose `New Directory`
- Choose `New Project`
- In the "Directory name" type the name for the project (in our case "intro" might be a good name).
- In the `Create project as a subdirectory of` field select (type or browse) for the parent directory of the project.  By default this is probably your home directory, but you might prefer your "Documents" folder or in a "Classes" folder.

The RStudio window morphs around a bit, and the top left pane will disappear.

In the bottom right panel, make sure that the "Files" tab is selected and make a new folder called `data`. We strongly recommend keeping a directory like this in every project that contains your data.  Treat it read only (that is, write once, then basically don't change).  This may be a large shift in thinking if you've come from doing data analysis and management in Excel.

In more complicated projects, I would generally have a folder called `R` that contains scripts and function definitions, another called `figs` that contained figures that I've generated, and one called `doc` that contains the manuscript, talks, etc.

Let's download a dataset:

- [https://raw.githubusercontent.com/himbr/intro/master/data/seed_root_herbivores.csv](https://raw.githubusercontent.com/himbr/intro/master/data/seed_root_herbivores.csv)

(You may need to right-click the above links and "Save linked file" or equivalent)

Put these into the `data` directory you created. This is best done using your computer's file system (e.g., Mac Finder, PC Windows Explorer). Go to the `intro/data` folder and move the data files in there. To find this folder from inside RStudio, click "More" and "Show folder in new window", you'll get a file browser window opening in about the right place.

To make sure everything is working properly, in the console window (**Bottom left**) in RStudio and type:

    file.exists("data/seed_root_herbivores.csv")

Which should print:

    [1] TRUE

