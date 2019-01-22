What I Missed at the 2019 RStudio Conference
================
Michelle Stuart
2019/01/22 (updated: 2019-01-22)

class: center, middle

The over arching theme was
--------------------------

"Reproducibility"
=================

<https://medium.com/@sean_50535/rstudio-conf-2019-the-theme-you-may-have-missed-a3e2993a8121>

??? This article discusses package management and how it can be difficult to reproduce an analysis is package versions have changed.

class: center, middle <!--- inverse makes the slide white text on black background --->

Leaflet!
========

class: center, inverse

Make your data more reproducible
================================

Make packages, even if they are only for yourself - great resources: <https://www.rstudio.com/resources/videos/you-can-make-a-package-in-20-minutes/>

Funny talk, relatable - <https://www.rstudio.com/resources/videos/five-packages-in-five-weeks-from-boredom-to-contribution-via-blogging/>

Hillary Parker's R package in 5 minutes - <https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/>

class: middle, inverse

Tired: Use absolute paths or setwd()
====================================

Wired: use here::here()
=======================

class: middle, inverse

Tired: “my tired wired notes.Rmd”
---------------------------------

Wired: “2019-01-15\_Notes-from-WTF-workshop.Rmd”
------------------------------------------------

(for file names: use IS0 8601 dates, separate fields by “\_”, separate words within fields by “-“)

class: middle, inverse

Tired: Use standard fonts in Rstudio
====================================

Wired: Use FiraCode (gives you the fancy assignment arrow)
==========================================================

??? supposed to be available in the global options but I don’t see it - remember to make your screen happy.

class: middle, inverse

Tired: Use traceback() + browser() for debugging
================================================

(\*not that tired, still a good way) \# Wired: Set options(error = recover) then jump around through the traceback with “s”

class: middle, inverse

Tired: Download R files from CRAN to look at source code
========================================================

Wired: Use @jimhester\_'s lookup package
========================================

??? - developer based

class: middle

Tired: Launch vanilla R as if you’re not an opinionated monster 🧟
=================================================================

Wired: Make R respect all your quirks via .Rprofile and .Renviron *and* track these files in GitHub for use on multiple machines
================================================================================================================================

class: middle, inverse

Tired: a new commit which should have been part of the previous commit
======================================================================

Wired: git commit --amend
=========================
