function x_dev = dx(x, t)
  k = 1;
  b = 1;
  m = 1;
  F = 1;
  x_dev = [x(2), (-k/m)*x(1) - (b/m)*x(2) + F/m]';
end

x0 = [1 1];
t0 = 1;
tf = 10;
h = 0.1;

[t,x] = feuler(@dx, x0, t0, tf, h);
x
plot(t,x);
