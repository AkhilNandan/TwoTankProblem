using ModelingToolkit
using OrdinaryDiffEq
using ModelingToolkit: t_nounits as t, D_nounits as D
using ..Interfaces:ValveInterface
@mtkmodel Valve begin
    @extend ValveInterface()
    @parameters begin
        k = 0.7
    end
    @variables begin
        height(t),[input=true] #Initial height of tank
    end
    
    @equations begin
        q_out.value~ k*sqrt(height)
    end
end

