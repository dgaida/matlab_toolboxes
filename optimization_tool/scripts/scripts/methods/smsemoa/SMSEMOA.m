function [paretoFront, ...   % objectives
    paretoSet, ... % parameters
    out] = SMSEMOA(... % struct with information
    problem, ...             % problem-string
    inopts, ...              % struct with options (optional)
    initPop)                 % initial population (optional)
% smsemoa.m, Version 1.0, last change: August, 14, 2008
% SMS-EMOA implements the S-Metric-Section-based Evolutionary
% Multi-Objective Algorithm for nonlinear vector minimization.
%
% OPTS = SMSEMOA returns default options.
% OPTS = SMSEMOA('defaults') returns default options quietly.
% OPTS = SMSEMOA('displayoptions') displays options.
% OPTS = SMSEMOA('defaults', OPTS) supplements options OPTS with default
% options.
%
% function call:
% [PARETOFRONT, PARETOSET] = SMSEMOA(PROBLEM[, OPTS])
%
% Input arguments:
%  PROBLEM is a string function name like 'Sympart'. PROBLEM.m
%  takes as argument a row vector of parameters and returns [objectives,
%     parameters] (both row vectors). The feedback of parameters can be
%     used to repair illegal values.
%     Additionally a corresponding initializePROBLEM.m is needed. It must
%     return [nVar rngMin rngMax isInt nObj algoCall], where
%     *  nVar is the dimension of the parameters
%     *  rngMin is the minimum of the parameter values (row vector)
%     *  rngMax is the maximum of the parameter values (row vector)
%     *  isInt is a row vector of 0/1, indicating if parameter values are
%        Integer
%     *  nObj is the dimension of the objectives
%     *  algoCall is a string to call the evaluation-function to get the
%        objective values, usually PROBLEM
%  OPTS (an optional argument) is a struct holding additional input
%     options. Valid field names and a short documentation can be
%     discovered by looking at the default options (type 'smsemoa'
%     without arguments, see above). Empty or missing fields in OPTS
%     invoke the default value, i.e. OPTS needs not to have all valid
%     field names.  Capitalization does not matter and unambiguous
%     abbreviations can be used for the field names. If a string is
%     given where a numerical value is needed, the string is evaluated
%     by eval, where
%     'nVar' expands to the problem dimension
%     'nObj' expands to the objectives dimension
%     'nPop' expands to the population size
%     'countEval' expands to the number of the recent evaluation
%     'nPV' expands to the number paretofronts
%
% Output:
%  PARETOFRONT is a struct holding the objectives in rows. Each row holds
%     the results of the objective function of one solution
%  PARETOSET is a struct holding the parameters. Each row holds one
%     solution.
%
%
% This software is Copyright (C) 2008
% Tobias Wagner, Fabian Kretzschmar
% ISF, TU Dortmund
% July 4, 2008
%
% This program is free software (software libre); you can redistribute it
% and/or modify it under the terms of the GNU General Public License as
% published by the Free Software Foundation; either version 2 of the
% License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
% Public License for more details.
%
% implementation based on [1][2] using
% *  Computation of the Hypervolume Indicator based on [3]
%    http://sbe.napier.ac.uk/~manuel/hypervolume
% *  Pareto Front Algorithms
%    http://www.mathworks.com/matlabcentral/fileexchange/loadFile.do?object
%    Id=17251&objectType=file
% *  coding-fragments from NSGA - II
%    http://www.mathworks.com/matlabcentral/fileexchange/loadFile.do?object
%    Id=10429&objectType=file
%
% [1] Michael Emmerich, Nicola Beume, and Boris Naujoks. An EMO algorithm
% using the hypervolume measure as selection criterion. In C. A. Coello
% Coello et al., Eds., Proc. Evolutionary Multi-Criterion Optimization,
% 3rd Int'l Conf. (EMO 2005), LNCS 3410, pp. 62-76. Springer, Berlin, 2005.
%
% [2] Boris Naujoks, Nicola Beume, and Michael Emmerich. Multi-objective
% optimisation using S-metric selection: Application to three-dimensional
% solution spaces. In B. McKay et al., Eds., Proc. of the 2005 Congress on
% Evolutionary Computation (CEC 2005), Edinburgh, Band 2, pp. 1282-1289.
% IEEE Press, Piscataway NJ, 2005.
%
% [3] Carlos M. Fonseca, Luís Paquete, and Manuel López-Ibáñez. An improved
% dimension-sweep algorithm for the hypervolume indicator.  In IEEE
% Congress on Evolutionary Computation, pages 3973-3979, Vancouver, Canada,
% July 2006.

% ----------- Set Defaults for Options ---------------------------------
% options: general - these are evaluated once
defopts.nPop              = '100           % size of the population';
defopts.maxEval           = 'inf           % maximum number of evaluations';
defopts.useOCD            = 'true          % use OCD to detect convergence';
defopts.OCD_VarLimit      = '1e-9          % variance limit of OCD';
defopts.OCD_nPreGen       = '10            % number of preceding generations used in OCD';
defopts.nPFevalHV         = 'inf           % evaluate 1st to this number paretoFronts with HV';
defopts.outputGen         = 'inf           % rate of writing output files';

