function delfdelx = gradObj(x)
    %%% Gradient vector. (row vector)
    %%% df/dx = [df/dx1, df/dx2, ... , df/dxn]
    
    delfdelx = [2*x(1), 2*x(2), 2*x(3)];