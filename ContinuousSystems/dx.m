function x_dev = dx(x, t)
  k = 1;
  b = 1;
  m = 1;
  F = 1;
  x_dev = [x(2), (-k/m)*x(1) - (b/m)*x(2) + F/m]';
end