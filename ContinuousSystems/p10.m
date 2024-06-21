% Parámetros del sistema masa-resorte
  b = 1;
  k = 1;
  m = 1;
  F = 1;
d = @(x, t) [x(2), (-k/m)*x(1) - (b/m)*x(2) + F/m]';

% Condiciones iniciales
x0 = [0; 0];
ti = 0;
tf = 20;
reltol = 1e-6;
abstol = 1e-8;

% Ejecutamos el método rk23
[t1, x1] = rk23(d, x0, ti, tf, reltol, abstol);

% Gráfico del resultado
plot(t1, x1(1, :));
xlabel('Tiempo');
ylabel('Desplazamiento');
title('Sistema Masa-Resorte con b = 1 usando rk23');
