using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D
@mtkmodel lagmodel begin

    @parameters begin
        tau = 3.0
    end

    @variables begin
        x(t) = 0
        y(t) = 5   #No guess values are passed by the simulation mention explicitly
    end

    @equations begin
        tau * D(x) + x ~ 1
        tau * D(y) + x ~ 1 
    end
end
@mtkcompile model = lagmodel()
using OrdinaryDiffEq, Plots
prob = ODEProblem(model, [model.x => 10, model.tau => 5], (0, 10))
sol = solve(prob)
plot(sol, idxs=[model.y])

## Steps to write a modelling problem

# Declare the variables with init conditions, parameters 
# Write the dependant equations 
# Compile the model for index reduction, tearing and sorting
# Construct the ODE problem from the flattened code 
# Solve the ODE problem
# plot and see the dependent variables using named indexes