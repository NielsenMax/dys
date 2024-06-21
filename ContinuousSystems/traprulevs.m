function [t, x] = traprulevs(f, x0, ti, tf, reltol, abstol)
    hmax = (tf - ti) / 10;
    t = zeros(1, 10000);
    x = zeros(length(x0), 10000);
    t(1) = ti;
    x(:, 1) = x0;
    k = 1;
    h = 1e-6 * (tf - ti);
    
    while t(k) < tf
        if t(k) > tf - h
            h = tf - t(k);
        end
        
        k1 = f(x(:, k), t(k));
        k2 = f(x(:, k) + h * k1, t(k) + h);
        xheun = x(:, k) + h * (k1 / 2 + k2 / 2);
        
        F = @(xk1) xk1 - x(:, k) - 0.5 * h * (f(xk1, t(k) + h) + f(x(:, k), t(k)));
        xtrap = fsolve(F, x(:, k));
        
        err = norm(xtrap - xheun);
        maxerr = max(abstol, reltol * norm(xtrap));
        
        if err < maxerr
            x(:, k+1) = xtrap;
            t(k+1) = t(k) + h;
            k = k + 1;
        end
        
        if err != 0
            h = 0.8 * h * (maxerr / err)^(1/3);
            if h > hmax
                h = hmax;
            end
        else
            h = hmax;
        end
    end
    
    t = t(1:k);
    x = x(:, 1:k);
end
