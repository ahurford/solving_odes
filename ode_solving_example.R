require(deSolve) # for solving the ODE
require(ggplot2) # for producing quality plots
require(dplyr) # for manipulating data easily
require(patchwork) # for arranging plots

# Consider the package vignette:
# https://cran.r-project.org/web/packages/deSolve/vignettes/deSolve.pdf

# I will show how I solve the first system of equations dX/dt, dY/dt, dZ/dt.

# Parameters
# (these need to be assigned using <- not = because they need to be read
# into the lorenz function)
a <- -8/3
b <- -10
c <- 28

# Initial conditions
X0 = 1
Y0 = 1
Z0 = 1

# This is a vector of the values of time that you want solutions for:
times = seq(0, 100, by = 0.01)

# Model
lorenz<-function(t,y,parms){
  # y is a vector of your dependent variables, but it is nice if they
  # have symbols the same as how you wrote your model. This will help
  # you minimize errors in writing down the model equations.
  X = y[1]
  Y = y[2]
  Z = y[3]
  # If you don't have 3 dependent variables you are going to need to modify
  # the above.
  
  # The parameters are read in because they have global scope due to the <-
  dX = a*X + Y*Z
  dY = b*(Y-Z)
  dZ = -X*Y + c*Y - Z
  
  # the ode() function wants your rates of change returned as a list (after you
  # first make them a vector)
  
  # you need to keep the order the variables consistent.
  return(list(c(dX,dY,dZ)))
}

# Now we have defined all the quantities needed to run the ode() function
# which will return the values of X(t), Y(t), and Z(t) which is what we want
# to know.
out = ode(y = c(X0,Y0,Z0), times = times, func = lorenz, parms = NULL)
# This output is not a dataframe and I am much better at plotting from
# data.frames so I change it over to make plots.
out = data.frame(out)

# The names of the variables are X1, X2, and X3 so lets use the dplyr function
# rename to change them to better names

out = rename(out, X = X1, Y = X2, Z = X3)

# We might as well use ggplot2 for the plotting because base R plot() doesn't
# produce publication standard figures.

g1=ggplot(data=out, aes(x=time))+
  geom_line(aes(y=X), linewidth =0.05)

g2=ggplot(data=out, aes(x=time))+
  geom_line(aes(y=Y), linewidth = 0.05)

g3=ggplot(data=out, aes(x=time))+
  geom_line(aes(y=Z), linewidth = 0.05)

g4=ggplot(data=out, aes(x=X))+
  geom_point(aes(y=Z), size = 0.005)

# joining the plots together 
g5 = g1+g2+g3+g4

# This is good practice to export your graphs. Helps with sizing in
# reports and publications
ggsave("~/Desktop/figure.png", width = 10, height = 8, units = "cm")
