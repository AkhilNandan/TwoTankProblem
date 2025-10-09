using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D
@connector RealOutput begin
 value(t), [output=true]
end
