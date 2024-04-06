model CarOne
discrete Real x(start = 0), y(start = 0), v(start = 0), theta(start = 0), psi(start = 0);
parameter Real L = 1, h = 0.1;
Real a, omega;
discrete Real t(start = 0);
algorithm
  when sample(0, h) then
    a := (if pre(t) < 2 then 1 else 0);
    omega := (if pre(t) < 1 then 0.1 elseif (pre(t) < 2) then -0.1 else 0);
    t := pre(t) + h;
    x := pre(x) + h * cos(pre(theta)) * cos(pre(psi)) * pre(v);
    y := pre(y) + h * sin(pre(theta)) * cos(pre(psi)) * pre(v);
    theta := pre(theta) + h * (sin(pre(psi)) * pre(v) / L);
    v := pre(v) + h * a;
    psi := pre(psi) + h * omega;
  end when;
end CarOne;