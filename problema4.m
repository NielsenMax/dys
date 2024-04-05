s0 = 1e6;
e0 = 0;
i0 = 1;
r0 = 0;
Ne = zeros(100,1);
Ne(1) = (1.5/9)*(i0*s0)/1e6
[t,x] = dtsim(@discreteSEIRER, [s0; e0; i0; r0; Ne] , 1, 100);
plot(t,x, "linewidth", 2.5);
xlabel("Generation");
ylabel("Population");
