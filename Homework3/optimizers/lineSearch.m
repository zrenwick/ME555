% Armijo line search
function a = lineSearch(f,g,x,opt)
    t = 0.3; % scale factor on current gradient: [0.01, 0.3]
    b = 0.8; % scale factor on backtracking: [0.1, 0.8]
    a = 1; % maximum step length
    G = g(x);
    D = -G;
    
    % terminate if line search takes too long
    count = 0;
    while count<100
        % stop if condition satisfied
        % write stop as a boolian expression
        stop = f(x+a*D) < (f(x)+t*a*(G'*D));
        if stop;
            break;
        else
            % backtracking
            a = b*a;
            % increase crounter by 1
            count = count+1;
        end
    end