%%%%%%%%%%%%%% Gradient Descent Implementation %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% By Max Yi Ren and Emrah Bayrak %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function solution = gradientAlg(f,g,H,x0,opt)
    % Set initial conditions
     x = x0; % Set current solution to the initial guess
     iter = 0; % Set iteration counter to 0
    
    % Initialize a structure to record search process
    solution = struct('x',[]); 
    solution.x = [solution.x, x0]; % save current point
    
    % Set the termination criterion: Norm of gradient vector
    gnorm = norm(gradObj(x));

    while gnorm>opt.eps % if not terminated
        iter = iter + 1;
        
        % opt.linesearch switches line search on or off. 
        % You can first set the variable "a" to different constant values and see how it
        % affects the convergence.
        if opt.linesearch
            a = lineSearch(f,g,H,x,opt);
        else
            a = 0.001;
        end
        

        
        % Gradient descent:
        x = x-a.*gradObj(x);

        % save new point
        solution.x = [solution.x,x]; 
        
        % Update termination criterion: Norm of gradient vector at new point
        gnorm = norm(gradObj(x));
        disp(gnorm)
    end