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

  model HydraulicPump
  SliderCrank sliderCrank annotation(
      Placement(transformation(origin = {0, 64}, extent = {{-10, -10}, {10, 10}})));
  CheckValve inCheckValve annotation(
      Placement(transformation(origin = {-48, 0}, extent = {{-10, -10}, {10, 10}})));
  CheckValve outCheckValve1 annotation(
      Placement(transformation(origin = {54, 0}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.MultiDomain.HydroMechanical.Components.PistonCylinder pistonCylinder(A = 0.001)  annotation(
      Placement(transformation(origin = {4, 22}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Hydraulics.Interfaces.FluidPort fluidPort annotation(
      Placement(transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Hydraulics.Interfaces.FluidPort fluidPort1 annotation(
      Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Mechanical.Rotational.Interfaces.Flange flange annotation(
      Placement(transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Mechanical.Translational.Components.Fixed fixed annotation(
      Placement(transformation(origin = {-22, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
  connect(fluidPort, inCheckValve.fluidPort_b) annotation(
      Line(points = {{-100, 0}, {-58, 0}}));
  connect(flange, sliderCrank.rot_flange) annotation(
      Line(points = {{0, 100}, {0, 64}}));
  connect(sliderCrank.trans_flange, pistonCylinder.flange_b) annotation(
      Line(points = {{6, 72}, {14, 72}, {14, 22}}));
  connect(inCheckValve.fluidPort_a, pistonCylinder.fluidPort) annotation(
      Line(points = {{-38, 0}, {0, 0}, {0, 14}}));
  connect(pistonCylinder.fluidPort, outCheckValve1.fluidPort_b) annotation(
      Line(points = {{0, 14}, {0, 0}, {26, 0}, {26, 1}, {44, 1}, {44, 0}}));
  connect(outCheckValve1.fluidPort_a, fluidPort1) annotation(
      Line(points = {{64, 0}, {100, 0}}));
  connect(fixed.flange, pistonCylinder.flange_a) annotation(
      Line(points = {{-22, 22}, {-6, 22}}));
  annotation(
      Icon(graphics = {Polygon(lineColor = {0, 0, 255}, pattern = LinePattern.None, fillPattern = FillPattern.VerticalCylinder, points = {{-48, -60}, {-72, -100}, {72, -100}, {48, -60}, {-48, -60}}), Rectangle(fillColor = {0, 127, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 32}, {100, -32}}), Ellipse(fillColor = {26, 182, 199}, fillPattern = FillPattern.Sphere, extent = {{-80, 80}, {80, -80}}), Polygon(origin = {5, -3}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, points = {{-33, 51}, {49, 1}, {-33, -43}, {-33, 49}, {-33, 51}}), Rectangle(origin = {-63, 123}, rotation = 90, fillColor = {238, 238, 238}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-83, -49}, {-23, -77}})}));
end HydraulicPump;

  model System3
  PumpingSystem.HydraulicPump hydraulicPump annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  DSFLib.Mechanical.Rotational.Components.Fixed fixed annotation(
      Placement(transformation(origin = {-88, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  DSFLib.Mechanical.Rotational.Components.ConstTorque constTorque annotation(
      Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Mechanical.Rotational.Components.Inertia inertia annotation(
      Placement(transformation(origin = {-30, 60}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Hydraulics.Components.Valve valve(RH = 1e8)  annotation(
      Placement(transformation(origin = {60, 60}, extent = {{-10, -10}, {10, 10}})));
  DSFLib.Hydraulics.Components.ConstPress constPress annotation(
      Placement(transformation(origin = {-20, -80}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(fixed.flange, constTorque.flange_a) annotation(
      Line(points = {{-88, 0}, {-60, 0}}));
    connect(inertia.flange, constTorque.flange_b) annotation(
      Line(points = {{-40, 60}, {-40, 0}}));
    connect(constTorque.flange_b, hydraulicPump.flange) annotation(
      Line(points = {{-40, 0}, {-10, 0}}));
    connect(constPress.fluidPort, hydraulicPump.fluidPort) annotation(
      Line(points = {{-10, -80}, {0, -80}, {0, -10}}));
    connect(valve.fluidPort_a, constPress.fluidPort) annotation(
      Line(points = {{70, 60}, {80, 60}, {80, -80}, {-10, -80}}));
    connect(hydraulicPump.fluidPort1, valve.fluidPort_b) annotation(
      Line(points = {{0, 10}, {0, 60}, {50, 60}}));
  end System3;
end PumpingSystem;