% options: generation of offsprings - these are evaluated each run
defopts.var_crossover_prob= '0.9           % [0.8, 1] % variable crossover probability';
defopts.var_crossover_dist= '15            % distribution index for crossover';
defopts.var_mutation_prob = '1./nVar       % variable mutation probability';
defopts.var_mutation_dist = '20            % distribution index for mutation';
defopts.var_swap_prob     = '0.5           % variable swap probability';
defopts.DE_F              = '0.2+rand(1).*0.6% difference weight for DE';
defopts.DE_CR             = '0.9           % crossover probability for differential evo';
defopts.DE_CombinedCR     = 'true          % crossover of blocks instead of single variables';
defopts.useDE             = 'true          % perform differential evo instead of SBX&PM';
defopts.refPoint          = '0             % refPoint for HV; if 0, max(obj)+1 is used';

% ---------------------- Handling Input Parameters ----------------------

if nargin < 1 || isequal(problem, 'defaults') % pass default options
    if nargin < 1
        disp('Default options returned (type "help smsemoa" for help).');
    end
    paretoFront = defopts;
    if nargin > 1 % supplement second argument with default options
        paretoFront = getoptions(inopts, defopts);
    end
    return;
end

if isequal(problem, 'displayoptions')
    names = fieldnames(defopts);
    for name = names'
        disp([name{:} repmat(' ', 1, 20-length(name{:})) ': ''' defopts.(name{:}) '''']);
    end
    return;
end

if isempty(problem)
    error('Objective function not determined');
end

%% edited D. Gaida, 04.08.2011
%% -----------
% if ~ischar(problem)
%     error('first argument ''problem'' must be a string');
% end
%% -----------


% Compose options opts
if nargin < 2 || isempty(inopts) % no input options available
    opts = defopts;
else
    opts = getoptions(inopts, defopts);
end

if nargin < 3
    initPop = '';
end;

% ------------------------ Initialization -------------------------------
%% TODO Daniel Gaida, commented out clc
% clc;
disp('0 percent calculated');

% Reset the random number generator to a different state each restart
rand('state',sum(100*clock));

% load parameters from problem


%% edited D. Gaida, 04.08.2011
%% -----------
initProblemStr = problem;%sprintf('initialize%s', problem);
%% -----------

[nVar rngMin rngMax isInt nObj problemCall] = feval(initProblemStr);

% get parameters for initialization
nPop = myeval(opts.nPop);
nPV = ceil((1/(2^(nObj-1)))*nPop); % guess number of Pareto-Ranks
maxEval = myeval(opts.maxEval);
useOCD = myeval(opts.useOCD);
OCD_VarLimit = myeval(opts.OCD_VarLimit);
OCD_nPreGen = myeval(opts.OCD_nPreGen);
nPFevalHV = myeval(opts.nPFevalHV);
outputGen = myeval(opts.outputGen);

% calculate initial sampling
ranks = inf(nPop+1,1);
population = initialize_variables(nPop, nObj, nVar, rngMin, ...
    rngMax, problemCall, initPop);
% set evaluation counter
countEval = nPop;
% initialize new Element position
elementInd = nPop+1;
if mod(countEval, outputGen)==0
    writeToFile(population, nPop, elementInd, nVar, nObj, ranks,...
        countEval)
end;
if useOCD
    PF{1} = population(paretofront(population(:,nVar+1:nVar+nObj)),...
        nVar+1:nVar+nObj);
end;
terminationCriterion = false;
while ~terminationCriterion && (countEval < maxEval)
    if ~useOCD && mod(countEval,floor(0.05.*maxEval)) == 0
        %% TODO Daniel Gaida, commented out clc
        % clc;
        disp(sprintf('%d percent calculated', floor((countEval./(maxEval-1))*100)));
        disp(sprintf('%d fronts', nPV));
    end;
    % evaluate parameters
    variable_crossover_prob = myeval(opts.var_crossover_prob);
    variable_crossover_dist = myeval(opts.var_crossover_dist);
    variable_mutation_prob = myeval(opts.var_mutation_prob);
    variable_mutation_dist =myeval(opts.var_mutation_dist);
    variable_swap_prob = myeval(opts.var_swap_prob);
    DE_F = myeval(opts.DE_F);
    DE_CR = myeval(opts.DE_CR);
    DE_CombinedCR = myeval(opts.DE_CombinedCR);
    useDE = myeval(opts.useDE);
    refPoint = myeval(opts.refPoint);
    
    % generate and add offspring
    % if useDE offsprings are generated by differential evolution
    % else SBX and Mutation is used
    population(elementInd,:) = generate_offspring(population, ...
        nObj, nVar, rngMin, rngMax, problemCall, ranks, ...
        variable_crossover_prob, variable_crossover_dist, ...
        variable_mutation_prob, variable_mutation_dist, variable_swap_prob, ...
        useDE, DE_CombinedCR, DE_F, DE_CR);
    countEval = countEval+1;
    ranks = paretoRank(population(:,nVar+1:nVar+nObj));
    nPV = max(ranks);
    elementInd = select_element_to_remove(population, nPop, nObj, ...
        nVar, nPV, ranks, nPFevalHV, refPoint);
    if useOCD && mod(countEval, nPop)==0
        iteration = int16(round(countEval./nPop));
        if iteration > OCD_nPreGen+1
            for i = 2:OCD_nPreGen+1
                PF{i-1} = PF{i};
            end;
            PF{OCD_nPreGen+1} = population(ranks==1,nVar+1:nVar+nObj);
            [OCD_termCrit OCD_lb OCD_ub OCD_pChi2 OCD_pReg] = OCD(PF, ...
                OCD_VarLimit, 0.05, [1 1 1], ...
                OCD_lb, OCD_ub, OCD_pChi2, OCD_pReg);
            %% TODO Daniel Gaida, commented out clc
            %clc;
            disp(sprintf('%d evaluations calculated', countEval));
            disp(sprintf('maximum p-value variance test: %f', max(OCD_pChi2)));
            disp(sprintf('p-value regression analysis: %f', OCD_pReg));
        else
            PF{iteration} = population(ranks==1,nVar+1:nVar+nObj);
            if iteration == OCD_nPreGen+1
                [OCD_termCrit OCD_lb OCD_ub OCD_pChi2 OCD_pReg] = OCD(PF,...
                    OCD_VarLimit);
                %% TODO Daniel Gaida, commented out clc
                %clc;
                disp(sprintf('%d evaluations calculated', countEval));
                disp(sprintf('maximum p-value variance test: %f', max(OCD_pChi2)));
                disp(sprintf('p-value regression analysis: %f', OCD_pReg));
            end;
        end;
        if exist('OCD_termCrit', 'var') && any(OCD_termCrit)
            terminationCriterion = any(OCD_termCrit);
            if OCD_termCrit(1)
                disp('OCD detected convergence due to the variance test');
            else
                disp('OCD detected convergence due to the regression analysis');
            end;
        end;
    end;
    if mod(countEval, outputGen)==0
        if exist('OCD_pReg', 'var')
            writeToFile(population, nPop, elementInd, nVar, nObj, ranks,...
                countEval, OCD_pReg, OCD_pChi2)
        else
            writeToFile(population, nPop, elementInd, nVar, nObj, ranks,...
                countEval)
        end;
    end;
end;
if ~terminationCriterion
    %% TODO Daniel Gaida, commented out clc
    %clc;
    disp('maxEval evaluations have been reached');
end
if (outputGen < inf) &&  mod(countEval, outputGen)~=0
    if exist('OCD_pReg', 'var')
        writeToFile(population, nPop, elementInd, nVar, nObj, ranks,...
            countEval, OCD_pReg, OCD_pChi2)
    else
        writeToFile(population, nPop, elementInd, nVar, nObj, ranks,...
            countEval)
    end;
end;
population(elementInd,:) = [];
paretoFront = population(:,nVar+1:nVar+nObj);
paretoSet = population(:,1:nVar);
if nargout == 3
    if ~terminationCriterion
        out.termCrit = 'evaluation limit';
    elseif OCD_termCrit(1)
        out.termCrit = 'variance test';
    else
        out.termCrit = 'regression analysis';
    end;
    out.nEval = countEval;
end;
end


%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------
function res=myeval(s)
if ischar(s)
    res = evalin('caller', s);
else
    res = s;
end
end



function writeToFile(population, nPop, elementInd, nVar, nObj, ranks,...
    countEval, OCD_pReg, OCD_pChi2)
active = setdiff(1:nPop+1,elementInd);
PS = population(active,1:nVar);
PF = population(active,nVar+1:nVar+nObj);
% this is the complete approximation of the paretoset, but not all points
% are pareto optimal, size equals population size
dlmwrite(sprintf('par_%03d.txt',countEval), PS, ' ');
% this is the corresponding pareto front, not all elements are pareto
% optimal 
dlmwrite(sprintf('obj_%03d.txt',countEval), PF, ' ');
% this is the part of the pareto set which contains pareto optimal points.
% they have rank one
dlmwrite(sprintf('ps_%03d.txt',countEval), PS(ranks(active)==1,:), ' ');
% this is the corresponding pareto front
dlmwrite(sprintf('pf_%03d.txt',countEval), PF(ranks(active)==1,:), ' ');
if nargin > 7
    dlmwrite(sprintf('pvalues_%03d.txt',countEval), ...
        [OCD_pReg OCD_pChi2], ' ');
end;
end