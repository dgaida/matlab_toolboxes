%% startStdPSOKriging
% Prepare and start method for optimal biogas
% plant control. 
%
function [u, varargout]= startPSOKriging(ObjectiveFunction, lenIndividual, varargin)
%% Release: 0.9

%%

error( nargchk(2, 8, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%
% check parameters

checkArgument(ObjectiveFunction, 'ObjectiveFunction', 'function_handle', '1st');

%% 
% read out varargin

if nargin >= 3, LB= varargin{1}; else LB= []; end
if nargin >= 4, UB= varargin{2}; else UB= []; end

if nargin >= 5, popSize= varargin{3}; else popSize= []; end
if nargin >= 6, noGenerations= varargin{4}; else noGenerations= []; end
%% TODO
% timelimit not used yet
if nargin >= 7, timelimit= varargin{5}; else timelimit= []; end

if nargin >= 8, 
  tolerance= varargin{6}; 
else
  tolerance= 0; 
end

%%

checkArgument(LB, 'LB', 'double', '3rd');
checkArgument(UB, 'UB', 'double', '4th');

if ~isempty(popSize)
  validateattributes(popSize, {'double'}, {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'popSize', 5);
end

if ~isempty(noGenerations)
  validateattributes(noGenerations, {'double'}, {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'noGenerations', 6);
end


%% 
% start PSO Kriging

if existMPfile('PSO_Kriging')
    
  vBoundaries= [LB(:)'; UB(:)'; (1:lenIndividual)];
  
  [RESULT_surrogate, RESULT_simModel, final_surrModel, finalPOP, RMSE, NoUpdates] =  ...
      PSO_Kriging( ...
      noGenerations, popSize, lenIndividual, vBoundaries, ...
      tolerance, ObjectiveFunction, zeros(lenIndividual,1)', 0);

  %%
  
  fitness= RESULT_simModel;
  
  u= RESULT_surrogate(1:lenIndividual,1);
  
  %%
    
else
  error('PSO_Kriging not existent!');
end


%%

if nargout >= 2
    varargout{1}= fitness;
end

if nargout >= 3
    varargout{2}= [];
end

%%


