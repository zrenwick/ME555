% Armijo line search
function a = lineSearch(f,g,H,x,opt)
    t = 0.05; % scale factor on current gradient: [0.01, 0.3]
    b = 0.85; % scale factor on backtracking: [0.1, 0.8]
    a = 0.25; % maximum step length
    G = g(x);
    
    if strcmp(opt.alg,'gradient')
        D = -G;  % Direction for gradinet method
    elseif strcmp(opt.alg,'newton')
        D = -inv(H(x))*G;  % Direction for Newton method
    end
    %D = D/norm(D); % to convert to unit vector;
    
    % terminate if line search takes too long
    count = 0;
    while count<100
        psi = t.*G'*D*a + f(x);
        phi = f(x + a*D);
        % stop if condition satisfied
        % write stop as a boolian expression
        stop = phi < psi;
        if stop;
            break;
        else
            % backtracking
            a = a*b;
            % increase counter by 1
            count = count+1;
        end
    end