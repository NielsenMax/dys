m = 1;
k = 1;
b = 1;
A = [0 1;-k/m -b/m];

% Paso de integración h
h = 0.001;

stable = true;
while stable
    Ad = inv(eye(size(A)) - h * A) * (eye(size(A)) + 0.5 * h * A);
    lambda_d = eig(Ad);
    for k = 1:numel(lambda_d)
      stable = stable && abs(lambda_d(k)) <= 1;
    end
    fprintf('h = %.6f es estable.\n', h);
    h = h + 0.001; % Incrementa h para la siguiente prueba
end

% El último valor de h_max antes de volverse inestable
h = h - 0.001;
fprintf('El máximo h estable encontrado es %.6f.\n', h);