model multiSIR3
  discreteSIRimp M1, M2(I.start = 1), M3(I.start = 0);
algorithm
  when sample(0, 1) then
    M1.imp := 1/2 * M2.exp;
    M2.imp := M1.exp + M3.exp;
    M3.imp := 1/2 * M2.exp;
  end when;
end multiSIR3;