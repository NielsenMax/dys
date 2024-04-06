model multiSIR
  discreteSIRimp M1, M2(I.start = 0);
algorithm
  when sample(0, 1) then
    M1.imp := M2.exp;
    M2.imp := M1.exp;
  end when;
end multiSIR;