using ModelingToolkit
using OrdinaryDiffEq
using Plots
using ModelingToolkitStandardLibrary
using ModelingToolkitStandardLibrary.Blocks: LimPID,Constant
using ModelingToolkit: t_nounits as t, D_nounits as D
using Library
using Library.Components: Tank
@mtkmodel Test begin
    @parameters begin 
    k=100
    Ti=10
    Td=10
    Ni=0.9
    u_max=5
    u_min=0
    end
    @components begin
        setpoint=Constant(name=:setpoint,k=5)
        tank1 = Library.Components.Tank(; Area=4, DischargeCoefficient=0.8, init_height=0)
        tank11= Library.Components.Tank(; Area=4, DischargeCoefficient=0.8, init_height=0)
        controller = LimPID(;k=100,Ti=10,Td=10,Ni=0.9,Nd=5,u_max=5,u_min=0,name=:controller)
    end
    @equations begin
        connect(setpoint.output,controller.reference)
        connect(tank11.height_out,controller.measurement)
        connect(controller.ctr_output,tank1.q_in)
        connect(tank1.q_out,tank11.q_in)
    end
end
@mtkcompile model = Test()
prob = ODEProblem(model, [], (0, 500))
sol = solve(prob)
plot(sol,idxs=[model.tank11.height])

