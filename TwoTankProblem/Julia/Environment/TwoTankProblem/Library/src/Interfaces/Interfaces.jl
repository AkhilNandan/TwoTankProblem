module Interfaces
using ModelingToolkit
include("TankInterface.jl")
include("ValveInterface.jl")
include("VariableValveInterface.jl")  
export TankInterface,ValveInterface,VariableValveInterface
end

