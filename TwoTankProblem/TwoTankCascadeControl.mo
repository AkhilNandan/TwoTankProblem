within TwoTankProblem;

model TwoTankCascadeControl
  Tank tank1(Area = 4, DischargeCoefficient = 0.8, init_height = 25) annotation(
    Placement(transformation(origin = {6, 16}, extent = {{-24, -24}, {24, 24}})));
  Modelica.Blocks.Sources.Constant setpoint(k = 5) annotation(
    Placement(transformation(origin = {-202, 14}, extent = {{-14, -14}, {14, 14}})));
  Modelica.Blocks.Continuous.LimPID PID(Ti = 100, yMax = 30, yMin = 10, k = 100, controllerType = Modelica.Blocks.Types.SimpleController.PI, Td = 10, Nd = 5) annotation(
    Placement(transformation(origin = {-144, 14}, extent = {{-10, -10}, {10, 10}})));
  TankWithVariableValve Tank11(Area = 4, init_height = 25) annotation(
    Placement(transformation(origin = {166, 16}, extent = {{-22, -22}, {22, 22}})));
  Modelica.Blocks.Continuous.LimPID PID1(Nd = 5, Td = 10, Ti = 100, controllerType = Modelica.Blocks.Types.SimpleController.PID, k = 100, yMax = 4, yMin = 0) annotation(
    Placement(transformation(origin = {-64, 14}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant setpoint1(k = 0.8) annotation(
    Placement(transformation(origin = {96, 6}, extent = {{-14, -14}, {14, 14}})));
equation
  connect(tank1.qout, Tank11.qin) annotation(
    Line(points = {{34.8, 15.52}, {139.8, 15.52}}, color = {0, 0, 127}));
  connect(PID1.y, tank1.qin) annotation(
    Line(points = {{-53, 14}, {-22, 14}, {-22, 16}, {-24, 16}}, color = {0, 0, 127}));
  connect(PID1.u_m, tank1.out_height) annotation(
    Line(points = {{-64, 2}, {-64, -30}, {46, -30}, {46, 5}, {35, 5}}, color = {0, 0, 127}));
  connect(setpoint.y, PID.u_s) annotation(
    Line(points = {{-187, 14}, {-156, 14}}, color = {0, 0, 127}));
  connect(PID.u_m, Tank11.heightOut) annotation(
    Line(points = {{-144, 2}, {-144, -56}, {214, -56}, {214, 6}, {192, 6}}, color = {0, 0, 127}));
  connect(PID.y, PID1.u_s) annotation(
    Line(points = {{-133, 14}, {-76, 14}}, color = {0, 0, 127}));
  connect(setpoint1.y, Tank11.k_control) annotation(
    Line(points = {{111, 6}, {139.4, 6}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 600, Tolerance = 1e-06, Interval = 1.2),
Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}),
  Documentation(info = "<html><head></head><body>In&nbsp;TwoTankProblemNew.TwoTankOnlyOuterControl we have seen that only outer controller for level control is not sufficient since it fail against underflow and overflow situations. In this example, we are trying to see if we can employ a cascaded control, where the outer controller for tank 2 level control produces a setpoint for tank 1 level control.<br><br><b>Expectation:</b><div><b><br></b></div><div>- Control coordination in both the tank levels. Tank 2 outflow or level is heavily dependant on Tank 1 water level, hence it is required to employ control on both. Also Tank 1 dynamics is faster than Tank 2 due to unidirectional coupling.&nbsp;</div><div>- Quicker the level control in Tank 1, we can expect a smooth control of level control in Tank 2 and Tank 2 correction requirement mostly act as a disturbance to the Tank 1, and employing a inner controller will help to cancel out effectively.<br><br>Note: The tuning of controllers needs to be &nbsp;done separately which is not performed here.</div><div><br></div><div><b>Assumptions and Limits considered in SI units.&nbsp;</b></div><div><b><br></b></div><div>- Tank 1 and Tank 11 share the same geometry.&nbsp;</div><div>- The initial water levels in the tank can be parameterized.</div><div>- Controller tuning is not performed, but outer controller is PI and inner controller is PID owing to the slower and faster dynamics.&nbsp;</div><div>- Maximum input flow limit in tank 1 is considered to be 5 units. This is performed using steady state analysis.</div><div>- Tank level is having maximum and minimum limits between 30 and 10 units &nbsp;to avoid underflow and overflow.&nbsp;</div><div><br></div><div>&nbsp;</div><div><br></div></body></html>"));
end TwoTankCascadeControl;