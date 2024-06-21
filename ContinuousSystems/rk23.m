function [t, x] = rk23(f, x0, ti, tf, reltol, abstol)
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
        k3 = f(x(:, k) + h * k1 / 4 + h * k2 / 4, t(k) + h / 2);
        
        xheun = x(:, k) + h * (k1 / 2 + k2 / 2);
        xrk3 = x(:, k) + h * (k1 / 6 + k2 / 6 + 2 * k3 / 3);
        
        err = norm(xrk3 - xheun);
        maxerr = max(abstol, reltol * norm(xrk3));
        
        if err < maxerr
            x(:, k+1) = xrk3;
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
