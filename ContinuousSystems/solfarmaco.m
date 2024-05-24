function x=solfarmaco(a, x0, t)
  for k=1:length(t)
    x(k)= exp(-a*t(k)) * x0;
  end
end