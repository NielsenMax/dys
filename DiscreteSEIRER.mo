model DiscreteSEIRER
  parameter Real N = 1e6;
  discrete Real S(start = N), I(start = 10), E, R;
  parameter Real alpha = 1, gamma = 0.5, mu = 0.5, R0 = 1.5;
  parameter Integer Ti = 3, Tr = 12;
  parameter Real Ne[100];
  Integer i = 0;
  Real Ne_Ti, Ne_Tr;

equation

initial algorithm
  Ne[1] := (R0/(Tr-Ti))*(I*S/N);
algorithm
  when sample(0, 1) then
    i := pre(i) + 1;
    Ne_Ti := 0;
    if (i - Ti >= 0) then
      Ne_Ti := Ne[i - Ti];
    end if;
    Ne_Tr := 0;
    if (i - Tr >= 0) then
      Ne_Tr := Ne[i - Tr];
    end if;
    
    S := pre(S) - Ne[i];
    E := pre(E) + Ne[i] - Ne_Ti;
    I := pre(I) + Ne_Ti - Ne_Tr;
    R := pre(R) + Ne_Tr;
    Ne[i] := (R0/(Tr-Ti))*(I*S/N);
  end when;
end DiscreteSEIRER;