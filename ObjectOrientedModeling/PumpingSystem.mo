package PumpingSystem
   
model SliderCrank    
      DSFLib.Mechanical.Rotational.Interfaces.Flange rot_flange annotation(
      Placement(transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Mechanical.Translational.Interfaces.Flange trans_flange annotation(
      Placement(transformation(origin = {54, 84}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {54, 84}, extent = {{-10, -10}, {10, 10}})));
    
    DSFLib.Mechanical.Translational.Units.Position s;
    DSFLib.Mechanical.Translational.Units.Force f;
    DSFLib.Mechanical.Rotational.Units.Angle phi;
    DSFLib.Mechanical.Rotational.Units.Torque tau;
    parameter DSFLib.Mechanical.Translational.Units.Position L = 0.1;
    parameter DSFLib.Mechanical.Translational.Units.Position r = 0.01;
    parameter DSFLib.Mechanical.Translational.Units.Position s0 = 0 annotation(
      Placement(visible = false, transformation(extent = {{0, 0}, {0, 0}})));
  equation
  s = r * cos(phi) + L * sqrt(1-((r/L) * sin(phi))^2);
  
  tau * (s - r * cos(phi)) = f * (r * s * sin(phi));
  
  trans_flange.s = s + s0;
  trans_flange.f = f;
  rot_flange.tau = tau;
  rot_flange.phi = phi;
  


annotation(
      Icon(graphics = {Ellipse(origin = {1, -1}, lineThickness = 2, extent = {{-99, 99}, {99, -99}})}),
  Diagram(graphics = {Ellipse(extent = {{-98, 98}, {98, -98}})}));
end SliderCrank;

  model System
  DSFLib.Mechanical.Rotational.Components.Inertia inertia annotation(
      Placement(transformation(origin = {-28, 54}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Mechanical.Rotational.Components.Fixed fixed annotation(
      Placement(transformation(origin = {-88, 12}, extent = {{-18, -18}, {18, 18}})));
  DSFLib.Mechanical.Rotational.Components.ConstTorque constTorque annotation(
      Placement(transformation(origin = {-48, 10}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Mechanical.Translational.Components.Mass mass annotation(
      Placement(transformation(origin = {42, 12}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Mechanical.Translational.Components.Damper damper annotation(
      Placement(transformation(origin = {70, 10}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Mechanical.Translational.Components.Fixed fixed1 annotation(
      Placement(transformation(origin = {80, -68}, extent = {{-10, -10}, {10, 10}})));
  SliderCrank sliderCrank annotation(
      Placement(transformation(origin = {6, 8}, extent = {{-10, -10}, {10, 10}})));
  equation
  connect(fixed.flange, constTorque.flange_a) annotation(
      Line(points = {{-88, 12}, {-72, 12}, {-72, 10}, {-58, 10}}));
  connect(inertia.flange, constTorque.flange_b) annotation(
      Line(points = {{-38, 54}, {-38, 10}}));
  connect(fixed1.flange, damper.flange_b) annotation(
      Line(points = {{80, -68}, {80, 10}}));
  connect(damper.flange_a, mass.flange) annotation(
      Line(points = {{60, 10}, {60, -11}, {42, -11}, {42, 12}}));
  connect(constTorque.flange_b, sliderCrank.rot_flange) annotation(
      Line(points = {{-38, 10}, {6, 10}, {6, 8}}));
  connect(sliderCrank.trans_flange, mass.flange) annotation(
      Line(points = {{12, 16}, {42, 16}, {42, 12}}));
  end System;
  
  model CheckValve
    extends DSFLib.Hydraulics.Interfaces.TwoPort;
    parameter Real Ron(unit = "Pa.s/m3") = 1e-6 "Hydraulic Resistance";
    parameter Real Roff(unit = "Pa.s/m3") = 1e12 "Hydraulic Resistance";
  equation
  
    if q > 0 then
      p = Ron * q;
    else
      p = Roff * q;
    end if;
    
    
    annotation(
      Icon(graphics = {Line(origin = {-0.76, 15}, points = {{-80.9999, 44.7675}, {-80.9999, -75.2325}, {-80.9999, -75.2325}, {79.0001, 44.7675}, {81.0001, -73.2325}, {-80.9999, 44.7675}, {-56.9999, 26.7675}}, thickness = 0.5), Line(origin = {-5, -0.9}, points = {{-55, 0.022178}, {55, 0.022178}, {45, 18.0222}, {55, -1.97782}, {45, -17.9778}, {55, -1.97782}, {55, 0.022178}}, thickness = 1.25)}));
  end CheckValve;

  model System2
  DSFLib.Hydraulics.Components.Tank tank annotation(
      Placement(transformation(origin = {2, 82}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Hydraulics.Components.ConstPress constPress annotation(
      Placement(transformation(origin = {-90, -64}, extent = {{-10, -10}, {10, 10}})));
  CheckValve checkValve annotation(
      Placement(transformation(origin = {-48, -4}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Hydraulics.Components.Valve valve annotation(
      Placement(transformation(origin = {4, 48}, extent = {{-10, -10}, {10, 10}})));
  CheckValve checkValve1 annotation(
      Placement(transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}})));
  equation
  connect(constPress.fluidPort, checkValve.fluidPort_b) annotation(
      Line(points = {{-80, -64}, {-58, -64}, {-58, -4}}));
  connect(checkValve1.fluidPort_a, constPress.fluidPort) annotation(
      Line(points = {{70, 0}, {84, 0}, {84, -64}, {-80, -64}}));
  connect(checkValve.fluidPort_a, checkValve1.fluidPort_b) annotation(
      Line(points = {{-38, -4}, {50, -4}, {50, 0}}));
  connect(valve.fluidPort_b, tank.fluidPort) annotation(
      Line(points = {{-6, 48}, {-22, 48}, {-22, 72}, {2, 72}}));
  connect(valve.fluidPort_a, checkValve.fluidPort_a) annotation(
      Line(points = {{14, 48}, {-9, 48}, {-9, 32}, {22, 32}, {22, 22}, {-38, 22}, {-38, -4}}));
  end System2;
end PumpingSystem;