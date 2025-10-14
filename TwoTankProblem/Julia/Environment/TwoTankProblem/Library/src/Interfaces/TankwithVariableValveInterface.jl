using ModelingToolkit
using OrdinaryDiffEq
using ModelingToolkitStandardLibrary
using ModelingToolkit: t_nounits as t, D_nounits as D
using ModelingToolkitStandardLibrary.Blocks: RealInput, RealOutput

@mtkmodel TankwithVariableValveInterface begin
    @components begin
        q_in = RealInput()
        q_out = RealOutput()
        height_out= RealOutput()
        k=RealInput()
    end
end

