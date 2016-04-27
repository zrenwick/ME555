% Armijo line search
function [a, w] = lineSearch(f, df, g, dg, x, s, mu_old, w_old)
    t = 0.3; % scale factor on current gradient: [0.01, 0.3]
    b = 0.8; % scale factor on backtracking: [0.1, 0.8]
    a = 1; % maximum step length
    
    D = s;                  % direction for x
    
    % Calculate weights in the merit function using eqaution (6.77) in POD3
    w = max(mu_old, 0.5.*(w_old + mu_old));

    % terminate if line search takes too long
    count = 0;
    while count<100
        % Calculate phi(alpha) using merit function in (6.76) in POD3
        phi_a = f(x + a.*s) + w'*abs(max(0,g(x + a.*s)));
        
        % Caluclate psi(alpha) in the line search using phi(alpha)
        phi0 = f(x) + w'*abs(max(0,g(x)));                   % phi(0)
        dphi0 = df(x)*s + w'*dg(x)*s;                  % phi'(0)
        psi_a = phi0 + t*a*dphi0;                  % psi(alpha) = phi(0)+t*alpha*phi'(0)
                
        % stop if condition satisfied
        stop = phi_a <= psi_a;
        
        if stop;
            break;
        else
            % backtracking
            a = a*b;
            count = count + 1;
        end
    end
    
end