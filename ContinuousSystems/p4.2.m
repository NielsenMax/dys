function x_dev = dx(x, t)
  k = 1;
  b = 1;
  m = 1;
  F = 1;
  x_dev = [x(2), (-k/m)*x(1) - (b/m)*x(2) + F/m]';
end

% Parámetros 
x0 = [1 1];
t0 = 1;
tf = 10;
h = 0.1;

% Llamamos al método de Euler
[t,x] = feuler(@dx, x0, t0, tf, h);

% Graficamos la solución
plot(t, x);
xlabel('Tiempo t');
ylabel('Estado x');
legend('x_1 (posición)', 'x_2 (velocidad)');
title('Solución del sistema masa-resorte utilizando Forward Euler');
