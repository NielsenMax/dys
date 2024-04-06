function x=P2(pre_x,t)
  b = 0.1;
  a = 0.01;
  pre_P = pre_x;
  d = a * pre_P;
  P = pre_P * (1 + b - d);
  x = P;
end