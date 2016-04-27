%%%%%%%%%%%%%% Sequential Quadratic Programming Implementation %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% By Max Yi Ren and Emrah Bayrak %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function solution = mysqp(f, df, g, dg, x0, opt)
    % Set initial conditions
    
    x = x0; % Set current solution to the initial guess
    
    % Initialize a structure to record search process
    solution = struct('x',[]); 
    solution.x = [solution.x, x]; % save current solution to solution.x
    
    % Initialization of the Hessian matrix
    W = eye(size(dg(x),2));             % Start with an identity Hessian matrix

    % Initialization of the Lagrange multipliers
    mu_old = zeros(size(dg(x),1),1);    % Start with zero Lagrange multiplier estimates

    % Initialization of the weights in merit function
    w = zeros(size(dg(x),1),1);         % Start with zero weights

    grad_L = @(x,mu) df(x) + mu'*dg(x);
    
    % Set the termination criterion
    gnorm = norm(grad_L(x,mu_old)); % norm of Largangian gradient
    
    while gnorm>opt.eps % if not terminated
        % Implement QP problem and solve
        % Solve the QP subproblem to find s and mu (using your own method)
        [s, mu_new] = solveqp(x, W, df, g, dg);

        
        % opt.linesearch switches line search on or off. 
        % You can first set the variable "a" to different constant values and see how it
        % affects the convergence.
        if opt.linesearch
            [a, w] = lineSearch(f, df, g, dg, x, s, mu_old, w);
        else
            a = 0.1;
        end
        
        % Update the current solution using the step
        dx = a.*s;               % Step for x
        x = x + dx;             % Update x using the step
        
        % Update Hessian using BFGS.
        % Compute y_k
        y_k = grad_L(x,mu_new)' - grad_L(solution.x(:,end), mu_new)';

        % Compute theta
        
        if (dx'*y_k >= (0.2)*dx'*W*dx)
            theta = 1;
        else
            theta = ((0.8)*dx'*W*dx)/(dx'*W*dx - dx'*y_k);
        end
        % Compute  dg_k using y_k, theta, W and dx
        dg_k = theta*y_k + (1-theta)*W*dx;

        % Compute new Hessian using BFGS update formula
        W = W + (dg_k*dg_k')/(dg_k'*dx) - ((W*dx)*(W*dx)')/(dx'*W*dx);
        
        % Update termination criterion:
        gnorm = norm(grad_L(x, mu_new)); % norm of Largangian gradient
        disp(gnorm)
        mu_old = mu_new;  % Update mu_old by setting it to mu_new

        % save current solution to solution.x
        solution.x = [solution.x, x]; 
    end