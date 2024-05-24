s0 = 1e6;
i0 = 10;
r0 = 0;
[t,x] = dtsim(@discreteSIR, [s0, i0, r0] , 0, 100)
plot(t,x, "linewidth", 2.5);
xlabel("Generation");
ylabel("Population");