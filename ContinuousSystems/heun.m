function [t, x] = heun(f, x0, t0, tf, h)
    t = [t0:h:tf];
    x = zeros(length(x0), length(t));
    x(:,1) = x0;

    for k=1:length(t)-1
        tk = t(k);
        xk = x(:,k);
        
        k1 = feval(f, xk, tk);
        k2 = feval(f, xk + h*k1, tk + h); 
        
        x(:,k+1) = xk + (h/2) * (k1 + k2);
    end
end