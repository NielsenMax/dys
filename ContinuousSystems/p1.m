% Parámetros
a = 1;
x0 = 1;
t = 1:100
% Calculamos la solución analítica
x = solfarmaco(1, 1, t)

% Graficamos la solución
plot(t, x, "linewidth", 2.5);
xlabel('Tiempo t');
ylabel('Concentración x(t)');
title('Absorción de un Fármaco en el Sistema Digestivo');