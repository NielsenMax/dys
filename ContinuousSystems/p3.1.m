% Parámetros del sistema masa-resorte
t = 0:0.1:10;
m = 1;
k = 1;
b = 1;
F = 1;
A = [0 1;-k/m -b/m];
B = [0 F]';
x0 = [0 0]';
u = 1/m;
% Llamamos a la función ltiSolve
x = ltiSolve(A,B,u,x0,t);

% Graficamos los resultados
plot(t, x(1,:), 'b', t, x(2,:), 'r');
xlabel('Tiempo t');
ylabel('Estados x(t)');
legend('Posición x_1(t)', 'Velocidad x_2(t)');
title('Solución Analítica del Sistema Masa-Resorte-Amortiguador')
