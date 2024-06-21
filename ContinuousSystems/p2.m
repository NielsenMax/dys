% Parámetros del sistema
t = 1:10;
A = [0 1;-1 -1];
B = [0 1]';
x0 = [0 0]';
u = 1;

% Llamamos a la función ltiSolve
x = ltiSolve(A,B,u,x0,t)

% Graficamos los resultados

plot(t, x(1,:), 'b', t, x(2,:), 'r');
xlabel('Tiempo t');
ylabel('Estados x(t)');
legend('x_1(t)', 'x_2(t)');
title('Solución Analítica del Sistema LTI');
