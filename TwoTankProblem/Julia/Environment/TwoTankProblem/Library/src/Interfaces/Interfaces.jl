module Interfaces
using ModelingToolkit
include("RealInput.jl") 
include("RealOutput.jl") 
include("TankInterface.jl")
include("ValveInterface.jl")
include("VariableValveInterface.jl")  
export RealInput,RealOutput,TankInterface,ValveInterface,VariableValveInterface
end

