using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D
@connector RealInput begin
 value(t), [input=true]
end