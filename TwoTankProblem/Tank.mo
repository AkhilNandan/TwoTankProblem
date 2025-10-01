within TwoTankProblem;

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
annotation(
    Documentation(info = "<html><head></head><body>This is a ideal tank model with water level as one of the state. The water level of the tank is dependant upon the the inflow and outflow values. Where the inflow is from an external input source and outflow is through an orifice.&nbsp;
<div><br><br><b>Important relations:&nbsp;</b></div><div><br></div><div><div>Valve dynamics:</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">		<b>	</b></span><b>q&nbsp;= k&nbsp;× √h</b></div></div><div>

<p>Tank dynamics:</p><p><span class=\"Apple-tab-span\" style=\"white-space:pre\">		<b>	</b></span><b>A(dh/dt) = u(t) - q</b></p><p>where,</p><p><b>A</b> is the area of the tank</p><p><b>h</b> is the height of liquid&nbsp;</p><p><b>u</b> is the external flow source</p><p><b>q</b> is the outflow of liquid through orifice</p>


<p><br></p></div><div><br></div><div><br></div><div><br></div></body></html>"));
end Tank;