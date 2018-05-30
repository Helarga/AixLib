within AixLib.Controls;
package HydraulicModules "Controller for hydraulic circuits"
  extends Modelica.Icons.VariantsPackage;
  block Ctr_unmixed_simple "controller for unmixed circuit"
    import Zugabe;
    //Boolean choice;

    parameter Real rpm_pump(min=0, unit="1") = 2000 "Rpm of the Pump";
    parameter Modelica.SIunits.Temperature Tamb = 293.15 "ambient temperature";

    Modelica.Blocks.Sources.RealExpression realExpression(y=rpm_pump)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Fluid.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus annotation (Placement(
          transformation(extent={{78,-24},{124,24}}), iconTransformation(extent={{
              78,-24},{124,24}})));
    Modelica.Blocks.Sources.Constant const(k=Tamb)
      annotation (Placement(transformation(extent={{22,44},{42,64}})));
  equation
    connect(realExpression.y, hydraulicBus.pumpBus.rpm_Input) annotation (Line(
          points={{11,0},{101.115,0},{101.115,0.12}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(const.y, hydraulicBus.T_amb) annotation (Line(points={{43,54},{
            101.115,54},{101.115,0.12}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Text(
            extent={{-90,20},{56,-20}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="HCMI"),
            Rectangle(
            extent={{-90,80},{80,-80}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),Line(
            points={{10,80},{78,0},{30,-80}},
            color={95,95,95},
            thickness=0.5),
            Text(
            extent={{-90,20},{56,-20}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="Unmixed")}),
                                  Diagram(coordinateSystem(preserveAspectRatio=
              false)),
      Documentation(revisions="<html>
<ul>
<li>October 25, by Alexander K&uuml;mpel:<br/>First implementation.</li>
</ul>
</html>",   info="<html>
<p>Simple controller for unmixed circuit.</p>
</html>"));
  end Ctr_unmixed_simple;

  block Ctr_admix "controller for mixed cooling circuit "
    //Boolean choice;

    parameter Modelica.SIunits.Temperature TflowSet = 289.15 "Flow temperature set point of consumer";
    parameter Real k(min=0, unit="1") = 0.025 "Gain of controller";
    parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small)=130
      "Time constant of Integrator block";
    parameter Modelica.SIunits.Time Td(min=0)= 4 "Time constant of Derivative block";
    parameter Modelica.SIunits.Temperature Tamb = 293.15 "ambient temperature";
    parameter Real rpm_pump(min=0, unit="1") = 2000 "Rpm of the Pump";

    Modelica.Blocks.Continuous.LimPID PID(
      yMax=1,
      yMin=0,
      xi_start=0.5,
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      k=k,
      Ti=Ti,
      Td=Td)  annotation (Placement(transformation(extent={{-16,-60},{4,-40}})));
    Fluid.HydraulicModules.BaseClasses.HydraulicBus  hydraulicBus
      annotation (Placement(transformation(extent={{66,-38},{120,16}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=TflowSet)
      annotation (Placement(transformation(extent={{-84,-60},{-64,-40}})));
    Modelica.Blocks.Math.Gain gain(k=-1)
      annotation (Placement(transformation(extent={{-46,-56},{-34,-44}})));
    Modelica.Blocks.Math.Gain gain1(k=-1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=90,
          origin={-5,-77})));
    Modelica.Blocks.Sources.RealExpression realExpression1(
                                                          y=rpm_pump)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Sources.Constant const(k=Tamb)
      annotation (Placement(transformation(extent={{22,44},{42,64}})));
  equation
    connect(PID.y, hydraulicBus.valveSet) annotation (Line(points={{5,-50},{48,
            -50},{48,-10.865},{93.135,-10.865}},
                                        color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(gain1.y, PID.u_m) annotation (Line(points={{-5,-71.5},{-5,-66.75},{-6,
            -66.75},{-6,-62}}, color={0,0,127}));
    connect(realExpression.y, gain.u)
      annotation (Line(points={{-63,-50},{-47.2,-50}}, color={0,0,127}));
    connect(gain.y, PID.u_s)
      annotation (Line(points={{-33.4,-50},{-18,-50}}, color={0,0,127}));
    connect(realExpression1.y, hydraulicBus.pumpBus.rpm_Input) annotation (Line(
          points={{11,0},{52,0},{52,-10.865},{93.135,-10.865}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(const.y, hydraulicBus.T_amb) annotation (Line(points={{43,54},{
            93.135,54},{93.135,-10.865}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(gain1.u, hydraulicBus.TFwrd_out) annotation (Line(points={{-5,-83},
            {93.135,-83},{93.135,-10.865}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Text(
            extent={{-90,20},{56,-20}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="HCMI"),
            Rectangle(
            extent={{-90,80},{70,-80}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),Line(
            points={{10,80},{70,0},{30,-80}},
            color={95,95,95},
            thickness=0.5),
            Text(
            extent={{-90,20},{56,-20}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="Admix")}),Diagram(coordinateSystem(preserveAspectRatio=
              false)),
      Documentation(revisions="<html>
<ul>
<li>October 25, by Alexander K&uuml;mpel:<br/>First implementation.</li>
</ul>
</html>",   info="<html>
<p>Simple controller for admix circuit.</p>
</html>"));
  end Ctr_admix;
  annotation (Documentation(info="<html>
</html>", revisions="<html>
</html>"));
end HydraulicModules;
