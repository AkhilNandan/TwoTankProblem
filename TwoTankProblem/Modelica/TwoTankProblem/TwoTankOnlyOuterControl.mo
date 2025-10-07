within TwoTankProblem;

model TwoTankOnlyOuterControl
  Tank tank1(Area = 4, DischargeCoefficient = 0.8, init_height = 0) annotation(
    Placement(transformation(origin = {-16, 0}, extent = {{-24, -24}, {24, 24}})));
  Modelica.Blocks.Sources.Constant setpoint(k = 5) annotation(
    Placement(transformation(origin = {-114, 0}, extent = {{-14, -14}, {14, 14}})));
  Tank tank11(Area = 4, DischargeCoefficient = 0.8, init_height = 0) annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-24, -24}, {24, 24}})));
  Modelica.Blocks.Continuous.LimPID PID(Ti = 10, yMax = 5, yMin = 0, k = 100, controllerType = Modelica.Blocks.Types.SimpleController.PID, Td = 10, Nd = 5) annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(tank1.qout, tank11.qin) annotation(
    Line(points = {{13, 0}, {41, 0}}, color = {0, 0, 127}));
  connect(setpoint.y, PID.u_s) annotation(
    Line(points = {{-99, 0}, {-82, 0}}, color = {0, 0, 127}));
  connect(PID.u_m, tank11.out_height) annotation(
    Line(points = {{-70, -12}, {-70, -42}, {132, -42}, {132, -11}, {99, -11}}, color = {0, 0, 127}));
  connect(PID.y, tank1.qin) annotation(
    Line(points = {{-59, 0}, {-45, 0}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 2),
Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}),
  Documentation(info = "<html><head></head><body>This example demonstrates how a single PID controller is used to adjust the level of tank 2 by regulating the input flow of tank 1.&nbsp;<br><br><b>Expectation</b>:&nbsp;<br><br>- No direct control is applied on the outflow or level control of height in tank 1 apart from input flow, hence expecting it to have overflow and underflow situations while level controlling in Tank 2.&nbsp;<div><br></div><div>- Since no control is applied on Tank 1, the level control in tank 2 is expected to be sluggish.</div><div><br></div><div><b>Observation:</b></div><div><b><br></b><div><br></div></div></body></html>"));
end TwoTankOnlyOuterControl;