% Armijo line search
function a = lineSearch(f,delf,delh,x,d_id, s_id)
    
    t = 0.1; % scale factor on current gradient: [0.01, 0.3]
    b = 0.5; % scale factor on backtracking: [0.1, 0.8]
    a = 0.1; % maximum step length
    
    
    delfdelx = delf(x);   % calculate df/dx at the current point from delf function
    delhdelx = delh(x);   % calculate dh/dx at the current point from delh function

    delfdeld = delfdelx(d_id);   % use delfdelx and d_id to extract df/dd
    delfdels = delfdelx(s_id);   % use delfdelx and s_id to extract df/ds
    delhdeld = delhdelx(:, d_id);   % use delhdelx and d_id to extract dh/dd
    delhdels = delhdelx(:, s_id);   % use delhdelx and s_id to extract dh/ds
    delzdeld = delfdeld - delfdels*inv(delhdels)*delhdeld; % reduced gradient using the variables above
    
    G = delfdelx';   % gradient vector of all variables 
    
    D = zeros(length(x),1);   % A zero direction vector for state and decision variables
    
    Dd = -delzdeld';                       % Direction for decision variables, i.e., deld (Lecture 14, Slide 10)
    Ds = inv(delhdels)*delhdeld*delzdeld'; % Direction for state variables, i.e., dels (Lecture 14, Slide 10)
    D([d_id, s_id]) = [Dd;Ds];   % Save the directions to direction vector      
    
    % terminate if line search takes too long
    count = 0;
    while count<10
        % stop if condition satisfied
        % write stop as a boolian expression
        stop = f(x+a*D) < (f(x)+t*a*(G'*D));
        if stop
            break;
        else
            % backtracking
            a = b*a;
            % increase crounter by 1
            count = count+1;
        end
    end