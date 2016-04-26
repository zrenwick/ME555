function H = correctH(H)
    % Fix singular H matrix
    I = eye(size(H));
    lambda = 1e-3;
    H = H +lambda*I;
end