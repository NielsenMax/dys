t0 = 0; 
tf = 10; 

t = 0:0.1:10;
m = 1;
k = 1;
b = 1;
F = 1;
A = [0 1;-k/m -b/m];
B = [0 F]';
x0 = [0 0]';
u = 1/m;

% Paso de integración h = 0.1
h1 = 0.1;
[t1, x1] = beuler(@dx, x0, t0, tf, h1);

xa1 = @ltiSolve(A,B,u,x0,t1);

% Paso de integración h = 0.01
h2 = 0.01;
[t2, x2] = beuler(@dx, x0, t0, tf, h2);

xa2 = @ltiSolve(A,B,u,x0,t2);

% Graficar los resultados
plot(t1, x1(1, :));
hold on;
plot(t2, x2(1, :));
plot(t2, xa2(1, :));
hold off;
xlabel('Tiempo');
ylabel('Desplazamiento');
legend('h1 = 0.1', 'h2 = 0.01', 'Solución Analítica');
title('Sistema Masa-Resorte usando Backward Euler');

% Calculamos del error en el primer paso
error_h1 = norm(x1(:,2) - xa1(:,2), 1);
error_h2 = norm(x2(:,2) - xa2(:,2), 1);

% Mostramos los errores
disp(['Error en el primer paso con h = 0.1: ', num2str(error_h1)]);
disp(['Error en el primer paso con h = 0.01: ', num2str(error_h2)]);

% Calculamos el error máximo a lo largo de toda la simulación
error_max_h2 = norm(x2 - xa2, 1);
error_max_h1 = norm(x1 - xa1, 1);

% Mostramos los errores máximos
disp(['Error máximo a lo largo de toda la simulación con h = 0.1: ', num2str(error_max_h1)]);
disp(['Error máximo a lo largo de toda la simulación con h = 0.01: ', num2str(error_max_h2)]);

