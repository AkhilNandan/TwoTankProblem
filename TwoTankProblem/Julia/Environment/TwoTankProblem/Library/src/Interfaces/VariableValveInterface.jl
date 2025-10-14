using ModelingToolkit
using OrdinaryDiffEq
using ModelingToolkitStandardLibrary
using ModelingToolkit: t_nounits as t, D_nounits as D
using ModelingToolkitStandardLibrary.Blocks: RealInput, RealOutput

@mtkmodel VariableValveInterface begin
    @components begin
        q_out = RealOutput()
    end
end



