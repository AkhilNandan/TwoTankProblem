using ModelingToolkit
using OrdinaryDiffEq
using Plots
using ModelingToolkit: t_nounits as t, D_nounits as D
using Library
using Library.Components: Tank
@mtkmodel Test begin
    @components begin
        tank1 = Tank(;Area=4, DischargeCoefficient=0.8,init_height=0)
        tank2 = Tank(;Area=4, DischargeCoefficient=0.8,init_height=0)
    end
    @equations begin
        tank1.q_in.value ~ 2
        connect(tank1.q_out,tank2.q_in)
    end
end
@mtkcompile model = Test()
prob=ODEProblem(model,[],(0,500))
sol=solve(prob)
plot(sol)