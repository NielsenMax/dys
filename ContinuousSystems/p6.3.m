% Defimos la matriz A
m = 1;
k = 1;
b = 0;
A = [0 1;-k/m -b/m];

% Paso de integracion h
h = 0.001;

stable = true;
while stable
    Ad = eye(size(A)) + h * A;
    lambda_d = eig(Ad);
    for k = 1:numel(lambda_d)
      stable = stable && abs(lambda_d(k)) < 1;
    end
    fprintf('h = %.6f es estable.\n', h);
    h = h + 0.01; % Incrementa h para la siguiente prueba
end

% El ultimo valor de h_max antes de volverse inestable
h = h - 0.01;
fprintf('El maximo h estable encontrado es %.6f.\n', h);
