module Interfaces
using ModelingToolkit
include("TankInterface.jl")
include("ValveInterface.jl")
include("VariableValveInterface.jl")  
include("TankwithVariableValveInterface.jl")
export TankInterface,ValveInterface,VariableValveInterface
end

