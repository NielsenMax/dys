% Parámetros del sistema masa-resorte
  b = 100;
  k = 1;
  m = 1;
  F = 1;
d = @(x, t) [x(2), (-k/m)*x(1) - (b/m)*x(2) + F/m]';


% Condiciones iniciales
x0 = [0; 0]; 
ti = 0;
tf = 1000;
reltol = 1e-6;
abstol = 1e-8;

% Ejecutamos el método traprulevs
[t1, x1] = traprulevs(d, x0, ti, tf, reltol, abstol);

% Gráfico del resultado
plot(t1, x1(1, :));
xlabel('Tiempo');
ylabel('Desplazamiento');
title('Sistema Masa-Resorte con b = 100 usando traprulevs');