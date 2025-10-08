within TwoTankProblem;

model SingleTankOpenLoop
  Tank tank1(Area = 4, DischargeCoefficient = 0.8, init_height = 0) annotation(
    Placement(transformation(origin = {-28, 0}, extent = {{-24, -24}, {24, 24}})));
  Modelica.Blocks.Sources.Constant inflow(k = 2) annotation(
    Placement(transformation(origin = {-90, 0}, extent = {{-14, -14}, {14, 14}})));
equation
  connect(inflow.y, tank1.qin) annotation(
    Line(points = {{-75, 0}, {-57, 0}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 2),
Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}),
  Documentation(info = "<html><head></head><body>This example shows the open loop model of connected two tank problem. This model can be used to understand the individual dynamics, coupling and in a way understand the time constants of individual tank models. The outflow, height of the second tank is unidirectionally dependant on the outflow of tank1 hence tank 2 is always expected to be lagging behind tank1 dynamics.&nbsp;<br><br><br><b>At Steady state:&nbsp;
</b><p>(K<sub>1</sub>/K<sub>2</sub>)<sup>2</sup> = (H<sub>2</sub>/H<sub>1</sub>)</p><p>&nbsp;Q<sub>1</sub> = Q<sub>2</sub></p><br><p></p><div><br><div><br></div><div><br><div><br></div><div><br></div></div></div></body></html>"));
end SingleTankOpenLoop;