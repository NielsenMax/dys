function x_dev = dx(x, t)
  k = 1;
  b = 1;
  m = 1;
  F = 1;
  x_dev = [x(2), (-k/m)*x(1) - (b/m)*x(2) + F/m]';
end

% Valores para calcular la solucion analitica
m = 1;
k =1;
b = 1;
F = 1;
A = [0 1;-k/m -b/m];
B = [0 F]';
u = 1/m;

x0 = [1; 1]; 
t0 = 0; 
tf = 10; 

% Paso de integración h = 0.1
h1 = 0.1;
[t1, x1] = feuler(@dx, x0, t0, tf, h1);

xa1 = @ltiSolve(A,B,u,x0,t1);


% Calculamos el error máximo a lo largo de toda la simulación para h1
error_max_h1 = norm(x1 - xa1, 1);

% Paso de integración h = 0.01
h2 = 0.01;
[t2, x2] = feuler(@dx, x0, t0, tf, h2);

xa2 = @ltiSolve(A,B,u,x0,t2);

% Calculamos el error máximo a lo largo de toda la simulación para h2
error_max_h2 = norm(x2 - xa2, 1);

% Mostramos los errores máximos
disp(['Error máximo a lo largo de toda la simulación con h = 0.1: ', num2str(error_max_h1)]);
disp(['Error máximo a lo largo de toda la simulación con h = 0.01: ', num2str(error_max_h2)]);
