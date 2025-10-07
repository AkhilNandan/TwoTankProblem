using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D
value_vector=randn(10)
f_fun(t) = t >= 10 ? value_vector[end] : value_vector[Int(floor(t)) + 1]
@register_symbolic f_fun(t)

@mtkmodel lagmodelwithForceExplicit begin

    @parameters begin
        tau = 3.0
    end

    @variables begin
        x(t) = 0 # dependent variables and their initial condition
        f(t)     # should be a input
    end

    @equations begin
        f~ f_fun(t)
        tau * D(x) + x ~ f
    end
end

@mtkcompile model=lagmodelwithForceExplicit()
prob=ODEProblem(model,[],[0,20])
sol=solve(prob)
plot(sol,idxs=[model.x,model.f])    