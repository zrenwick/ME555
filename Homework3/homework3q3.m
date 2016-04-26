%--------------------------------------------------------------------------
%           ME 555 - Winter 2016 - HW 3
%
%           Reference: Papalambros, P.Y. and Wilde, D.J., 2000. Principles
%                      of Optimal Design: Modeling and Computation.
%                      Cambridge University Press.
%
%           Authors: Alex Burnap, Emrah Bayrak, Namwoo Kang
%           Date of Last Update: February 10, 2016
%           License: MIT (see bottom of file)
%            
%           Instructions: In this file, we will be comparing the gradient
%           optimization algorithm you have implemented versus the genetric
%           algorithm nongradient search method.
%           
%           We will be using two test functions: 6 hump Camelback and the
%           Eggholder Function; your homework will have visualization of
%           the 2D functions.
%
%           Note: You will only need to modify the code at lines that say:
%                 *** CHANGE CODE HERE ***
%--------------------------------------------------------------------------
%% Overhead
clear; % Clear the workspace
close all; % Close all windows
addpath('./obj_functions_and_gradients');
addpath('./optimizers');
addpath('./utilities');
delete('./*.mat')

%% Optimization settings
% Here we specify the objective function by giving the function handle to a
% variable, for example:

% We will try two objective functions, the first is the 6 hump camelback
% For the camelback, there are two optima with function value: -1.0316
% Located at x = [-0.0898 0.7126] and [0.0898 -0.7126]

% %% CAMELBACK FUNCTION -- ONLY COMMENT OUT ONE FUNCTION AT A TIME
% f = @(x)camelbackObj(x);
% g = @(x)camelbackg(x);
% 
% % Here we will set the bounds of the design space FOR THE CAMELBACK
% x1_min = -3.0;
% x1_max = 3.0;
% x2_min = -3.0;
% x2_max = 3.0;

%% EGGHOLDER FUNCTION -- ONLY COMMENT OUT ONE FUNCTION AT A TIME
% The eggholder has a single optima with function value: -959.6407
% Located at x = [512 404.2319]
f = @(x)eggholderObj(x);
g = @(x)eggholderg(x);

% Here we will set the bounds of the design space FOR THE EGGHOLDER
x1_min = -512.0;
x1_max = 512.0;
x2_min = -512.0;
x2_max = 512.0;

%% Multistart Gradient Method
% "Multistart" refers to trying a number of different initial guess and
% saving the best runs -- i.e., just changing the initial starting point

% We will just be using gradient methods
opt.alg = 'gradient'; 

% We will be using line search
opt.linesearch = true; 

% Set the tolerance to be used as a termination criterion
opt.eps = 1e-6;

% We did not have this in the last homework, but we will set a maximum
% number of iterations
opt.max_iterations = 100;

% *** START CHANGE CODE HERE ***
% Set a number of initial guesses.
% e.g., x0 = [1;1] for the Camelback or [300;100] for the Eggholder

%Camel Best
%x0 = [0;0.25];
%Eggholder best  
x0 = [512.1 ;404.2319];
% *** END CHANGE CODE HERE ***

% Run optimization
tic;
display('Starting Gradient Method...');
gradient_method_solution = gradientAlg(f,g,x0,opt);
display('Gradient Method Convergence Time:');
toc;

%% Report Performance of Gradient Method
% Implement report.m to generate a report.
report(gradient_method_solution, f, opt.alg, x1_min, x1_max, x2_min, x2_max);
disp('Number of Function Evaluations:');
disp(num2str(length(gradient_method_solution.x)));
disp('Optimal design variables:')
disp(['x1: ', num2str(gradient_method_solution.x(1,end))])
disp(['x2: ', num2str(gradient_method_solution.x(2,end))])
disp('Optimal function value:')
disp(['f(x): ', num2str(f(gradient_method_solution.x(:,end)))])

% %%  Genetic Algorithm
% % We will be using the version of the Genetic Algorithm built into MATLAB
% % Still, we need to set a number of parameters using 'gaoptimset'
% 
% % We will just be using the genetic algorithm
% opt.alg = 'ga'; 
% 
% % We need the number of design variables
% num_variables = 2;
% 
% % Set the lower bound and upper bound for the GA serach
% lb=[x1_min x2_min]; % lower bounds of x1 and x2
% ub=[x1_max x2_max]; % upper bounds of x1 and x2
% 
% 
% % *** START CHANGE CODE HERE ***
% % % Best parameters for camelback
% % %set population size
% % %num_population = 20; %set population size
% % 
% % %set number of generations
% % %num_generations = 150;
% 
% % Best parameters for eggholder
% % %set population size
% % num_population = 1100; %set population size
% % 
% % %set number of generations
% % num_generations = 500;
% 
% % *** END CHANGE CODE HERE ***
% 
% % Set the tolerance to be used as a termination criterion (if we do not run
% % out of generations first
% opt.eps = 1e-6;
% 
% % Set the initial guess (Optional) - set the vectors of population size. 
% % If you use 100 population and 2 design variables, 
% % the initial guess will be 100 x 2 matrix
% random_scaling = abs(x1_max-x1_min)*1;
% initial_guess = rand(num_population, 2)*random_scaling; % Please use a GOOD and FEASIBLE initial guess
% 
% % @gaplotbestfun will show you a convergence plot. Based on this, 
% % tune population size and number of generations 
% options = gaoptimset('InitialPopulation',initial_guess,'PopulationSize', ...
% num_population,'Generations',num_generations,'PlotFcns',@gaplotbestfun, ...
% 'TolFun', opt.eps, 'OutputFcns',@GAGenSave);
% 
% tic;
% display('Starting Genetic Algorithm...');
% [ga_x,ga_fval,exitflag,output] = ga(f,num_variables,[],[],[],[],lb,ub,[],[],options);
% ga_convergence_time = toc;
% 
% %% Report Performance of Genetic Algorithm
% load('ga_solution.mat');
% report(ga_solution, f, opt.alg, x1_min, x1_max, x2_min, x2_max);
% display('Genetic Algorithm Convergence Time:');
% disp(num2str(ga_convergence_time));
% disp('Number of Generations Completed:');
% disp(num2str(num_generations));
% disp('Number of Function Evaluations:');
% disp(num2str(output.funccount));
% disp('Optimal design variables:')
% disp(['x1: ', num2str(ga_x(1))])
% disp(['x2: ', num2str(ga_x(2))])
% disp('Optimal function value:')
% disp(['f(x): ', num2str(ga_fval(:,end))])

%%
% LICENSE
% Permission is hereby granted, free of charge, to any person obtaining a
% copy of this software and associated documentation files (the
% �Software�), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to permit
% persons to whom the Software is furnished to do so, subject to the
% following conditions:
% 
% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED �AS IS�, WITHOUT WARRANTY OF ANY KIND, EXPRESS
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
% NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
% DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
% OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
% USE OR OTHER DEALINGS IN THE SOFTWARE.
