package TwoTankProblem
  model Tank
    Modelica.Blocks.Interfaces.RealOutput qout annotation(
      Placement(transformation(origin = {120, -2}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, -2}, extent = {{-20, -20}, {20, 20}})));
    Modelica.Blocks.Interfaces.RealOutput out_height annotation(
      Placement(transformation(origin = {120, -46}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, -46}, extent = {{-20, -20}, {20, 20}})));
    parameter Real Area = 10;
    parameter Real DischargeCoefficient = 0.2;
    parameter Real init_height = 10;
    Real height;
    Modelica.Blocks.Interfaces.RealInput qin annotation(
      Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
    Valve valve(k = DischargeCoefficient) annotation(
      Placement(transformation(origin = {55, -3}, extent = {{-13, -13}, {13, 13}})));
  initial equation
    height = init_height;
  equation
    Area*der(height) = qin - qout;
    height = valve.height;
    height = out_height;
    connect(valve.massFlow, qout) annotation(
      Line(points = {{71, -3}, {68, -3}, {68, -2}, {120, -2}}, color = {0, 0, 127}));
  end Tank;

  model Valve
    Modelica.Blocks.Interfaces.RealOutput massFlow annotation(
      Placement(transformation(origin = {120, -2}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, -2}, extent = {{-20, -20}, {20, 20}})));
    Real height annotation(
      Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
    Real k(start = 0.50);
  equation
    massFlow = k*sqrt(height);
  end Valve;

  model Example
    Tank tank1(Area = 100, DischargeCoefficient = 1, init_height = 100) annotation(
      Placement(transformation(origin = {-50, 0}, extent = {{-24, -24}, {24, 24}})));
    Tank tank(Area = 100, DischargeCoefficient = 0.5, init_height = 10) annotation(
      Placement(transformation(origin = {27, 1}, extent = {{-23, -23}, {23, 23}})));
    Modelica.Blocks.Sources.Constant inflow(k = 10) annotation(
      Placement(transformation(origin = {-158, 0}, extent = {{-14, -14}, {14, 14}})));
  equation
    connect(tank1.qout, tank.qin) annotation(
      Line(points = {{-21, 0}, {-4, 0}, {-4, 1}, {-1, 1}}, color = {0, 0, 127}));
    connect(inflow.y, tank1.qin) annotation(
      Line(points = {{-143, 0}, {-78, 0}}, color = {0, 0, 127}));
  end Example;

  model TankWithVariableValve
    Modelica.Blocks.Interfaces.RealOutput qout annotation(
      Placement(transformation(origin = {120, -2}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, -2}, extent = {{-20, -20}, {20, 20}})));
    Modelica.Blocks.Interfaces.RealOutput heightOut annotation(
      Placement(transformation(origin = {120, -46}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, -46}, extent = {{-20, -20}, {20, 20}})));
    Modelica.Blocks.Interfaces.RealInput k_control annotation(
      Placement(transformation(origin = {-120, -42}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -42}, extent = {{-20, -20}, {20, 20}})));
    parameter Real Area = 10;
    parameter Real init_height = 10;
    Real height;
    Modelica.Blocks.Interfaces.RealInput qin annotation(
      Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
    VariableValve valve annotation(
      Placement(transformation(origin = {-11, -43}, extent = {{-13, -13}, {13, 13}})));
  initial equation
    height = init_height;
  equation
    Area*der(height) = qin - qout;
    height = valve.height;
    height = heightOut;
    connect(valve.massFlow, qout) annotation(
      Line(points = {{5, -43}, {68, -43}, {68, -2}, {120, -2}}, color = {0, 0, 127}));
    connect(k_control, valve.k) annotation(
      Line(points = {{-120, -42}, {-27, -42}, {-27, -43}}, color = {0, 0, 127}));
  end TankWithVariableValve;

  model VariableValve
    Modelica.Blocks.Interfaces.RealOutput massFlow annotation(
      Placement(transformation(origin = {120, -2}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, -2}, extent = {{-20, -20}, {20, 20}})));
    Real height;
    Modelica.Blocks.Interfaces.RealInput k annotation(
      Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  equation
    massFlow = k*sqrt(height);
  end VariableValve;

  model ExampleWithOneControl
    Tank tank1(Area = 4, DischargeCoefficient = 0.7, init_height = 3) annotation(
      Placement(transformation(origin = {32, 48}, extent = {{-24, -24}, {24, 24}})));
    Modelica.Blocks.Sources.Constant inflow(k = 4) annotation(
      Placement(transformation(origin = {-136, 48}, extent = {{-14, -14}, {14, 14}})));
    Modelica.Blocks.Continuous.LimPID Control(k = 1, Ti = 13.2, yMax = 100, yMin = 0, controllerType = Modelica.Blocks.Types.SimpleController.PI) annotation(
      Placement(transformation(origin = {-68, 48}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(Control.y, tank1.qin) annotation(
      Line(points = {{-57, 48}, {2, 48}}, color = {0, 0, 127}));
    connect(inflow.y, Control.u_s) annotation(
      Line(points = {{-120.6, 48}, {-80.6, 48}}, color = {0, 0, 127}));
    connect(Control.u_m, tank1.out_height) annotation(
      Line(points = {{-68, 36}, {-68, 0}, {61, 0}, {61, 37}}, color = {0, 0, 127}));
    annotation(
      experiment(StartTime = 0, StopTime = 600, Tolerance = 1e-06, Interval = 1.2));
  end ExampleWithOneControl;

  model ClosedLoop
    Tank tank1(Area = 4, DischargeCoefficient = 0.8, init_height = 25) annotation(
      Placement(transformation(origin = {-46, 0}, extent = {{-24, -24}, {24, 24}})));
    Modelica.Blocks.Sources.Constant inflow(k = 5) annotation(
      Placement(transformation(origin = {-178, 0}, extent = {{-14, -14}, {14, 14}})));
    TwoTankProblem.Tank tank11(Area = 4, DischargeCoefficient = 0.8, init_height = 25) annotation(
      Placement(transformation(origin = {54, 0}, extent = {{-24, -24}, {24, 24}})));
    Modelica.Blocks.Continuous.LimPID PID(Ti = 10, yMax = 5, yMin = 0, k = 100, controllerType = Modelica.Blocks.Types.SimpleController.PID, Td = 10, Nd = 5) annotation(
      Placement(transformation(origin = {-122, 0}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(tank1.qout, tank11.qin) annotation(
      Line(points = {{-17, 0}, {25, 0}}, color = {0, 0, 127}));
    connect(inflow.y, PID.u_s) annotation(
      Line(points = {{-162, 0}, {-134, 0}}, color = {0, 0, 127}));
    connect(PID.u_m, tank11.out_height) annotation(
      Line(points = {{-122, -12}, {-122, -42}, {132, -42}, {132, -11}, {83, -11}}, color = {0, 0, 127}));
    connect(PID.y, tank1.qin) annotation(
      Line(points = {{-111, 0}, {-75, 0}}, color = {0, 0, 127}));
    annotation(
      experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 2));
  end ClosedLoop;

  model OpenLoop
    Tank tank1(Area = 4, DischargeCoefficient = 0.8, init_height = 25) annotation(
      Placement(transformation(origin = {-60, 0}, extent = {{-24, -24}, {24, 24}})));
    Modelica.Blocks.Sources.Constant inflow(k = 2) annotation(
      Placement(transformation(origin = {-178, 0}, extent = {{-14, -14}, {14, 14}})));
    Tank tank11(Area = 4, DischargeCoefficient = 0.2, init_height = 25) annotation(
      Placement(transformation(origin = {76, 0}, extent = {{-24, -24}, {24, 24}})));
  equation
    connect(tank1.qout, tank11.qin) annotation(
      Line(points = {{-31, 0}, {47, 0}}, color = {0, 0, 127}));
    connect(inflow.y, tank1.qin) annotation(
      Line(points = {{-162, 0}, {-89, 0}}, color = {0, 0, 127}));
    annotation(
      experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 2));
  end OpenLoop;

  model ClosedLoopBiControl
    Tank tank1(Area = 4, DischargeCoefficient = 0.8, init_height = 25) annotation(
      Placement(transformation(origin = {6, 16}, extent = {{-24, -24}, {24, 24}})));
    Modelica.Blocks.Sources.Constant inflow(k = 5) annotation(
      Placement(transformation(origin = {-204, 14}, extent = {{-14, -14}, {14, 14}})));
    Modelica.Blocks.Continuous.LimPID PID(Ti = 100, yMax = 30, yMin = 10, k = 100, controllerType = Modelica.Blocks.Types.SimpleController.PI, Td = 10, Nd = 5) annotation(
      Placement(transformation(origin = {-144, 14}, extent = {{-10, -10}, {10, 10}})));
    TankWithVariableValve Tank11(Area = 4, init_height = 25) annotation(
      Placement(transformation(origin = {166, 16}, extent = {{-22, -22}, {22, 22}})));
    Modelica.Blocks.Continuous.LimPID PID1(Nd = 5, Td = 10, Ti = 10, controllerType = Modelica.Blocks.Types.SimpleController.PID, k = 100, yMax = 4, yMin = 0) annotation(
      Placement(transformation(origin = {-66, 14}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Sources.Constant inflow1(k = 0.9) annotation(
      Placement(transformation(origin = {92, -24}, extent = {{-14, -14}, {14, 14}})));
  equation
    connect(tank1.qout, Tank11.qin) annotation(
      Line(points = {{34.8, 15.52}, {139.8, 15.52}}, color = {0, 0, 127}));
    connect(PID1.y, tank1.qin) annotation(
      Line(points = {{-55, 14}, {-24, 14}, {-24, 16}}, color = {0, 0, 127}));
    connect(PID1.u_m, tank1.out_height) annotation(
      Line(points = {{-66, 2}, {-66, -30}, {46, -30}, {46, 5}, {35, 5}}, color = {0, 0, 127}));
    connect(inflow.y, PID.u_s) annotation(
      Line(points = {{-189, 14}, {-156, 14}}, color = {0, 0, 127}));
    connect(PID.u_m, Tank11.heightOut) annotation(
      Line(points = {{-144, 2}, {-144, -56}, {214, -56}, {214, 6}, {192, 6}}, color = {0, 0, 127}));
    connect(PID.y, PID1.u_s) annotation(
      Line(points = {{-133, 14}, {-78, 14}}, color = {0, 0, 127}));
    connect(inflow1.y, Tank11.k_control) annotation(
      Line(points = {{107.4, -24}, {117.4, -24}, {117.4, 6}, {139.4, 6}}, color = {0, 0, 127}));
    annotation(
      experiment(StartTime = 0, StopTime = 600, Tolerance = 1e-06, Interval = 1.2));
  end ClosedLoopBiControl;
  
  model ClosedLoopBiControlK2
    Tank tank1(Area = 4, DischargeCoefficient = 0.8, init_height = 30) annotation(
      Placement(transformation(origin = {8, 28}, extent = {{-24, -24}, {24, 24}})));
    Modelica.Blocks.Continuous.LimPID PID(Ti = 100, yMax = 4, yMin = 0, k = 1000, controllerType = Modelica.Blocks.Types.SimpleController.PID, Td = 1, Nd = 5) annotation(
      Placement(transformation(origin = {-80, 28}, extent = {{-10, -10}, {10, 10}})));
    TankWithVariableValve Tank11(Area = 4, init_height = 30) annotation(
      Placement(transformation(origin = {166, 28}, extent = {{-22, -22}, {22, 22}})));
  Modelica.Blocks.Continuous.LimPID PID1(Nd = 5, Td = 10, Ti = 10, controllerType = Modelica.Blocks.Types.SimpleController.PID, k = 100, yMax = 1, yMin = 0) annotation(
      Placement(transformation(origin = {-80, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant inflow1(k = 10) annotation(
      Placement(transformation(origin = {-258, 10}, extent = {{-14, -14}, {14, 14}})));
  Modelica.Blocks.Continuous.LimPID PID2(Nd = 5, Td = 10, Ti = 150, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 10, yMax = 30, yMin = 10) annotation(
      Placement(transformation(origin = {-196, 28}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add(k1 = 1, k2 = -1)  annotation(
      Placement(transformation(origin = {8, -46}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant inflow11(k = 1) annotation(
      Placement(transformation(origin = {-44, -28}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(tank1.qout, Tank11.qin) annotation(
      Line(points = {{36.8, 27.52}, {139.8, 27.52}}, color = {0, 0, 127}));
    connect(PID.y, tank1.qin) annotation(
      Line(points = {{-69, 28}, {-22, 28}}, color = {0, 0, 127}));
    connect(PID1.u_m, Tank11.heightOut) annotation(
      Line(points = {{-80, -62}, {-80, -70}, {216, -70}, {216, 18}, {192, 18}}, color = {0, 0, 127}));
    connect(PID2.y, PID.u_s) annotation(
      Line(points = {{-185, 28}, {-92, 28}}, color = {0, 0, 127}));
    connect(PID2.u_m, Tank11.heightOut) annotation(
      Line(points = {{-196, 16}, {-196, -10}, {214, -10}, {214, 18}, {192, 18}}, color = {0, 0, 127}));
  connect(inflow1.y, PID2.u_s) annotation(
      Line(points = {{-243, 10}, {-226.6, 10}, {-226.6, 28}, {-208.6, 28}}, color = {0, 0, 127}));
  connect(PID1.u_s, inflow1.y) annotation(
      Line(points = {{-92, -50}, {-226, -50}, {-226, 10}, {-243, 10}}, color = {0, 0, 127}));
  connect(tank1.out_height, PID.u_m) annotation(
      Line(points = {{36.8, 16.96}, {56.8, 16.96}, {56.8, -1.04}, {-79.2, -1.04}, {-79.2, 16.96}}, color = {0, 0, 127}));
  connect(PID1.y, add.u2) annotation(
      Line(points = {{-69, -50}, {-37, -50}, {-37, -52}, {-5, -52}}, color = {0, 0, 127}));
  connect(inflow11.y, add.u1) annotation(
      Line(points = {{-33, -28}, {-17, -28}, {-17, -40}, {-5, -40}}, color = {0, 0, 127}));
  connect(add.y, Tank11.k_control) annotation(
      Line(points = {{19, -46}, {117, -46}, {117, 16}, {133, 16}, {133, 18}, {139, 18}}, color = {0, 0, 127}));
    annotation(
      experiment(StartTime = 0, StopTime = 600, Tolerance = 1e-06, Interval = 1.2));
  end ClosedLoopBiControlK2;
  
  model ClosedLoopBiControlK2Hysterisis
    Tank tank1(Area = 4, DischargeCoefficient = 0.8, init_height = 0) annotation(
      Placement(transformation(origin = {8, 28}, extent = {{-24, -24}, {24, 24}})));
    Modelica.Blocks.Continuous.LimPID PID(Ti = 100, yMax = 4, yMin = 0, k = 1000, controllerType = Modelica.Blocks.Types.SimpleController.PID, Td = 1, Nd = 5) annotation(
      Placement(transformation(origin = {-80, 28}, extent = {{-10, -10}, {10, 10}})));
    TankWithVariableValve Tank11(Area = 4, init_height = 0) annotation(
      Placement(transformation(origin = {166, 28}, extent = {{-22, -22}, {22, 22}})));
  Modelica.Blocks.Continuous.LimPID PID1(Nd = 5, Td = 10, Ti = 150, controllerType = Modelica.Blocks.Types.SimpleController.PID, k = 10, yMax = 30, yMin = 5) annotation(
      Placement(transformation(origin = {-92, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant inflow1(k = 20) annotation(
      Placement(transformation(origin = {-258, 10}, extent = {{-14, -14}, {14, 14}})));
  Modelica.Blocks.Continuous.LimPID PID2(Nd = 5, Td = 10, Ti = 150, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 10, yMax = 30, yMin = 5) annotation(
      Placement(transformation(origin = {-196, 28}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(pre_y_start = false, uHigh = 1, uLow = -1) annotation(
      Placement(transformation(origin = {6, -38}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
      Placement(transformation(origin = {96, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.MathBoolean.Not not1 annotation(
      Placement(transformation(origin = {48, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add(k1 = 1, k2 = -1)  annotation(
      Placement(transformation(origin = {-40, -40}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(tank1.qout, Tank11.qin) annotation(
      Line(points = {{36.8, 27.52}, {139.8, 27.52}}, color = {0, 0, 127}));
    connect(PID.y, tank1.qin) annotation(
      Line(points = {{-69, 28}, {-22, 28}}, color = {0, 0, 127}));
    connect(PID1.u_m, Tank11.heightOut) annotation(
      Line(points = {{-92, -52}, {-92, -70}, {216, -70}, {216, 18}, {192, 18}}, color = {0, 0, 127}));
    connect(PID2.y, PID.u_s) annotation(
      Line(points = {{-185, 28}, {-92, 28}}, color = {0, 0, 127}));
    connect(PID2.u_m, Tank11.heightOut) annotation(
      Line(points = {{-196, 16}, {-196, -10}, {214, -10}, {214, 18}, {192, 18}}, color = {0, 0, 127}));
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
      Line(points = {{108, -40}, {120, -40}, {120, 18}, {140, 18}}, color = {0, 0, 127}));
  connect(PID1.y, add.u1) annotation(
      Line(points = {{-80, -40}, {-66, -40}, {-66, -34}, {-52, -34}}, color = {0, 0, 127}));
  connect(add.y, hysteresis.u) annotation(
      Line(points = {{-28, -40}, {-17, -40}, {-17, -38}, {-6, -38}}, color = {0, 0, 127}));
  connect(add.u2, Tank11.heightOut) annotation(
      Line(points = {{-52, -46}, {-66, -46}, {-66, -66}, {226, -66}, {226, 18}, {192, 18}}, color = {0, 0, 127}));
    annotation(
      experiment(StartTime = 0, StopTime = 600, Tolerance = 1e-06, Interval = 1.2));
  end ClosedLoopBiControlK2Hysterisis;

  model TestHysterisis
  equation

  end TestHysterisis;
  annotation(
    uses(Modelica(version = "4.0.0")));
end TwoTankProblem;