t = 0:0.1:10;
m = 1;
k =1;
b = 1;
F = 1;
A = [0 1;-k/m -b/m];
B = [0 F]';
x0 = [0 0]';
u = 1/m;
x = ltiSolve(A,B,u,x0,t);
plot(t,x)