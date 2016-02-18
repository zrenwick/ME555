%--------------------------------------------------------------------------
%           ME 555 - Winter 2016 - HW 3
%
%           Reference: Papalambros, P.Y. and Wilde, D.J., 2000. Principles
%                      of Optimal Design: Modeling and Computation.
%                      Cambridge University Press.
%           Reference: http://www.mathworks.com/matlabcentral/answers/78808
%                      -get-multiple-solutions-from-genetic-algorithm-ga
%
%           Authors: Alex Burnap, Emrah Bayrak, Max Yi Ren
%           Date of Last Update: February 10, 2016
%           License: MIT (see bottom of file)
%            
%           Instructions: This is an auxillary file to generate output from
%           in a custom manner from the GA.
%
%           Note: You do not need to change this file
%--------------------------------------------------------------------------

function [state, options, optchanged] = GAGenSave(options, state, flag)

    FileName = ['ga_solution', '.mat'];

    if (exist(FileName)) == 2
        try
            load(FileName);
        end
        if state.Generation == 0
            iter = ga_solution.Generation;
        else
            iter = ga_solution.Generation + 1;
        end
    else
        disp('could not find file');
        iter = 1;
    end

    ga_solution.x(iter, :) = state.Population(1, :);
    ga_solution.Generation = iter;
    ga_solution.FunEval(iter, :) = state.FunEval;
    ga_solution.Population(:, :, iter) = state.Population;
    ga_solution.Score(:, iter) = state.Score;

    try
        save(FileName, 'ga_solution');
    end
    optchanged = false;

    switch flag
    case 'init'
            %disp('Starting the algorithm');
        case {'iter','interrupt'}
            %disp('Iterating ...')
        case 'done'
            disp('Performing final task');
            save(FileName, 'ga_solution');

end    % GAGenSave()