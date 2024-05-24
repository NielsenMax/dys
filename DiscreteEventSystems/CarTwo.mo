model CarTwo
discrete Real x(start = 0), y(start = 0), v(start = 0), theta(start = 0), psi(start = 0);
parameter Real L = 1, h = 0.1, Kv = 1, Kpsi = 2, Ky = 0.5, L0 = 4, v_ref = 2, y_ref = 1;
Real psi_ref;
Real a, omega;
algorithm
  when sample(0, h) then
    psi_ref := Ky * (atan(y_ref - pre(y))/L0 - pre(omega));
    a := Kv * (v_ref - pre(v));
    omega := Kpsi * (psi_ref - pre(psi));
    
    x := pre(x) + h * cos(pre(theta)) * cos(pre(psi)) * pre(v);
    y := pre(y) + h * sin(pre(theta)) * cos(pre(psi)) * pre(v);
    theta := pre(theta) + h * (sin(pre(psi)) * pre(v) / L);
    v := pre(v) + h * a;
    psi := pre(psi) + h * omega;
  end when;
end CarTwo;