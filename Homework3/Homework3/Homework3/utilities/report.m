%--------------------------------------------------------------------------
%           ME 555 - Winter 2016 - HW 3
%
%           Reference: Papalambros, P.Y. and Wilde, D.J., 2000. Principles
%                      of Optimal Design: Modeling and Computation.
%                      Cambridge University Press.
%
%           Authors: Alex Burnap, Emrah Bayrak, Max Yi Ren
%           Date of Last Update: February 10, 2016
%           License: MIT (see bottom of file)
%            
%           Instructions: In this file, we will create plots of the contour
%           functions for either of the two test functions.
%           We will be using two test functions: 6 hump Camelback and the
%           Eggholder Function; your homework will have visualization of
%           the 2D functions.
%
%           Note: You do not need to change this file
%--------------------------------------------------------------------------

function report(solution, f, algorithm, x1_min, x1_max, x2_min, x2_max)
    figure; % Open an empty figure window
    xlabel('x1');
    ylabel('x2');
    %title('Search Path', 20);
    hold on; % Hold on to the current figure
    
    % Draw a 2D contour plot for the objective function
    % You can edit drawing parameters within the file: drawContour.m
    drawContour(f, x1_min, x1_max, x2_min, x2_max);
    
    if strcmp(algorithm, 'gradient')
        % Plot the search path
        x = solution.x;
        iter = size(x,2);
        plot(x(1,1),x(2,1),'.y','markerSize',20);
        for i = 2:iter
            % Draw lines. Type "help line" to see more drawing options.
            line([x(1,i-1),x(1,i)],[x(2,i-1),x(2,i)],'Color','y');
            plot(x(1,i),x(2,i),'.y','markerSize',20);
        end
    elseif strcmp(algorithm, 'ga')
        for i = 1:int16(solution.Generation)
            % Plot the best member of the population for the last few
            % generations
            %[best_fval, best_index] = min(solution.Score(:,i));
            %x_best = solution.Population(best_index, :, i);
            %plot(x_best(1),x_best(2),'r.','markerSize',20);
            plot(solution.Population(:,1,i),solution.Population(:,2,i),'r.','markerSize',10);
            hold on
        end
    else
        disp('ERROR: Optimization algorithm not set');
    end