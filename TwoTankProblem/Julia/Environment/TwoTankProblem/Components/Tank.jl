using ModelingToolkit
using OrdinaryDiffEq
using ModelingToolkit: t_nounits as t, D_nounits as D

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
        Area*D(height) ~ (q_in.value-q_out.value)
        static_valve.height ~height
        height_out.value ~ height
        connect(static_valve.q_out,q_out)
    end
end

