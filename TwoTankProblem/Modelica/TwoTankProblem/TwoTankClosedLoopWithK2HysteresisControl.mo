within TwoTankProblem;

model TwoTankClosedLoopWithK2HysteresisControl
  Tank tank1(Area = 4, DischargeCoefficient = 0.7, init_height = 0) annotation(
    Placement(transformation(origin = {8, 28}, extent = {{-24, -24}, {24, 24}})));
  Modelica.Blocks.Continuous.LimPID PID(Ti = 100, yMax = 4, yMin = 0, k = 1000, controllerType = Modelica.Blocks.Types.SimpleController.PID, Td = 1, Nd = 5) annotation(
    Placement(transformation(origin = {-80, 28}, extent = {{-10, -10}, {10, 10}})));
  TankWithVariableValve Tank11(Area = 4, init_height = 0) annotation(
    Placement(transformation(origin = {164, 30}, extent = {{-22, -22}, {22, 22}})));
  Modelica.Blocks.Continuous.LimPID PID1(Nd = 5, Td = 10, Ti = 150, controllerType = Modelica.Blocks.Types.SimpleController.PID, k = 10, yMax = 30, yMin = 5) annotation(
    Placement(transformation(origin = {-92, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant inflow1(k = 25) annotation(
    Placement(transformation(origin = {-258, 10}, extent = {{-14, -14}, {14, 14}})));
  Modelica.Blocks.Continuous.LimPID PID2(Nd = 5, Td = 10, Ti = 150, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 10, yMax = 30, yMin = 5) annotation(
    Placement(transformation(origin = {-196, 28}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(pre_y_start = false, uHigh = 1, uLow = -1) annotation(
    Placement(transformation(origin = {6, -38}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
    Placement(transformation(origin = {96, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.MathBoolean.Not not1 annotation(
    Placement(transformation(origin = {48, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add(k1 = 1, k2 = -1) annotation(
    Placement(transformation(origin = {-40, -40}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(tank1.qout, Tank11.qin) annotation(
    Line(points = {{36.8, 27.52}, {88.3, 27.52}, {88.3, 30}, {138, 30}}, color = {0, 0, 127}));
  connect(PID.y, tank1.qin) annotation(
    Line(points = {{-69, 28}, {-22, 28}}, color = {0, 0, 127}));
  connect(PID1.u_m, Tank11.heightOut) annotation(
    Line(points = {{-92, -52}, {-92, -70}, {216, -70}, {216, 20}, {190, 20}}, color = {0, 0, 127}));
  connect(PID2.y, PID.u_s) annotation(
    Line(points = {{-185, 28}, {-92, 28}}, color = {0, 0, 127}));
  connect(PID2.u_m, Tank11.heightOut) annotation(
    Line(points = {{-196, 16}, {-196, -10}, {214, -10}, {214, 20}, {190, 20}}, color = {0, 0, 127}));
  connect(inflow1.y, PID2.u_s) annotation(
    Line(points = {{-243, 10}, {-226.6, 10}, {-226.6, 28}, {-208.6, 28}}, color = {0, 0, 127}));
  connect(PID1.u_s, inflow1.y) annotation(
    Line(points = {{-104, -40}, {-226, -40}, {-226, 10}, {-243, 10}}, color = {0, 0, 127}));
  connect(tank1.out_height, PID.u_m) annotation(
    Line(points = {{36.8, 16.96}, {56.8, 16.96}, {56.8, -1.04}, {-79.2, -1.04}, {-79.2, 16.96}}, color = {0, 0, 127}));
  connect(hysteresis.y, not1.u) annotation(
    Line(points = {{17, -38}, {25, -38}, {25, -40}, {33, -40}}, color = {255, 0, 255}));
  connect(not1.y, booleanToReal.u) annotation(
    Line(points = {{60, -40}, {84, -40}}, color = {255, 0, 255}));
  connect(booleanToReal.y, Tank11.k_control) annotation(
    Line(points = {{108, -40}, {120, -40}, {120, 21}, {138, 21}}, color = {0, 0, 127}));
  connect(PID1.y, add.u1) annotation(
    Line(points = {{-80, -40}, {-66, -40}, {-66, -34}, {-52, -34}}, color = {0, 0, 127}));
  connect(add.y, hysteresis.u) annotation(
    Line(points = {{-28, -40}, {-17, -40}, {-17, -38}, {-6, -38}}, color = {0, 0, 127}));
  connect(add.u2, Tank11.heightOut) annotation(
    Line(points = {{-52, -46}, {-66, -46}, {-66, -66}, {226, -66}, {226, 20}, {190, 20}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 600, Tolerance = 1e-06, Interval = 1.2),
Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}));
end TwoTankClosedLoopWithK2HysteresisControl;