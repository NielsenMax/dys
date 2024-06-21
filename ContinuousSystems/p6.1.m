% Función que devuelve la derivada de x(t) para el sistema masa-resorte
function x_dev = dx(x, t, b)
  k = 1;
  m = 1;
  F = 1;
  x_dev = [x(2); (F/m) - (k/m)*x(1) - (b/m)*x(2)];
end

% Parámetros y condiciones iniciales
m = 1;
k = 1;
F = 1;
x0 = [1; 1];
t0 = 0; 
tf = 10; 

A = [0 1;-k/m -b/m];
B = [0 F]';
u = 1/m;

b = 1; 
h_values = 0.01:0.1:2.5; % Valores de h a probar

% Prueba valores de h hasta encontrar el máximo estable
for h = h_values
    [t, x] = beuler(@dx, x0, t0, tf, h, b);
    xa = ltiSolve(A,B,u,x0,t);
    % Comprobar estabilidad
    if norm(x - xa, 1) < 1;
        fprintf('Estable para h = %.2f\n', h);
    else
        fprintf('Inestable para h = %.2f\n', h);
        break;
    end
end