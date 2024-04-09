function x=discreteSEIRER(pre_x,t)
  al=1;
  gam=0.5;
  mu=0.5;
  N=1e6;
  Ti = 3;
  Tr = 12;
  R0 = 1.5;

  pre_S=pre_x(1);
  pre_E=pre_x(2);
  pre_I=pre_x(3);
  pre_R=pre_x(4);

  Ne = pre_x(5:end);
  pre_Ne = Ne(Tr);
  Ne_Ti = Ne(Tr-Ti);
  Ne_Tr = Ne(1);

  S = pre_S - pre_Ne;
  E = pre_E + pre_Ne - Ne_Ti;
  I = pre_I + Ne_Ti - Ne_Tr ;
  R = pre_R + Ne_Tr;

  for i=1:(Tr-1)
      Ne(i) = Ne(i+1);
  end;
  Ne(Tr) = (R0/(Tr-Ti))*(I*S/N);


  x=[S;E;I;R;Ne];
end
