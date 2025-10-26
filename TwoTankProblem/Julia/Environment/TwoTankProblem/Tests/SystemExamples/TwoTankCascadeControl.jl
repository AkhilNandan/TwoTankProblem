using ModelingToolkit
using OrdinaryDiffEq
using Plots
using ModelingToolkitStandardLibrary
using ModelingToolkitStandardLibrary.Blocks: LimPID,Constant,Add
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
        setpoint=Constant(name=:setpoint,k=10)
        unitConstant=Constant(name=:unitConstant,k=1)
        tank1 = Library.Components.Tank(; Area=4, DischargeCoefficient=0.8, init_height=0)
        tank11= Library.Components.TankwithVariableValve(; Area=4, init_height=0)
        outer_controller = LimPID(;k=10,Ti=150,Td=false,Ni=0.9,Nd=5,u_max=30,u_min=10,name=:outer_controller)
        inner_controller = LimPID(;k=1000,Ti=100,Td=1,Ni=0.9,Nd=5,u_max=3.5,u_min=0,name=:inner_controller)
        discharge_controller=LimPID(;k=100,Ti=10,Td=10,Ni=0.9,Nd=5,u_max=1,u_min=0,name=:discharge_controller)
        add_block=Add(k1=1,k2=-1)
    end
    @equations begin
        connect(setpoint.output,outer_controller.reference)
        connect(tank11.height_out,outer_controller.measurement)
        connect(outer_controller.ctr_output,inner_controller.reference)
        connect(inner_controller.measurement,tank1.height_out)
        connect(inner_controller.ctr_output,tank1.q_in)
        connect(tank1.q_out,tank11.q_in)
        connect(setpoint.output,discharge_controller.reference)
        connect(discharge_controller.measurement,tank11.height_out)
        connect(unitConstant.output,add_block.input1)
        connect(discharge_controller.ctr_output,add_block.input2)
        connect(add_block.output,tank11.k)
    end
end
@mtkcompile model = Test()
prob = ODEProblem(model, [], (0, 500))
sol = solve(prob)
plot(sol,idxs=[model.tank11.height])

