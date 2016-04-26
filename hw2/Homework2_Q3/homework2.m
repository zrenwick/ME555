%%%%%%%%%%%%%% Main Entrance %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% By Max Yi Ren and Emrah Bayrak %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Instruction: Please read through the code and fill in blanks 
% (marked by ***). Note that you need to do so for every involved
% function, i.e., m files. 

%% Optional overhead
clear; % Clear the workspace
close all; % Close all windows

%% Optimization settings
% Here we specify the objective function by giving the function handle to a
% variable, for example:
f = @(x)obj(x); % replace rosenbrock with your objective function
% In the same way, we also provide the gradient and the Hessian of the 
% objective:
g = @(x)gradObj(x); % replace accordingly
H = @(x)HessObj(x); % replace accordingly
% Note that explicit gradient and Hessian information is only optional.
% However, providing these information to the search algorithm will save
% computational cost from finite difference calculations for them.

% Specify algorithm
% opt.alg = 'gradient';
opt.alg = 'newton';

% Turn on or off line search. You could turn on line search once other
% parts of the program are debugged.
% opt.linesearch = false;
opt.linesearch = true;

% Set the tolerance to be used as a termination criterion:
opt.eps = 1e-6;

% Set the initial guess: Define it as a column vector
x0 = [2;3];

%% Run optimization
% Run your implementation of the gradient descent and Newton's method. See
% gradient.m and newton.m.
if strcmp(opt.alg,'gradient')
    solution = gradientAlg(f,g,H,x0,opt);
elseif strcmp(opt.alg,'newton')
    solution = newtonAlg(f,g,H,x0,opt);
end

%% Report
% Implement report.m to generate a report.
report(solution,f);
disp('Optimal design variables:')
disp(['x1: ', num2str(solution.x(1,end))])
disp(['x2: ', num2str(solution.x(2,end))])
disp('Optimal function value:')
disp(['f(x): ', num2str(f(solution.x(:,end)))])