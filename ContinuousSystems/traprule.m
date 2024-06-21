function [t,x]=traprule(f,x0,t0,tf,h)
  t=[t0:h:tf];
  x=zeros(length(x0),length(t));
  x(:,1)=x0;
  for k=1:length(t)-1
    F=@(xk1) xk1-x(:,k)-0.5*h*(f(xk1,t(k)+h)+f(x(:,k),t(k)));
    x(:,k+1)=fsolve(F,x(:,k));
  endfor
endfunction