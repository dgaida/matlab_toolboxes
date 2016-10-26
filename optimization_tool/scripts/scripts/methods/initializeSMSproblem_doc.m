%% Syntax
%       [nVar rngMin rngMax isInt nObj algoCall]=
%       initializeSMSproblem(params) 
%
%% Description
% |[nVar rngMin rngMax isInt nObj algoCall]= initializeSMSproblem(params)|
% is needed by SMS-EMOA algorithm to initialize the optimization problem.
% The function is called by the <startsmsemoa.html startSMSEMOA> function
% and is just an internally used function. The function just returns the
% components inside |params|. 
%
%%
% @param |params| : 6 dimensional cell array with the arguments in the same
% order as they are returned by this function. 
%
%%
% @return |nVar| : number of variables
%
%%
% @return |rngMin| : vector of lower boundaries with dimension of |nVar|. 
%
%%
% @return |rngMax| : vector of upper boundaries with dimension of |nVar|. 
%
%%
% @return |isInt| : defines if variable is an integer or a double. Double
% vector of 0s and 1s with dimension of |nVar|. 
%
% * 0 : variable is a double
% * 1 : variable is an integer
%
%%
% @return |nObj| : number of objectives of the objective function
%
%%
% @return |algoCall| : <matlab:doc('matlab/function_handle')
% function_handle> to the objective function 
%
%% Example
% 
%

params= {2, [0 0], [5 10], zeros(1,2), 2, @fitnessfcn};

[nVar rngMin rngMax isInt nObj algoCall]= initializeSMSproblem(params);

disp('nVar: ')
disp(nVar)
disp('rngMin: ')
disp(rngMin)
disp('rngMax: ')
disp(rngMax)
disp('isInt: ')
disp(isInt)
disp('nObj: ')
disp(nObj)
disp('algoCall: ')
disp(algoCall)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="startsmsemoa.html">
% startSMSEMOA</a>
% </html>
%
%% See Also
%
%
%% TODOs
% # check documentation
%
%% <<AuthorTag_DG/>>


