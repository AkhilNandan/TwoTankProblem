within TwoTankProblem;

  model variableconstant
  parameter Real switch_time =50; 
  Modelica.Blocks.Interfaces.RealOutput qin annotation(
      Placement(transformation(origin = {120, -2}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, -2}, extent = {{-20, -20}, {20, 20}}))); 
  parameter Real Qoff;
  parameter Real Qon;
  equation
  qin=if time > switch_time then Qoff else Qon;
  end variableconstant;
