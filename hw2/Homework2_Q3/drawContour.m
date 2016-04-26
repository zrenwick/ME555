function drawContour(f)

    % Define the range of the contour plot
    x = -3:0.1:3;
    y = -3:0.1:4;
    
    % Evaluate objective values on the grid
    Z = zeros(length(x));
    for i = 1:length(x)
        for j = 1:length(y)
            Z(j,i) = feval(f,[x(i);y(j)]);
        end
    end
    
    % Plot contour
    contourf(x, y, Z, 100); 
    shading flat;