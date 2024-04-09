model DiscreteSEIRER
  parameter Real N = 1e6;
  discrete Real S(start = N), I(start = 1000), E(start=0), R(start=0);
  parameter Real R0 = 1.5;
  parameter Integer Ti = 3, Tr = 12;
  Real Ne[Tr];
  Real Ne_i, Ne_Ti, Ne_Tr;

equation

initial algorithm
  for i in 1:(Tr-1) loop
    Ne[i] := 0;
  end for;
  Ne[Tr] := (R0/(Tr-Ti))*(I*S/N);
algorithm
  when sample(0, 1) then
    Ne_i := Ne[Tr];
    Ne_Ti := Ne[Tr-Ti];
    Ne_Tr := Ne[1];
    
    S := pre(S) - Ne_i;
    E := pre(E) + Ne_i - Ne_Ti;
    I := pre(I) + Ne_Ti - Ne_Tr;
    R := pre(R) + Ne_Tr;

    for i in 1:(Tr-1) loop
      Ne[i] := Ne[i+1];
    end for;
    Ne[Tr] := (R0/(Tr-Ti))*(I*S/N);
  end when;
end DiscreteSEIRER;