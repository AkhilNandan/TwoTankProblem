within TwoTankProblem;

model SingleTankControl
  Tank tank1(Area = 4, DischargeCoefficient = 0.7, init_height = 0) annotation(
    Placement(transformation(origin = {72, 48}, extent = {{-24, -24}, {24, 24}})));
  Modelica.Blocks.Sources.Constant setpoint(k = 4) annotation(
    Placement(transformation(origin = {-86, 48}, extent = {{-14, -14}, {14, 14}})));
  Modelica.Blocks.Continuous.LimPID Control(k = 1, Ti = 13.2, yMax = 5, yMin = 0, controllerType = Modelica.Blocks.Types.SimpleController.PI) annotation(
    Placement(transformation(origin = {-32, 48}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(Control.y, tank1.qin) annotation(
    Line(points = {{-21, 48}, {43, 48}}, color = {0, 0, 127}));
  connect(setpoint.y, Control.u_s) annotation(
    Line(points = {{-71, 48}, {-44, 48}}, color = {0, 0, 127}));
  connect(Control.u_m, tank1.out_height) annotation(
    Line(points = {{-32, 36}, {-32, 0}, {101, 0}, {101, 37}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 600, Tolerance = 1e-06, Interval = 1.2),
Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}),
  Documentation(info = "<html><head></head><body>This example shows how a PID controller can be employed for level control of a single tank. This example helps in understanding and build up for the next coupled tank analysis.&nbsp;</body></html>"));
end SingleTankControl;