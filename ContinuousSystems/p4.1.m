% Parámetros
dx = @(x, t) -x;
x0 = 1;
t0 = 1;
tf = 10;
h = 0.1;

% Llamamos al método de Euler
[t,x] = feuler(dx, x0, t0, tf, h);

% Graficamos la solución
figure;
plot(t, x, '-o');
xlabel('Tiempo t');
ylabel('Concentración x(t)');
title('Aproximación de la Concentración del Fármaco usando Forward Euler');
