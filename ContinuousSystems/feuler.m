function [t, x]=feuler(f, x0, t0, tf, h)
  t = [t0:h:tf];
  x = zeros(length(x0), length(t));
  x(:,1) = x0;
  for k=1:length(t)-1
    primer = x(:,k)
    segundo = f(x(:,k), t(k))
    x(:,k+1) = x(:,k) + h*f(x(:,k), t(k));
  end
end
