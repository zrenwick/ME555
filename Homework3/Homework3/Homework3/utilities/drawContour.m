function drawContour(f, x_min, x_max, y_min, y_max)
    
    stepx = (x_max-x_min)/200;
    stepy = (y_max-y_min)/200;
    
    % UPDATED to account for varying grid sizes
    x = x_min:stepx:x_max;
    y = y_min:stepy:y_max;
    
    [X,Y] = meshgrid(x,y);
    Z = zeros(length(y),length(x));
    for i = 1:length(x)
        for j = 1:length(y)
            Z(j,i) = feval(f,[x(i);y(j)]);
        end
    end
    
    
    contourf(X, Y, real(Z.^0.5), 20); 
    colormap winter;
end