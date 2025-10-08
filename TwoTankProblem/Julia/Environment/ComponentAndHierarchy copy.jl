using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D


@mtkmodel FOLUnconnectedFunction begin
    @parameters begin
        τ # parameters
    end
    @variables begin
        x(t) # dependent variables
        f(t)
        RHS(t)
    end
    @equations begin
        RHS ~ f
        D(x) ~ (RHS - x) / τ
    end
end
@mtkmodel FOLConnected begin
    @components begin
        fol_1 = FOLUnconnectedFunction(; τ = 2.0, x = -0.5)
        fol_2 = FOLUnconnectedFunction(; τ = 4.0, x = 1.0)
    end
    @equations begin
        fol_1.f ~ 1.5
        fol_2.f ~ fol_1.x
    end
end
@mtkcompile connected = FOLConnected()