using ModelingToolkit
using OrdinaryDiffEq
using Plots
using ModelingToolkit: t_nounits as t, D_nounits as D
using ..Library.Components: Valve
@mtkmodel Test begin
    @components begin
        static_valve = Valve(; k=0.8)
    end
    @equations begin
        static_valve.height ~ 16
    end
end
@mtkcompile model = Test()
prob=ODEProblem(model,[],(0,10))
sol=solve(prob)