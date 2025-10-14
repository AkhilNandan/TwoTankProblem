using ModelingToolkit
using OrdinaryDiffEq
using ModelingToolkit: t_nounits as t, D_nounits as D
using ..Interfaces: TankwithVariableValveInterface
@mtkmodel TankwithVariableValve begin
    @extend TankwithVariableValveInterface()
    @parameters begin
        Area = 10;
        DischargeCoefficient = 0.2;
        init_height = 10;
    end
    @variables begin 
        height(t)=init_height
    end

    @components begin
        dynamic_valve=VariableValve()
    end

    @equations begin
        Area*D(height) ~ (q_in.u-q_out.u)
        dynamic_valve.height ~height
        height_out.u ~ height
        connect(dynamic_valve.q_out,q_out)
        connect(k,dynamic_valve.k)
    end
end

