s0 = 1e6;
e0 = 1;
i0 = 0;
r0 = 0;
[t,x] = dtsim(@discreteSEIR, [s0; e0; i0; r0] , 0, 100)
plot(t,x, "linewidth", 2.5);
xlabel("Generation");
ylabel("Population");