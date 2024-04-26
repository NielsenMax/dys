function x=ltiSolve(A,B,u,x0,t)
  for k=1:length(t)
    eAt = expm(A*t(k));
    x(:,k) = eAt * x0 + inv(A) * (eAt - eye(length(x0))) * B * u;
  end
end