using ModelingToolkitStandardLibrary.Blocks, ModelingToolkit

@named P = FirstOrder(k = 1, T = 1) # A first-order system with pole in -1
@named C = Gain(-1)             # A P controller
#t = ModelingToolkit.get_iv(P)
eqs = [connect(P.output, :plant_output, C.input)  # Connect with an automatically created analysis point called :plant_output
       connect(C.output, :plant_input, P.input)]
sys = System(eqs, t, systems = [P, C], name = :feedback_system)

matrices_S = get_sensitivity(sys, :plant_input)[1] # Compute the matrices of a state-space representation of the (input)sensitivity function.
matrices_T = get_comp_sensitivity(sys, :plant_input)[1]