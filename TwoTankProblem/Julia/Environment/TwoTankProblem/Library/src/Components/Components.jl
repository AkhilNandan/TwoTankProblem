module Components
using ModelingToolkit
using ..Interfaces
include("Tank.jl")    
include("Valve.jl")
include("TankwithVariableValve.jl")
include("VariableValve.jl")
export Tank,Valve,TankwithVariableValve,VariableValve

end
