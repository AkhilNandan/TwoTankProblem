within TwoTankProblem;

model Valve
  Modelica.Blocks.Interfaces.RealOutput massFlow annotation(
    Placement(transformation(origin = {120, -2}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, -2}, extent = {{-20, -20}, {20, 20}})));
  Real height annotation(
    Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  Real k(start = 0.50);
equation
  massFlow = k*sqrt(height);
annotation(
    Documentation(info = "<html><head></head><body>This is non-linear valve/orifice model. flow of the liquid through valve's opening depends on discharge coefficent and the height of the liquid above it. <br><br>Valve dynamics:<div><br></div><div><b><span class=\"Apple-tab-span\" style=\"white-space: pre;\">			</span>q&nbsp;= k&nbsp;× √h&nbsp;</b></div><div><br></div><div>where,</div><div><br></div><div><b>q</b> is the flow of liquid throght the valve.</div><div><b>k</b> is the discharge coefficent.&nbsp;</div><div><b>h </b>is the level of liquid above the valve.</div><div><br></div></body></html>"));
end Valve;