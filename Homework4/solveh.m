function s = solveh(x, h, delh, s_id)

eps = 1e-8;  % Set a tolerance for convergence 
s = x(s_id);    % Save the current state variables

iter = 0;       % Set initial iteration to 0
% Set termination criterion
hnorm = norm(h(x));% norm of the constraint vector

    while(hnorm > eps)
        iter = iter+1; % Increment iteration by 1
        delhdelx = delh(x); % dh/dx at the current point x
        delhdels = delhdelx(:,s_id); % extract dh/ds from delhdelx using s_id
        
        % Modify dh/ds when it is singular
        %%%%%%%%%%%%%%%%%%%%%%%%%% KEEP THIS %%%%%%%%%
        if det(delhdels)<1e-9
            delhdels = correctH(delhdels);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        s = s - inv(delhdels)*h(x);          % Use dh/ds and h(x) to calculate new s (Lecture 14, Slide 11)
        x(s_id) = s;        % Save new s to the current solution
        
        % Update termination critetion
        hnorm = norm(h(x)); % norm of the constraint vector
    end
end