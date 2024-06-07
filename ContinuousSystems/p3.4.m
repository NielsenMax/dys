
dx = @(x, t) -x;
x0 = 1;
t0 = 1;
tf = 10;
h = 0.1;

[t,x] = feuler(dx, x0, t0, tf, h);

plot(t,x);
