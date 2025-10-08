using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D
include("FOLUnconnectedModel.jl")
@mtkmodel CoupledModel begin
    @components begin
           fol1 =UnconnectedModel(; x=0, tau=3)
           fol2 =UnconnectedModel(; x=0, tau=5)
    end

    @equations begin
        fol1.f ~ 1.5
        fol2.f ~ fol1.x
    end
end

using OrdinaryDiffEq
@mtkcompile model = CoupledModel()
prob=ODEProblem(model,[],(0,100))
sol=solve(prob)

using Plots
plot(sol,idx=[model.fol1.x,model.fol2.x])