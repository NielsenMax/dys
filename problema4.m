s0 = 1e6;
e0 = 0;
i0 = 1000;
r0 = 0;

Tr = 12;
Ne = zeros(Tr,1);
Ne(Tr) = (1.5/9)*(i0*s0)/1e6;
[t,x] = dtsim(@discreteSEIRER, [s0; e0; i0; r0; Ne] , 1, 1000);
x = x(1:4,:);
plot(t,x, "linewidth", 2.5);
xlabel("Generation");
ylabel("Population");
