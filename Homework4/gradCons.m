function delhdelx = gradCons(x)
    %%% Gradient of the contraints:
    %%% dh/dx = [dh1/dx1, dh1/dx2, ... dh1/dxn;
    %%%           ...
    %%%          dhn/dx1, dhn/dx2, ... dhn/dxn]
    
    
    delhdelx = [ (1/2)*x(1), (2/5)*x(2), (2/25)*x(3);...
                          1,          1,          -1];