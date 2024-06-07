package DSFLib
  package Circuits
    package Units
      type Voltage = Real(unit = "V");
      type Current = Real(unit = "A");
    end Units;

    package Interfaces
      connector Pin
        DSFLib.Circuits.Units.Voltage v;
        flow DSFLib.Circuits.Units.Current i;
        annotation(
          Icon(graphics = {Rectangle(fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}})}));
      end Pin;

      partial model OnePort
        DSFLib.Circuits.Interfaces.Pin p annotation(
          Placement(visible = true, transformation(origin = {-102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        DSFLib.Circuits.Interfaces.Pin n annotation(
          Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        DSFLib.Circuits.Units.Voltage v;
        DSFLib.Circuits.Units.Current i;
      equation
        v = p.v - n.v;
        p.i = i;
        n.i + p.i = 0;
      end OnePort;
    end Interfaces;

    package Components
      model Ground
        DSFLib.Circuits.Interfaces.Pin p annotation(
          Placement(visible = true, transformation(origin = {-102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 80}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
      equation
        p.v = 0;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(origin = {0, -30}, points = {{-60, 50}, {60, 50}}, color = {0, 0, 255}), Line(origin = {0, -30}, points = {{-40, 30}, {40, 30}}, color = {0, 0, 255}), Line(origin = {0, -30}, points = {{-20, 10}, {20, 10}}, color = {0, 0, 255}), Line(origin = {0, -30}, points = {{0, 96}, {0, 50}}, color = {0, 0, 255}), Text(origin = {0, -30}, textColor = {0, 0, 255}, extent = {{-150, -10}, {150, -50}}, textString = "%name")}));
      end Ground;

      model Resistor
        extends DSFLib.Circuits.Interfaces.OnePort;
        parameter Real R(unit = "Ohm") = 1;
      equation
        v - R*i = 0;
        annotation(
          Icon(coordinateSystem(initialScale = 0.1), graphics = {Line(points = {{70, 0}, {90, 0}}, color = {0, 0, 255}), Text(extent = {{-150, -40}, {150, -80}}, textString = "R=%R"), Line(points = {{-90, 0}, {-70, 0}}, color = {0, 0, 255}), Text(textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Rectangle(lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-70, 24}, {70, -24}}), Line(visible = false, points = {{0, -100}, {0, -30}}, color = {127, 0, 0}, pattern = LinePattern.Dot)}));
      end Resistor;

      model Capacitor
        extends DSFLib.Circuits.Interfaces.OnePort;
        parameter Real C(unit = "F") = 1;
      equation
        C*der(v) - i = 0;
        annotation(
          Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Line(origin = {4, 0}, points = {{6, 40}, {6, -40}}, color = {0, 0, 255}), Line(origin = {-4, 0}, points = {{-6, 40}, {-6, -40}}, color = {0, 0, 255}), Text(extent = {{-150, -40}, {150, -80}}, textString = "C=%C"), Line(points = {{10, 0}, {90, 0}}, color = {0, 0, 255}), Line(points = {{-90, 0}, {-10, 0}}, color = {0, 0, 255})}));
      end Capacitor;

      model Inductor
        extends DSFLib.Circuits.Interfaces.OnePort;
        parameter Real L(unit = "H") = 1;
      equation
        L*der(i) - v = 0;
        annotation(
          Icon(graphics = {Text(extent = {{-150, -40}, {150, -80}}, textString = "L=%L"), Line(points = {{-30, 0}, {-29, 6}, {-22, 14}, {-8, 14}, {-1, 6}, {0, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(points = {{30, 0}, {31, 6}, {38, 14}, {52, 14}, {59, 6}, {60, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(points = {{-60, 0}, {-59, 6}, {-52, 14}, {-38, 14}, {-31, 6}, {-30, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(points = {{-90, 0}, {-60, 0}}, color = {0, 0, 255}), Line(points = {{0, 0}, {1, 6}, {8, 14}, {22, 14}, {29, 6}, {30, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(points = {{60, 0}, {90, 0}}, color = {0, 0, 255}), Text(textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name")}));
      end Inductor;

      model Diode
        extends DSFLib.Circuits.Interfaces.OnePort;
        parameter Real Ron = 1e-5, Roff = 1e5, Vknee = 0.6;
      equation
        i = if v > Vknee then (v - Vknee)/Ron + Vknee/Roff else v/Roff;
        annotation(
          Icon(graphics = {Line(visible = false, points = {{0, -100}, {0, -20}}, color = {127, 0, 0}, pattern = LinePattern.Dot), Line(points = {{-90, 0}, {40, 0}}, color = {0, 0, 255}), Polygon(lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{30, 0}, {-30, 40}, {-30, -40}, {30, 0}}), Text(textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Line(points = {{40, 0}, {90, 0}}, color = {0, 0, 255}), Line(points = {{30, 40}, {30, -40}}, color = {0, 0, 255})}));
      end Diode;

      model Switch
        extends DSFLib.Circuits.Interfaces.OnePort;
        parameter Real Ron = 1e-5, Roff = 1e5;
        discrete Real s;
      equation
        v = if s > 0.5 then i*Ron else i*Roff;
        annotation(
          Icon(graphics = {Line(points = {{-37, 2}, {40, 40}}, color = {0, 0, 255}), Ellipse(lineColor = {0, 0, 255}, extent = {{-44, 4}, {-36, -4}}), Text(textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Line(points = {{-90, 0}, {-44, 0}}, color = {0, 0, 255}), Line(points = {{40, 0}, {90, 0}}, color = {0, 0, 255})}));
      end Switch;

      model ConstCurr
        extends DSFLib.Circuits.Interfaces.OnePort;
        parameter Real I(unit = "A") = 1;
      equation
        i = -I;
        annotation(
          Icon(graphics = {Line(points = {{50, 0}, {90, 0}}, color = {0, 0, 255}), Text(textColor = {0, 0, 255}, extent = {{-150, 60}, {150, 100}}, textString = "%name"), Line(points = {{0, -50}, {0, 50}}, color = {0, 0, 255}), Line(points = {{-90, 0}, {-50, 0}}, color = {0, 0, 255}), Text(extent = {{-150, -100}, {150, -60}}, textString = "I=%I"), Ellipse(lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-50, 50}, {50, -50}}), Polygon(origin = {44, 0}, rotation = 180, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{90, 0}, {60, 10}, {60, -10}, {90, 0}}), Line(origin = {14, 0}, points = {{-30, 0}, {30, 0}, {30, 0}}, color = {0, 0, 255})}));
      end ConstCurr;

      model ConstVolt
        extends DSFLib.Circuits.Interfaces.OnePort;
        parameter Real V(unit = "V") = 1;
      equation
        v = V;
        annotation(
          Icon(graphics = {Ellipse(lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-50, 50}, {50, -50}}), Line(points = {{-80, 20}, {-60, 20}}, color = {0, 0, 255}), Text(extent = {{-150, -110}, {150, -70}}, textString = "V=%V"), Line(points = {{60, 20}, {80, 20}}, color = {0, 0, 255}), Text(textColor = {0, 0, 255}, extent = {{-150, 70}, {150, 110}}, textString = "%name"), Line(points = {{-90, 0}, {-50, 0}}, color = {0, 0, 255}), Line(points = {{-50, 0}, {50, 0}}, color = {0, 0, 255}), Line(points = {{50, 0}, {90, 0}}, color = {0, 0, 255}), Line(points = {{-70, 30}, {-70, 10}}, color = {0, 0, 255})}));
      end ConstVolt;

      model NLInductor
        extends DSFLib.Circuits.Interfaces.OnePort;
        parameter Real[:] currTable = {-2, -1, 0, 1, 2};
        parameter Real[:] fluxTable = {-2, -1, 0, 1, 2};
        Real phi(unit = "V.s");
      equation
        der(phi) = v;
        phi = DSFLib.Utilities.Functions.LookUpTable(i, currTable, fluxTable);
        annotation(
          Icon(graphics = {Line(origin = {-0.02, 50.73}, points = {{-60, 0}, {60, 0}}, color = {0, 0, 255}), Line(origin = {0.3, 32.6}, points = {{-60, 0}, {60, 0}}, color = {0, 0, 255}), Line(points = {{-30, 0}, {-29, 6}, {-22, 14}, {-8, 14}, {-1, 6}, {0, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(points = {{-60, 0}, {-59, 6}, {-52, 14}, {-38, 14}, {-31, 6}, {-30, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Text(origin = {0, -128}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Line(points = {{-90, 0}, {-60, 0}}, color = {0, 0, 255}), Line(points = {{30, 0}, {31, 6}, {38, 14}, {52, 14}, {59, 6}, {60, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(points = {{0, 0}, {1, 6}, {8, 14}, {22, 14}, {29, 6}, {30, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(points = {{60, 0}, {90, 0}}, color = {0, 0, 255})}));
      end NLInductor;
    end Components;

    package Examples
      model RLC
        DSFLib.Circuits.Components.Resistor res(R = 1) annotation(
          Placement(visible = true, transformation(origin = {8, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DSFLib.Circuits.Components.Ground ground annotation(
          Placement(visible = true, transformation(origin = {-8, -6}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
        DSFLib.Circuits.Components.Capacitor cap(C = 100e-6, v(start = 1)) annotation(
          Placement(visible = true, transformation(origin = {32, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        DSFLib.Circuits.Components.Inductor ind(L = 1e-3) annotation(
          Placement(visible = true, transformation(origin = {-28, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(ind.n, res.p) annotation(
          Line(points = {{-18, 50}, {-2, 50}}));
        connect(ind.p, ground.p) annotation(
          Line(points = {{-38, 50}, {-47.5, 50}, {-47.5, 0}, {-8, 0}}));
        connect(cap.n, ground.p) annotation(
          Line(points = {{32, 12}, {31.5, 12}, {31.5, 0}, {-8, 0}}));
        connect(res.n, cap.p) annotation(
          Line(points = {{18, 50}, {32, 50}, {32, 32}}));
        annotation(
          experiment(StartTime = 0, StopTime = 0.02, Tolerance = 1e-06, Interval = 4.00802e-05));
      end RLC;

      package SolarPanels
        package Components
          model SolarCell
            DSFLib.Circuits.Components.Diode dio annotation(
              Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
            DSFLib.Circuits.Components.Resistor rs(R = 0.02) annotation(
              Placement(visible = true, transformation(origin = {52, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
            DSFLib.Circuits.Components.Resistor rsh(R = 250) annotation(
              Placement(visible = true, transformation(origin = {22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
            DSFLib.Circuits.Interfaces.Pin p annotation(
              Placement(visible = true, transformation(origin = {20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
            DSFLib.Circuits.Interfaces.Pin n annotation(
              Placement(visible = true, transformation(origin = {22, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
            DSFLib.Circuits.Components.ConstCurr Iph annotation(
              Placement(visible = true, transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          equation
            connect(dio.p, rs.p) annotation(
              Line(points = {{0, 10}, {0, 20}, {42, 20}}));
            connect(rsh.p, rs.p) annotation(
              Line(points = {{22, 10}, {22, 10}, {22, 20}, {42, 20}, {42, 20}}));
            connect(rs.n, p) annotation(
              Line(points = {{62, 20}, {62, 40}, {20, 40}}));
            connect(rsh.n, dio.n) annotation(
              Line(points = {{22, -10}, {22, -20}, {0, -20}, {0, -10}}));
            connect(Iph.p, rs.p) annotation(
              Line(points = {{-22, 10}, {-22, 20}, {42, 20}}));
            connect(Iph.n, dio.n) annotation(
              Line(points = {{-22, -10}, {-22, -20}, {0, -20}, {0, -10}}));
            connect(rsh.n, n) annotation(
              Line(points = {{22, -10}, {22, -34}}));
          protected
            annotation(
              Diagram,
              Icon(graphics = {Rectangle(lineColor = {147, 147, 147}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-88, 88}, {88, -88}}), Polygon(origin = {0, 1}, lineColor = {62, 62, 62}, fillPattern = FillPattern.Vertical, points = {{-60, 79}, {-80, 59}, {-80, -61}, {-60, -81}, {60, -81}, {80, -61}, {80, 59}, {60, 79}, {-54, 79}, {-60, 79}, {-60, 79}}), Line(origin = {-29.51, 23.68}, points = {{0, 56}, {0, -40}, {0, -102}}, color = {147, 147, 147}, thickness = 0.5), Line(origin = {29.55, 23.88}, points = {{0, 56}, {0, -40}, {0, -104}}, color = {147, 147, 147}, thickness = 0.5), Line(origin = {46.3446, 105}, points = {{-80, 20}, {-60, 20}}, color = {0, 0, 255}), Line(origin = {46.3446, 105}, points = {{-70, 30}, {-70, 10}}, color = {0, 0, 255})}));
          end SolarCell;

          model SolarPanel
            parameter Integer N = 3, M = 4;
            SolarCell[N, M] cell;
            DSFLib.Circuits.Interfaces.Pin p annotation(
              Placement(visible = true, transformation(origin = {100, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
            DSFLib.Circuits.Interfaces.Pin n annotation(
              Placement(visible = true, transformation(origin = {98, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          equation
            for i in 1:N loop
              for j in 1:M - 1 loop
                connect(cell[i, j].p, cell[i, j + 1].p);
                connect(cell[i, j].n, cell[i, j + 1].n);
              end for;
            end for;
            for i in 1:N - 1 loop
              connect(cell[i, 1].n, cell[i + 1, 1].p);
            end for;
            connect(cell[1, 1].p, p);
            connect(cell[N, 1].n, n);
            annotation(
              Icon(graphics = {Bitmap(origin = {-1, -3}, rotation = 90, extent = {{-99, 95}, {99, -95}}, imageSource = "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"), Line(origin = {190.086, 0.362069}, points = {{-80, 20}, {-60, 20}}, color = {0, 0, 255}), Line(origin = {190.086, 0.362069}, points = {{-70, 30}, {-70, 10}}, color = {0, 0, 255})}));
          end SolarPanel;
        end Components;

        model TwoCells
          DSFLib.Circuits.Components.Ground ground annotation(
            Placement(visible = true, transformation(origin = {-2, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.Resistor rl annotation(
            Placement(visible = true, transformation(origin = {-2, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Circuits.Components.Capacitor capacitor(C = 1e-3) annotation(
            Placement(visible = true, transformation(origin = {24, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Circuits.Examples.SolarPanels.Components.SolarCell solarCell_1 annotation(
            Placement(visible = true, transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Examples.SolarPanels.Components.SolarCell solarCell_2 annotation(
            Placement(visible = true, transformation(origin = {-30, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(rl.n, ground.p) annotation(
            Line(points = {{-2, -14}, {-2, -40}}));
          connect(ground.p, capacitor.n) annotation(
            Line(points = {{-2, -40}, {24, -40}, {24, -14}}));
          connect(solarCell_1.n, solarCell_2.p) annotation(
            Line(points = {{-30, 0}, {-30, -10}}));
          connect(solarCell_2.n, ground.p) annotation(
            Line(points = {{-30, -30}, {-30, -40}, {-2, -40}}));
          connect(solarCell_1.p, capacitor.p) annotation(
            Line(points = {{-30, 20}, {-30, 30}, {24, 30}, {24, 6}}));
          connect(rl.p, solarCell_1.p) annotation(
            Line(points = {{-2, 6}, {-2, 30}, {-30, 30}, {-30, 20}}));
          annotation(
            experiment(StartTime = 0, StopTime = 0.02, Tolerance = 1e-06, Interval = 4.00802e-05));
        end TwoCells;

        model SolarPanelLoad
          DSFLib.Circuits.Components.Ground ground annotation(
            Placement(visible = true, transformation(origin = {0, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.Resistor rl(R = 1) annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Circuits.Components.Capacitor capacitor(C = 1e-3) annotation(
            Placement(visible = true, transformation(origin = {22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Circuits.Examples.SolarPanels.Components.SolarPanel solarPanel(M = 10, N = 5) annotation(
            Placement(visible = true, transformation(origin = {-32, -2}, extent = {{-24, -24}, {24, 24}}, rotation = 90)));
        equation
          connect(rl.n, ground.p) annotation(
            Line(points = {{0, -10}, {0, -40}}));
          connect(capacitor.n, ground.p) annotation(
            Line(points = {{22, -10}, {22, -40}, {0, -40}}));
          connect(solarPanel.n, ground.p) annotation(
            Line(points = {{-32, -26}, {-32, -40}, {0, -40}}));
          connect(solarPanel.p, rl.p) annotation(
            Line(points = {{-32, 22}, {-32, 36}, {0, 36}, {0, 10}}));
          connect(capacitor.p, rl.p) annotation(
            Line(points = {{22, 10}, {22, 36}, {0, 36}, {0, 10}}));
          annotation(
            experiment(StartTime = 0, StopTime = 0.001, Tolerance = 1e-6, Interval = 6.66667e-07));
        end SolarPanelLoad;
      end SolarPanels;
    end Examples;
  end Circuits;

  package Mechanical
    package Translational
      package Units
        type Position = Real(unit = "m");
        type Force = Real(unit = "N");
      end Units;

      package Interfaces
        import DSFLib.Mechanical.Translational.Units.*;

        connector Flange
          Position s;
          flow Force f;
          annotation(
            Icon(graphics = {Rectangle(fillColor = {0, 118, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}})}, coordinateSystem(initialScale = 0.1)));
        end Flange;

        partial model Compliant
          DSFLib.Mechanical.Translational.Interfaces.Flange flange_b annotation(
            Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -4.44089e-16}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Interfaces.Flange flange_a annotation(
            Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 1.55431e-15}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          Position s_rel;
          Force f;
        equation
          s_rel = flange_b.s - flange_a.s;
          flange_b.f = f;
          flange_a.f = -f;
        end Compliant;
      end Interfaces;

      package Components
        import DSFLib.Mechanical.Translational.Units.*;
        import DSFLib.Mechanical.Translational.Interfaces.*;

        model Fixed
          DSFLib.Mechanical.Translational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {2, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1.55431e-15, -1.55431e-15}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          parameter Position s_0 = 0;
        equation
          flange.s = s_0;
          annotation(
            Icon(coordinateSystem(initialScale = 0.1), graphics = {Line(points = {{40, -40}, {0, -80}}, color = {0, 127, 0}), Line(points = {{-40, -40}, {-80, -80}}, color = {0, 127, 0}), Line(points = {{-80, -40}, {80, -40}}, color = {0, 127, 0}), Line(points = {{0, -40}, {0, -10}}, color = {0, 127, 0}), Line(points = {{80, -40}, {40, -80}}, color = {0, 127, 0}), Line(points = {{0, -40}, {-40, -80}}, color = {0, 127, 0}), Text(textColor = {0, 0, 255}, extent = {{-150, -90}, {150, -130}}, textString = "%name")}));
        end Fixed;

        model Mass
          DSFLib.Mechanical.Translational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -4.44089e-16}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          parameter Real m(unit = "Kg") = 1;
          Position s;
          Real v(unit = "m/s");
          Force f;
        equation
          s = flange.s;
          f = flange.f;
          m*der(v) - f = 0;
          der(s) - v = 0;
          annotation(
            Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(textColor = {0, 0, 255}, extent = {{-150, 85}, {150, 45}}, textString = "%name"), Text(extent = {{-150, -45}, {150, -75}}, textString = "m=%m"), Rectangle(origin = {-2, 0}, lineColor = {0, 127, 0}, fillColor = {160, 215, 160}, fillPattern = FillPattern.Sphere, extent = {{-73, -36}, {74, 36}})}));
        end Mass;

        model Spring
          extends Compliant;
          parameter Real k(unit = "N/m") = 1;
          parameter Position s_rel0 = 0;
        equation
          f = k*(s_rel - s_rel0);
          annotation(
            Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {0, -8}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Text(extent = {{-150, -45}, {150, -75}}, textString = "k=%k"), Line(points = {{-98, 0}, {-60, 0}, {-44, -30}, {-16, 30}, {14, -30}, {44, 30}, {60, 0}, {100, 0}}, color = {0, 127, 0})}));
        end Spring;

        model Damper
          extends Compliant;
          parameter Real b(unit = "N.s/m") = 1;
        equation
          f = b*der(s_rel);
          annotation(
            Icon(coordinateSystem(initialScale = 0.1), graphics = {Line(points = {{-90, 0}, {100, 0}}, color = {0, 127, 0}), Line(visible = false, points = {{-100, -100}, {-100, -20}, {-14, -20}}, color = {191, 0, 0}, pattern = LinePattern.Dot), Text(origin = {0, -8}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Line(points = {{-60, -30}, {-60, 30}}), Line(points = {{60, -30}, {-60, -30}, {-60, 30}, {60, 30}}, color = {0, 127, 0}), Rectangle(lineColor = {0, 127, 0}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, extent = {{-60, 30}, {30, -30}}), Text(extent = {{-150, -45}, {150, -75}}, textString = "b=%b")}));
        end Damper;

        model ConstForce
          DSFLib.Mechanical.Translational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {-98, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -1.55431e-15}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          parameter Force F = 1;
        equation
          flange.f = -F;
          annotation(
            Diagram,
            Icon(graphics = {Text(origin = {4, -58}, extent = {{-98, 16}, {98, -16}}, textString = "F=%F"), Text(origin = {-2, -6}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Polygon(origin = {40, 0}, lineColor = {0, 127, 0}, fillColor = {160, 215, 160}, fillPattern = FillPattern.Solid, points = {{-100, 10}, {14, 10}, {14, 27}, {60, 0}, {14, -27}, {14, -10}, {-100, -10}, {-100, 10}}), Line(origin = {-77, 0}, points = {{17, 0}, {-17, 0}, {-17, 0}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end ConstForce;

        model ModulatedForce
          DSFLib.Mechanical.Translational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {-98, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -1.55431e-15}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Interfaces.RealInput u annotation(
            Placement(visible = true, transformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2.22045e-16, 60}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
        equation
          flange.f = -u;
          annotation(
            Icon(graphics = {Polygon(origin = {40, 0}, lineColor = {0, 127, 0}, fillColor = {160, 215, 160}, fillPattern = FillPattern.Solid, points = {{-100, 10}, {14, 10}, {14, 27}, {60, 0}, {14, -27}, {14, -10}, {-100, -10}, {-100, 10}}), Line(origin = {-77, 0}, points = {{17, 0}, {-17, 0}, {-17, 0}}), Text(origin = {-2, -126}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name")}));
        end ModulatedForce;
      end Components;

      package Examples
        import DSFLib.Mechanical.Translational.Components.*;

        model SpringMass
          DSFLib.Mechanical.Translational.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Translational.Components.Mass mass(s(start = 1)) annotation(
            Placement(visible = true, transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.Spring spring annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(spring.flange_b, mass.flange) annotation(
            Line(points = {{10, -4.44089e-17}, {17, -4.44089e-17}, {17, 0}, {28, 0}}));
          connect(fixed.flange, spring.flange_a) annotation(
            Line(points = {{-22, 0}, {-10, 0}}));
          annotation(
            Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
            experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.04));
        end SpringMass;

        model SpringMassForce
          DSFLib.Mechanical.Translational.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Translational.Components.Mass mass(s(start = 0)) annotation(
            Placement(visible = true, transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.Spring spring annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.ConstForce constForce annotation(
            Placement(visible = true, transformation(origin = {58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(spring.flange_b, mass.flange) annotation(
            Line(points = {{10, -4.44089e-17}, {17, -4.44089e-17}, {17, 0}, {20, 0}}));
          connect(fixed.flange, spring.flange_a) annotation(
            Line(points = {{-22, 0}, {-10, 0}}));
          connect(constForce.flange, mass.flange) annotation(
            Line(points = {{48, 0}, {20, 0}}));
          annotation(
            Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
            experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
        end SpringMassForce;

        model SpringDamperMass
          DSFLib.Mechanical.Translational.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-34, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
          DSFLib.Mechanical.Translational.Components.Mass mass(m = 10, s(start = 1)) annotation(
            Placement(visible = true, transformation(origin = {36, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.Spring spring annotation(
            Placement(visible = true, transformation(origin = {0, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.Damper damper annotation(
            Placement(visible = true, transformation(origin = {0, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(fixed.flange, spring.flange_a) annotation(
            Line(points = {{-34, 0}, {-20, 0}, {-20, -10}, {-10, -10}}));
          connect(damper.flange_a, spring.flange_a) annotation(
            Line(points = {{-10, 10}, {-20, 10}, {-20, -10}, {-10, -10}}));
          connect(damper.flange_b, spring.flange_b) annotation(
            Line(points = {{10, 10}, {18, 10}, {18, -10}, {10, -10}}));
          connect(mass.flange, damper.flange_b) annotation(
            Line(points = {{36, 0}, {18, 0}, {18, 10}, {10, 10}}));
          annotation(
            Diagram,
            experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-06, Interval = 0.12));
        end SpringDamperMass;
      end Examples;
    end Translational;

    package Rotational
      package Units
        type Angle = Real(unit = "rad");
        type Torque = Real(unit = "N.m");
      end Units;

      package Interfaces
        connector Flange
          DSFLib.Mechanical.Rotational.Units.Angle phi;
          flow DSFLib.Mechanical.Rotational.Units.Torque tau;
          annotation(
            Icon(coordinateSystem(initialScale = 0.1), graphics = {Ellipse(fillColor = {193, 193, 193}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}})}));
        end Flange;

        partial model Compliant
          DSFLib.Mechanical.Rotational.Interfaces.Flange flange_b annotation(
            Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {99, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Interfaces.Flange flange_a annotation(
            Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-101, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Units.Angle phi_rel;
          DSFLib.Mechanical.Rotational.Units.Torque tau;
        equation
          phi_rel = flange_b.phi - flange_a.phi;
          flange_b.tau = tau;
          flange_a.tau = -tau;
        end Compliant;
      end Interfaces;

      package Components
        import DSFLib.Mechanical.Rotational.Units.*;
        import DSFLib.Mechanical.Rotational.Interfaces.*;

        model Fixed
          parameter Angle phi_0 = 0;
          DSFLib.Mechanical.Rotational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.22045e-16, 8.88178e-16}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        equation
          flange.phi = phi_0;
          annotation(
            Icon(graphics = {Line(points = {{-80, -40}, {80, -40}}), Text(textColor = {0, 0, 255}, extent = {{-150, -90}, {150, -130}}, textString = "%name"), Line(points = {{80, -40}, {40, -80}}), Line(points = {{-40, -40}, {-80, -80}}), Line(points = {{40, -40}, {0, -80}}), Line(points = {{0, -40}, {0, -10}}), Line(points = {{0, -40}, {-40, -80}})}));
        end Fixed;

        model Inertia
          DSFLib.Mechanical.Rotational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-98, -8.88178e-16}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          parameter Real J(unit = "Kg.m2") = 1;
          Angle phi;
          Real w(unit = "rad/s");
          Torque tau;
        equation
          phi = flange.phi;
          tau = flange.tau;
          J*der(w) - tau = 0;
          der(phi) - w = 0;
          annotation(
            Icon(graphics = {Text(origin = {5, 118}, extent = {{-105, 18}, {105, -18}}, textString = "J=%J"), Rectangle(origin = {17, -4}, fillColor = {238, 238, 238}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-57, 104}, {43, -96}}, radius = 20), Rectangle(origin = {-17, 63}, fillColor = {238, 238, 238}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-83, -49}, {-23, -77}}), Text(origin = {6, -184}, textColor = {0, 0, 255}, extent = {{-150, 80}, {150, 40}}, textString = "%name")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
        end Inertia;

        model Spring
          extends Compliant;
          parameter Real k(unit = "N.m/rad") = 1;
          parameter Angle phi_rel0 = 0;
        equation
          tau = k*(phi_rel - phi_rel0);
          annotation(
            Icon(graphics = {Text(textColor = {0, 0, 255}, extent = {{-150, 80}, {150, 40}}, textString = "%name"), Line(points = {{-100, 0}, {-58, 0}, {-43, -30}, {-13, 30}, {17, -30}, {47, 30}, {62, 0}, {100, 0}}), Text(origin = {9, -12}, extent = {{-141, -34}, {141, -68}}, textString = "k=%k")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end Spring;

        model Damper
          extends Compliant;
          parameter Real b(unit = "N.m.s/rad") = 1;
        equation
          tau = b*der(phi_rel);
          annotation(
            Icon(graphics = {Line(visible = false, points = {{-100, -100}, {-100, -40}, {-20, -40}, {-20, 0}}, color = {191, 0, 0}, pattern = LinePattern.Dot), Rectangle(fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, extent = {{-60, 30}, {30, -30}}), Line(points = {{-60, 30}, {60, 30}}), Line(points = {{-90, 0}, {-60, 0}}), Line(points = {{-60, -30}, {-60, 30}}), Text(textColor = {0, 0, 255}, extent = {{-150, 80}, {150, 40}}, textString = "%name"), Line(points = {{-60, -30}, {60, -30}}), Text(extent = {{-150, -50}, {150, -90}}, textString = "b=%b"), Line(points = {{30, 0}, {90, 0}})}));
        end Damper;

        model ConstTorque
          extends DSFLib.Mechanical.Rotational.Interfaces.Compliant;
          parameter Real Tau(unit = "N.m") = 1;
        equation
          tau = -Tau;
          annotation(
            Icon(graphics = {Text(origin = {-4, 80}, extent = {{-96, 16}, {96, -16}}, textString = "Tau=%Tau"), Line(origin = {74.38, -0.191319}, points = {{-14, 0}, {14, 0}}, thickness = 0.5), Line(origin = {-74.6161, -0.292183}, points = {{-14, 0}, {14, 0}}, thickness = 0.5), Line(origin = {-38.81, -0.53}, points = {{-18.6464, 41}, {21.3536, 1}, {-20.6464, -41}}, thickness = 0.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 10, smooth = Smooth.Bezier), Line(origin = {39.2395, 0.441271}, rotation = 180, points = {{-18.6464, 41}, {21.3536, 1}, {-20.6464, -41}}, thickness = 0.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 10, smooth = Smooth.Bezier), Text(origin = {-4, -154}, textColor = {0, 0, 255}, extent = {{-150, 80}, {150, 40}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
        end ConstTorque;
      end Components;

      package Examples
        import DSFLib.Mechanical.Rotational.Components.*;

        model SpringDamperInertia
          DSFLib.Mechanical.Rotational.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-24, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
          DSFLib.Mechanical.Rotational.Components.Inertia inertia(J = 0.009, phi(start = 1), w(start = 0.2)) annotation(
            Placement(visible = true, transformation(origin = {34, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Spring spring(k = 2.7114) annotation(
            Placement(visible = true, transformation(origin = {0, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Damper damper(b = 0.04) annotation(
            Placement(visible = true, transformation(origin = {0, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(spring.flange_b, damper.flange_b) annotation(
            Line(points = {{9.9, 11.9}, {15.9, 11.9}, {15.9, -12.1}, {9.9, -12.1}}));
          connect(spring.flange_b, inertia.flange) annotation(
            Line(points = {{9.9, 11.9}, {15.9, 11.9}, {15.9, -0.1}, {23.9, -0.1}}));
          connect(spring.flange_a, damper.flange_a) annotation(
            Line(points = {{-10.1, 11.9}, {-16.1, 11.9}, {-16.1, -12.1}, {-10.1, -12.1}}));
          connect(fixed.flange, spring.flange_a) annotation(
            Line(points = {{-24, 2.22045e-17}, {-16, 2.22045e-17}, {-16, 12}, {-10, 12}}));
          annotation(
            experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-06, Interval = 0.01));
        end SpringDamperInertia;
      end Examples;
    end Rotational;

    package RotoTranslational
      package Components
        model RackPinion
          DSFLib.Mechanical.Translational.Interfaces.Flange flangeT annotation(
            Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -70}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Interfaces.Flange flangeR annotation(
            Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-21, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          parameter Real r(unit = "m") = 1 "Pinion radius";
          parameter Real s_0(unit = "m") = 0 "Position s when angle phi=0";
        equation
          flangeT.s - s_0 = r*flangeR.phi;
          r*flangeT.f = -flangeR.tau;
          annotation(
            Icon(graphics = {Line(origin = {-79.4754, -70.0239}, points = {{6, 0}, {-6, 0}, {6, 0}}), Text(origin = {48, -8}, extent = {{-150, 50}, {150, 80}}, textString = "r=%r"), Rectangle(fillColor = {72, 143, 0}, fillPattern = FillPattern.Solid, extent = {{-74.41, -80}, {106.59, -60}}), Polygon(origin = {-20, 0}, rotation = 10, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-5.3473, 43.0304}, {-10, 10}, {-45, 5}, {-45, -5}, {-10, -10}, {-5, -45}, {5, -45}, {10, -10}, {41.0608, -4.30541}, {41.0608, 5.69459}, {10, 10}, {4.6527, 43.0304}, {-5.3473, 43.0304}}), Polygon(origin = {-20, 0}, rotation = 55, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-5, 45}, {-10, 10}, {-45, 5}, {-45, -5}, {-10, -10}, {-5, -45}, {5, -45}, {10, -10}, {43.3617, -6.14715}, {43.3617, 3.85285}, {10, 10}, {5, 45}, {-5, 45}}), Polygon(origin = {16.88, -50}, fillColor = {66, 132, 0}, fillPattern = FillPattern.Solid, points = {{-84.375, -10}, {-79.375, 10}, {-69.375, 10}, {-64.375, -10}, {-54.375, -10}, {-49.375, 10}, {-39.375, 10}, {-34.375, -10}, {-24.375, -10}, {-19.375, 10}, {-9.375, 10}, {-4.375, -10}, {5.625, -10}, {10.625, 10}, {20.625, 10}, {25.625, -10}, {35.625, -10}, {40.625, 10}, {50.625, 10}, {55.625, -10}, {65.625, -10}, {70.625, 10}, {78.125, 10}, {78.125, -10}, {-84.375, -10}}), Ellipse(origin = {-21, -1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-29, -29}, {29, 29}}), Text(origin = {0, -222}, textColor = {0, 0, 255}, extent = {{-150, 85}, {150, 125}}, textString = "%name")}));
        end RackPinion;
      end Components;

      package Examples
        model RotTrans
          DSFLib.Mechanical.Rotational.Components.Inertia inertia(J = 1, phi(start = 1)) annotation(
            Placement(visible = true, transformation(origin = {37, 11}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Fixed fixed1 annotation(
            Placement(visible = true, transformation(origin = {54, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
          DSFLib.Mechanical.Rotational.Components.Spring spring(k = 1) annotation(
            Placement(visible = true, transformation(origin = {36, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.Damper damper(b = 1) annotation(
            Placement(visible = true, transformation(origin = {-42, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.Mass mass(m = 1) annotation(
            Placement(visible = true, transformation(origin = {-18, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-62, 6}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
          DSFLib.Mechanical.RotoTranslational.Components.RackPinion rackPinion(r = 0.1) annotation(
            Placement(visible = true, transformation(origin = {6, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(spring.flange_b, fixed1.flange) annotation(
            Line(points = {{45.9, 35.9}, {51.9, 35.9}, {51.9, 36}, {54, 36}}));
          connect(damper.flange_b, mass.flange) annotation(
            Line(points = {{-32, 6}, {-18, 6}}));
          connect(damper.flange_a, fixed.flange) annotation(
            Line(points = {{-52, 6}, {-62, 6}}));
          connect(rackPinion.flangeT, mass.flange) annotation(
            Line(points = {{-4, 5}, {-12, 5}, {-12, 6}, {-18, 6}}));
          connect(spring.flange_a, inertia.flange) annotation(
            Line(points = {{25.9, 35.9}, {19.9, 35.9}, {19.9, 11}, {28, 11}}));
          connect(rackPinion.flangeR, inertia.flange) annotation(
            Line(points = {{4, 12}, {20, 12}, {20, 11}, {28, 11}}));
          annotation(
            experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.04));
        end RotTrans;
      end Examples;
    end RotoTranslational;

    package Planar
      package Units
        type Position = DSFLib.Mechanical.Translational.Units.Position[2];
        type Force = DSFLib.Mechanical.Translational.Units.Force[2];
      end Units;

      package Interfaces
        connector Frame
          DSFLib.Mechanical.Planar.Units.Position r;
          flow DSFLib.Mechanical.Planar.Units.Force f;
          DSFLib.Mechanical.Rotational.Units.Angle phi;
          flow DSFLib.Mechanical.Rotational.Units.Torque tau;
          annotation(
            Icon(graphics = {Rectangle(fillColor = {221, 221, 221}, fillPattern = FillPattern.Solid, extent = {{-22, 100}, {22, -100}})}));
        end Frame;

        partial model Compliant
          DSFLib.Mechanical.Planar.Interfaces.Frame frame_a annotation(
            Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-104, 2.55351e-15}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Interfaces.Frame frame_b annotation(
            Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {104, 1.11022e-15}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
          Real l(unit = "m");
          Real phi(unit = "rad");
          Real w(unit = "rad/s");
          DSFLib.Mechanical.Translational.Units.Force f;
        equation
          frame_b.r[1] - frame_a.r[1] = l*cos(phi);
          frame_b.r[2] - frame_a.r[2] = l*sin(phi);
          der(phi) = w;
          frame_a.f = -frame_b.f;
          phi = frame_a.phi;
          phi = frame_b.phi;
          frame_a.tau + frame_b.tau + l*cos(phi)*frame_b.f[2] - l*sin(phi)*frame_b.f[1] = 0;
          frame_b.f[1]*cos(phi) + frame_b.f[2]*sin(phi) = f;
        end Compliant;
      end Interfaces;

      package Components
        model Fixed
          parameter DSFLib.Mechanical.Planar.Units.Position r = {0, 0};
          parameter DSFLib.Mechanical.Rotational.Units.Angle phi = 0;
          DSFLib.Mechanical.Planar.Interfaces.Frame frame annotation(
            Placement(visible = true, transformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {104, 6.66134e-16}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        equation
          frame.r = r;
          frame.phi = phi;
          annotation(
            Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Text(textColor = {0, 0, 255}, extent = {{150, 145}, {-150, 105}}, textString = "%name"), Text(extent = {{-150, -105}, {150, -135}}, textString = "r=%r"), Line(origin = {40.231, -0.362069}, rotation = -90, points = {{0, -40}, {-40, -80}}), Line(origin = {40.231, -0.362069}, rotation = -90, points = {{0, -40}, {0, 60}}), Line(origin = {40.231, -0.362069}, rotation = -90, points = {{-40, -40}, {-80, -80}}), Line(origin = {40.231, -0.362069}, rotation = -90, points = {{-80, -40}, {80, -40}}), Line(origin = {40.231, -0.362069}, rotation = -90, points = {{40, -40}, {0, -80}}), Line(origin = {40.231, -0.362069}, rotation = -90, points = {{80, -40}, {40, -80}})}),
            Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}})));
        end Fixed;

        model Body
          DSFLib.Mechanical.Planar.Interfaces.Frame frame annotation(
            Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-105, -1}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
          parameter Real m(unit = "Kg") = 1 "Mass of the body";
          parameter Real J(unit = "Kg.m2") = 0.1 "Inertia of the body";
          parameter Real[2] g(each unit = "m/s2") = {0, -9.81} "Gravity acceleration";
          DSFLib.Mechanical.Planar.Units.Position r;
          Real[2] v;
          DSFLib.Mechanical.Rotational.Units.Angle phi;
          Real w;
        equation
          r = frame.r;
          phi = frame.phi;
          v = der(r);
          w = der(phi);
          m*der(v) = frame.f + m*g;
          J*der(w) = frame.tau;
          annotation(
            Icon(graphics = {Rectangle(fillColor = {85, 170, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 40}, {-20, -40}}), Ellipse(fillColor = {85, 170, 255}, fillPattern = FillPattern.Sphere, extent = {{-60, 60}, {60, -60}}), Text(extent = {{150, -96}, {-150, -66}}, textString = "m=%m"), Text(extent = {{150, -130}, {-150, -100}}, textString = "J=%J"), Text(textColor = {0, 0, 255}, extent = {{-150, 100}, {150, 60}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end Body;

        model pointMass
          DSFLib.Mechanical.Planar.Interfaces.Frame frame annotation(
            Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.44249e-15, 2.44249e-15}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
          parameter Real m(unit = "Kg") = 1 "Mass of the body";
          parameter Real[2] g(each unit = "m/s2") = {0, -9.81} "Gravity acceleration";
          DSFLib.Mechanical.Planar.Units.Position r;
          Real[2] v;
        equation
          r = frame.r;
          v = der(r);
          m*der(v) = frame.f + m*g;
          frame.tau = 0;
          annotation(
            Icon(graphics = {Ellipse(fillColor = {85, 170, 255}, fillPattern = FillPattern.Sphere, extent = {{-60, 60}, {60, -60}}), Text(extent = {{150, -96}, {-150, -66}}, textString = "m=%m"), Text(textColor = {0, 0, 255}, extent = {{-150, 100}, {150, 60}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end pointMass;

        model RigidBar
          extends DSFLib.Mechanical.Planar.Interfaces.Compliant;
          parameter Real L(unit = "m") = 1;
        equation
          l = L;
          annotation(
            Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(origin = {0, -1}, fillColor = {179, 179, 179}, fillPattern = FillPattern.Solid, extent = {{-100, 7}, {100, -7}}), Text(textColor = {0, 0, 255}, extent = {{-150, 100}, {150, 60}}, textString = "%name"), Text(extent = {{150, -96}, {-150, -66}}, textString = "L=%L")}));
        end RigidBar;

        model Revolute
          DSFLib.Mechanical.Planar.Interfaces.Frame frame_a annotation(
            Placement(visible = true, transformation(origin = {-102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-104, 3.9968e-15}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Interfaces.Frame frame_b annotation(
            Placement(visible = true, transformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {104, -1.77636e-15}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Interfaces.Flange support annotation(
            Placement(visible = true, transformation(origin = {-60, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-63, -87}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Interfaces.Flange flange_a annotation(
            Placement(visible = true, transformation(origin = {60, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {61, -87}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
        equation
          frame_b.r = frame_a.r;
          frame_a.f = -frame_b.f;
          frame_a.tau = -frame_b.tau;
          frame_b.tau = -flange_a.tau;
          support.phi = 0;
          flange_a.phi = frame_b.phi - frame_a.phi;
          annotation(
            Icon(graphics = {Rectangle(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{30, -60}, {100, 60}}, radius = 10), Rectangle(lineColor = {64, 64, 64}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, extent = {{-30, 11}, {30, -10}}), Rectangle(lineColor = {64, 64, 64}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, extent = {{-30, 11}, {30, -10}}), Text(textColor = {128, 128, 128}, extent = {{-90, 14}, {-54, -11}}, textString = "a"), Line(visible = false, points = {{-20, 70}, {-60, 70}, {-60, 60}}), Rectangle(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, -60}, {-30, 60}}, radius = 10), Polygon(visible = false, lineColor = {64, 64, 64}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{-10, 30}, {10, 30}, {30, 50}, {-30, 50}, {-10, 30}}), Rectangle(lineColor = {64, 64, 64}, extent = {{-100, 60}, {-30, -60}}, radius = 10), Text(textColor = {0, 0, 255}, extent = {{-150, 70}, {150, 110}}, textString = "%name")}));
        end Revolute;

        model Prismatic
          extends DSFLib.Mechanical.Planar.Interfaces.Compliant;
          DSFLib.Mechanical.Translational.Interfaces.Flange support annotation(
            Placement(visible = true, transformation(origin = {-80, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-64, -62}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Interfaces.Flange flange_a annotation(
            Placement(visible = true, transformation(origin = {80, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {64, -62}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
        equation
          f = -flange_a.f;
          support.s = 0;
          flange_a.s = l;
          annotation(
            Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Text(textColor = {0, 0, 255}, extent = {{-150, 100}, {150, 60}}, textString = "%name"), Rectangle(lineColor = {0, 0, 255}, fillColor = {192, 192, 192}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100, -50}, {-30, 41}}), Line(points = {{-30, -50}, {-30, 50}}), Text(textColor = {128, 128, 128}, extent = {{60, 12}, {96, -13}}, textString = "b"), Rectangle(lineColor = {0, 0, 255}, fillColor = {192, 192, 192}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-30, -30}, {100, 20}}), Rectangle(lineColor = {0, 0, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-30, 20}, {100, 30}}), Rectangle(lineColor = {0, 0, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100, 40}, {-30, 50}})}));
        end Prismatic;
      end Components;

      package Examples
        model Pendulum
          DSFLib.Mechanical.Planar.Components.Revolute revolute annotation(
            Placement(visible = true, transformation(origin = {0, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.RigidBar rigidBar(phi.start = -1) annotation(
            Placement(visible = true, transformation(origin = {24, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Planar.Components.pointMass pointMass annotation(
            Placement(visible = true, transformation(origin = {24, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Planar.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-28, 38}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
        equation
          connect(revolute.frame_b, rigidBar.frame_a) annotation(
            Line(points = {{10, 18}, {24, 18}, {24, 6}}));
          connect(pointMass.frame, rigidBar.frame_b) annotation(
            Line(points = {{24, -30}, {24, -14}}));
          connect(fixed.frame, revolute.frame_a) annotation(
            Line(points = {{-28, 27.6}, {-28, 18}, {-10, 18}}));
          annotation(
            Diagram,
            experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.04));
        end Pendulum;

        model PhysicalPendulum
          DSFLib.Mechanical.Planar.Components.Body body(phi.start = -1) annotation(
            Placement(visible = true, transformation(origin = {18, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Planar.Components.Revolute revolute annotation(
            Placement(visible = true, transformation(origin = {0, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.RigidBar rigidBar annotation(
            Placement(visible = true, transformation(origin = {18, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Planar.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-26, 38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        equation
          connect(revolute.frame_b, rigidBar.frame_a) annotation(
            Line(points = {{10.4, 18}, {18.4, 18}, {18.4, 10}}));
          connect(rigidBar.frame_b, body.frame) annotation(
            Line(points = {{18, -10.4}, {18, -16.4}}));
          connect(fixed.frame, revolute.frame_a) annotation(
            Line(points = {{-26, 27.6}, {-26, 17.6}, {-10, 17.6}}));
          annotation(
            Diagram,
            experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.04));
        end PhysicalPendulum;

        model DoublePendulum
          DSFLib.Mechanical.Planar.Components.Revolute revolute annotation(
            Placement(visible = true, transformation(origin = {0, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.RigidBar rigidBar(phi.start = -1) annotation(
            Placement(visible = true, transformation(origin = {24, 4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Planar.Components.pointMass pointMass(m = 0.5) annotation(
            Placement(visible = true, transformation(origin = {24, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Mechanical.Planar.Components.pointMass pointMass1 annotation(
            Placement(visible = true, transformation(origin = {-24, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Mechanical.Planar.Components.RigidBar rigidBar1 annotation(
            Placement(visible = true, transformation(origin = {-24, -46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Planar.Components.Revolute revolute1 annotation(
            Placement(visible = true, transformation(origin = {0, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Mechanical.Planar.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-24, 54}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        equation
          connect(revolute.frame_b, rigidBar.frame_a) annotation(
            Line(points = {{10.4, 28}, {24.4, 28}, {24.4, 14}}));
          connect(pointMass.frame, rigidBar.frame_b) annotation(
            Line(points = {{24, -28}, {24, -6}}));
          connect(pointMass1.frame, rigidBar1.frame_b) annotation(
            Line(points = {{-24, -72}, {-24, -66.1}, {-24.3, -66.1}, {-24.3, -56.1}}));
          connect(pointMass.frame, revolute1.frame_a) annotation(
            Line(points = {{24, -28}, {15, -28}, {15, -27.9}, {10.3, -27.9}}));
          connect(rigidBar1.frame_a, revolute1.frame_b) annotation(
            Line(points = {{-24, -36}, {-24, -27.2}, {-10, -27.2}}));
          connect(revolute.frame_a, fixed.frame) annotation(
            Line(points = {{-10, 28}, {-24.4, 28}, {-24.4, 44}}));
          annotation(
            Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
            experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-06, Interval = 0.006));
        end DoublePendulum;

        model BridgeCrane
          DSFLib.Mechanical.Planar.Components.Revolute revolute annotation(
            Placement(visible = true, transformation(origin = {26, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.RigidBar rigidBar(phi.start = -1) annotation(
            Placement(visible = true, transformation(origin = {46, -6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Planar.Components.pointMass pointMass(m = 1000) annotation(
            Placement(visible = true, transformation(origin = {46, -28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Planar.Components.Prismatic prismatic annotation(
            Placement(visible = true, transformation(origin = {-26, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.pointMass pointMass1(m = 100) annotation(
            Placement(visible = true, transformation(origin = {0, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.Damper damper annotation(
            Placement(visible = true, transformation(origin = {-26, -12}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-58, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(revolute.frame_b, rigidBar.frame_a) annotation(
            Line(points = {{36.4, 12}, {46.4, 12}, {46.4, 4}}));
          connect(pointMass.frame, rigidBar.frame_b) annotation(
            Line(points = {{46, -28}, {46, -16}}));
          connect(prismatic.frame_b, pointMass1.frame) annotation(
            Line(points = {{-15.6, 12}, {0.4, 12}}));
          connect(pointMass1.frame, revolute.frame_a) annotation(
            Line(points = {{2.44249e-16, 12}, {16, 12}}));
          connect(fixed.frame, prismatic.frame_a) annotation(
            Line(points = {{-47.6, 12}, {-35.6, 12}}));
          connect(prismatic.support, damper.flange_a) annotation(
            Line(points = {{-32.4, 5.8}, {-32.4, -0.2}, {-40.4, -0.2}, {-40.4, -12.2}, {-34.4, -12.2}}));
          connect(prismatic.flange_a, damper.flange_b) annotation(
            Line(points = {{-19.6, 5.8}, {-19.6, -0.2}, {-11.6, -0.2}, {-11.6, -12.2}, {-17.6, -12.2}}));
          annotation(
            Diagram,
            experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
        end BridgeCrane;

        model SpringPendulum
          DSFLib.Mechanical.Planar.Components.Revolute revolute annotation(
            Placement(visible = true, transformation(origin = {-10, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.pointMass pointMass(r.start = {cos(-1), sin(-1)}) annotation(
            Placement(visible = true, transformation(origin = {18, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Planar.Components.Prismatic prismatic annotation(
            Placement(visible = true, transformation(origin = {18, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Translational.Components.Spring spring(k = 100, s_rel0 = 1) annotation(
            Placement(visible = true, transformation(origin = {-6, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Planar.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-36, 36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        equation
          connect(prismatic.frame_b, pointMass.frame) annotation(
            Line(points = {{18, -28.4}, {18, -50}}));
          connect(revolute.frame_b, prismatic.frame_a) annotation(
            Line(points = {{0.4, 16}, {18.4, 16}, {18.4, -8}}));
          connect(fixed.frame, revolute.frame_a) annotation(
            Line(points = {{-36, 25.6}, {-36, 15.6}, {-20, 15.6}}));
          connect(spring.flange_a, prismatic.support) annotation(
            Line(points = {{-6, -8}, {-6, -2}, {6, -2}, {6, -12}, {12, -12}}));
          connect(spring.flange_b, prismatic.flange_a) annotation(
            Line(points = {{-6, -28}, {-6, -34}, {6, -34}, {6, -24}, {12, -24}}));
          annotation(
            Diagram,
            experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.004));
        end SpringPendulum;

        model SliderCrank
          DSFLib.Mechanical.Planar.Components.Revolute revolute annotation(
            Placement(visible = true, transformation(origin = {-58, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.RigidBar rigidBar(L = 0.1) annotation(
            Placement(visible = true, transformation(origin = {-39, 43}, extent = {{-11, -11}, {11, 11}}, rotation = 90)));
          DSFLib.Mechanical.Planar.Components.Revolute revolute1 annotation(
            Placement(visible = true, transformation(origin = {-22, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.RigidBar rigidBar1(L = 1) annotation(
            Placement(visible = true, transformation(origin = {-5, 43}, extent = {{-11, -11}, {11, 11}}, rotation = -90)));
          DSFLib.Mechanical.Planar.Components.Revolute revolute2 annotation(
            Placement(visible = true, transformation(origin = {14, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.Prismatic prismatic annotation(
            Placement(visible = true, transformation(origin = {58, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Mechanical.Planar.Components.pointMass pointMass(g = {0, 0}) annotation(
            Placement(visible = true, transformation(origin = {36, 18}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.Body body(J = 1, g = {0, 0}, m = 0) annotation(
            Placement(visible = true, transformation(origin = {-20, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.Damper damper(b = 100) annotation(
            Placement(visible = true, transformation(origin = {58, 40}, extent = {{-8, -8}, {8, 8}}, rotation = 180)));
          DSFLib.Mechanical.Planar.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-90, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Planar.Components.Fixed fixed1(r = {2, 0}) annotation(
            Placement(visible = true, transformation(origin = {90, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Mechanical.Rotational.Components.ConstTorque constTorque annotation(
            Placement(visible = true, transformation(origin = {-58, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(revolute.frame_b, rigidBar.frame_a) annotation(
            Line(points = {{-47.6, 18}, {-39, 18}, {-39, 32}}));
          connect(rigidBar.frame_b, revolute1.frame_a) annotation(
            Line(points = {{-39, 54}, {-39, 66}, {-32, 66}}));
          connect(rigidBar1.frame_b, revolute2.frame_a) annotation(
            Line(points = {{-5, 32}, {-4.8, 32}, {-4.8, 17.6}, {4, 17.6}}));
          connect(revolute2.frame_b, prismatic.frame_b) annotation(
            Line(points = {{24.4, 18}, {48.4, 18}}));
          connect(pointMass.frame, prismatic.frame_b) annotation(
            Line(points = {{36, 18}, {48, 18}}));
          connect(fixed.frame, revolute.frame_a) annotation(
            Line(points = {{-80, 18}, {-68, 18}}));
          connect(fixed1.frame, prismatic.frame_a) annotation(
            Line(points = {{80, 18}, {68, 18}}));
          connect(revolute1.frame_b, rigidBar1.frame_a) annotation(
            Line(points = {{-12, 66}, {-4, 66}, {-4, 54}}));
          connect(damper.flange_b, prismatic.flange_a) annotation(
            Line(points = {{50, 40}, {44, 40}, {44, 30}, {52, 30}, {52, 24}}));
          connect(damper.flange_a, prismatic.support) annotation(
            Line(points = {{66, 40}, {72, 40}, {72, 30}, {64, 30}, {64, 24}}));
          connect(body.frame, revolute.frame_b) annotation(
            Line(points = {{-30, 18}, {-48, 18}}));
          connect(revolute.support, constTorque.flange_a) annotation(
            Line(points = {{-64, 10}, {-74, 10}, {-74, -10}, {-68, -10}}));
          connect(revolute.flange_a, constTorque.flange_b) annotation(
            Line(points = {{-52, 10}, {-42, 10}, {-42, -10}, {-48, -10}}));
          annotation(
            experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.004));
        end SliderCrank;
      end Examples;
      annotation();
    end Planar;
  end Mechanical;

  package Hydraulics
    package Units
      type Pressure = Real(unit = "Pa");
      type VolumeFlow = Real(unit = "m3/s");
    end Units;

    package Interfaces
      import DSFLib.Hydraulics.Units.*;

      connector FluidPort
        Pressure p;
        flow VolumeFlow q;
        annotation(
          Icon(graphics = {Ellipse(origin = {0, 1}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 99}, {100, -99}}, endAngle = 360)}));
      end FluidPort;

      partial model TwoPort
        DSFLib.Hydraulics.Interfaces.FluidPort fluidPort_b annotation(
          Placement(visible = true, transformation(origin = {-100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        DSFLib.Hydraulics.Interfaces.FluidPort fluidPort_a annotation(
          Placement(visible = true, transformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        Pressure p;
        VolumeFlow q;
      equation
        p = fluidPort_b.p - fluidPort_a.p;
        q = fluidPort_b.q;
        q = -fluidPort_a.q;
        annotation(
          Icon);
      end TwoPort;
    end Interfaces;

    package Components
      import DSFLib.Hydraulics.Interfaces.*;
      import DSFLib.Hydraulics.Units.*;

      model Valve
        extends TwoPort;
        parameter Real RH(unit = "Pa.s/m3") = 1000 "Hydraulic Resistance";
      equation
        p - RH*q = 0;
        annotation(
          Icon(graphics = {Polygon(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {100, -50}, {100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(origin = {0, 14}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Text(origin = {2, -18}, extent = {{-144, -34}, {144, -68}}, textString = "RH=%RH")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
      end Valve;

      model Tank
        parameter Real A(unit = "m2") = 1 "Tank area";
        parameter Real g(unit = "m/s2") = 9.8;
        parameter Real rho(unit = "Kg/m3") = 1000 "Fluid density";
        DSFLib.Hydraulics.Interfaces.FluidPort fluidPort annotation(
          Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2.22045e-16, -100}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        Real v(unit = "m3", start=1000);
        VolumeFlow q;
        Pressure p;
        Pressure dp;
      equation
        q = der(v);
        p = v*rho*g/A;
        dp = if v > 0 or q > 0 then 0 else 1e10*q;
        fluidPort.q = q;
        fluidPort.p = p + dp;
        annotation(
          Diagram,
          Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}), graphics = {Text(origin = {34, 65}, extent = {{-112, 15}, {54, -15}}, textString = "A=%A"), Text(extent = {{-95, -24}, {95, -44}}, textString = "%level_start"), Rectangle(fillColor = {85, 170, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-100, -100}, {100, 10}}), Line(points = {{-100, 100}, {-100, -100}, {100, -100}, {100, 100}}), Text(textColor = {0, 0, 255}, extent = {{-150, 110}, {150, 150}}, textString = "%name")}));
      end Tank;

      model Inertance
        extends TwoPort;
        parameter Real I(unit = "Pa.s2/m3") = 1;
      equation
        I*der(q) = p;
        annotation(
          Icon(graphics = {Text(origin = {7, 65}, rotation = 180, extent = {{-99, 15}, {115, -27}}, textString = "I=%I"), Rectangle(rotation = -90, fillColor = {0, 170, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-14, 96}, {14, -96}})}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
      end Inertance;

      model Column
        extends TwoPort;
        parameter Real H(unit = "m") = 1 "Column height";
        parameter Real g(unit = "m/s2") = 9.8;
        parameter Real rho(unit = "Kg/m3") = 1000 "Fluid density";
      equation
        p = rho*g*H;
        annotation(
          Icon(graphics = {Rectangle(rotation = -90, fillColor = {0, 170, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-14, 96}, {14, -96}}), Text(origin = {7, 57}, rotation = 180, extent = {{-101, 15}, {117, -27}}, textString = "H=%H")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
      end Column;

      model ConstPress
        parameter Pressure P = 0;
        DSFLib.Hydraulics.Interfaces.FluidPort fluidPort annotation(
          Placement(visible = true, transformation(origin = {94, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -1.11022e-15}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
      equation
        fluidPort.p = P;
        annotation(
          Icon(graphics = {Rectangle(origin = {71, 0}, fillColor = {0, 127, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-29, 32}, {29, -32}}), Ellipse(fillColor = {0, 170, 255}, fillPattern = FillPattern.Sphere, extent = {{-80, 80}, {80, -80}}), Text(origin = {0, -200}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Text(origin = {-25, 102}, rotation = 180, extent = {{-199, 17}, {145, -24}}, textString = "P=%P")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
      end ConstPress;

      model IdealPump
        extends TwoPort;
        parameter Real Q(unit = "m3/s") = 1e-3;
      equation
        q = Q;
        annotation(
          Icon(graphics = {Text(origin = {-17, 107}, rotation = 180, extent = {{-181, 18}, {131, -21}}, textString = "Q=%Q"), Polygon(fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, points = {{-28, 30}, {-28, -30}, {50, -2}, {-28, 30}}), Polygon(lineColor = {0, 0, 255}, pattern = LinePattern.None, fillPattern = FillPattern.VerticalCylinder, points = {{-48, -60}, {-72, -100}, {72, -100}, {48, -60}, {-48, -60}}), Rectangle(fillColor = {0, 127, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-100, 32}, {100, -32}}), Ellipse(fillColor = {26, 182, 199}, fillPattern = FillPattern.Sphere, extent = {{-80, 80}, {80, -80}}), Polygon(origin = {5, -3}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, points = {{-33, 51}, {49, 1}, {-33, -43}, {-33, 49}, {-33, 51}}), Text(origin = {0, -200}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
      end IdealPump;
    end Components;

    package Examples
      import DSFLib.Hydraulics.Components.*;

      model TankValve
        DSFLib.Hydraulics.Components.Column column annotation(
          Placement(visible = true, transformation(origin = {0, 6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        DSFLib.Hydraulics.Components.Tank tank(v(start = 1)) annotation(
          Placement(visible = true, transformation(origin = {-2.22045e-16, 56}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
        Components.Valve valve(RH = 2e7) annotation(
          Placement(visible = true, transformation(origin = {24, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DSFLib.Hydraulics.Components.IdealPump idealPump annotation(
          Placement(visible = true, transformation(origin = {-44, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DSFLib.Hydraulics.Components.ConstPress constPress annotation(
          Placement(visible = true, transformation(origin = {-78, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DSFLib.Hydraulics.Components.ConstPress constPress1 annotation(
          Placement(visible = true, transformation(origin = {58, -14}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      equation
        connect(tank.fluidPort, column.fluidPort_a) annotation(
          Line(points = {{0, 40}, {0, 16}}));
        connect(column.fluidPort_a, valve.fluidPort_b) annotation(
          Line(points = {{0, -4}, {0, -14}, {14, -14}}));
        connect(constPress1.fluidPort, valve.fluidPort_a) annotation(
          Line(points = {{48, -14}, {34, -14}}));
        connect(constPress.fluidPort, idealPump.fluidPort_b) annotation(
          Line(points = {{-68, 30}, {-54, 30}}));
        connect(idealPump.fluidPort_a, tank.fluidPort) annotation(
          Line(points = {{-34, 30}, {0, 30}, {0, 40}}));
        annotation(
          experiment(StartTime = 0, StopTime = 10000, Tolerance = 1e-06, Interval = 20));
      end TankValve;
    end Examples;
  end Hydraulics;

  package Thermal
    package Units
      type Temperature = Real(unit = "K", start = 293);
      type HeatFlow = Real(unit = "W");
    end Units;

    package Interfaces
      import DSFLib.Thermal.Units.*;

      connector HeatPort
        Temperature T;
        flow HeatFlow q;
        annotation(
          Icon(graphics = {Rectangle(fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}})}));
      end HeatPort;

      partial model TwoPort
        DSFLib.Thermal.Interfaces.HeatPort heatPort_b annotation(
          Placement(visible = true, transformation(origin = {-100, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 6.66134e-16}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        DSFLib.Thermal.Interfaces.HeatPort heatPort_a annotation(
          Placement(visible = true, transformation(origin = {100, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 8.88178e-16}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        Temperature T_rel;
        HeatFlow q;
      equation
        T_rel = heatPort_b.T - heatPort_a.T;
        q = heatPort_b.q;
        q = -heatPort_a.q;
      end TwoPort;
    end Interfaces;

    package Components
      import DSFLib.Thermal.Units.*;
      import DSFLib.Thermal.Interfaces.*;

      model HeatCapacitor
        DSFLib.Thermal.Interfaces.HeatPort heatPort annotation(
          Placement(visible = true, transformation(origin = {0, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1.77636e-15, -80}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        parameter Real C(unit = "J/K") = 1 "Heat capacity";
        Temperature T;
        HeatFlow q;
      equation
        C*der(T) = q;
        q = heatPort.q;
        T = heatPort.T;
        annotation(
          Icon(graphics = {Rectangle(origin = {0, 10}, fillColor = {255, 0, 0}, fillPattern = FillPattern.VerticalCylinder, extent = {{-80, 70}, {80, -70}}), Text(origin = {114, -7}, rotation = -90, extent = {{-129, 14}, {129, -14}}, textString = "C=%C"), Text(origin = {-4, 30}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
      end HeatCapacitor;

      model ThermalResistor
        extends TwoPort;
        parameter Real R(unit = "K/W") = 1 "Heat resistance";
      equation
        R*q = T_rel;
        annotation(
          Icon(graphics = {Rectangle(fillColor = {195, 163, 158}, fillPattern = FillPattern.Solid, extent = {{-86, 50}, {86, -50}}), Text(origin = {0, -18}, extent = {{-150, -45}, {150, -75}}, textString = "R=%R"), Line(points = {{-98, 0}, {-60, 0}, {-44, -30}, {-16, 30}, {14, -30}, {44, 30}, {60, 0}, {100, 0}}, color = {255, 0, 0}), Text(origin = {0, 14}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name")}));
      end ThermalResistor;

      model HeatFlowSource
        DSFLib.Thermal.Interfaces.HeatPort heatPort annotation(
          Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 1.9984e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
        parameter HeatFlow Q = 1;
      equation
        heatPort.q = -Q;
        annotation(
          Icon(graphics = {Ellipse(origin = {0, -1}, lineColor = {255, 0, 0}, extent = {{-100, 99}, {100, -99}}), Line(points = {{-80, 0}, {80, 0}}, color = {255, 0, 0}), Polygon(origin = {60, -1}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, points = {{-20, 21}, {20, 1}, {-20, -19}, {-20, 21}}), Text(origin = {1, 119}, extent = {{-123, 9}, {123, -9}}, textString = "q=%Q")}));
      end HeatFlowSource;

      model ConstTemp
        DSFLib.Thermal.Interfaces.HeatPort heatPort annotation(
          Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {97, -1}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
        parameter Temperature T = 273.15;
      equation
        heatPort.T = T;
        annotation(
          Icon(graphics = {Rectangle(origin = {-18, -11}, fillColor = {255, 199, 197}, fillPattern = FillPattern.Forward, extent = {{-168, 97}, {98, -73}}), Text(origin = {-73, -111}, extent = {{-129, 13}, {159, -13}}, textString = "T=%T"), Text(origin = {-101, 1}, extent = {{-79, 23}, {183, -25}}, textString = "Tconst"), Text(origin = {-56, 50}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
      end ConstTemp;
    end Components;

    package Examples
      import DSFLib.Thermal.Components.*;

      model TwoCompartments
        DSFLib.Thermal.Components.ThermalResistor thermalResistor annotation(
          Placement(visible = true, transformation(origin = {-24, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DSFLib.Thermal.Components.HeatFlowSource heatFlowSource annotation(
          Placement(visible = true, transformation(origin = {-84, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DSFLib.Thermal.Components.ThermalResistor thermalResistor1 annotation(
          Placement(visible = true, transformation(origin = {42, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DSFLib.Thermal.Components.HeatCapacitor room1 annotation(
          Placement(visible = true, transformation(origin = {-54, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DSFLib.Thermal.Components.HeatCapacitor room2 annotation(
          Placement(visible = true, transformation(origin = {10, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DSFLib.Thermal.Components.ConstTemp constTemp annotation(
          Placement(visible = true, transformation(origin = {76, 14}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      equation
        connect(room1.heatPort, thermalResistor.heatPort_b) annotation(
          Line(points = {{-54, 26}, {-54, 14}, {-34, 14}}));
        connect(heatFlowSource.heatPort, room1.heatPort) annotation(
          Line(points = {{-74, 14}, {-54, 14}, {-54, 26}}));
        connect(room2.heatPort, thermalResistor.heatPort_a) annotation(
          Line(points = {{10, 26}, {10, 14}, {-14, 14}}));
        connect(thermalResistor1.heatPort_b, room2.heatPort) annotation(
          Line(points = {{32, 14}, {10, 14}, {10, 26}}));
        connect(constTemp.heatPort, thermalResistor1.heatPort_a) annotation(
          Line(points = {{66, 14}, {52, 14}}));
        annotation(
          experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.04));
      end TwoCompartments;
    end Examples;
  end Thermal;

  package MultiDomain
    package ElectroMechanical
      package Components
        import DSFLib.Circuits.Interfaces.*;
        import DSFLib.Circuits.Units.*;
        import DSFLib.Mechanical.Rotational.Interfaces.*;
        import DSFLib.Mechanical.Rotational.Units.*;

        model EMF
          DSFLib.Circuits.Interfaces.Pin p annotation(
            Placement(visible = true, transformation(origin = {-80, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          DSFLib.Circuits.Interfaces.Pin n annotation(
            Placement(visible = true, transformation(origin = {-80, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {119, 1}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
          DSFLib.Circuits.Units.Voltage e;
          DSFLib.Circuits.Units.Current i;
          DSFLib.Mechanical.Rotational.Units.Torque tau;
          Real w(unit = "rad/s");
          parameter Real K(unit = "V.s/rad") = 1;
        equation
          e = p.v - n.v;
          p.i = i;
          n.i + p.i = 0;
          e = K*w;
          tau = K*i;
          tau = -flange.tau;
          w = der(flange.phi);
          annotation(
            Icon(graphics = {Ellipse(extent = {{-86, 84}, {86, -84}}), Rectangle(origin = {66, 1}, fillColor = {240, 240, 240}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-66, 7}, {66, -7}})}));
        end EMF;

        model SepExcDCM
          parameter Real phi0(unit = "Wb") = 0 "Initial Flux";
          DSFLib.Circuits.Components.NLInductor inductor(currTable = currTable, fluxTable = fluxTable, phi(start = phi0)) annotation(
            Placement(visible = true, transformation(origin = {-48, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Interfaces.Pin p_ex annotation(
            Placement(visible = true, transformation(origin = {-98, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 100}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
          DSFLib.Circuits.Interfaces.Pin n_ex annotation(
            Placement(visible = true, transformation(origin = {-98, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -100}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
          DSFLib.Circuits.Interfaces.Pin p annotation(
            Placement(visible = true, transformation(origin = {2, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 100}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
          DSFLib.Circuits.Interfaces.Pin n annotation(
            Placement(visible = true, transformation(origin = {2, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -100}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {234, -2}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          parameter Real[:] currTable = {-2, -1, 0, 1, 2};
          parameter Real[:] fluxTable = {-2, -1, 0, 1, 2};
          DSFLib.Circuits.Units.Voltage e;
          DSFLib.Circuits.Units.Current i;
          DSFLib.Mechanical.Rotational.Units.Torque tau;
          Real w(unit = "rad/s");
          parameter Real K(unit = "1/rad") = 1;
        equation
          e = p.v - n.v;
          p.i = i;
          n.i + p.i = 0;
          e = K*inductor.phi*w;
          tau = K*inductor.phi*i;
          tau = -flange.tau;
          w = der(flange.phi);
          connect(p_ex, inductor.p) annotation(
            Line(points = {{-98, 38}, {-58, 38}}));
          connect(inductor.n, n_ex) annotation(
            Line(points = {{-38, 38}, {-16, 38}, {-16, -48}, {-98, -48}}));
          annotation(
            Icon(graphics = {Ellipse(origin = {100, 0}, extent = {{-88, 88}, {88, -88}}), Line(origin = {-61.42, -0.59}, rotation = -90, points = {{-50, 0}, {50, 0}}, color = {0, 0, 255}), Line(origin = {-74.92, -0.85}, rotation = -90, points = {{-50, 0}, {50, 0}}, color = {0, 0, 255}), Line(origin = {-99.9812, -0.499914}, rotation = -90, points = {{-30, 0}, {-29, 6}, {-22, 14}, {-8, 14}, {-1, 6}, {0, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(origin = {-99.9812, -0.499914}, rotation = -90, points = {{0, 0}, {1, 6}, {8, 14}, {22, 14}, {29, 6}, {30, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(origin = {-99.9812, -0.499914}, rotation = -90, points = {{-60, 0}, {-59, 6}, {-52, 14}, {-38, 14}, {-31, 6}, {-30, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(origin = {-99.9812, -0.499914}, rotation = -90, points = {{60, 0}, {90, 0}}, color = {0, 0, 255}), Line(origin = {-99.9812, -0.499914}, rotation = -90, points = {{30, 0}, {31, 6}, {38, 14}, {52, 14}, {59, 6}, {60, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(origin = {-99.9812, -0.499914}, rotation = -90, points = {{-90, 0}, {-60, 0}}, color = {0, 0, 255}), Rectangle(origin = {166, -1}, fillColor = {240, 240, 240}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-66, 7}, {66, -7}})}));
        end SepExcDCM;

        model DCMotor
          parameter Real R(unit = "Ohm") = 1, L(unit = "Hy") = 1, Km(unit = "V.s/rad") = 1, Jm(unit = "Kg.m^2") = 1;
          DSFLib.MultiDomain.ElectroMechanical.Components.EMF emf(K = Km) annotation(
            Placement(visible = true, transformation(origin = {10, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.Ground ground annotation(
            Placement(visible = true, transformation(origin = {10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Inertia inertia(J = Jm) annotation(
            Placement(visible = true, transformation(origin = {57, 33}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
          DSFLib.Circuits.Components.Resistor resistor(R = R) annotation(
            Placement(visible = true, transformation(origin = {-36, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.Inductor inductor(L = L) annotation(
            Placement(visible = true, transformation(origin = {-6, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Interfaces.Pin p annotation(
            Placement(visible = true, transformation(origin = {-100, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Circuits.Interfaces.Pin n annotation(
            Placement(visible = true, transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Mechanical.Rotational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {100, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(emf.n, ground.p) annotation(
            Line(points = {{10, -7}, {10, -23}}));
          connect(emf.flange, inertia.flange) annotation(
            Line(points = {{24, 2}, {28, 2}, {28, 33}, {46, 33}}));
          connect(resistor.n, inductor.p) annotation(
            Line(points = {{-26, 30}, {-16, 30}}));
          connect(inductor.n, emf.p) annotation(
            Line(points = {{4, 30}, {10, 30}, {10, 12}}));
          connect(p, resistor.p) annotation(
            Line(points = {{-100, 78}, {-62, 78}, {-62, 30}, {-46, 30}}));
          connect(n, ground.p) annotation(
            Line(points = {{-100, -80}, {-62, -80}, {-62, -23}, {10, -23}}));
          connect(emf.flange, flange) annotation(
            Line(points = {{24, 2}, {100, 2}}));
          annotation(
            Icon(graphics = {Bitmap(origin = {-1, -9}, extent = {{89, -89}, {-89, 89}}, imageSource = "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"), Line(origin = {-32, 76}, points = {{-28, 22}, {-28, -8}, {28, -8}, {28, -22}, {28, -22}}), Line(origin = {34, 75}, points = {{26, 21}, {26, -7}, {-26, -7}, {-26, -21}, {-26, -21}})}));
        end DCMotor;

        model DCMotorSepExc
          parameter Real Rarm(unit = "Ω") = 0.05, Larm(unit = "H") = 0.003, Rexc(unit = "Ω") = 25, J(unit = "Kg.m^2") = 15, b(unit = "N.m.s/rad") = 1, K(unit = "1/rad") = 0.016, phi0(unit = "Wb") = 500;
          parameter Real[:] currTable = {0, 1.5, 3, 4.5, 6, 9, 10, 12, 13.5, 14.5, 15};
          parameter Real[:] fluxTable = {0, 100, 200, 300, 370, 470, 500, 520, 539, 540};
          DSFLib.Mechanical.Rotational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {100, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {104, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Interfaces.Pin p annotation(
            Placement(visible = true, transformation(origin = {-100, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {68, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Interfaces.Pin n annotation(
            Placement(visible = true, transformation(origin = {-100, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-52, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Interfaces.Pin p_exc annotation(
            Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-102, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Interfaces.Pin n_exc annotation(
            Placement(visible = true, transformation(origin = {-100, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-102, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Inertia inertia(J = 15) annotation(
            Placement(visible = true, transformation(origin = {64, -28}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          DSFLib.Circuits.Components.Resistor Re(R = Rexc) annotation(
            Placement(visible = true, transformation(origin = {-42, 40}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          DSFLib.Circuits.Components.Inductor La(L = Larm) annotation(
            Placement(visible = true, transformation(origin = {-2, 78}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          DSFLib.Circuits.Components.Resistor Ra(R = Rarm) annotation(
            Placement(visible = true, transformation(origin = {-42, 78}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Damper damper(b = b) annotation(
            Placement(visible = true, transformation(origin = {52, -62}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          Mechanical.Rotational.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {52, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.MultiDomain.ElectroMechanical.Components.SepExcDCM sepExcDCM(K = K, currTable = currTable, fluxTable = fluxTable, phi0 = phi0) annotation(
            Placement(visible = true, transformation(origin = {8, 2}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
          DSFLib.Circuits.Components.Ground ground annotation(
            Placement(visible = true, transformation(origin = {-20, -90}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          DSFLib.Circuits.Components.Ground ground1 annotation(
            Placement(visible = true, transformation(origin = {-42, -50}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
        equation
          connect(damper.flange_a, inertia.flange) annotation(
            Line(points = {{52, -52}, {52, -28}}));
          connect(Ra.n, La.p) annotation(
            Line(points = {{-30, 78}, {-14, 78}}));
          connect(La.n, sepExcDCM.p) annotation(
            Line(points = {{10, 78}, {24, 78}, {24, 16}}));
          connect(inertia.flange, sepExcDCM.flange) annotation(
            Line(points = {{52, -28}, {45, -28}, {45, 2}}));
          connect(damper.flange_b, fixed.flange) annotation(
            Line(points = {{52, -72}, {52, -80}}));
          connect(Ra.p, p) annotation(
            Line(points = {{-54, 78}, {-100, 78}}));
          connect(sepExcDCM.n, ground.p) annotation(
            Line(points = {{24, -14}, {24, -80}, {-20, -80}}));
          connect(ground.p, n) annotation(
            Line(points = {{-20, -80}, {-100, -80}}));
          connect(sepExcDCM.flange, flange) annotation(
            Line(points = {{46, 2}, {100, 2}}));
          connect(Re.n, sepExcDCM.p_ex) annotation(
            Line(points = {{-30, 40}, {-8, 40}, {-8, 18}}));
          connect(sepExcDCM.n_ex, ground1.p) annotation(
            Line(points = {{-8, -14}, {-8, -40}, {-42, -40}}));
          connect(p_exc, Re.p) annotation(
            Line(points = {{-100, 40}, {-54, 40}}));
          connect(n_exc, ground1.p) annotation(
            Line(points = {{-100, -40}, {-42, -40}}));
          annotation(
            Icon(graphics = {Bitmap(origin = {9, -5}, extent = {{89, -89}, {-89, 89}}, imageSource = "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"), Line(origin = {-24.8409, 78.983}, points = {{-28, 22}, {-28, -8}, {28, -8}, {28, -22}, {28, -22}}), Line(origin = {41.1591, 77.983}, points = {{26, 21}, {26, -7}, {-26, -7}, {-26, -21}, {-26, -21}}), Line(points = {{-110, -4}, {-109, 1}, {-105, 5}, {-100, 6}, {-95, 5}, {-91, 1}, {-90, -4}}, color = {0, 0, 255}), Line(points = {{-90, -4}, {-89, 1}, {-85, 5}, {-80, 6}, {-75, 5}, {-71, 1}, {-70, -4}}, color = {0, 0, 255}), Line(points = {{-100, -50}, {-100, -20}, {-70, -20}, {-70, -2}}, color = {0, 0, 3}), Line(points = {{-100, 50}, {-100, 20}, {-130, 20}, {-130, -4}}, color = {0, 0, 255}), Line(points = {{-130, -4}, {-129, 1}, {-125, 5}, {-120, 6}, {-115, 5}, {-111, 1}, {-110, -4}}, color = {0, 0, 255})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end DCMotorSepExc;
      end Components;

      package Examples
        model DCMotor
          DSFLib.MultiDomain.ElectroMechanical.Components.EMF emf annotation(
            Placement(visible = true, transformation(origin = {36, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.Ground ground annotation(
            Placement(visible = true, transformation(origin = {0, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Inertia inertia(J = 0.05) annotation(
            Placement(visible = true, transformation(origin = {70, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.Resistor resistor(R = 0.2) annotation(
            Placement(visible = true, transformation(origin = {-12, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.ConstVolt constVolt(V = 12) annotation(
            Placement(visible = true, transformation(origin = {-34, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Circuits.Components.Inductor inductor(L = 1e-3) annotation(
            Placement(visible = true, transformation(origin = {18, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(emf.flange, inertia.flange) annotation(
            Line(points = {{47.9, 12.1}, {59.9, 12.1}}));
          connect(constVolt.p, resistor.p) annotation(
            Line(points = {{-34, 22}, {-34, 42.2}, {-22.2, 42.2}}));
          connect(constVolt.n, ground.p) annotation(
            Line(points = {{-34, 2}, {-34, -20}, {0, -20}}));
          connect(resistor.n, inductor.p) annotation(
            Line(points = {{-2, 42}, {8, 42}}));
          connect(inductor.n, emf.p) annotation(
            Line(points = {{28, 42}, {36, 42}, {36, 22}}));
          connect(emf.n, ground.p) annotation(
            Line(points = {{36, 2}, {36, -20}, {0, -20}}));
          annotation(
            experiment(StartTime = 0, StopTime = 0.1, Tolerance = 1e-06, Interval = 0.0002));
        end DCMotor;

        model DCMotorSepExc
          DSFLib.Mechanical.Rotational.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {78, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
          Components.SepExcDCM sepExcDCM(K = 0.016, currTable = {0, 1.5, 3, 4.5, 6, 9, 10, 12, 13.5, 14.5, 15}, fluxTable = {0, 100, 200, 300, 370, 470, 500, 520, 539, 540}, phi0 = 0) annotation(
            Placement(visible = true, transformation(origin = {8, 2}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Damper damper(b = 1.1) annotation(
            Placement(visible = true, transformation(origin = {56, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.Resistor Ra(R = 0.05) annotation(
            Placement(visible = true, transformation(origin = {-42, 66}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          DSFLib.Circuits.Components.Ground ground annotation(
            Placement(visible = true, transformation(origin = {-34, -40}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          Circuits.Components.Resistor Re(R = 25) annotation(
            Placement(visible = true, transformation(origin = {-42, 40}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Inertia inertia(J = 15) annotation(
            Placement(visible = true, transformation(origin = {74, 2}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          DSFLib.Circuits.Components.Inductor La(L = 3e-3) annotation(
            Placement(visible = true, transformation(origin = {-2, 66}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          DSFLib.Circuits.Components.ConstVolt Va(V = 180) annotation(
            Placement(visible = true, transformation(origin = {-80, 16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        equation
          connect(Re.n, sepExcDCM.p_ex) annotation(
            Line(points = {{-30, 40}, {-8, 40}, {-8, 18}}));
          connect(sepExcDCM.n, ground.p) annotation(
            Line(points = {{24, -14}, {24, -30}, {-34, -30}}));
          connect(La.n, sepExcDCM.p) annotation(
            Line(points = {{10, 66}, {24, 66}, {24, 16}}));
          connect(damper.flange_b, fixed.flange) annotation(
            Line(points = {{65.9, 43.9}, {77.9, 43.9}}));
          connect(Ra.n, La.p) annotation(
            Line(points = {{-30, 66}, {-14, 66}}));
          connect(sepExcDCM.n_ex, ground.p) annotation(
            Line(points = {{-8, -14}, {-8, -30}, {-34, -30}}));
          connect(sepExcDCM.flange, inertia.flange) annotation(
            Line(points = {{46, 2}, {62, 2}}));
          connect(damper.flange_a, sepExcDCM.flange) annotation(
            Line(points = {{46, 44}, {46, 2}}));
          connect(Va.p, Ra.p) annotation(
            Line(points = {{-80, 26}, {-80, 66}, {-54, 66}}));
          connect(Va.n, ground.p) annotation(
            Line(points = {{-80, 6}, {-80, -30}, {-34, -30}}));
          connect(Re.p, Va.p) annotation(
            Line(points = {{-54, 40}, {-80, 40}, {-80, 26}}));
          annotation(
            experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
            Diagram);
        end DCMotorSepExc;

        model DCMotorSepExc2
          DSFLib.MultiDomain.ElectroMechanical.Components.DCMotorSepExc motor(Rexc = 25.2, b = 1.1, phi0 = 500) annotation(
            Placement(visible = true, transformation(origin = {10, -2}, extent = {{-32, -32}, {32, 32}}, rotation = 0)));
          DSFLib.Circuits.Components.ConstVolt Vexc(V = 184) annotation(
            Placement(visible = true, transformation(origin = {-48, -6}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          ControlSystems.Blocks.Components.RampSource rampSource(U = 460, t0 = 2, tf = 5) annotation(
            Placement(visible = true, transformation(origin = {-44, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Actuators.Circuits.ModulatedVoltageSource modulatedVoltageSource annotation(
            Placement(visible = true, transformation(origin = {-8, 56}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        equation
          connect(motor.p_exc, Vexc.p) annotation(
            Line(points = {{-28, 10}, {-48, 10}, {-48, 4}}));
          connect(Vexc.n, motor.n_exc) annotation(
            Line(points = {{-48, -16}, {-48, -22}, {-28, -22}}));
          connect(rampSource.y, modulatedVoltageSource.u) annotation(
            Line(points = {{-32, 56}, {-14, 56}}, color = {0, 0, 127}));
          connect(modulatedVoltageSource.n, motor.n) annotation(
            Line(points = {{-8, 46}, {-6, 46}, {-6, 30}}));
          connect(modulatedVoltageSource.p, motor.p) annotation(
            Line(points = {{-8, 66}, {-8, 78}, {32, 78}, {32, 30}}));
          annotation(
            experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.02));
        end DCMotorSepExc2;
      end Examples;
    end ElectroMechanical;

    package HydroMechanical
      package Components
        import DSFLib.Hydraulics.Units.*;
        import DSFLib.Hydraulics.Interfaces.*;
        import DSFLib.Mechanical.Translational.Units.*;
        import DSFLib.Mechanical.Translational.Interfaces.*;

        model PistonCylinder
          extends DSFLib.Mechanical.Translational.Interfaces.Compliant;
          DSFLib.Hydraulics.Interfaces.FluidPort fluidPort annotation(
            Placement(visible = true, transformation(origin = {36, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-39, -79}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          parameter Real A(unit = "m2") = 1;
        equation
          fluidPort.q = der(s_rel)*A;
          fluidPort.p*A = -f;
          annotation(
            Icon(graphics = {Text(origin = {-5, 87}, extent = {{-151, -15}, {151, 15}}, textString = "A=%A"), Rectangle(origin = {2, -1}, rotation = -90, lineColor = {0, 0, 255}, fillColor = {170, 213, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-49, 40}, {49, -100}}), Polygon(origin = {10, 0}, rotation = -90, lineColor = {95, 95, 95}, fillColor = {135, 135, 135}, fillPattern = FillPattern.Backward, points = {{-48, -106}, {48, -106}, {48, 70}, {52, 70}, {52, -110}, {-52, -110}, {-52, 70}, {-48, 70}, {-48, -106}}), Rectangle(origin = {10, 0}, rotation = -90, lineColor = {95, 95, 95}, fillColor = {135, 135, 135}, fillPattern = FillPattern.Forward, extent = {{-6, 92}, {6, 40}}), Line(visible = false, origin = {10.8021, -0.953105}, rotation = -90, points = {{-100, 0}, {-52, 0}}, color = {198, 0, 0}), Rectangle(origin = {10, 0}, rotation = -90, lineColor = {95, 95, 95}, fillColor = {135, 135, 135}, fillPattern = FillPattern.Forward, extent = {{-48, 40}, {48, 30}}), Rectangle(origin = {-34, -60}, rotation = -90, lineColor = {0, 0, 255}, fillColor = {170, 213, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-14, 6}, {14, -16}}), Rectangle(origin = {-62, -61}, rotation = -90, lineColor = {95, 95, 95}, fillColor = {135, 135, 135}, fillPattern = FillPattern.Forward, extent = {{-13, 16}, {13, 12}}), Rectangle(origin = {-44, -61}, rotation = -90, lineColor = {95, 95, 95}, fillColor = {135, 135, 135}, fillPattern = FillPattern.Forward, extent = {{-13, 16}, {13, 12}})}));
        end PistonCylinder;
      end Components;

      package Examples
        model HydraulicJack
          DSFLib.MultiDomain.HydroMechanical.Components.PistonCylinder pistonCylinder(A = 1e-3) annotation(
            Placement(visible = true, transformation(origin = {-32, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
          DSFLib.MultiDomain.HydroMechanical.Components.PistonCylinder pistonCylinder1(A = 0.1) annotation(
            Placement(visible = true, transformation(origin = {32, 8}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
          DSFLib.Hydraulics.Components.Valve valve(RH = 1e6) annotation(
            Placement(visible = true, transformation(origin = {0, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Mechanical.Translational.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {0, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Translational.Components.ConstForce constForce(F = -100) annotation(
            Placement(visible = true, transformation(origin = {-54, 20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Mechanical.Translational.Components.Mass mass(m = 1e3) annotation(
            Placement(visible = true, transformation(origin = {32, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Mechanical.Translational.Components.ConstForce constForce1(F = -9.8e3) annotation(
            Placement(visible = true, transformation(origin = {56, 18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        equation
          connect(valve.fluidPort_a, pistonCylinder1.fluidPort) annotation(
            Line(points = {{10, 4}, {24, 4}}));
          connect(mass.flange, constForce1.flange) annotation(
            Line(points = {{32, 38}, {56, 38}, {56, 28}}));
          connect(pistonCylinder.fluidPort, valve.fluidPort_b) annotation(
            Line(points = {{-24, 4}, {-10, 4}}));
          connect(mass.flange, pistonCylinder1.flange_b) annotation(
            Line(points = {{32, 38}, {32, 18}}));
          connect(pistonCylinder1.flange_a, fixed.flange) annotation(
            Line(points = {{32, -2}, {32, -22}, {0, -22}}));
          connect(pistonCylinder.flange_a, fixed.flange) annotation(
            Line(points = {{-32, -2}, {-32, -22}, {0, -22}}));
          connect(constForce.flange, pistonCylinder.flange_b) annotation(
            Line(points = {{-54, 30}, {-32, 30}, {-32, 18}}));
          annotation(
            experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
        end HydraulicJack;
      end Examples;
    end HydroMechanical;

    package HydroThermal
      package Components
        import DSFLib.Thermal.Units.*;
        import DSFLib.Thermal.Interfaces.*;
        import DSFLib.Hydraulics.Units.*;
        import DSFLib.Hydraulics.Interfaces.*;

        model Convection
          extends DSFLib.Hydraulics.Interfaces.TwoPort;
          DSFLib.Thermal.Interfaces.HeatPort heatPort_a annotation(
            Placement(visible = true, transformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          DSFLib.Thermal.Interfaces.HeatPort heatPort_b annotation(
            Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          Temperature T;
          HeatFlow q_heat;
          parameter Real rho(unit = "Kg/m3") = 1000 "Fluid density";
          parameter Real c(unit = "J/K/Kg") = 4184 "Fluid specific heat capacity";
        equation
          p = 0;
          q_heat = heatPort_b.q;
          q_heat = -heatPort_a.q;
          T = if q >= 0 then heatPort_b.T else heatPort_a.T;
          q_heat = rho*c*q*T;
          annotation(
            Icon(graphics = {Rectangle(origin = {2, -51}, rotation = 90, fillColor = {0, 170, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-49, 102}, {91, -98}}), Polygon(origin = {68, 0}, rotation = -90, lineColor = {0, 170, 255}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, points = {{0, 10}, {12, -12}, {-12, -12}, {0, 10}}), Rectangle(origin = {-8, 2.5}, rotation = 90, lineColor = {0, 170, 255}, fillColor = {0, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-7, 69}, {3, -69}}), Text(origin = {0, 18}, textColor = {0, 0, 255}, extent = {{-150, 85}, {150, 45}}, textString = "%name"), Polygon(origin = {68, -60}, rotation = -90, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, points = {{0, 10}, {12, -12}, {-12, -12}, {0, 10}}), Rectangle(origin = {-8, -57.5}, rotation = 90, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-7, 69}, {3, -69}})}, coordinateSystem(initialScale = 0.1)));
        end Convection;
      end Components;

      package Examples
        model SolarCollector
          DSFLib.Thermal.Components.HeatCapacitor fluid(C = 4184) annotation(
            Placement(visible = true, transformation(origin = {8, -16}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          DSFLib.Thermal.Components.HeatCapacitor collector(C = 1000) annotation(
            Placement(visible = true, transformation(origin = {8, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Thermal.Components.ThermalResistor thermalResistor(R = 0.001) annotation(
            Placement(visible = true, transformation(origin = {8, 14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Thermal.Components.HeatFlowSource heatFlowSource(Q = 1e4) annotation(
            Placement(visible = true, transformation(origin = {40, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Thermal.Components.ConstTemp roomTemp(T = 293) annotation(
            Placement(visible = true, transformation(origin = {-62, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.MultiDomain.HydroThermal.Components.Convection convection annotation(
            Placement(visible = true, transformation(origin = {-28, -14}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          DSFLib.Hydraulics.Components.IdealPump idealPump(Q = 1e-4) annotation(
            Placement(visible = true, transformation(origin = {-62, -10}, extent = {{10, 10}, {-10, -10}}, rotation = 180)));
          DSFLib.Hydraulics.Components.ConstPress constPress annotation(
            Placement(visible = true, transformation(origin = {-108, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.MultiDomain.HydroThermal.Components.Convection convection1 annotation(
            Placement(visible = true, transformation(origin = {42, -14}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
          DSFLib.Thermal.Components.ThermalResistor thermalResistor1 annotation(
            Placement(visible = true, transformation(origin = {-26, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Thermal.Components.ConstTemp roomTemp1(T = 293) annotation(
            Placement(visible = true, transformation(origin = {80, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Hydraulics.Components.ConstPress constPress1 annotation(
            Placement(visible = true, transformation(origin = {86, -26}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
        equation
          connect(thermalResistor.heatPort_a, fluid.heatPort) annotation(
            Line(points = {{8, 4}, {8, -8}}));
          connect(thermalResistor.heatPort_b, collector.heatPort) annotation(
            Line(points = {{8, 24}, {8, 40}}));
          connect(thermalResistor1.heatPort_a, roomTemp.heatPort) annotation(
            Line(points = {{-36, 34}, {-52, 34}}));
          connect(thermalResistor1.heatPort_b, collector.heatPort) annotation(
            Line(points = {{-16, 34}, {8, 34}, {8, 40}}));
          connect(convection.heatPort_a, fluid.heatPort) annotation(
            Line(points = {{-18, -8}, {8, -8}}));
          connect(convection1.heatPort_b, fluid.heatPort) annotation(
            Line(points = {{32, -8}, {8, -8}}));
          connect(heatFlowSource.heatPort, collector.heatPort) annotation(
            Line(points = {{30, 34}, {8, 34}, {8, 40}}));
          connect(roomTemp.heatPort, convection.heatPort_b) annotation(
            Line(points = {{-52.3, 33.9}, {-44.3, 33.9}, {-44.3, -8}, {-38, -8}}));
          connect(idealPump.fluidPort_a, convection.fluidPort_b) annotation(
            Line(points = {{-52, -10}, {-45, -10}, {-45, -14}, {-38, -14}}));
          connect(convection1.heatPort_a, roomTemp1.heatPort) annotation(
            Line(points = {{52, -8}, {60, -8}, {60, 8}, {70, 8}}));
          connect(convection.fluidPort_a, convection1.fluidPort_b) annotation(
            Line(points = {{-18, -14}, {-10, -14}, {-10, -38}, {26, -38}, {26, -14}, {32, -14}}));
          connect(constPress.fluidPort, idealPump.fluidPort_b) annotation(
            Line(points = {{-98, -20}, {-78, -20}, {-78, -10}, {-72, -10}}));
          connect(convection1.fluidPort_a, constPress1.fluidPort) annotation(
            Line(points = {{52, -14}, {62, -14}, {62, -26}, {76, -26}}));
          annotation(
            experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2));
        end SolarCollector;
      end Examples;
    end HydroThermal;

    package ElectroThermal
      import DSFLib.Circuits.Components;
      import DSFLib.Thermal.Interfaces;

      package Components
        model HeatingResistor
          extends DSFLib.Circuits.Components.Resistor;
          DSFLib.Thermal.Interfaces.HeatPort heatPort annotation(
            Placement(visible = true, transformation(origin = {0, -96}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1, -147}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
        equation
          heatPort.q = -v*i;
          annotation(
            Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(origin = {4, -94}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-5, 4}, {2, -20}}), Polygon(origin = {2, -122}, rotation = 180, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, points = {{0, 10}, {12, -10}, {-12, -10}, {0, 10}})}));
        end HeatingResistor;
      end Components;

      package Examples
        model WaterHeater
          DSFLib.MultiDomain.ElectroThermal.Components.HeatingResistor heatingResistor(R = 10) annotation(
            Placement(visible = true, transformation(origin = {-12, -34}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
          DSFLib.Circuits.Components.Ground ground annotation(
            Placement(visible = true, transformation(origin = {-32, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Components.ConstVolt constVolt(V = 200) annotation(
            Placement(visible = true, transformation(origin = {-52, -34}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          DSFLib.Thermal.Components.HeatCapacitor water(C = 41840) annotation(
            Placement(visible = true, transformation(origin = {8, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Thermal.Components.ConstTemp constTemp(T = 293) annotation(
            Placement(visible = true, transformation(origin = {-78, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.MultiDomain.HydroThermal.Components.Convection convection annotation(
            Placement(visible = true, transformation(origin = {-22, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.MultiDomain.HydroThermal.Components.Convection convection1 annotation(
            Placement(visible = true, transformation(origin = {38, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Thermal.Components.ConstTemp constTemp1(T = 293) annotation(
            Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.Hydraulics.Components.IdealPump idealPump(Q = 0.0001) annotation(
            Placement(visible = true, transformation(origin = {-60, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Hydraulics.Components.ConstPress constPress annotation(
            Placement(visible = true, transformation(origin = {-92, 36}, extent = {{10, 10}, {-10, -10}}, rotation = 180)));
          DSFLib.Hydraulics.Components.ConstPress constPress1 annotation(
            Placement(visible = true, transformation(origin = {82, 36}, extent = {{-10, 10}, {10, -10}}, rotation = -180)));
        equation
          connect(constVolt.n, ground.p) annotation(
            Line(points = {{-52, -44}, {-52, -52}, {-32, -52}}));
          connect(constTemp.heatPort, convection.heatPort_b) annotation(
            Line(points = {{-68.3, -0.1}, {-32.3, -0.1}}));
          connect(convection1.heatPort_a, constTemp1.heatPort) annotation(
            Line(points = {{48, 0}, {70, 0}}));
          connect(heatingResistor.heatPort, water.heatPort) annotation(
            Line(points = {{3, -34}, {8, -34}, {8, 12}}));
          connect(convection.heatPort_a, water.heatPort) annotation(
            Line(points = {{-12, 0}, {8, 0}, {8, 12}}));
          connect(convection1.heatPort_b, water.heatPort) annotation(
            Line(points = {{28, 0}, {8, 0}, {8, 12}}));
          connect(convection.fluidPort_a, convection1.fluidPort_b) annotation(
            Line(points = {{-12, 6}, {-8, 6}, {-8, 40}, {24, 40}, {24, 6}, {28, 6}}));
          connect(constPress.fluidPort, idealPump.fluidPort_b) annotation(
            Line(points = {{-82, 36}, {-70, 36}}));
          connect(idealPump.fluidPort_a, convection.fluidPort_b) annotation(
            Line(points = {{-50, 36}, {-44, 36}, {-44, 6}, {-32, 6}}));
          connect(ground.p, heatingResistor.n) annotation(
            Line(points = {{-32, -52}, {-12, -52}, {-12, -44}}));
          connect(constVolt.p, heatingResistor.p) annotation(
            Line(points = {{-52, -24}, {-52, -16}, {-12, -16}, {-12, -24}}));
          connect(constPress1.fluidPort, convection1.fluidPort_a) annotation(
            Line(points = {{72, 36}, {64, 36}, {64, 6}, {48, 6}}));
          annotation(
            Diagram,
            experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 2));
        end WaterHeater;
      end Examples;
    end ElectroThermal;
  end MultiDomain;

  package ControlSystems
    package Blocks
      package Interfaces
        connector RealInput = input Real annotation(
          Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {102, 0}, {-100, -100}, {-100, 100}})}),
          Diagram(graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {102, 0}, {-100, -100}, {-100, 100}}), Text(origin = {-12, -6}, textColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        connector RealOutput = output Real annotation(
          Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {102, 0}, {-100, -100}, {-100, 100}})}),
          Diagram(graphics = {Text(origin = {-12, -6}, textColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name"), Polygon(lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {102, 0}, {-100, -100}, {-100, 100}})}));

        partial block SISO
          RealInput u annotation(
            Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {110, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          annotation(
            Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
        end SISO;

        partial block SO
          RealOutput y annotation(
            Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          annotation(
            Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end SO;
      end Interfaces;

      package Components
        block Integrator
          extends DSFLib.ControlSystems.Blocks.Interfaces.SISO(y.start = y_0);
          parameter Real y_0 = 0;
        equation
          der(y) = u;
          annotation(
            Icon(graphics = {Bitmap(origin = {-2, 2}, extent = {{90, 82}, {-90, -82}}, imageSource = "iVBORw0KGgoAAAANSUhEUgAAAC4AAABcCAYAAAARU4f9AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAuIwAALiMBeKU/dgAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAQCSURBVHic7ZtLbE1BGMd/+qDe9agq9Wix8IgEQSQshB2xQCKxsbXASiI2EqzsEJFILHQhNixYEalIhISIRNBoqVSjGvEoFbSathZzj557zszc05xvzp0m95+cRb+Z+ebX737nzJk5M1B81QHHgGbgEzAA9ALtwA3gEDCraHQajQdOA7+B4dz1E3gNtAJ9IXsfcAaYUhTSkGYBjxgB6wB2AhWhOuXABuAs0J+r9xyYlyVoWFXkQ7/DngqVwAlgKFf/KerXylxXGYEeArZY6k4DHobqB9dhx4wx7Y0ANBeof4Y49DDwxCFjTJOBzgjA7gJtWtCD97rDjOtopPPfwIQCbdrQg391h5mvCuB9pPO7CdqdRw/e5AYzrj2azo8naDcduBNpdx+Y7YRSo+vEwbePov1aYB+wTh7NrKnkj47BVbSBJKl2EYfuSeu0LK2DBNqqsbWkdZoF+GaNrSOtU9fgZcByjb1LwrFLNaBGzKi60zp2Db7KYPcefKXB/jGtY9fgKwz2z2kdFyviXxz3m1o/iQ8+g6hpmbeqxeErqctUWWKwi6SJS/BGg70UcVdqMNjHbMS9Bx+TOT4RtZipk9c53giMM5R5HfHFljKvwRdZyrxOlQWWMq/BFxrsIjN8yD7ivcBfiQ6yjrjYYqUL8HLMq1RiEwgX4HWozx86eR1x2xPFa3DbMzz17D6QC3DTjQkC6ymBXIDXW8q8jrjprRAE1gwDuQCvtZR5HXET+DCCOe5C39Gvp6RedgtLOuJVqC9lOomlCciD11jKRNNEGnyupaxTsiNpcNsTxWvwOZYyr8FtOT5mwTskO5IGN21RGkRwuAd5cNOuhm7UtjwxZRXx98L9ZBZx0RsTShEH1Oy+2lDmdcRnWPx5HXHbPql2wX6AbMCHEB58QBbcdGN2oTb1iiqLiIunCWQT8XeCffxXCZxSqiRTKeLATI3tB462TEuC62Y/rYL+8yQFXoZ6V4nqlZB/bYcSqkW/z8p7cNNi/ksh/zFJgZu++4zJiPciPLMPyyX4M9TyshNJga/W2G4L+Xaqz8QX8nX/jFeaTxy6FfMOIREFxxArUYcwluU6vYVaNkui9RpbEw7zO1A98IL4Ibikhz4vRdoOYP/WKaZr6D82nUvYPnrw7oo8ol496MGTvCBtJB7tpW4w81WGeS93ktXVI5G/LwJvUxGNQo/RR/xUgXYNqG1KQf02YJI7zLgOEoe+WQCiHHgQqv8LlTaZqoKRw8/9wIEC9SuBy4xA/2F0JwVFVYN6BA6jzsBfADaRv0WpHNhB/uHnD+jPsmWqKuAk6mcPwPqBN7krfMB/EDXI6GY9mUg3LFcD+4FtwBrUt8tK4BvqVOA91LPfybJDUv0D7tQsfW31v+gAAAAASUVORK5CYII="), Text(textColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end Integrator;

        block StateSpace
          extends DSFLib.ControlSystems.Blocks.Interfaces.SISO;
          parameter Real A[:, size(A, 1)] = [0, 1; -1, -1];
          parameter Real B[size(A, 1), 1] = [0; 1];
          parameter Real C[1, size(A, 1)] = [1, 0];
          parameter Real D[1, 1] = [0];
          parameter Real x_0[size(A, 1), 1] = [0; 0];
          Real x[size(A, 1), 1](start = x_0);
        protected
          Real ymat[1, 1];
        equation
          der(x) = A*x + B*u;
          ymat = C*x + D*u;
          y = ymat[1, 1];
          annotation(
            Icon(graphics = {Text(origin = {-2, 44}, extent = {{-90, 22}, {90, -22}}, textString = "x=Ax+Bu"), Text(origin = {-67, 69}, extent = {{-19, 17}, {19, -17}}, textString = ".", textStyle = {TextStyle.Bold}), Text(origin = {0, -30}, extent = {{-90, 22}, {90, -22}}, textString = "y=Cx+Du"), Text(textColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end StateSpace;

        block StepSource
          extends DSFLib.ControlSystems.Blocks.Interfaces.SO;
          parameter Real U = 1 "Step amplitude";
          parameter Real Ti = 0 "Initial Step Time";
        equation
          y = if time < Ti then 0 else U;
          annotation(
            Icon(graphics = {Text(origin = {0, -130}, extent = {{-102, 28}, {102, -28}}, textString = "U=%U"), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(origin = {0, -10}, points = {{-80, 80}, {-80, -80}}, color = {95, 95, 95}), Line(origin = {-31.64, -9.64}, points = {{-48, -70}, {0, -70}, {0, 56}, {100, 56}}, thickness = 0.5), Polygon(origin = {0, -10}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, points = {{90, -70}, {68, -64}, {68, -76}, {90, -70}}), Polygon(lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, points = {{-80, 90}, {-86, 68}, {-74, 68}, {-80, 90}}), Line(origin = {0, -10}, points = {{-90, -70}, {82, -70}}, color = {95, 95, 95}), Text(origin = {-2, 42}, textColor = {0, 0, 255}, extent = {{-150, 70}, {150, 110}}, textString = "%name")}));
        end StepSource;

        model RampSource
          extends DSFLib.ControlSystems.Blocks.Interfaces.SO;
          parameter Real tf(unit = "s") = 1, t0(unit = "s") = 0;
          parameter Real U = 1 "Final Value";
        equation
          if time < t0 then
            y = 0;
          elseif time > tf then
            y = U;
          else
            y = U*(time - t0)/(tf - t0);
          end if;
          annotation(
            Icon(graphics = {Text(origin = {0, -130}, extent = {{-102, 28}, {102, -28}}, textString = "U=%U"), Text(origin = {-2, 42}, textColor = {0, 0, 255}, extent = {{-150, 70}, {150, 110}}, textString = "%name"), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Polygon(origin = {0, -10}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, points = {{90, -70}, {68, -64}, {68, -76}, {90, -70}}), Line(origin = {0, -10}, points = {{-80, 80}, {-80, -80}}, color = {95, 95, 95}), Line(origin = {-32.2095, -9.64004}, points = {{-48, -70}, {-18, -70}, {70, 56}, {100, 56}}, thickness = 0.5), Polygon(lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, points = {{-80, 90}, {-86, 68}, {-74, 68}, {-80, 90}}), Line(origin = {0, -10}, points = {{-90, -70}, {82, -70}}, color = {95, 95, 95})}));
        end RampSource;

        block PulseSource
          extends DSFLib.ControlSystems.Blocks.Interfaces.SO;
          parameter Real U = 1 "Step amplitude";
          parameter Real Ti = 0 "Initial Step Time";
          parameter Real Tf = 0 "Final Step Time";
        equation
          y = if (time < Ti) or (time > Tf) then 0 else U;
          annotation(
            Icon(graphics = {Text(origin = {0, -130}, extent = {{-102, 28}, {102, -28}}, textString = "U=%U"), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(origin = {0, -10}, points = {{-80, 80}, {-80, -80}}, color = {95, 95, 95}), Line(origin = {-31.64, -9.64}, points = {{-48, -70}, {0, -70}, {0, 56}, {24, 56}}, thickness = 0.5), Polygon(origin = {0, -10}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, points = {{90, -70}, {68, -64}, {68, -76}, {90, -70}}), Polygon(lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, points = {{-80, 90}, {-86, 68}, {-74, 68}, {-80, 90}}), Line(origin = {0, -10}, points = {{-90, -70}, {82, -70}}, color = {95, 95, 95}), Text(origin = {-2, 42}, textColor = {0, 0, 255}, extent = {{-150, 70}, {150, 110}}, textString = "%name"), Line(origin = {18.48, -16.5}, points = {{-25.9921, 62.9921}, {-23.9921, -63.0079}, {26.0079, -63.0079}, {40.0079, -63.0079}}, thickness = 0.5)}));
        end PulseSource;

        block ConstSource
          extends DSFLib.ControlSystems.Blocks.Interfaces.SO;
          parameter Real U = 1 "Value";
        equation
          y = U;
          annotation(
            Icon(graphics = {Text(origin = {0, -130}, extent = {{-102, 28}, {102, -28}}, textString = "U=%U"), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(origin = {0, -10}, points = {{-80, 80}, {-80, -80}}, color = {95, 95, 95}), Polygon(origin = {0, -10}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, points = {{90, -70}, {68, -64}, {68, -76}, {90, -70}}), Polygon(lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, points = {{-80, 90}, {-86, 68}, {-74, 68}, {-80, 90}}), Line(origin = {0, -10}, points = {{-90, -70}, {82, -70}}, color = {95, 95, 95}), Text(origin = {-2, 42}, textColor = {0, 0, 255}, extent = {{-150, 70}, {150, 110}}, textString = "%name"), Line(origin = {-37.7419, -47.2671}, points = {{-42, 56}, {-28, 56}, {0, 56}, {106, 56}}, thickness = 0.5)}));
        end ConstSource;

        block Add
          extends DSFLib.ControlSystems.Blocks.Interfaces.SO;
          parameter Real k1 = 1 "Gain on first input";
          parameter Real k2 = 1 "Gain on second input";
          Interfaces.RealInput u1 annotation(
            Placement(visible = true, transformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Interfaces.RealInput u2 annotation(
            Placement(visible = true, transformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          y = k1*u1 + k2*u2;
          annotation(
            Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-63, 58}, extent = {{-29, 22}, {29, -22}}, textString = "%k1"), Text(origin = {-63, -58}, extent = {{-29, 22}, {29, -22}}, textString = "%k2"), Line(origin = {19.0908, -8}, points = {{0, 40}, {0, -40}}, thickness = 0.5), Line(origin = {19.6908, -8}, points = {{-40, 0}, {40, 0}}, thickness = 0.5), Text(textColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end Add;

        block TransferFunction
          extends DSFLib.ControlSystems.Blocks.Interfaces.SISO;
          parameter Real num[:] = {1} "Numerator coefficients";
          parameter Real den[:] = {1, 1} "Denominator coefficients";
        protected
          parameter Real A[size(den, 1) - 1, size(den, 1) - 1](each fixed = false);
          parameter Real B[size(den, 1) - 1, 1](each fixed = false);
          parameter Real C[1, size(den, 1) - 1](each fixed = false);
          parameter Real D[1, 1](each fixed = false);
          Real x[size(den, 1) - 1, 1];
          Real ymat[1, 1];
        initial algorithm
          (A, B, C, D) := DSFLib.Utilities.Functions.TF2SS(num, den);
        equation
          der(x) = A*x + B*u;
          ymat = C*x + D*u;
          y = ymat[1, 1];
          annotation(
            Icon(graphics = {Text(origin = {7, 1}, extent = {{-65, 57}, {65, -57}}, textString = "H(s)"), Text(textColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end TransferFunction;

        block Gain
          extends DSFLib.ControlSystems.Blocks.Interfaces.SISO;
          parameter Real K = 1 "Gain";
        equation
          y = K*u;
          annotation(
            Icon(graphics = {Text(origin = {0, 4}, extent = {{-98, 24}, {98, -24}}, textString = "K=%K"), Text(textColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end Gain;

        block DiscreteStateSpace
          extends DSFLib.ControlSystems.Blocks.Interfaces.SISO;
          parameter Real A[:, size(A, 1)] = [0.5, 0.5; -0.5, 0.5];
          parameter Real B[size(A, 1), 1] = [0; 1];
          parameter Real C[1, size(A, 1)] = [1, 0];
          parameter Real D[1, 1] = [0];
          parameter Real x_0[size(A, 1), 1] = [0; 0];
          parameter Real T = 0.1 "Sample Period";
          discrete Real x[size(A, 1), 1](start = x_0);
        protected
          discrete Real ymat[1, 1];
        equation
          y = ymat[1, 1];
        algorithm
          when sample(0, T) then
            ymat := C*x + D*u;
            x := A*x + B*u;
          end when;
          annotation(
            Icon(graphics = {Text(origin = {-2, 44}, extent = {{-90, 22}, {90, -22}}, textString = "x⁺=Ax+Bu"), Text(origin = {0, -30}, extent = {{-90, 22}, {90, -22}}, textString = "y=Cx+Du"), Text(textColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end DiscreteStateSpace;

        block DiscreteTransferFunction
          extends DSFLib.ControlSystems.Blocks.Interfaces.SISO;
          parameter Real num[:] = {1, -0.95} "Numerator coefficients";
          parameter Real den[:] = {1, -1} "Denominator coefficients";
          parameter Real T = 0.1 "Sample Period";
        protected
          parameter Integer n = size(den, 1);
          parameter Integer m = size(num, 1);
          discrete Real ylast[n](each start = 0);
          discrete Real ulast[n](each start = 0);
        equation
          y = ylast[1];
        algorithm
          when sample(0, T) then
            ylast[2:n] := ylast[1:n - 1];
            ulast[2:n] := ulast[1:n - 1];
            ulast[1] := u;
            ylast[1] := (-ylast[2:n]*den[2:n]/den[1]) + ulast[n - m + 1:n]*num[1:m]/den[1];
          end when;
          annotation(
            Icon(graphics = {Text(origin = {7, 1}, extent = {{-65, 57}, {65, -57}}, textString = "H(z)"), Text(textColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end DiscreteTransferFunction;
      end Components;

      package Examples
        model ControlSystem1
          DSFLib.ControlSystems.Blocks.Components.StepSource stepSource annotation(
            Placement(visible = true, transformation(origin = {-78, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.StateSpace stateSpace annotation(
            Placement(visible = true, transformation(origin = {72, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.TransferFunction transferFunction(den = {1, 10}, num = {10}) annotation(
            Placement(visible = true, transformation(origin = {36, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
          DSFLib.ControlSystems.Blocks.Components.Integrator integrator annotation(
            Placement(visible = true, transformation(origin = {0, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.Add add1(k1 = 1, k2 = 1) annotation(
            Placement(visible = true, transformation(origin = {36, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.Add add(k1 = 1, k2 = -1) annotation(
            Placement(visible = true, transformation(origin = {-38, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.Gain gain(K = 1.2) annotation(
            Placement(visible = true, transformation(origin = {-4, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(stateSpace.y, transferFunction.u) annotation(
            Line(points = {{84, 8}, {94, 8}, {94, -28}, {48, -28}}));
          connect(add1.y, stateSpace.u) annotation(
            Line(points = {{48, 8}, {60, 8}}));
          connect(integrator.y, add1.u2) annotation(
            Line(points = {{12, -8}, {17, -8}, {17, 2}, {24, 2}}));
          connect(add.y, integrator.u) annotation(
            Line(points = {{-26, 2}, {-20, 2}, {-20, -8}, {-12, -8}}));
          connect(stepSource.y, add.u1) annotation(
            Line(points = {{-66, 8}, {-50, 8}}));
          connect(transferFunction.y, add.u2) annotation(
            Line(points = {{24, -28}, {-62, -28}, {-62, -4}, {-50, -4}}));
          connect(gain.y, add1.u1) annotation(
            Line(points = {{8, 20}, {14, 20}, {14, 14}, {24, 14}}));
          connect(gain.u, add.y) annotation(
            Line(points = {{-16, 20}, {-20, 20}, {-20, 2}, {-26, 2}}));
        protected
        end ControlSystem1;

        model DiscreteControlSystem
          DSFLib.ControlSystems.Blocks.Components.StepSource stepSource annotation(
            Placement(visible = true, transformation(origin = {-62, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.DiscreteTransferFunction discreteControl(den = {1, -1}, num = {1, -0.95}) annotation(
            Placement(visible = true, transformation(origin = {28, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.Add add(k2 = -1) annotation(
            Placement(visible = true, transformation(origin = {-14, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Components.StateSpace plant annotation(
            Placement(visible = true, transformation(origin = {70, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(stepSource.y, add.u1) annotation(
            Line(points = {{-50, 14}, {-26, 14}}));
          connect(add.y, discreteControl.u) annotation(
            Line(points = {{-2, 8}, {16, 8}}));
          connect(discreteControl.y, plant.u) annotation(
            Line(points = {{40, 8}, {58, 8}}));
          connect(plant.y, add.u2) annotation(
            Line(points = {{82, 8}, {90, 8}, {90, -18}, {-32, -18}, {-32, 2}, {-26, 2}}));
        protected
        end DiscreteControlSystem;
      end Examples;
    end Blocks;

    package Sensors
      package Circuits
        model VoltageSensor
          extends DSFLib.Circuits.Interfaces.OnePort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
        equation
          y = v;
          i = 0;
          annotation(
            Icon(graphics = {Line(points = {{-70, 0}, {-90, 0}}), Line(points = {{0, -100}, {0, -70}}, color = {0, 0, 127}), Line(points = {{70, 0}, {90, 0}}), Text(textColor = {0, 0, 255}, extent = {{-150, 80}, {150, 120}}, textString = "%name"), Ellipse(fillColor = {245, 245, 245}, fillPattern = FillPattern.Solid, extent = {{-70, -70}, {70, 70}}), Line(points = {{0, 70}, {0, 40}}), Line(points = {{37.6, 13.7}, {65.8, 23.9}}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}), Polygon(rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-5, 0}, {-2, 60}, {0, 65}, {2, 60}, {5, 0}, {-5, 0}}), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -12}, {12, 12}}), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, -7}, {7, 7}}), Text(origin = {-90, 66}, extent = {{20, -116}, {160, -86}}, textString = "V")}));
        end VoltageSensor;

        model CurrentSensor
          extends DSFLib.Circuits.Interfaces.OnePort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
        equation
          y = i;
          v = 0;
          annotation(
            Icon(graphics = {Line(points = {{-70, 0}, {-90, 0}}), Line(points = {{0, -100}, {0, -70}}, color = {0, 0, 127}), Ellipse(fillColor = {245, 245, 245}, fillPattern = FillPattern.Solid, extent = {{-70, -70}, {70, 70}}), Text(textColor = {0, 0, 255}, extent = {{-150, 80}, {150, 120}}, textString = "%name"), Line(points = {{70, 0}, {90, 0}}), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -12}, {12, 12}}), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}), Line(points = {{37.6, 13.7}, {65.8, 23.9}}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}), Line(points = {{0, 70}, {0, 40}}), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, -7}, {7, 7}}), Text(origin = {-90, 66}, extent = {{20, -116}, {160, -86}}, textString = "I"), Polygon(rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-5, 0}, {-2, 60}, {0, 65}, {2, 60}, {5, 0}, {-5, 0}})}));
        end CurrentSensor;
      end Circuits;

      package Mechanical
        package Translational
          model ForceSensor
            extends DSFLib.Mechanical.Translational.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = f;
            s_rel = 0;
            annotation(
              Icon(graphics = {Text(textColor = {0, 85, 0}, extent = {{-150, 80}, {150, 120}}, textString = "%name"), Line(points = {{70, 0}, {90, 0}}), Line(points = {{0, -100}, {0, -70}}, color = {0, 0, 127}), Ellipse(fillColor = {245, 245, 245}, fillPattern = FillPattern.Solid, extent = {{-70, -70}, {70, 70}}), Line(points = {{-70, 0}, {-90, 0}}), Polygon(rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-5, 0}, {-2, 60}, {0, 65}, {2, 60}, {5, 0}, {-5, 0}}), Text(origin = {-90, 66}, extent = {{20, -116}, {160, -86}}, textString = "F"), Line(points = {{37.6, 13.7}, {65.8, 23.9}}), Line(points = {{0, 70}, {0, 40}}), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, -7}, {7, 7}}), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -12}, {12, 12}}), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}})}));
          end ForceSensor;

          model DistanceSensor
            extends DSFLib.Mechanical.Translational.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = s_rel;
            f = 0;
            annotation(
              Icon(graphics = {Line(points = {{70, 0}, {90, 0}}), Line(points = {{-70, 0}, {-90, 0}}), Text(textColor = {0, 85, 0}, extent = {{-150, 80}, {150, 120}}, textString = "%name"), Ellipse(fillColor = {245, 245, 245}, fillPattern = FillPattern.Solid, extent = {{-70, -70}, {70, 70}}), Line(points = {{0, -100}, {0, -70}}, color = {0, 0, 127}), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, -7}, {7, 7}}), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}), Line(points = {{0, 70}, {0, 40}}), Polygon(rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-5, 0}, {-2, 60}, {0, 65}, {2, 60}, {5, 0}, {-5, 0}}), Line(points = {{37.6, 13.7}, {65.8, 23.9}}), Text(origin = {-90, 66}, extent = {{20, -116}, {160, -86}}, textString = "s_rel"), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -12}, {12, 12}})}));
          end DistanceSensor;

          model SpeedSensor
            extends DSFLib.Mechanical.Translational.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = der(s_rel);
            f = 0;
            annotation(
              Icon(graphics = {Line(points = {{70, 0}, {90, 0}}), Line(points = {{0, -100}, {0, -70}}, color = {0, 0, 127}), Ellipse(fillColor = {245, 245, 245}, fillPattern = FillPattern.Solid, extent = {{-70, -70}, {70, 70}}), Line(points = {{-70, 0}, {-90, 0}}), Text(textColor = {0, 85, 0}, extent = {{-150, 80}, {150, 120}}, textString = "%name"), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, -7}, {7, 7}}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}), Polygon(rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-5, 0}, {-2, 60}, {0, 65}, {2, 60}, {5, 0}, {-5, 0}}), Text(origin = {-90, 66}, extent = {{20, -116}, {160, -86}}, textString = "v_rel"), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}), Line(points = {{37.6, 13.7}, {65.8, 23.9}}), Line(points = {{0, 70}, {0, 40}}), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -12}, {12, 12}})}));
          end SpeedSensor;
        end Translational;

        package Rotational
          model TorqueSensor
            extends DSFLib.Mechanical.Rotational.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = tau;
            phi_rel = 0;
            annotation(
              Icon(graphics = {Line(points = {{70, 0}, {90, 0}}), Line(points = {{0, -100}, {0, -70}}, color = {0, 0, 127}), Text(textColor = {64, 64, 64}, extent = {{-150, 80}, {150, 120}}, textString = "%name"), Ellipse(fillColor = {245, 245, 245}, fillPattern = FillPattern.Solid, extent = {{-70, -70}, {70, 70}}), Line(points = {{-70, 0}, {-90, 0}}), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, -7}, {7, 7}}), Polygon(rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-5, 0}, {-2, 60}, {0, 65}, {2, 60}, {5, 0}, {-5, 0}}), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), Line(points = {{0, 70}, {0, 40}}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}), Line(points = {{37.6, 13.7}, {65.8, 23.9}}), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}), Text(origin = {-90, 66}, extent = {{20, -116}, {160, -86}}, textString = "𝜏"), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -12}, {12, 12}})}));
          end TorqueSensor;

          model AngleSensor
            extends DSFLib.Mechanical.Rotational.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = phi_rel;
            tau = 0;
            annotation(
              Icon(graphics = {Line(points = {{70, 0}, {90, 0}}), Text(textColor = {64, 64, 64}, extent = {{-150, 80}, {150, 120}}, textString = "%name"), Line(points = {{-70, 0}, {-90, 0}}), Ellipse(fillColor = {245, 245, 245}, fillPattern = FillPattern.Solid, extent = {{-70, -70}, {70, 70}}), Line(points = {{0, -100}, {0, -70}}, color = {0, 0, 127}), Polygon(rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-5, 0}, {-2, 60}, {0, 65}, {2, 60}, {5, 0}, {-5, 0}}), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -12}, {12, 12}}), Text(origin = {-90, 66}, extent = {{20, -116}, {160, -86}}, textString = "ϕ"), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}), Line(points = {{37.6, 13.7}, {65.8, 23.9}}), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, -7}, {7, 7}}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}), Line(points = {{0, 70}, {0, 40}})}));
          end AngleSensor;

          model AngSpeedSensor
            extends DSFLib.Mechanical.Rotational.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = der(phi_rel);
            tau = 0;
            annotation(
              Icon(graphics = {Text(textColor = {64, 64, 64}, extent = {{-150, 80}, {150, 120}}, textString = "%name"), Ellipse(fillColor = {245, 245, 245}, fillPattern = FillPattern.Solid, extent = {{-70, -70}, {70, 70}}), Line(points = {{70, 0}, {90, 0}}), Line(points = {{-70, 0}, {-90, 0}}), Line(points = {{0, -100}, {0, -70}}, color = {0, 0, 127}), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -12}, {12, 12}}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}), Polygon(rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-5, 0}, {-2, 60}, {0, 65}, {2, 60}, {5, 0}, {-5, 0}}), Line(points = {{37.6, 13.7}, {65.8, 23.9}}), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}), Text(origin = {-90, 66}, extent = {{20, -116}, {160, -86}}, textString = "ω"), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, -7}, {7, 7}}), Line(points = {{0, 70}, {0, 40}})}));
          end AngSpeedSensor;
        end Rotational;

        package Planar
          model ForceSensor
            extends DSFLib.Mechanical.Planar.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = f;
            l = 0;
            annotation(
              Icon(graphics = {Ellipse(fillColor = {245, 245, 245}, fillPattern = FillPattern.Solid, extent = {{-70, -70}, {70, 70}}), Text(textColor = {64, 64, 64}, extent = {{-150, 80}, {150, 120}}, textString = "%name"), Polygon(rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-5, 0}, {-2, 60}, {0, 65}, {2, 60}, {5, 0}, {-5, 0}}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -12}, {12, 12}}), Line(points = {{0, -100}, {0, -70}}, color = {0, 0, 127}), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), Line(points = {{37.6, 13.7}, {65.8, 23.9}}), Line(points = {{0, 70}, {0, 40}}), Line(origin = {2.72357, (0 - 6)}, points = {{-74, 0}, {-104, 0}}), Text(origin = {-90, 66}, extent = {{20, -116}, {160, -86}}, textString = "F"), Line(points = {{70, 0}, {90, 0}}), Line(origin = {8, 0}, points = {{62, 0}, {90, 0}}), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, -7}, {7, 7}}), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}})}));
          end ForceSensor;

          model DistanceSensor
            extends DSFLib.Mechanical.Planar.Interfaces.Compliant;
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
          equation
            y = l;
            f = 0;
            annotation(
              Icon(graphics = {Text(textColor = {64, 64, 64}, extent = {{-150, 80}, {150, 120}}, textString = "%name"), Ellipse(fillColor = {245, 245, 245}, fillPattern = FillPattern.Solid, extent = {{-70, -70}, {70, 70}}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}), Polygon(rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-5, 0}, {-2, 60}, {0, 65}, {2, 60}, {5, 0}, {-5, 0}}), Line(points = {{70, 0}, {90, 0}}), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -12}, {12, 12}}), Line(origin = {2.72357, (0 - 6)}, points = {{-74, 0}, {-104, 0}}), Line(points = {{37.6, 13.7}, {65.8, 23.9}}), Line(points = {{0, -100}, {0, -70}}, color = {0, 0, 127}), Line(points = {{0, 70}, {0, 40}}), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, -7}, {7, 7}}), Text(origin = {-90, 66}, extent = {{20, -116}, {160, -86}}, textString = "L"), Line(origin = {8, 0}, points = {{62, 0}, {90, 0}})}));
          end DistanceSensor;
        end Planar;
      end Mechanical;

      package Hydraulics
        model PressureSensor
          extends DSFLib.Hydraulics.Interfaces.TwoPort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
        equation
          y = p;
          q = 0;
          annotation(
            Icon(graphics = {Ellipse(fillColor = {245, 245, 245}, fillPattern = FillPattern.Solid, extent = {{-70, -70}, {70, 70}}), Line(points = {{-70, 0}, {-90, 0}}), Line(points = {{70, 0}, {90, 0}}), Text(textColor = {64, 64, 64}, extent = {{-150, 80}, {150, 120}}, textString = "%name"), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), Polygon(rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-5, 0}, {-2, 60}, {0, 65}, {2, 60}, {5, 0}, {-5, 0}}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}), Line(points = {{37.6, 13.7}, {65.8, 23.9}}), Text(origin = {-90, 66}, extent = {{20, -116}, {160, -86}}, textString = "P"), Line(points = {{0, -100}, {0, -70}}, color = {0, 0, 127}), Line(points = {{0, 70}, {0, 40}}), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, -7}, {7, 7}}), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -12}, {12, 12}})}));
        end PressureSensor;

        model FlowSensor
          extends DSFLib.Hydraulics.Interfaces.TwoPort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
        equation
          y = q;
          p = 0;
          annotation(
            Icon(graphics = {Line(points = {{0, -100}, {0, -70}}, color = {0, 0, 127}), Text(textColor = {64, 64, 64}, extent = {{-150, 80}, {150, 120}}, textString = "%name"), Ellipse(fillColor = {245, 245, 245}, fillPattern = FillPattern.Solid, extent = {{-70, -70}, {70, 70}}), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}), Line(points = {{-70, 0}, {-90, 0}}), Line(points = {{70, 0}, {90, 0}}), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -12}, {12, 12}}), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, -7}, {7, 7}}), Line(points = {{0, 70}, {0, 40}}), Text(origin = {-90, 66}, extent = {{20, -116}, {160, -86}}, textString = "Q"), Polygon(rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-5, 0}, {-2, 60}, {0, 65}, {2, 60}, {5, 0}, {-5, 0}}), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}), Line(points = {{37.6, 13.7}, {65.8, 23.9}})}));
        end FlowSensor;
      end Hydraulics;

      package Thermal
        model TemperatureSensor
          extends DSFLib.Thermal.Interfaces.TwoPort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
        equation
          y = T_rel;
          q = 0;
          annotation(
            Icon(graphics = {Line(points = {{70, 0}, {90, 0}}), Ellipse(fillColor = {245, 245, 245}, fillPattern = FillPattern.Solid, extent = {{-70, -70}, {70, 70}}), Line(points = {{-70, 0}, {-90, 0}}), Text(textColor = {64, 64, 64}, extent = {{-150, 80}, {150, 120}}, textString = "%name"), Line(points = {{37.6, 13.7}, {65.8, 23.9}}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, -7}, {7, 7}}), Line(points = {{0, -100}, {0, -70}}, color = {0, 0, 127}), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -12}, {12, 12}}), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), Line(points = {{0, 70}, {0, 40}}), Text(origin = {-90, 66}, extent = {{20, -116}, {160, -86}}, textString = "T_rel"), Polygon(rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-5, 0}, {-2, 60}, {0, 65}, {2, 60}, {5, 0}, {-5, 0}}), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}})}));
        end TemperatureSensor;

        model HeatFlowSensor
          extends DSFLib.Thermal.Interfaces.TwoPort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {8, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -118}, extent = {{-18, -18}, {18, 18}}, rotation = -90)));
        equation
          y = q;
          T_rel = 0;
          annotation(
            Icon(graphics = {Ellipse(fillColor = {245, 245, 245}, fillPattern = FillPattern.Solid, extent = {{-70, -70}, {70, 70}}), Text(textColor = {64, 64, 64}, extent = {{-150, 80}, {150, 120}}, textString = "%name"), Text(origin = {-90, 66}, extent = {{20, -116}, {160, -86}}, textString = "q"), Line(points = {{37.6, 13.7}, {65.8, 23.9}}), Line(points = {{-70, 0}, {-90, 0}}), Polygon(rotation = -17.5, fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-5, 0}, {-2, 60}, {0, 65}, {2, 60}, {5, 0}, {-5, 0}}), Ellipse(fillColor = {64, 64, 64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-7, -7}, {7, 7}}), Line(points = {{-37.6, 13.7}, {-65.8, 23.9}}), Line(points = {{-22.9, 32.8}, {-40.2, 57.3}}), Line(points = {{0, 70}, {0, 40}}), Ellipse(lineColor = {64, 64, 64}, fillColor = {255, 255, 255}, extent = {{-12, -12}, {12, 12}}), Line(points = {{0, -100}, {0, -70}}, color = {0, 0, 127}), Line(points = {{22.9, 32.8}, {40.2, 57.3}}), Line(points = {{70, 0}, {90, 0}})}));
        end HeatFlowSensor;
      end Thermal;
    end Sensors;

    package Actuators
      package Circuits
        import DSFLib.Circuits.Interfaces.*;

        model ModulatedVoltageSource
          extends OnePort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealInput u annotation(
            Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -64}, extent = {{-14, -14}, {14, 14}}, rotation = 90)));
        equation
          v = u;
          annotation(
            Icon(graphics = {Ellipse(lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-50, 50}, {50, -50}}), Line(points = {{-80, 20}, {-60, 20}}, color = {0, 0, 255}), Line(points = {{60, 20}, {80, 20}}, color = {0, 0, 255}), Text(textColor = {0, 0, 255}, extent = {{-150, 70}, {150, 110}}, textString = "%name"), Line(points = {{-90, 0}, {-50, 0}}, color = {0, 0, 255}), Line(points = {{-50, 0}, {50, 0}}, color = {0, 0, 255}), Line(points = {{50, 0}, {90, 0}}, color = {0, 0, 255}), Line(points = {{-70, 30}, {-70, 10}}, color = {0, 0, 255})}));
        end ModulatedVoltageSource;

        model ModulatedCurrentSource
          extends DSFLib.Circuits.Interfaces.OnePort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealInput u annotation(
            Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -64}, extent = {{-14, -14}, {14, 14}}, rotation = 90)));
        equation
          i = -u;
          annotation(
            Icon(graphics = {Line(points = {{50, 0}, {90, 0}}, color = {0, 0, 255}), Text(textColor = {0, 0, 255}, extent = {{-150, 60}, {150, 100}}, textString = "%name"), Line(points = {{0, -50}, {0, 50}}, color = {0, 0, 255}), Line(points = {{-90, 0}, {-50, 0}}, color = {0, 0, 255}), Ellipse(lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-50, 50}, {50, -50}}), Polygon(origin = {44, 0}, rotation = 180, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{90, 0}, {60, 10}, {60, -10}, {90, 0}}), Line(origin = {14, 0}, points = {{-30, 0}, {30, 0}, {30, 0}}, color = {0, 0, 255})}));
        end ModulatedCurrentSource;
      end Circuits;

      package Mechanical
        model ModulatedForceSource
          extends DSFLib.Mechanical.Translational.Interfaces.Compliant;
          DSFLib.ControlSystems.Blocks.Interfaces.RealInput u annotation(
            Placement(visible = true, transformation(origin = {0, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 64}, extent = {{-14, 14}, {14, -14}}, rotation = -90)));
        equation
          flange_a.f = -u;
          annotation(
            Icon(graphics = {Text(origin = {0, -16}, textColor = {0, 0, 255}, extent = {{-150, -40}, {150, -80}}, textString = "%name"), Polygon(origin = {-6, 0}, lineColor = {0, 127, 0}, fillColor = {160, 215, 160}, fillPattern = FillPattern.Solid, points = {{90, 0}, {60, -30}, {60, -10}, {26, -10}, {26, 10}, {60, 10}, {60, 30}, {90, 0}}), Polygon(origin = {6, 0}, lineColor = {0, 127, 0}, fillColor = {160, 215, 160}, fillPattern = FillPattern.Solid, points = {{-90, 0}, {-60, 30}, {-60, 10}, {-26, 10}, {-26, -10}, {-60, -10}, {-60, -30}, {-90, 0}}), Ellipse(lineColor = {0, 127, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-50, 50}, {50, -50}})}));
        end ModulatedForceSource;
      end Mechanical;
    end Actuators;

    package Examples
      package DCMotorControl
        package Components
          model DCMotorBlock
            DSFLib.ControlSystems.Blocks.Interfaces.RealInput u annotation(
              Placement(visible = true, transformation(origin = {-112, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-117, 1}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
            DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
              Placement(visible = true, transformation(origin = {112, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {118, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
            DSFLib.Circuits.Components.ConstVolt Vexc(V = 184) annotation(
              Placement(visible = true, transformation(origin = {-51, -1}, extent = {{-11, -11}, {11, 11}}, rotation = -90)));
            DSFLib.Circuits.Components.Resistor Rexc(R = 25.2) annotation(
              Placement(visible = true, transformation(origin = {-27, 23}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
            DSFLib.MultiDomain.ElectroMechanical.Components.SepExcDCM sepExcDCM(K = 0.016, currTable = {0, 1.5, 3, 4.5, 6, 9, 10, 12, 13.5, 14.5, 15}, flange(phi(start = 0)), fluxTable = {0, 100, 200, 300, 370, 470, 500, 520, 539, 540}, phi0 = 413.385996015012) annotation(
              Placement(visible = true, transformation(origin = {12, 0}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
            DSFLib.Mechanical.Rotational.Components.Damper damper(b = 1) annotation(
              Placement(visible = true, transformation(origin = {68, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
            DSFLib.Circuits.Components.Ground ground annotation(
              Placement(visible = true, transformation(origin = {-27, -41}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
            DSFLib.Circuits.Components.Inductor La(L = 0.003) annotation(
              Placement(visible = true, transformation(origin = {-7, 45}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
            DSFLib.Circuits.Components.Resistor Ra(R = 0.05) annotation(
              Placement(visible = true, transformation(origin = {-47, 45}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
            DSFLib.Mechanical.Rotational.Components.Inertia inertia(J = 15) annotation(
              Placement(visible = true, transformation(origin = {66, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
            DSFLib.ControlSystems.Actuators.Circuits.ModulatedVoltageSource Va annotation(
              Placement(visible = true, transformation(origin = {-82, -8.88178e-16}, extent = {{-12, -12}, {12, 12}}, rotation = -90)));
            DSFLib.ControlSystems.Sensors.Mechanical.Rotational.AngSpeedSensor angSpeedSensor annotation(
              Placement(visible = true, transformation(origin = {68, -32}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
            DSFLib.Mechanical.Rotational.Components.Fixed fixed annotation(
              Placement(visible = true, transformation(origin = {88, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
          equation
            connect(Rexc.n, sepExcDCM.p_ex) annotation(
              Line(points = {{-16, 23}, {-2, 23}, {-2, 14}}));
            connect(La.n, sepExcDCM.p) annotation(
              Line(points = {{4, 45}, {26, 45}, {26, 14}}));
            connect(sepExcDCM.n, ground.p) annotation(
              Line(points = {{26, -14}, {26, -32}, {-27, -32}}));
            connect(Rexc.p, Vexc.p) annotation(
              Line(points = {{-38, 23}, {-51, 23}, {-51, 10}}));
            connect(Ra.n, La.p) annotation(
              Line(points = {{-36, 45}, {-18, 45}}));
            connect(inertia.flange, sepExcDCM.flange) annotation(
              Line(points = {{54, 0}, {45, 0}}));
            connect(Va.p, Ra.p) annotation(
              Line(points = {{-82, 12}, {-82, 45}, {-58, 45}}));
            connect(Va.n, ground.p) annotation(
              Line(points = {{-82, -12}, {-82, -32}, {-27, -32}}));
            connect(Vexc.n, ground.p) annotation(
              Line(points = {{-51, -12}, {-51, -32}, {-27, -32}}));
            connect(sepExcDCM.n_ex, ground.p) annotation(
              Line(points = {{-2, -14}, {-2, -32}, {-26, -32}}));
            connect(u, Va.u) annotation(
              Line(points = {{-112, 0}, {-90, 0}}));
            connect(angSpeedSensor.y, y) annotation(
              Line(points = {{68, -20}, {89, -20}, {89, 0}, {112, 0}}));
            connect(damper.flange_b, fixed.flange) annotation(
              Line(points = {{78, -58}, {88, -58}, {88, -32}}));
            connect(angSpeedSensor.flange_a, fixed.flange) annotation(
              Line(points = {{78, -32}, {88, -32}}));
            connect(angSpeedSensor.flange_b, sepExcDCM.flange) annotation(
              Line(points = {{58, -32}, {44, -32}, {44, 0}}));
            connect(damper.flange_a, sepExcDCM.flange) annotation(
              Line(points = {{58, -58}, {44, -58}, {44, 0}}));
            annotation(
              Icon(graphics = {Text(origin = {-2, 42}, textColor = {0, 0, 255}, extent = {{-150, 70}, {150, 110}}, textString = "%name"), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Bitmap(origin = {1, 3}, extent = {{89, -89}, {-89, 89}}, imageSource = "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")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
          end DCMotorBlock;
        end Components;

        model ControlledDCMotor
          DSFLib.ControlSystems.Examples.DCMotorControl.Components.DCMotorBlock motor annotation(
            Placement(visible = true, transformation(origin = {38, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.Add add(k2 = -1) annotation(
            Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.Gain gain(K = 1000) annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.RampSource reference(U = 60, t0 = 0, tf = 10) annotation(
            Placement(visible = true, transformation(origin = {-90, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(add.y, gain.u) annotation(
            Line(points = {{-32, 0}, {-10, 0}}, color = {0, 0, 127}));
          connect(gain.y, motor.u) annotation(
            Line(points = {{12, 0}, {26, 0}}, color = {0, 0, 127}));
          connect(motor.y, add.u2) annotation(
            Line(points = {{50, 0}, {60, 0}, {60, -20}, {-60, -20}, {-60, -6}, {-54, -6}}, color = {0, 0, 127}));
          connect(reference.y, add.u1) annotation(
            Line(points = {{-79, 6}, {-54, 6}}, color = {0, 0, 127}));
          annotation(
            experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.004));
        end ControlledDCMotor;
      end DCMotorControl;

      package QuarterVehicle
        model QuarterVehiclePasiveSuspention
          Mechanical.Translational.Components.Mass mc(m = 300, s(start = 0.9319)) annotation(
            Placement(visible = true, transformation(origin = {-1.77636e-15, 64}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
          Mechanical.Translational.Components.Mass mr(m = 30, s(start = 0.3792)) annotation(
            Placement(visible = true, transformation(origin = {0, -6}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
          Mechanical.Translational.Components.Spring k(k = 19960, s_rel0 = 0.7) annotation(
            Placement(visible = true, transformation(origin = {-16, 28}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
          Mechanical.Translational.Components.Damper c(b = 1300) annotation(
            Placement(visible = true, transformation(origin = {16, 28}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
          Mechanical.Translational.Components.Spring kt(k = 155900, s_rel0 = 0.4) annotation(
            Placement(visible = true, transformation(origin = {0, -38}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
          Mechanical.Translational.Components.ConstForce wc(F = -9.8*300) annotation(
            Placement(visible = true, transformation(origin = {44, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          Mechanical.Translational.Components.ConstForce wr(F = -9.8*30) annotation(
            Placement(visible = true, transformation(origin = {28, -38}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          ModulatedPosition modulatedPosition annotation(
            Placement(visible = true, transformation(origin = {-30, -66}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
          SoftPulseSource softPulseSource(U = 0.20, t1 = 2, t2 = 2.2, t3 = 6.2, t4 = 6.4) annotation(
            Placement(visible = true, transformation(origin = {-70, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(mc.flange, k.flange_b) annotation(
            Line(points = {{-1.77636e-15, 64}, {-1.77636e-15, 46}, {-16, 46}, {-16, 38}}));
          connect(mc.flange, c.flange_b) annotation(
            Line(points = {{-1.77636e-15, 64}, {-1.77636e-15, 46}, {16, 46}, {16, 38}}));
          connect(k.flange_a, mr.flange) annotation(
            Line(points = {{-16, 18}, {-16, 10}, {0, 10}, {0, -6}}));
          connect(c.flange_a, mr.flange) annotation(
            Line(points = {{16, 18}, {16, 10}, {0, 10}, {0, -6}}));
          connect(mr.flange, kt.flange_b) annotation(
            Line(points = {{0, -6}, {0, -28}}));
          connect(kt.flange_a, modulatedPosition.flange) annotation(
            Line(points = {{1.55431e-16, -48}, {1.55431e-16, -66}, {-16, -66}}));
          connect(mc.flange, wc.flange) annotation(
            Line(points = {{-1.77636e-15, 64}, {44, 64}, {44, 38}}));
          connect(mr.flange, wr.flange) annotation(
            Line(points = {{0, -6}, {28, -6}, {28, -28}}));
          connect(softPulseSource.y, modulatedPosition.u) annotation(
            Line(points = {{-58, -66}, {-46, -66}}));
          annotation(
            Diagram,
            experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
        end QuarterVehiclePasiveSuspention;

        model ModulatedPosition
          ControlSystems.Blocks.Interfaces.RealInput u annotation(
            Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-112, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Mechanical.Translational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
        equation
          flange.s = u;
          annotation(
            Icon(graphics = {Line(points = {{0, 52}, {0, 32}}, color = {0, 127, 0}), Line(origin = {0.490654, 41.215}, points = {{-30, -100}, {30, -100}}, color = {0, 127, 0}), Text(textColor = {0, 0, 255}, extent = {{150, 60}, {-150, 100}}, textString = "%name"), Rectangle(lineColor = {0, 127, 0}, fillColor = {160, 215, 160}, fillPattern = FillPattern.Solid, extent = {{-100, 20}, {100, -20}}), Line(origin = {0.490654, 41.215}, points = {{-10, -120}, {10, -100}}, color = {0, 127, 0}), Line(origin = {0.490654, 41.215}, points = {{10, -120}, {30, -100}}, color = {0, 127, 0}), Line(points = {{-29, 32}, {30, 32}}, color = {0, 127, 0}), Line(points = {{-30, -32}, {30, -32}}, color = {0, 127, 0}), Line(origin = {0.490654, 41.215}, points = {{-30, -120}, {-10, -100}}, color = {0, 127, 0}), Line(origin = {0.490654, 41.215}, points = {{-50, -120}, {-30, -100}}, color = {0, 127, 0}), Line(origin = {0.490654, 41.215}, points = {{0, -74}, {0, -100}}, color = {0, 127, 0})}));
        end ModulatedPosition;

        block SoftPulseSource
          parameter Real t1(unit = "s") = 0, t2(unit = "s") = 1, t3(unit = "s") = 5, t4(unit = "s") = 6, U = 1 "Amplitude";
          ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {116, -8.88178e-16}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
          ControlSystems.Blocks.Components.RampSource up(U = U, t0 = t1, tf = t2) annotation(
            Placement(visible = true, transformation(origin = {14, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          ControlSystems.Blocks.Components.RampSource down(U = U, t0 = t3, tf = t4) annotation(
            Placement(visible = true, transformation(origin = {14, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          ControlSystems.Blocks.Components.Add add(k2 = -1) annotation(
            Placement(visible = true, transformation(origin = {62, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(up.y, add.u1) annotation(
            Line(points = {{26, 22}, {36, 22}, {36, 6}, {50, 6}}));
          connect(down.y, add.u2) annotation(
            Line(points = {{26, -16}, {36, -16}, {36, -6}, {50, -6}}));
          connect(add.y, y) annotation(
            Line(points = {{74, 0}, {110, 0}}));
          annotation(
            Icon(graphics = {Text(origin = {0, -130}, extent = {{-102, 28}, {102, -28}}, textString = "U=%U"), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Line(origin = {0, -10}, points = {{-80, 80}, {-80, -80}}, color = {95, 95, 95}), Line(origin = {-31.99, -9.28}, points = {{-48, -70}, {-30, -70}, {10, 56}, {42, 56}}, thickness = 0.5), Polygon(origin = {0, -10}, lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, points = {{90, -70}, {68, -64}, {68, -76}, {90, -70}}), Polygon(lineColor = {95, 95, 95}, fillColor = {95, 95, 95}, fillPattern = FillPattern.Solid, points = {{-80, 90}, {-86, 68}, {-74, 68}, {-80, 90}}), Line(origin = {0, -10}, points = {{-90, -70}, {82, -70}}, color = {95, 95, 95}), Text(origin = {-2, 42}, textColor = {0, 0, 255}, extent = {{-150, 70}, {150, 110}}, textString = "%name"), Line(origin = {-30.4744, -11.5609}, points = {{96, -68}, {80, -68}, {42, 58}, {42, 58}}, thickness = 0.5)}));
        end SoftPulseSource;
      end QuarterVehicle;

      package TwoInertiasSystem
        model TwoInertiasSystem
          DSFLib.Mechanical.Rotational.Components.Fixed fixed annotation(
            Placement(visible = true, transformation(origin = {-78, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
          DSFLib.Mechanical.Rotational.Components.Inertia inertia_1(J = 0.009) annotation(
            Placement(visible = true, transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Spring spring_1(k = 2.7114) annotation(
            Placement(visible = true, transformation(origin = {-54, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Spring spring_2(k = 2.7114) annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Inertia inertia_2(J = 0.009) annotation(
            Placement(visible = true, transformation(origin = {32, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          TauSource tauSource annotation(
            Placement(visible = true, transformation(origin = {54, 0}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
          DSFLib.ControlSystems.Blocks.Components.PulseSource pulseSource(Tf = 6, Ti = 2, U = 0.5) annotation(
            Placement(visible = true, transformation(origin = {82, 8.88178e-16}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Components.Damper damper1(b = 0.02) annotation(
            Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          Mechanical.Rotational.Components.Damper damper(b = 0.02) annotation(
            Placement(visible = true, transformation(origin = {-54, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(spring_1.flange_a, fixed.flange) annotation(
            Line(points = {{-64.1, 9.9}, {-70.1, 9.9}, {-70.1, -0.1}, {-78.1, -0.1}}));
          connect(spring_1.flange_b, inertia_1.flange) annotation(
            Line(points = {{-44.1, 9.9}, {-38.1, 9.9}, {-38.1, -0.1}, {-32.1, -0.1}}));
          connect(spring_2.flange_a, inertia_1.flange) annotation(
            Line(points = {{-10, 0}, {-32, 0}}));
          connect(spring_2.flange_b, inertia_2.flange) annotation(
            Line(points = {{10, 0}, {22, 0}}));
          connect(tauSource.flange, inertia_2.flange) annotation(
            Line(points = {{46, 0}, {22, 0}}));
          connect(pulseSource.y, tauSource.u) annotation(
            Line(points = {{73, 0}, {66.22, 0}, {66.22, 8.17124e-16}, {61.72, 8.17124e-16}}));
          connect(damper.flange_b, inertia_1.flange) annotation(
            Line(points = {{-44.1, -12.1}, {-38.1, -12.1}, {-38.1, -0.1}, {-32.1, -0.1}}));
          connect(damper.flange_a, fixed.flange) annotation(
            Line(points = {{-64.1, -12.1}, {-70.1, -12.1}, {-70.1, -0.1}, {-78.1, -0.1}}));
          connect(inertia_2.flange, damper1.flange_b) annotation(
            Line(points = {{22, 0}, {16, 0}, {16, -30}, {10, -30}}));
          connect(damper1.flange_a, fixed.flange) annotation(
            Line(points = {{-10, -30}, {-70, -30}, {-70, 0}, {-78, 0}}));
        annotation(
            experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
end TwoInertiasSystem;

        model TauSource
          DSFLib.ControlSystems.Blocks.Interfaces.RealInput u annotation(
            Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-108, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
          DSFLib.Mechanical.Rotational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        equation
          flange.tau = -u;
          annotation(
            Icon(graphics = {Polygon(fillPattern = FillPattern.Solid, points = {{-53, -54}, {-36, -30}, {-50, -24}, {-53, -54}}), Line(points = {{-30, -100}, {30, -100}}), Text(extent = {{-62, -29}, {-141, -70}}, textString = "tau"), Line(points = {{-10, -120}, {10, -100}}), Line(points = {{-30, -120}, {-10, -100}}), Line(points = {{10, -120}, {30, -100}}), Line(points = {{-50, -120}, {-30, -100}}), Text(textColor = {0, 0, 255}, extent = {{-150, 110}, {150, 70}}, textString = "%name"), Polygon(origin = {-4, 6}, fillPattern = FillPattern.Solid, points = {{86, 0}, {66, 58}, {37, 27}, {86, 0}}), Line(points = {{0, -10}, {0, -101}}), Line(points = {{-84, 0}, {-78, 18}, {-58, 46}, {-26, 60}, {26, 60}, {60, 40}, {82, 8}}, thickness = 0.5, smooth = Smooth.Bezier), Line(points = {{-50, -40}, {-38, -24}, {-18, -12}, {0, -8}, {18, -12}, {38, -24}, {50, -40}}, smooth = Smooth.Bezier)}));
        end TauSource;
      end TwoInertiasSystem;
    end Examples;
  end ControlSystems;

  package BondGraph
    package Interfaces
      connector BondCon
        Real e;
        flow Real f;
        output Integer d;
        annotation(
          Icon(graphics = {Ellipse(origin = {1, -1}, fillColor = {216, 216, 216}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-99, 99}, {99, -99}})}));
      end BondCon;

      partial model PassiveOnePort
        BondGraph.Interfaces.BondCon bondCon annotation(
          Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-118, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Real e, f;
      equation
        e = bondCon.e;
        f = bondCon.f;
        bondCon.d = -1;
        annotation(
          Icon(graphics = {Line(origin = {-38.15, -20.21}, points = {{-79.8536, 20.2071}, {80.1464, 20.2071}, {40.1464, 60.2071}}, thickness = 10), Text(origin = {99, -82}, textColor = {0, 85, 255}, extent = {{-81, 20}, {81, -20}}, textString = "%name", fontSize = 12)}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
      end PassiveOnePort;

      partial model ActiveOnePort
        BondGraph.Interfaces.BondCon bondCon annotation(
          Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {152, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Real e, f;
      equation
        e = bondCon.e;
        f = bondCon.f;
        bondCon.d = 1;
        annotation(
          Icon(graphics = {Line(origin = {59.09, -21.61}, points = {{-79.8536, 20.2071}, {80.1464, 20.2071}, {40.1464, 60.2071}}, thickness = 10), Text(origin = {-84, -80}, textColor = {0, 85, 255}, extent = {{-80, 22}, {80, -22}}, textString = "%name", fontSize = 12)}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
      end ActiveOnePort;

      partial model TwoPort
        BondGraph.Interfaces.BondCon bondCon1 annotation(
          Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-216, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        BondGraph.Interfaces.BondCon bondCon2 annotation(
          Placement(visible = true, transformation(origin = {102, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {212, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Real e1, e2, f1, f2;
      equation
        e1 = bondCon1.e;
        e2 = bondCon2.e;
        f1 = bondCon1.f;
        f2 = bondCon2.f;
        bondCon1.d = -1;
        bondCon2.d = 1;
        annotation(
          Icon(graphics = {Line(origin = {-100.19, -18.42}, points = {{-101.854, 18.2071}, {18.1464, 18.2071}, {-23.8536, 60.2071}}, thickness = 10), Line(origin = {181.85, -17.37}, points = {{-101.854, 18.2071}, {18.1464, 18.2071}, {-23.8536, 60.2071}}, thickness = 10)}));
      end TwoPort;

      model ModPassiveOnePort
        extends BondGraph.Interfaces.PassiveOnePort;
        ControlSystems.Blocks.Interfaces.RealInput u annotation(
          Placement(visible = true, transformation(origin = {0, 0}, extent = {{0, 0}, {0, 0}}, rotation = 0), iconTransformation(origin = {87, 85}, extent = {{-15, 15}, {15, -15}}, rotation = -90)));
      equation

      end ModPassiveOnePort;

      model ModActiveOnePort
        extends BondGraph.Interfaces.ActiveOnePort;
        ControlSystems.Blocks.Interfaces.RealInput u annotation(
          Placement(visible = true, transformation(origin = {0, 0}, extent = {{0, 0}, {0, 0}}, rotation = 0), iconTransformation(origin = {-99, 85}, extent = {{-15, 15}, {15, -15}}, rotation = -90)));
      equation

      end ModActiveOnePort;

      model ModTwoPort
        extends BondGraph.Interfaces.TwoPort;
        DSFLib.ControlSystems.Blocks.Interfaces.RealInput u annotation(
          Placement(visible = true, transformation(extent = {{0, 0}, {0, 0}}, rotation = 0), iconTransformation(origin = {1, -85}, extent = {{-15, -15}, {15, 15}}, rotation = 90)));
      equation

      end ModTwoPort;

      connector BondConJ
        Real e;
        flow Real f;
        input Integer d;
        annotation(
          Icon(graphics = {Ellipse(origin = {1, -3}, fillColor = {216, 216, 216}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-99, 99}, {99, -99}}), Ellipse(origin = {4, -4}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-54, 52}, {54, -52}})}));
      end BondConJ;

      partial model Junction
        parameter Integer N = 3 "Number of ports";
        BondConJ bondConJ1(f = -f[1], e = e[1], d = d[1]) annotation(
          Placement(transformation(origin = {-100, 2}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 2}, extent = {{-10, -10}, {10, 10}})));
        BondConJ bondConJ2(f = -f[2], e = e[2], d = d[2]) annotation(
          Placement(transformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}})));
        BondConJ bondConJ3(f = -f[3], e = e[3], d = d[3]) if N > 2 annotation(
          Placement(transformation(origin = {110, 8}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 98}, extent = {{-10, -10}, {10, 10}})));
        BondConJ bondConJ4(f = -f[4], e = e[4], d = d[4]) if N > 3 annotation(
          Placement(transformation(origin = {120, 18}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}})));
        Real f[N], e[N];
        input Integer d[N];
      end Junction;
    end Interfaces;

    package Components
      package Basic
        model Bond
          BondGraph.Interfaces.BondCon bondCon1 annotation(
            Placement(visible = true, transformation(origin = {-102, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          BondGraph.Interfaces.BondCon bondCon2 annotation(
            Placement(visible = true, transformation(origin = {92, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {92, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          bondCon1.e = bondCon2.e;
          bondCon1.f = bondCon2.f;
          bondCon1.d = -1;
          bondCon2.d = 1;
          annotation(
            Icon(graphics = {Line(origin = {-0.46, -20.81}, points = {{-79.8536, 20.2071}, {80.1464, 20.2071}, {40.1464, 60.2071}}, thickness = 10)}));
        end Bond;

        model J0
          extends BondGraph.Interfaces.Junction;
        equation
          for i in 2:N loop
            e[i] = e[1];
          end for;
          f*d = 0;
          annotation(
            Icon(graphics = {Text(extent = {{-100, 100}, {100, -100}}, textString = "0"), Text(origin = {99, -82}, textColor = {0, 85, 255}, extent = {{-81, 20}, {81, -20}}, textString = "%name", fontSize = 12)}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end J0;

        model J1
          extends BondGraph.Interfaces.Junction;
        equation
          for i in 2:N loop
            f[i] = f[1];
          end for;
          e*d = 0;
          annotation(
            Icon(graphics = {Text(extent = {{-100, 100}, {100, -100}}, textString = "1"), Text(origin = {99, -82}, textColor = {0, 85, 255}, extent = {{-81, 20}, {81, -20}}, textString = "%name", fontSize = 12)}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end J1;

        model R
          extends BondGraph.Interfaces.PassiveOnePort;
          parameter Real R = 1;
        equation
          e = R*f;
          annotation(
            Icon(graphics = {Text(origin = {92, 6}, extent = {{-52, 92}, {52, -92}}, textString = "R")}));
        end R;

        model C
          extends BondGraph.Interfaces.PassiveOnePort;
          parameter Real C = 1;
          parameter Real q_0 = 0;
          Real q(start = q_0);
        equation
          der(q) = f;
          q = C*e;
          annotation(
            Icon(graphics = {Text(origin = {98, 6}, extent = {{-52, 92}, {52, -92}}, textString = "C")}));
        end C;

        model I
          extends BondGraph.Interfaces.PassiveOnePort;
          parameter Real I = 1;
          parameter Real p_0 = 0;
          Real p(start = p_0);
        equation
          der(p) = e;
          p = I*f;
          annotation(
            Icon(graphics = {Text(origin = {98, 6}, extent = {{-52, 92}, {52, -92}}, textString = "I")}));
        end I;

        model Se
          extends BondGraph.Interfaces.ActiveOnePort;
          parameter Real E = 1;
        equation
          e = E;
          annotation(
            Icon(graphics = {Text(origin = {-92, 9}, extent = {{-64, 107}, {64, -107}}, textString = "Se")}));
        end Se;

        model Sf
          extends BondGraph.Interfaces.ActiveOnePort;
          parameter Real F = 1;
        equation
          f = F;
          annotation(
            Icon(graphics = {Text(origin = {-92, 9}, extent = {{-64, 107}, {64, -107}}, textString = "Sf")}));
        end Sf;

        model TF
          extends BondGraph.Interfaces.TwoPort;
          parameter Real K = 1;
        equation
          e1 = K*e2;
          f2 = K*f1;
          annotation(
            Icon(graphics = {Text(origin = {-3, 5}, extent = {{-69, 83}, {69, -83}}, textString = "TF")}, coordinateSystem(initialScale = 0.1)));
        end TF;

        model GY
          extends BondGraph.Interfaces.TwoPort;
          parameter Real K = 1;
        equation
          e1 = K*f2;
          e2 = K*f1;
          annotation(
            Icon(graphics = {Text(origin = {-3, 5}, extent = {{-69, 83}, {69, -83}}, textString = "GY")}));
        end GY;
      end Basic;

      package Modulated
        model MR
          extends BondGraph.Interfaces.ModPassiveOnePort;
        equation
          e = u*f;
          annotation(
            Icon(graphics = {Text(origin = {92, 6}, extent = {{-52, 92}, {52, -92}}, textString = "R")}));
        end MR;

        model MC
          extends BondGraph.Interfaces.ModPassiveOnePort;
          parameter Real q_0 = 0;
          Real q(start = q_0);
        equation
          der(q) = f;
          q = u*e;
          annotation(
            Icon(graphics = {Text(origin = {98, 6}, extent = {{-52, 92}, {52, -92}}, textString = "C")}));
        end MC;

        model MI
          extends BondGraph.Interfaces.ModPassiveOnePort;
          parameter Real p_0 = 0;
          Real p(start = p_0);
        equation
          der(p) = e;
          p = u*f;
          annotation(
            Icon(graphics = {Text(origin = {98, 6}, extent = {{-52, 92}, {52, -92}}, textString = "I")}));
        end MI;

        model MSe
          extends BondGraph.Interfaces.ModActiveOnePort;
        equation
          e = u;
          annotation(
            Icon(graphics = {Text(origin = {-92, 9}, extent = {{-64, 107}, {64, -107}}, textString = "Se")}));
        end MSe;

        model MSf
          extends BondGraph.Interfaces.ModActiveOnePort;
        equation
          f = u;
          annotation(
            Icon(graphics = {Text(origin = {-92, 9}, extent = {{-64, 107}, {64, -107}}, textString = "Sf")}));
        end MSf;

        model MTF
          extends BondGraph.Interfaces.ModTwoPort;
        equation
          e1 = u*e2;
          f2 = u*f1;
          annotation(
            Icon(graphics = {Text(origin = {-3, 5}, extent = {{-69, 83}, {69, -83}}, textString = "TF")}));
        end MTF;

        model MGY
          extends BondGraph.Interfaces.ModTwoPort;
        equation
          e1 = u*f2;
          e2 = u*f1;
          annotation(
            Icon(graphics = {Text(origin = {-3, 5}, extent = {{-69, 83}, {69, -83}}, textString = "GY")}));
        end MGY;
      end Modulated;

      package Sensors
        model EffortSensor
          extends BondGraph.Interfaces.PassiveOnePort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {164, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {164, -2.22045e-15}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
        equation
          f = 0;
          y = e;
          annotation(
            Icon(graphics = {Text(origin = {92, 6}, extent = {{-52, 92}, {52, -92}}, textString = "De")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end EffortSensor;

        model FlowSensor
          extends BondGraph.Interfaces.PassiveOnePort;
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {164, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {164, -2.22045e-15}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
        equation
          e = 0;
          y = f;
          annotation(
            Icon(graphics = {Text(origin = {92, 6}, extent = {{-52, 92}, {52, -92}}, textString = "Df")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end FlowSensor;
      end Sensors;

      package MultiDomain
        model BGCircuit
          extends BondGraph.Interfaces.PassiveOnePort;
          Circuits.Interfaces.Pin p annotation(
            Placement(visible = true, transformation(origin = {102, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, 80}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
          Circuits.Interfaces.Pin n annotation(
            Placement(visible = true, transformation(origin = {112, 94}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, -70}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
          Real v(unit = "V");
          Real i(unit = "A");
        equation
          v = p.v - n.v;
          p.i = i;
          n.i + p.i = 0;
          v = e;
          i = f;
        end BGCircuit;
      end MultiDomain;
    end Components;

    package Examples
      model RC
        Components.Basic.J1 j1 annotation(
          Placement(transformation(origin = {-2, 4}, extent = {{-10, -10}, {10, 10}})));
        Components.Basic.Se se annotation(
          Placement(transformation(origin = {-32, 4}, extent = {{-10, -10}, {10, 10}})));
        Components.Basic.R r annotation(
          Placement(transformation(origin = {24, 4}, extent = {{-10, -10}, {10, 10}})));
        Components.Basic.C c annotation(
          Placement(transformation(origin = {-2, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      equation
        connect(se.bondCon, j1.bondConJ1) annotation(
          Line(points = {{-16, 4}, {-12, 4}}));
        connect(j1.bondConJ2, r.bondCon) annotation(
          Line(points = {{8, 4}, {12, 4}}));
        connect(j1.bondConJ3, c.bondCon) annotation(
          Line(points = {{-2, 14}, {-2, 18}}));
        annotation(
          experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
      end RC;

      model RLCCircuit
        BondGraph.Components.Basic.J0 v1(N = 2) annotation(
          Placement(transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}})));
        Components.Basic.Bond bond annotation(
          Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Basic.Bond bond1 annotation(
          Placement(transformation(origin = {24, 0}, extent = {{-10, -10}, {10, 10}})));
        BondGraph.Components.Basic.Bond bond2 annotation(
          Placement(transformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        BondGraph.Components.Basic.C C(q_0 = 1) annotation(
          Placement(transformation(origin = {-64, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        BondGraph.Components.Basic.R R annotation(
          Placement(transformation(origin = {72, 0}, extent = {{-10, -10}, {10, 10}})));
        BondGraph.Components.Basic.R R2 annotation(
          Placement(transformation(origin = {32, 34}, extent = {{-10, -10}, {10, 10}})));
        BondGraph.Components.Basic.I L annotation(
          Placement(transformation(origin = {46, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Components.Basic.J1 j1 annotation(
          Placement(transformation(extent = {{-10, -10}, {10, 10}})));
        Components.Basic.J0 v1_v2(N = 2) annotation(
          Placement(transformation(origin = {10, 34}, extent = {{-10, -10}, {10, 10}})));
        Components.Basic.J0 v2 annotation(
          Placement(transformation(origin = {46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      equation
        connect(C.bondCon, v1.bondConJ1) annotation(
          Line(points = {{-52, 0}, {-50, 0}}));
        connect(v1.bondConJ2, bond.bondCon1) annotation(
          Line(points = {{-30, 0}, {-28, 0}}));
        connect(bond.bondCon2, j1.bondConJ1) annotation(
          Line(points = {{-10, 0}, {-10, 0}}));
        connect(j1.bondConJ2, bond1.bondCon1) annotation(
          Line(points = {{10, 0}, {16, 0}}));
        connect(j1.bondConJ3, bond2.bondCon1) annotation(
          Line(points = {{0, 10}, {0, 11}}));
        connect(bond2.bondCon2, v1_v2.bondConJ1) annotation(
          Line(points = {{0, 29}, {0, 34}}));
        connect(v1_v2.bondConJ2, R2.bondCon) annotation(
          Line(points = {{20, 34}, {20, 34}}));
        connect(bond1.bondCon2, v2.bondConJ2) annotation(
          Line(points = {{34, 0}, {36, 0}}));
        connect(v2.bondConJ1, R.bondCon) annotation(
          Line(points = {{56, 0}, {60, 0}}));
        connect(v2.bondConJ3, L.bondCon) annotation(
          Line(points = {{46, -10}, {46, -14}}));
        annotation(
          experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
      end RLCCircuit;

      model DCMotor
        BondGraph.Components.Basic.Se Ua(E = 460) annotation(
          Placement(transformation(origin = {-76, 40}, extent = {{-10, -10}, {10, 10}})));
        BondGraph.Components.Basic.R Ra(R = 0.05) annotation(
          Placement(transformation(origin = {-46, 16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        BondGraph.Components.Basic.I La(I = 0.003) annotation(
          Placement(transformation(origin = {-46, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        BondGraph.Components.Basic.I J(I = 15) annotation(
          Placement(transformation(origin = {52, 42}, extent = {{-10, -10}, {10, 10}})));
        BondGraph.Components.Basic.R b(R = 1.1) annotation(
          Placement(transformation(origin = {26, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        BondGraph.Components.Basic.J1 ia(N = 4) annotation(
          Placement(transformation(origin = {-46, 40}, extent = {{-10, -10}, {10, 10}})));
        BondGraph.Components.Basic.J1 w annotation(
          Placement(transformation(origin = {26, 42}, extent = {{-10, -10}, {10, 10}})));
        Components.Basic.GY gy(K = 6.76) annotation(
          Placement(transformation(origin = {-10, 40}, extent = {{-10, -10}, {10, 10}})));
      equation
        connect(Ua.bondCon, ia.bondConJ1) annotation(
          Line(points = {{-61, 40}, {-56, 40}}));
        connect(ia.bondConJ3, La.bondCon) annotation(
          Line(points = {{-46, 50}, {-46, 54}}));
        connect(ia.bondConJ4, Ra.bondCon) annotation(
          Line(points = {{-46, 30}, {-46, 28}}));
        connect(w.bondConJ2, J.bondCon) annotation(
          Line(points = {{36, 42}, {40, 42}}));
        connect(b.bondCon, w.bondConJ3) annotation(
          Line(points = {{26, 58}, {26, 52}}));
        connect(ia.bondConJ2, gy.bondCon1) annotation(
          Line(points = {{-36, 40}, {-32, 40}}));
        connect(gy.bondCon2, w.bondConJ1) annotation(
          Line(points = {{11, 40}, {14, 40}, {14, 42}, {16, 42}}));
        annotation(
          experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
      end DCMotor;

      package SepExcMotor
        model NLI
          extends BondGraph.Interfaces.PassiveOnePort;
          parameter Real[:] f_Table = {-2, -1, 0, 1, 2};
          parameter Real[:] p_Table = {-2, -1, 0, 1, 2};
          parameter Real p_0 = 0;
          Real p(start = p_0);
        equation
          der(p) = e;
          p = DSFLib.Utilities.Functions.LookUpTable(f, f_Table, p_Table);
          annotation(
            Icon(graphics = {Text(origin = {98, 6}, extent = {{-52, 92}, {52, -92}}, textString = "I")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end NLI;

        model SepExcDCMotor
          BondGraph.Examples.SepExcMotor.NLIp nli(f_Table = {0, 3, 6, 9, 12, 15}, p_Table = {0, 200, 380, 480, 530, 545}) annotation(
            Placement(transformation(origin = {-20, -24}, extent = {{-10, -10}, {10, 10}})));
          BondGraph.Components.Basic.Se Ue(E = 184) annotation(
            Placement(transformation(origin = {-74, -24}, extent = {{-10, -10}, {10, 10}})));
          BondGraph.Components.Basic.R Re(R = 25.2) annotation(
            Placement(transformation(origin = {-44, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          BondGraph.Components.Basic.Se Ua(E = 460) annotation(
            Placement(transformation(origin = {-76, 40}, extent = {{-10, -10}, {10, 10}})));
          BondGraph.Components.Basic.R Ra(R = 0.05) annotation(
            Placement(transformation(origin = {-46, 16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          BondGraph.Components.Basic.I La(I = 0.003) annotation(
            Placement(visible = true, transformation(origin = {-46, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
          BondGraph.Components.Modulated.MGY mgy annotation(
            Placement(transformation(origin = {-12, 40}, extent = {{-10, -10}, {10, 10}})));
          BondGraph.Components.Basic.I J(I = 15) annotation(
            Placement(transformation(origin = {52, 42}, extent = {{-10, -10}, {10, 10}})));
          BondGraph.Components.Basic.R b(R = 1.1) annotation(
            Placement(transformation(origin = {26, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
          DSFLib.ControlSystems.Blocks.Components.Gain gain(K = 0.016) annotation(
            Placement(transformation(origin = {28, -24}, extent = {{-10, -10}, {10, 10}})));
          Components.Basic.J1 ia(N = 4) annotation(
            Placement(transformation(origin = {-46, 40}, extent = {{-10, -10}, {10, 10}})));
          Components.Basic.J1 w annotation(
            Placement(transformation(origin = {26, 42}, extent = {{-10, -10}, {10, 10}})));
          Components.Basic.J1 ie annotation(
            Placement(transformation(origin = {-44, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
        equation
          connect(nli.y, gain.u) annotation(
            Line(points = {{-3, -24}, {17, -24}}));
          connect(Ua.bondCon, ia.bondConJ1) annotation(
            Line(points = {{-61, 40}, {-56, 40}}));
          connect(ia.bondConJ3, La.bondCon) annotation(
            Line(points = {{-46, 50}, {-46, 54}}));
          connect(ia.bondConJ2, mgy.bondCon1) annotation(
            Line(points = {{-36, 40}, {-34, 40}}));
          connect(ia.bondConJ4, Ra.bondCon) annotation(
            Line(points = {{-46, 30}, {-46, 28}}));
          connect(mgy.bondCon2, w.bondConJ1) annotation(
            Line(points = {{9, 40}, {13.5, 40}, {13.5, 42}, {16, 42}}));
          connect(w.bondConJ2, J.bondCon) annotation(
            Line(points = {{36, 42}, {40, 42}}));
          connect(b.bondCon, w.bondConJ3) annotation(
            Line(points = {{26, 58}, {26, 52}}));
          connect(Ue.bondCon, ie.bondConJ2) annotation(
            Line(points = {{-59, -24}, {-54, -24}}));
          connect(ie.bondConJ3, Re.bondCon) annotation(
            Line(points = {{-44, -34}, {-44, -38}}));
          connect(ie.bondConJ1, nli.bondCon) annotation(
            Line(points = {{-34, -24}, {-32, -24}}));
          connect(gain.y, mgy.u) annotation(
            Line(points = {{39, -24}, {44, -24}, {44, 12}, {-12, 12}, {-12, 31.5}}, color = {0, 0, 127}));
          annotation(
            experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
        end SepExcDCMotor;

        model SepExcMotor
          BondGraph.Examples.SepExcMotor.NLI nli(f_Table = {0, 3, 6, 9, 12, 15}, p_Table = {0, 200, 380, 480, 530, 545}) annotation(
            Placement(visible = true, transformation(origin = {-58, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
          BondGraph.Components.Basic.J1 ie(N = 4) annotation(
            Placement(visible = true, transformation(origin = {-58, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          BondGraph.Components.Basic.Se Ue(E = 184) annotation(
            Placement(transformation(origin = {-86, -24}, extent = {{-10, -10}, {10, 10}})));
          BondGraph.Components.Basic.R Re(R = 25.2) annotation(
            Placement(visible = true, transformation(origin = {-58, -48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          BondGraph.Components.Basic.J1 ia(N = 4) annotation(
            Placement(visible = true, transformation(origin = {0, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          BondGraph.Components.Basic.Se Ua(E = 460) annotation(
            Placement(visible = true, transformation(origin = {-28, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          BondGraph.Components.Basic.R Ra(R = 0.05) annotation(
            Placement(visible = true, transformation(origin = {0, 18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          BondGraph.Components.Basic.I La(I = 0.003) annotation(
            Placement(visible = true, transformation(origin = {0, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
          BondGraph.Components.Modulated.MGY mgy annotation(
            Placement(visible = true, transformation(origin = {34, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          BondGraph.Components.Basic.J1 w annotation(
            Placement(visible = true, transformation(origin = {64, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          BondGraph.Components.Basic.I J(I = 15) annotation(
            Placement(visible = true, transformation(origin = {86, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          BondGraph.Components.Basic.R b(R = 1.1) annotation(
            Placement(transformation(origin = {64, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
          DSFLib.ControlSystems.Blocks.Components.Gain gain(K = 0.016) annotation(
            Placement(visible = true, transformation(origin = {70, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          BondGraph.Components.Sensors.FlowSensor ie_out annotation(
            Placement(visible = true, transformation(origin = {-34, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          BondGraph.Examples.SepExcMotor.LookUpTable lookUpTable(u_Table = {0, 3, 6, 9, 12, 15}, y_Table = {0, 200, 380, 480, 530, 545}) annotation(
            Placement(visible = true, transformation(origin = {14, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(Ua.bondCon, ia.bondConJ1) annotation(
            Line(points = {{-12.8, 42}, {-6.8, 42}}));
          connect(ia.bondConJ3, La.bondCon) annotation(
            Line(points = {{0, 50}, {0, 54}}));
          connect(ia.bondConJ2, mgy.bondCon1) annotation(
            Line(points = {{6.2, 42}, {12.2, 42}}));
          connect(Ra.bondCon, ia.bondConJ4) annotation(
            Line(points = {{0, 29.8}, {0, 33.8}}));
          connect(mgy.bondCon2, w.bondConJ1) annotation(
            Line(points = {{55.2, 42.2}, {57.2, 42.2}}));
          connect(w.bondConJ2, J.bondCon) annotation(
            Line(points = {{70.2, 42}, {74.2, 42}}));
          connect(ie.bondConJ4, Re.bondCon) annotation(
            Line(points = {{-57.8, -32}, {-57.8, -36}}));
          connect(ie.bondConJ1, Ue.bondCon) annotation(
            Line(points = {{-64.2, -24}, {-71, -24}}));
          connect(gain.y, mgy.u) annotation(
            Line(points = {{81.8, -24}, {89.8, -24}, {89.8, -2}, {33.8, -2}, {33.8, 34}}));
          connect(ie.bondConJ2, ie_out.bondCon) annotation(
            Line(points = {{-51.8, -24}, {-45.8, -24}}));
          connect(ie.bondConJ3, nli.bondCon) annotation(
            Line(points = {{-58, -16}, {-58, -10}}));
          connect(ie_out.y, lookUpTable.u) annotation(
            Line(points = {{-17.6, -24}, {2.4, -24}}));
          connect(lookUpTable.y, gain.u) annotation(
            Line(points = {{25.8, -24}, {57.8, -24}}));
          connect(b.bondCon, w.bondConJ3) annotation(
            Line(points = {{64, 56}, {64, 52}}));
          annotation(
            Diagram,
            experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02));
        end SepExcMotor;

        model NLIp
          extends BondGraph.Interfaces.PassiveOnePort;
          parameter Real[:] f_Table = {-2, -1, 0, 1, 2};
          parameter Real[:] p_Table = {-2, -1, 0, 1, 2};
          parameter Real p_0 = 0;
          Real p(start = p_0);
          DSFLib.ControlSystems.Blocks.Interfaces.RealOutput y annotation(
            Placement(visible = true, transformation(origin = {114, 88}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {169, 3}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
        equation
          der(p) = e;
          p = DSFLib.Utilities.Functions.LookUpTable(f, f_Table, p_Table);
          y = p;
          annotation(
            Icon(graphics = {Text(origin = {98, 6}, extent = {{-52, 92}, {52, -92}}, textString = "I"), Text(origin = {175, 65}, extent = {{-13, 13}, {13, -13}}, textString = "p")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end NLIp;

        block LookUpTable
          extends DSFLib.ControlSystems.Blocks.Interfaces.SISO;
          parameter Real[:] u_Table = {-2, -1, 0, 1, 2};
          parameter Real[:] y_Table = {-2, -1, 0, 1, 2};
        equation
          y = DSFLib.Utilities.Functions.LookUpTable(u, u_Table, y_Table);
          annotation(
            Icon(graphics = {Text(origin = {-8, 4}, extent = {{-78, 64}, {78, -64}}, textString = "LookUp 
Table")}));
        end LookUpTable;
      end SepExcMotor;
    end Examples;
 end BondGraph;

  package Utilities
    package Functions
      function LookUpTable
        input Real x;
        input Real[:] xdata;
        input Real[:] ydata;
        output Real y;
      protected
        Integer k;
      algorithm
        k := 1;
        while x > xdata[k + 1] and k < size(xdata, 1) - 1 loop
          k := k + 1;
        end while;
        y := (ydata[k + 1] - ydata[k])/(xdata[k + 1] - xdata[k])*(x - xdata[k]) + ydata[k];
      end LookUpTable;

      function TF2SS
        input Real num[:];
        input Real den[:];
        output Real A[size(den, 1) - 1, size(den, 1) - 1];
        output Real B[size(den, 1) - 1, 1];
        output Real C[1, size(den, 1) - 1];
        output Real D[1, 1];
      protected
        Integer n, m;
        Real num2[size(den, 1)];
      algorithm
        n := size(den, 1) - 1;
        if size(den, 1) == size(num, 1) then
          D[1, 1] := num[1]/den[1];
          num2 := num - D[1, 1]*den;
        else
          D[1, 1] := 0;
          num2 := 0*den;
          num2[n - size(num, 1) + 2:n + 1] := num;
        end if;
        B[n, 1] := 1;
        for i in 1:n loop
          A[n, i] := -den[n + 2 - i]/den[1];
          C[1, i] := num2[n + 2 - i]/den[1];
        end for;
        if n > 1 then
          A[1:n - 1, 2:n] := identity(n - 1);
          A[1:n - 1, 1] := zeros(n - 1);
          B[1:n - 1, 1] := zeros(n - 1);
        end if;
      end TF2SS;
    end Functions;
  end Utilities;
end DSFLib;