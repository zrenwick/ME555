%%%%%%%%%%%%%% Generalized Reduced Gradient Implementation %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% By Max Yi Ren and Emrah Bayrak %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function solution = redGradient(f, delf, h, delh, d0, s0, d_id, s_id, opt)
    % Set initial conditions
    
    d = d0; % Set current solution to the initial guess d0
    s = s0; % Set current state variables to s0
    
    x = zeros(numel(s_id)+numel(d_id),1); % Create a zero column vector for x  
    
    x([d_id, s_id]) = [d;s]; % Set initial guess to current solution. (REMEMBER THIS LINE #####)
    
    s = solveh(x, h, delh, s_id); % Find the corresponding s to d0 starting from s0
    
    x([d_id, s_id]) = [d;s]; % Save corrected s and d to current solution. (Same as line #####)
   
    % Initialize a structure to record search process
    solution = struct('x',[]); 
    solution.x = [solution.x, x]; % save current solution to solution.x
    
    % Remember that in GRG reduced gradient is used to find stationary points.
    
    delfdelx = delf(x);   % calculate df/dx at the current point from delf function
    delhdelx = delh(x);   % calculate dh/dx at the current point from delh function
    
    delfdeld = delfdelx(d_id);   % use delfdelx and d_id to extract df/dd
    delfdels = delfdelx(s_id);   % use delfdelx and s_id to extract df/ds
    delhdeld = delhdelx(:, d_id);   % use delhdelx and d_id to extract dh/dd
    delhdels = delhdelx(:, s_id);   % use delhdelx and s_id to extract dh/ds
    
    delzdeld = delfdeld - delfdels*inv(delhdels)*delhdeld; % calculate reduced gradient from the variables above (See Lecture 11, Slide 16)
    
    % Calcualte the termination criterion:
    gnorm = norm(delzdeld); % norm of reduced gradient

    while gnorm>opt.eps % if not terminated
        
        % opt.linesearch switches line search on or off. 
        % You can first set the variable "a" to different constant values and see how it
        % affects the convergence.
        if opt.linesearch
            a = lineSearch(f, delf, delh, x, d_id, s_id);
        else
            a = 0.01;
        end
        
        % Gradient descent:
        dstep = -a.*delzdeld';      % step for decision variables (make sure it is column vector) (Lecture 14, Slide 10)
        
        d = d + dstep;          % update d with dstep (Lecture 14, Slide 10)
        
        x([d_id,s_id]) = [d;s]; % Save new d to the current solution
        delhdelx = delh(x);   % Calculate dh/dx with the updated x
        delhdeld = delhdelx(:,d_id);   % use delhdelx and d_id to extract dh/dd
        delhdels = delhdelx(:, s_id);   % use delhdelx and s_id to extract dh/ds
        
        sstep = a.*inv(delhdels)*delhdeld*delzdeld';      % find approximate step for state variables (column vector) (Lecture 14, Slide 10)
        s_approx = s + sstep;   % calculate approximate values for s using the approximate step from previous line (Lecture 14 Slide 10)
        
        x([d_id,s_id]) = [d; s_approx]; % save the decision and approximate state variables to current solution
        
        % State variable correction
        s = solveh(x, h, delh, s_id); % Calculate the actual state variables using linear approximation of h
        
        x([d_id, s_id]) = [d;s];      % Save the corrected variables to current solution (Same as line #####)
        
        % Update reduced gradient
        delfdelx = delf(x);   % calculate df/dx at the current point from delf function
        delhdelx = delh(x);   % calculate dh/dx at the current point from delh function

        delfdeld = delfdelx(d_id);   % use delfdelx and d_id to extract df/dd
        delfdels = delfdelx(s_id);   % use delfdelx and s_id to extract df/ds
        delhdeld = delhdelx(:, d_id);   % use delhdelx and d_id to extract dh/dd
        delhdels = delhdelx(:, s_id);   % use delhdelx and s_id to extract dh/ds
    
        delzdeld = delfdeld - delfdels*inv(delhdels)*delhdeld; % reduced gradient using the variables above
        
        % Update termination criterion:
        gnorm = norm(delzdeld); % norm of reduced gradient

        % save current solution to solution.x
        solution.x = [solution.x, x]; 
    end