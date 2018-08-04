within AixLib.Fluid.HeatPumps;
model HeatPump "Base model of realistic heat pump"
  extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
  redeclare package Medium1 = Medium_con,
  redeclare package Medium2 = Medium_eva);
  MixingVolumes.MixingVolume Condenser(nPorts=2, redeclare final package Medium =
        Medium_con,
    final allowFlowReversal=allowFlowReversal_con,
    m_flow_nominal=mFlow_conNominal)             "Volume of Condenser"
    annotation (Placement(transformation(extent={{-8,104},{12,84}})));
  MixingVolumes.MixingVolume Evaporator(nPorts=2, redeclare final package
      Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversal_eva,
    final m_flow_nominal=mFlow_evaNominal)        "Volume of Evaporator"
    annotation (Placement(transformation(extent={{-6,-90},{14,-70}})));
  Sensors.MassFlowRate mFlow_a1(redeclare final package Medium = Medium_con,
      final allowFlowReversal=allowFlowReversal_con)
                                "mass flow rate at source inlet"
    annotation (Placement(transformation(extent={{-74,84},{-54,64}})));
  Sensors.TemperatureTwoPort senT_b2(
    final transferHeat=true,
    final TAmb=sigBusHP.T_amb,
    final tauHeaTra=1200,
    redeclare final package Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversal_eva,
    final m_flow_nominal=mFlow_evaNominal)
                                     "Temperature at sink outlet"
    annotation (Placement(transformation(extent={{-20,-96},{-40,-76}})));
  Sensors.TemperatureTwoPort senT_b1(
    final transferHeat=true,
    final TAmb=sigBusHP.T_amb_in,
    final tauHeaTra=1200,
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversal_con,
    final m_flow_nominal=mFlow_conNominal)
                                     "Temperature at source outlet"
    annotation (Placement(transformation(extent={{24,92},{44,72}})));
  Sensors.TemperatureTwoPort senT_a2(
    final transferHeat=true,
    final TAmb=sigBusHP.T_amb,
    final tauHeaTra=1200,
    redeclare final package Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversal_eva,
    final m_flow_nominal=mFlow_evaNominal)
                                     "Temperature at sink inlet"
    annotation (Placement(transformation(extent={{38,-96},{18,-76}})));
  Sensors.TemperatureTwoPort senT_a1(
    final transferHeat=true,
    final TAmb=sigBusHP.T_amb_in,
    final tauHeaTra=1200,
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversal_con,
    final m_flow_nominal=mFlow_conNominal)
                                     "Temperature at source inlet"
    annotation (Placement(transformation(extent={{-46,92},{-26,72}})));
  Sensors.MassFlowRate mFlow_a2(redeclare package Medium = Medium_eva, final
      allowFlowReversal=allowFlowReversal_eva)
                                "mass flow rate at sink inlet"
    annotation (Placement(transformation(extent={{86,-70},{66,-50}})));
  FixedResistances.PressureDrop preDro_2(redeclare final package Medium =
        Medium_eva,
    final allowFlowReversal=allowFlowReversal_eva,
    final m_flow_nominal=mFlow_evaNominal)
                                         "pressure drop at sink side"
    annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));
  FixedResistances.PressureDrop preDro_1(redeclare final package Medium =
        Medium_con,
    final allowFlowReversal=allowFlowReversal_con,
    final m_flow_nominal=mFlow_conNominal)
                                         "pressure drop at sink side"
    annotation (Placement(transformation(extent={{64,50},{84,70}})));
  Modelica.Blocks.Interfaces.RealInput nSet
    "input signal speed for compressor relative between 0 and 1" annotation (Placement(
        transformation(extent={{-132,-16},{-100,16}})));
  Controls.Interfaces.HeatPumpControlBus
                           sigBusHP
    annotation (Placement(transformation(extent={{-130,-48},{-100,-14}}),
        iconTransformation(extent={{-118,-40},{-100,-14}})));
  BaseClasses.innerCycle innerCycle annotation (Placement(transformation(
        extent={{-30,-30},{30,30}},
        rotation=90,
        origin={-10,8})));
public
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRate_eva
    "Heat flow rate of the evaporator" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-16,-58})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRate_con
    "Heat flow rate of the condenser" annotation (Placement(transformation(
        origin={-10,68},
        extent={{6,-6},{-6,6}},
        rotation=270)));
  replaceable package Medium_con = Modelica.Media.Interfaces.PartialMedium "Medium at sink side"
    annotation (__Dymola_choicesAllMatching=true);
  replaceable package Medium_eva = Modelica.Media.Interfaces.PartialMedium "Medium at source side"
    annotation (__Dymola_choicesAllMatching=true);
  parameter Boolean allowFlowReversal_eva=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal";
  parameter Boolean allowFlowReversal_con=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal";
  parameter Modelica.SIunits.MassFlowRate mFlow_conNominal
    "Nominal mass flow rate, used for regularization near zero flow";
  parameter Modelica.SIunits.MassFlowRate mFlow_evaNominal
    "Nominal mass flow rate";
