function x_dev = dx(x, t)
  k = 1;
  b = 1;
  m = 1;
  F = 1;
  x_dev = [x(2), (-k/m)*x(1) - (b/m)*x(2) + F/m]';
end

x0 = [1; 1]; 
t0 = 0; 
tf = 10; 

% Paso de integración h = 0.1
h1 = 0.1;
[t1, x1] = feuler(@dx, x0, t0, tf, h1);

% Paso de integración h = 0.01
h2 = 0.01;
[t2, x2] = feuler(@dx, x0, t0, tf, h2);

m = 1;
k = 1;
b = 1;
F = 1;
A = [0 1;-k/m -b/m];
B = [0 F]';
u = 1/m;

% Solución analítica en el primer paso para h1 y h2
xa_h1 = @ltiSolve(A,B,u,x0,t1);
xa_h2 = @ltiSolve(A,B,u,x0,t2);

% Graficar los resultados
plot(t1, x1(1, :));
hold on;
plot(t2, x2(1, :));
plot(t2, xa_h2(1, :));
hold off;
xlabel('Tiempo');
ylabel('Desplazamiento');
legend('h1 = 0.1', 'h2 = 0.01', 'Solución Analítica');
title('Sistema Masa-Resorte usando Forward Euler');

% Cálculo del error en el primer paso
error_h1 = norm(x1(:,2) - xa_h1(:,2), 1);
error_h2 = norm(x2(:,2) - xa_h2(:,2), 1);

% Mostrar los errores
disp(['Error en el primer paso con h = 0.1: ', num2str(error_h1)]);
disp(['Error en el primer paso con h = 0.01: ', num2str(error_h2)]);
