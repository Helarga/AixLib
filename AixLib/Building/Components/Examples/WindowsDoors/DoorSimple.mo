within AixLib.Building.Components.Examples.WindowsDoors;
model DoorSimple
  extends Modelica.Icons.Example;
  Components.WindowsDoors.Door doorSimple(
    eps=1,
    door_area=10,
    T0=293.15)
    annotation (Placement(transformation(extent={{-24,-4},{12,28}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Toutside(T=273.15)
    annotation (Placement(transformation(extent={{-62,0},{-42,20}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside(T=293.15)
    annotation (Placement(transformation(extent={{58,0},{38,20}})));
  Modelica.Blocks.Sources.RealExpression UValue(y=doorSimple.port_b.Q_flow/(
        doorSimple.port_b.T - doorSimple.port_a.T)/doorSimple.door_area)
    annotation (Placement(transformation(extent={{-20,-46},{0,-26}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside1(T=293.15)
    annotation (Placement(transformation(extent={{58,32},{38,52}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Toutside1(T=273.15)
    annotation (Placement(transformation(extent={{-62,26},{-42,46}})));
equation
  connect(Toutside.port, doorSimple.port_a) annotation (Line(
      points={{-42,10},{-34,10},{-34,12},{-22.2,12}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(doorSimple.port_b, Tinside.port) annotation (Line(
      points={{10.2,12},{24,12},{24,10},{38,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(doorSimple.Star, Tinside1.port) annotation (Line(
      points={{10.2,21.6},{20,21.6},{20,42},{38,42}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(Toutside1.port, doorSimple.Star1) annotation (Line(
      points={{-42,36},{-34,36},{-34,21.6},{-22.2,21.6}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (
    Diagram(graphics),
    experiment(
      StopTime=3600,
      Interval=60,
      Algorithm="Lsodar"),
    experimentSetupOutput,
    Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Simulation to test the <a href=\"AixLib.Building.Components.WindowsDoors.Door\">Door</a> model.</p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>Test case for calculation of U-value</p>
<p><ul>
<li>Area of component: 10 m2</li>
<li>Temperature difference: 20 K</li>
<li>Test time: 1 h</li>
</ul></p>
</html>",
        revisions="<html>
<ul>
  <li><i>April 1, 2012&nbsp;</i>
         by Ana Constantin and Corinna Leonhard:<br>
         Implemented.</li>
</ul>
</html>"));
end DoorSimple;
