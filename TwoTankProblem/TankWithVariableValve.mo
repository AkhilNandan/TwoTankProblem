within TwoTankProblem;

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
annotation(
    Documentation(info = "<html><head></head><body><div>This is a ideal tank model with water level as one of the state. The water level of the tank is dependant upon the the inflow and outflow values. Where the inflow is from an external input source and outflow is through an orifice.&nbsp;<div><br><br><b>Important relations:&nbsp;</b></div><div><br></div><div><div>Valve dynamics:</div><div><span class=\"Apple-tab-span\" style=\"white-space: pre;\">		<b>	</b></span><b>q&nbsp;= k&nbsp;× √h</b></div></div><div><p>Tank dynamics:</p><p><span class=\"Apple-tab-span\" style=\"white-space: pre;\">		<b>	</b></span><b>A(dh/dt) = qin - qout</b></p><p>where,</p><p><b>A</b>&nbsp;is the area of the tank</p><p><b>h</b>&nbsp;is the height of liquid&nbsp;</p><p><b>u</b>&nbsp;is the external flow source</p><p><b>qout</b>&nbsp;is the outflow of liquid through orifice</p><p><br></p><p><b>Note</b>: The valve dynamics in the model is arranged such that the discharge coefficient is not fixed but allowed to vary externally.</p><p><br></p></div><div><br></div><div><br></div></div></body></html>"));
end TankWithVariableValve;