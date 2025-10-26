#=
This example is to learn more about the dynamics of the connected two-tank system. 
Assumptions: Max height of tank is 40m, Aread is 1 sqm, and maximum flow rate at input is 0.625  metrecubes/s
Above assumptions are based on the time for filling tanks (300s to 60s)
=#
using ModelingToolkit
using OrdinaryDiffEq
using Plots
using ModelingToolkitStandardLibrary
using ModelingToolkitStandardLibrary.Blocks: LimPID, Constant, Gain, Add, RealOutput
using ModelingToolkit: t_nounits as t, D_nounits as D
using Library
using Library.Components: Tank,TankwithVariableValve
using ControlSystemsBase
using LinearAlgebra
@mtkmodel Test begin
    @parameters begin
        k = 2
        Ti = 13.2
        Td = false
        Ni = 0.9
        u_max = 5
        u_min = 0
        init_height_tank1 = 2
        init_height_tank11 =0
        setpoint_value = 2
    end
    @components begin
        setpoint = Constant(; name=:setpoint, k=setpoint_value)
        discharge_setting=Constant(k=1,name=:discharge_setting)
        tank1 = Tank(; Area=1, DischargeCoefficient=1, init_height=init_height_tank1)
        tank11= TankwithVariableValve(; Area=1, DischargeCoefficient=1, init_height=init_height_tank11)
        outpoint = RealOutput()
    end
    @equations begin
        connect(setpoint.output, :plant_input, tank1.q_in)
        connect(tank1.q_out,tank11.q_in) 
        connect(tank11.height_out, :plant_output, outpoint)
        connect(tank11.k,discharge_setting.output)
    end
end
# Simple sweep on setpoints and initial heights to check the worst transfer function
setpoints = [0.125, 0.250, 0.500, 0.625]
initheights= [12, 14, 16, 18]
m = Vector{Any}(undef, 4)
margins=Vector{Any}(undef, 4)
transfer_functions=Vector{Any}(undef, 4)
poles_system=Vector{Any}(undef, 4)
solutions= Vector{Any}(undef, 4) 

for i in 1:4
    @mtkcompile model = Test(setpoint_value=setpoints[i], init_height_tank11=initheights[i],init_height_tank1=initheights[i])
    prob = ODEProblem(model, [], (0, 50))
    sol = solve(prob)
    solutions[i]=sol
    # Linearization
    @named non_linear_model = Test(init_height_tank11=sol[model.tank11.height][end], setpoint_value=setpoints[1])
    matrices_S = linearize(non_linear_model, :plant_input, :plant_output)[1]
    As = matrices_S[1]
    Bs = matrices_S[2]
    Cs = matrices_S[3]
    Ds = matrices_S[4]
    state_space=ss(As,Bs,Cs,Ds)
    transfer_function=tf(state_space)
    transfer_functions[i]=transfer_function
    margins[i]=margin(transfer_function)
    poles_system[i]=poles(transfer_function)
end
