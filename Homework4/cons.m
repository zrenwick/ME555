function h = cons(x)
    %%%% Constraint vector (column vector)
    %%%% h(x) = [h1(x); h2(x); ...; hn(x)]
    
    h = [ (1/4)*x(1).^2 + (1/5)*x(2).^2 + (1/25)*x(3).^2 - 1;...
           x(1) + x(2) - x(3)];
         