equation
  connect(port_a1, mFlow_a1.port_a) annotation (Line(points={{-100,60},{-100,74},
          {-74,74}},          color={0,127,255}));
  connect(mFlow_a1.port_b, senT_a1.port_a) annotation (Line(points={{-54,74},{-52,
          74},{-52,82},{-46,82}}, color={0,127,255}));
  connect(senT_a1.port_b, Condenser.ports[1]) annotation (Line(points={{-26,82},
          {-16,82},{-16,104},{0,104}}, color={0,127,255}));
  connect(Condenser.ports[2], senT_b1.port_a) annotation (Line(points={{4,104},
          {16,104},{16,82},{24,82}}, color={0,127,255}));
  connect(preDro_1.port_b, port_b1)
    annotation (Line(points={{84,60},{100,60}}, color={0,127,255}));
  connect(preDro_1.port_a, senT_b1.port_b) annotation (Line(points={{64,60},{56,
          60},{56,82},{44,82}}, color={0,127,255}));
  connect(mFlow_a2.port_a, port_a2)
    annotation (Line(points={{86,-60},{100,-60}}, color={0,127,255}));
  connect(senT_a2.port_a, mFlow_a2.port_b) annotation (Line(points={{38,-86},{
          52,-86},{52,-60},{66,-60}}, color={0,127,255}));
  connect(senT_a2.port_b, Evaporator.ports[1])
    annotation (Line(points={{18,-86},{18,-90},{2,-90}}, color={0,127,255}));
  connect(senT_b2.port_a, Evaporator.ports[2]) annotation (Line(points={{-20,-86},
          {-10,-86},{-10,-90},{6,-90}}, color={0,127,255}));
  connect(preDro_2.port_b, port_b2)
    annotation (Line(points={{-80,-60},{-86,-60},{-86,-60},{-84,-60},{-84,-60},{
          -100,-60}},                               color={0,127,255}));
  connect(preDro_2.port_a, senT_b2.port_b) annotation (Line(points={{-60,-60},{
          -50,-60},{-50,-86},{-40,-86}}, color={0,127,255}));
  connect(mFlow_a1.m_flow, sigBusHP.m_flow_co) annotation (Line(points={{-64,63},
          {-64,52},{-72,52},{-72,42},{-72,-30.915},{-94,-30.915},{-114.925,-30.915}},
                                         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(mFlow_a2.m_flow, sigBusHP.m_flow_ev) annotation (Line(points={{76,-49},
          {76,-44},{-72,-44},{-72,-30.915},{-114.925,-30.915}},
                                                            color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_b2.T, sigBusHP.T_ret_ev) annotation (Line(points={{-30,-75},{-30,
          -44},{-72,-44},{-72,-30.915},{-114.925,-30.915}},
                                                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_a2.T, sigBusHP.T_flow_ev) annotation (Line(points={{28,-75},{28,
          -44},{-72,-44},{-72,-30.915},{-114.925,-30.915}},
                                                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_a1.T, sigBusHP.T_ret_co) annotation (Line(points={{-36,71},{-36,
          52},{-72,52},{-72,-30.915},{-114.925,-30.915}},
                                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_b1.T, sigBusHP.T_flow_co) annotation (Line(points={{34,71},{34,
          52},{-72,52},{-72,-30.915},{-114.925,-30.915}},
                                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBusHP, innerCycle.heatPumpControlBus) annotation (Line(
      points={{-115,-31},{-72,-31},{-72,8.3},{-40.9,8.3}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(heatFlowRate_eva.port, Evaporator.heatPort) annotation (Line(points={{
          -16,-68},{-16,-68},{-16,-70},{-16,-70},{-16,-80},{-6,-80}}, color={191,
          0,0}));
  connect(innerCycle.QEva, heatFlowRate_eva.Q_flow)
    annotation (Line(points={{-10,-25},{-10,-26},{-10,-26},{-10,-28},{-10,-38},
          {-16,-38},{-16,-48}},                             color={0,0,127}));
  connect(Condenser.heatPort, heatFlowRate_con.port)
    annotation (Line(points={{-8,94},{-10,94},{-10,74}}, color={191,0,0}));
  connect(heatFlowRate_con.Q_flow, innerCycle.QCon) annotation (Line(points={{-10,62},
          {-10,41}},                      color={0,0,127}));
  connect(innerCycle.COP, sigBusHP.CoP) annotation (Line(points={{23,8},{28,8},{
          28,-44},{-72,-44},{-72,-30.915},{-114.925,-30.915}},  color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(nSet, sigBusHP.N) annotation (Line(points={{-116,0},{-116,-30.915},{-114.925,
          -30.915}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-16,83},{16,-83}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={1,-64},
          rotation=90),
        Rectangle(
          extent={{-17,83},{17,-83}},
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0},
          origin={1,61},
          rotation=90),
        Text(
          extent={{-76,6},{74,-36}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="%name
"),     Line(
          points={{-9,40},{9,40},{-5,-2},{9,-40},{-9,-40}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={-3,-60},
          rotation=-90),
        Line(
          points={{9,40},{-9,40},{5,-2},{-9,-40},{9,-40}},
          color={0,0,0},
          smooth=Smooth.None,
          origin={-5,56},
          rotation=-90),
        Rectangle(
          extent={{-82,42},{84,-46}},
          lineColor={238,46,47},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-88,60},{88,60}}, color={28,108,200}),
        Line(points={{-88,-60},{88,-60}}, color={28,108,200})}),
                                            Diagram(coordinateSystem(extent={{
            -100,-100},{100,100}})));
end HeatPump;
