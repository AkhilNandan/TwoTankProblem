using ModelingToolkit
using OrdinaryDiffEq
using ModelingToolkit: t_nounits as t, D_nounits as D

@mtkmodel TankInterface begin
    @components begin
        q_in = RealInput()
        q_out = RealOutput()
        height_out= RealOutput()
    end
end
