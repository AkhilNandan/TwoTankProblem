using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D
@mtkmodel lagmodelwithForce begin

    @parameters begin
        tau = 3.0
    end

    @variables begin
        x(t) = 0 # dependent variables and their initial condition
        y(t)     # should be a input
    end

    @equations begin
        y ~ sin(t)
        tau * D(x) + x ~ y
    end
end
@mtkcompile model = lagmodelwithForce()
using OrdinaryDiffEq, Plots
prob = ODEProblem(model, [], (0, 100))
sol = solve(prob)
plot(sol, idxs=[model.x])

# Steps to write a modelling problem

# Declare the variables with init conditions, parameters 
# Write the dependant equations 
# Compile the model for index reduction, tearing and sorting
# Construct the ODE problem from the flattened code 
# Solve the ODE problem
# plot and see the dependent variables using named indexes