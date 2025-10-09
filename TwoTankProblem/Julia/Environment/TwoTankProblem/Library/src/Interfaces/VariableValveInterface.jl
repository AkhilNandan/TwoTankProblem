using ModelingToolkit
using OrdinaryDiffEq
using ModelingToolkit: t_nounits as t, D_nounits as D

@mtkmodel VariableValveInterface begin
    @components begin
        q_out = RealOutput()
    end
end



