function dg = constraintg(x)
    %%% Calculate the gradient of the constraints
    %%% dg(x)/dx = [dg1/dx1, dg1/dx2, ... , dg1/dxn;
    %%%             dg2/dx1, dg2/dx2, ... , dg2/dxn;
    %%%             ...
    %%%             dgm/dx1, dgm/dx2, ... , dgm/dxn]
    
    
    dg = [ -2,     2*x(2);...
            5, 2*(x(2)-1)];

end