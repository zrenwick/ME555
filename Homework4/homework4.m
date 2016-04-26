%%%%%%%%%%%%%% Main Entrance %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% By Max Yi Ren and Emrah Bayrak %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Instruction: Please read through the code and fill in blanks 
% (marked by ***). Note that you need to do so for every involved
% function, i.e., m files. 

%% Optional overhead
clc
clear; % Clear the workspace
close all; % Close all windows

%% Optimization settings
% Here we specify the objective function by giving the function handle to a
% variable, for example:
f = @(x)obj(x); % replace the expression in obj.m with your objective function
% In the same way, we also provide the gradient of the 
% objective:
delf = @(x)gradObj(x); % replace the expression in gradObj.m with gradient of your objective function

% Specify the equality constraints
h = @(x)cons(x); % replace the expression in cons.m with your equality constraints
% Provide the gradient of the constraints.
delh = @(x)gradCons(x); % replace the expression in gradCons.m with gradient of your equality constraints

% Note that explicit gradient information is only optional.
% However, providing these information to the search algorithm will save
% computational cost from finite difference calculations for them.


% Turn on or off line search. You could turn on line search once other
% parts of the program are debugged.

opt.linesearch = false; % false or true

% Set the tolerance to be used as a termination criterion:

opt.eps = 1e-3;

% Select state and decision variables and specify their indices
% E.g. if x1 and x2 are decision variables, d_id = [1,2]
% E.g. if x4 and x5 are your state variables, s_id = [4,5]

d_id = 1;
s_id = [2,3];

% Set the initial guess for decision variables: (column vector)

d0 = 0;
s0 = [0 ;0]; % set an arbitrary guess for s0 corresponding to your d0 (column vector)

%% Run optimization
% Run your implementation of GRG using the gradient descent method. See
% redGradient.m.

solution = redGradient(f, delf, h, delh, d0, s0, d_id,s_id, opt);

%% Report
% Make sure that your solutions are saved to solution.x in your gradient.m 
% file.
disp('Optimal design variables:')
disp(['x1: ', num2str(solution.x(1,end))])
disp(['x2: ', num2str(solution.x(2,end))])
disp(['x3: ', num2str(solution.x(3,end))])
disp('Optimal function value:')
disp(['f(x): ', num2str(f(solution.x(:,end)))])
report(solution,f);