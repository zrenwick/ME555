function g = constraint(x)
    %%% Calculate the constraints (column vector)
    %%% g(x) = [g1(x); g2(x); ... ; gm(x)]
    g = [ x(2)^2 - 2*x(1);...
         (x(2)-1)^2 + 5*x(1) - 15];
end