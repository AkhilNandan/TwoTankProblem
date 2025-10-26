using ModelingToolkit
using OrdinaryDiffEq
using Plots
using ModelingToolkitStandardLibrary
using ModelingToolkitStandardLibrary.Blocks: LimPID, Constant, Gain, Add, RealOutput
using ModelingToolkit: t_nounits as t, D_nounits as D
using Library
using Library.Components: Tank
using ControlSystemsBase
@mtkmodel Test begin
    @parameters begin
        k = 2
        Ti = 13.2
        Td = false
        Ni = 0.9
        u_max = 5
        u_min = 0
        init_height = 4
        setpoint_value = 2
    end
    @components begin
        setpoint = Constant(; name=:setpoint, k=setpoint_value)
        tank1 = Tank(; Area=1, DischargeCoefficient=1, init_height=init_height)
        outpoint = RealOutput()
    end
    @equations begin
        connect(setpoint.output, :plant_input, tank1.q_in)
        connect(tank1.height_out, :plant_output, outpoint)
    end
end
setpoints = [0.5, 1, 2, 2.5]
initheights = [2, 4, 6, 8]
m = Vector{Any}(undef, 4)
for i in 1:4
    @mtkcompile model = Test(setpoint_value=setpoints[i], init_height=initheights[i])
    prob = ODEProblem(model, [], (0, 500))
    sol = solve(prob)
    # Linearization
    @named non_linear_model = Test(init_height=sol[model.tank1.height][end], setpoint_value=setpoints[i])
    matrices_S = linearize(non_linear_model, :plant_input, :plant_output)[1]
    As = matrices_S[1]
    Bs = matrices_S[2]
    Cs = matrices_S[3]
    Ds = matrices_S[4]
    state_space=ss(As,Bs,Cs,Ds)
    transfer_function=tf(state_space)
    m[i]=transfer_function
end

