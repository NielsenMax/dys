% Defimos la matriz A
m = 1;
k = 1;
b = 10;
A = [0 1;-k/m -b/m];
lambda = eig(A);

% Paso de integracion h
h = 0.01;
h_dif = h;

stable = true;
while stable
    for k = 1:numel(lambda)
      lambda_d = 1 + lambda(k)*h ;
      stable = stable && abs(lambda_d) < 1;
    end
    if stable
      fprintf('h = %.4f es estable.\n', h);
      h = h + h_dif; % Incrementa h para la siguiente prueba
    end
end

% El ultimo valor de h_max antes de volverse inestable
fprintf('El maximo h estable encontrado es %.4f.\n', h);
