# solving_odes

The accompanying R script is how I solve ordinary differential equations. I am not very familar with the `with` function, so I define the parameters with global scope using `->` rather than `=`. My hope is that the .R serves as template for solving other systems of ordinary differential equations.

A common error when trying to solve a different system of ordinary differential equations relates to changes that need to be made for a different number of independent variables. Going from an SI model to an SIR model introduces one more independent variable, which means that 3 initial conditions need to be specified rather than 2.
