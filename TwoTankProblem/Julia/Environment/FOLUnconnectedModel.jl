using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D


@mtkmodel FOLUnconnectedModel begin
    @variables begin 
        f(t)
        x(t)=0
    end
    @parameters begin
        tau = 3
    end    
    @equations begin
        tau*D(x)+x ~ f
    end
end
