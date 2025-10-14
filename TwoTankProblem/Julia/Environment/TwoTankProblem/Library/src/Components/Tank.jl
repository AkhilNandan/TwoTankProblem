using ModelingToolkit
using OrdinaryDiffEq
using ModelingToolkit: t_nounits as t, D_nounits as D
using ..Interfaces: TankInterface
@mtkmodel Tank begin
    @extend TankInterface()
    @parameters begin
        Area = 10;
        DischargeCoefficient = 0.2;
        init_height = 10;
    end
    @variables begin 
        height(t)=init_height
    end

    @components begin
        static_valve=Valve(;k=DischargeCoefficient)
    end

    @equations begin
        Area*D(height) ~ (q_in.u-q_out.u)
        static_valve.height ~height
        height_out.u ~ height
        connect(static_valve.q_out,q_out)
    end
end

