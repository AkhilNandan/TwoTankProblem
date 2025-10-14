using ModelingToolkit
using OrdinaryDiffEq
using ModelingToolkit: t_nounits as t, D_nounits as D
using ..Interfaces:VariableValveInterface
@mtkmodel VariableValve begin
    @extend VariableValveInterface()
    @variables begin
        height(t),[input=true] #Initial height of tank
    end    
    @equations begin
        q_out.u~ (k.u)*sqrt(height)
    end
end
