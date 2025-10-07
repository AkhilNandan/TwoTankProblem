within TwoTankProblem;

model TwoTankParallelControlWithK2PIDControl
  Tank tank1(Area = 4, DischargeCoefficient = 0.8, init_height = 0) annotation(
    Placement(transformation(origin = {8, 28}, extent = {{-24, -24}, {24, 24}})));
  Modelica.Blocks.Continuous.LimPID PID(Ti = 100, yMax = 3.5, yMin = 0, k = 1000, controllerType = Modelica.Blocks.Types.SimpleController.PID, Td = 1, Nd = 5) annotation(
    Placement(transformation(origin = {-80, 28}, extent = {{-10, -10}, {10, 10}})));
  TankWithVariableValve Tank11(Area = 4, init_height = 0) annotation(
    Placement(transformation(origin = {168, 28}, extent = {{-22, -22}, {22, 22}})));
  Modelica.Blocks.Continuous.LimPID PID1(Nd = 5, Td = 10, Ti = 10, controllerType = Modelica.Blocks.Types.SimpleController.PID, k = 100, yMax = 1, yMin = 0) annotation(
    Placement(transformation(origin = {-80, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant setpoint(k = 10) annotation(
    Placement(transformation(origin = {-258, 10}, extent = {{-14, -14}, {14, 14}})));
  Modelica.Blocks.Continuous.LimPID PID2(Nd = 5, Td = 10, Ti = 150, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 10, yMax = 30, yMin = 10) annotation(
    Placement(transformation(origin = {-196, 28}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add(k1 = 1, k2 = -1) annotation(
    Placement(transformation(origin = {8, -46}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant const(k = 1) annotation(
    Placement(transformation(origin = {-44, -28}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(tank1.qout, Tank11.qin) annotation(
    Line(points = {{36.8, 27.52}, {88.3, 27.52}, {88.3, 28}, {142, 28}}, color = {0, 0, 127}));
  connect(PID.y, tank1.qin) annotation(
    Line(points = {{-69, 28}, {-22, 28}}, color = {0, 0, 127}));
  connect(PID1.u_m, Tank11.heightOut) annotation(
    Line(points = {{-80, -62}, {-80, -70}, {216, -70}, {216, 18}, {194, 18}}, color = {0, 0, 127}));
  connect(PID2.y, PID.u_s) annotation(
    Line(points = {{-185, 28}, {-92, 28}}, color = {0, 0, 127}));
  connect(PID2.u_m, Tank11.heightOut) annotation(
    Line(points = {{-196, 16}, {-196, -10}, {214, -10}, {214, 18}, {194, 18}}, color = {0, 0, 127}));
  connect(setpoint.y, PID2.u_s) annotation(
    Line(points = {{-243, 10}, {-226.6, 10}, {-226.6, 28}, {-208.6, 28}}, color = {0, 0, 127}));
  connect(PID1.u_s, setpoint.y) annotation(
    Line(points = {{-92, -50}, {-226, -50}, {-226, 10}, {-243, 10}}, color = {0, 0, 127}));
  connect(PID1.y, add.u2) annotation(
    Line(points = {{-69, -50}, {-37, -50}, {-37, -52}, {-5, -52}}, color = {0, 0, 127}));
  connect(const.y, add.u1) annotation(
    Line(points = {{-33, -28}, {-17, -28}, {-17, -40}, {-5, -40}}, color = {0, 0, 127}));
  connect(add.y, Tank11.k_control) annotation(
    Line(points = {{19, -46}, {117, -46}, {117, 16}, {133, 16}, {133, 19}, {142, 19}}, color = {0, 0, 127}));
connect(PID.u_m, tank1.out_height) annotation(
    Line(points = {{-80, 16}, {-80, -2}, {56, -2}, {56, 16}, {36, 16}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 600, Tolerance = 1e-06, Interval = 1.2),
    Diagram,
Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}),
  Documentation(info = "<html><head></head><body>In this example, an additional control is present on the level control of Tank 11. This is really good, since the manipulated variable is the discharge coefficient and it directly affects the outflow of liquid in Tank 11. The assumptions and limtations listed in&nbsp;TwoTankProblemNew.TwoTankCascadeControl also applies here. Here along with the cascaded control, another parallel control is also employed in Tank11's outflow.<br><div><br></div><div><b>Expectation:</b></div><div><b><br></b></div><div>- Robust performance thatn in&nbsp;TwoTankProblemNew.TwoTankCascadeControl</div></body></html>"));
end TwoTankParallelControlWithK2PIDControl;