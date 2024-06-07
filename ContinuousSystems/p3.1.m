p0 = 1;
t = 1:100
x = solfarmaco(1, 1, t)
plot(x,t, "linewidth", 2.5);
xlabel("Generation");
ylabel("Population");