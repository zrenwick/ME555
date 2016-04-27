function df = objectiveg(x)
    %%% Calculate the gradient of the objective (row vector)
    %%% df(x)/dx = [df/dx1, df/dx2, ..., df/xn]
    
    df = [2*x(1), 2*(x(2)-3)];

end