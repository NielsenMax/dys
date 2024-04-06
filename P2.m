function x=P2(pre_x,t)
  b = 0.1;
  a = 0.01;
  pre_P = pre_x;
  P = pre_P * (1 + b - a * pre_P);
  x = P;
end