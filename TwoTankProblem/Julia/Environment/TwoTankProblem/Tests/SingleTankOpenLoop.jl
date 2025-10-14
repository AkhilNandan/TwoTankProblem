using ModelingToolkit
using OrdinaryDiffEq
using Plots
using ModelingToolkit: t_nounits as t, D_nounits as D
using Library.Components: Tank
using Library
@mtkmodel Test begin
    @components begin
        tank1 = Library.Components.Tank(;Area=4, DischargeCoefficient=0.8,init_height=0)
    end
    @equations begin
        tank1.q_in.u ~ 2
    end
end
@mtkcompile model = Test()
prob=ODEProblem(model,[],(0,500))
sol=solve(prob)
plot(sol)