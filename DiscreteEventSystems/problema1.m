p0 = 1;
[t,x] = dtsim(@P, p0 , 0, 100)
plot(t,x, "linewidth", 2.5);
xlabel("Generation");
ylabel("Population");