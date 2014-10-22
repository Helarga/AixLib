within AixLib.Building.Components.Examples.WindowsDoors;
model WindowSimple
  extends Modelica.Icons.Example;
  Components.WindowsDoors.WindowSimple windowSimple(windowarea=10)
    annotation (Placement(transformation(extent={{-24,-4},{12,28}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Toutside(T=273.15)
    annotation (Placement(transformation(extent={{-62,0},{-42,20}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside(T=293.15)
    annotation (Placement(transformation(extent={{58,0},{38,20}})));
  Modelica.Blocks.Sources.RealExpression UValue(y=windowSimple.port_inside.Q_flow
        /(1 - windowSimple.frameFraction)/windowSimple.windowarea/(
        windowSimple.port_inside.T - windowSimple.port_outside.T))
    annotation (Placement(transformation(extent={{-20,-46},{0,-26}})));
  Utilities.Sources.PrescribedSolarRad
                                     varRad(I={100}, n=1)
    annotation (Placement(transformation(extent={{-66,40},{-46,60}})));
  Modelica.Blocks.Sources.Constant SolarRadiation(k=100)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature Tinside1(T=293.15)
    annotation (Placement(transformation(extent={{58,32},{38,52}})));
equation
  connect(Toutside.port, windowSimple.port_outside) annotation (Line(
      points={{-42,10},{-34,10},{-34,10.4},{-22.2,10.4}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(windowSimple.port_inside, Tinside.port) annotation (Line(
      points={{10.2,10.4},{24,10.4},{24,10},{38,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(windowSimple.Star, Tinside1.port) annotation (Line(
      points={{10.2,21.6},{20,21.6},{20,42},{38,42}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(varRad.solarRad_out[1], windowSimple.solarRad_in) annotation (Line(
      points={{-47,50},{-32,50},{-32,21.6},{-22.2,21.6}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(SolarRadiation.y, varRad.u[1]) annotation (Line(
      points={{-79,50},{-66,50}},
      color={0,0,127},
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
<p>Simulation to test the <a href=\"AixLib.Building.Components.WindowsDoors.WindowSimple\">WindowSimple</a> model.</p>
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
end WindowSimple;
