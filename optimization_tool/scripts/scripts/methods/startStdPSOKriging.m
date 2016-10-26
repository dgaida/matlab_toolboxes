%% startStdPSOKriging
% Prepare and start method for optimal biogas
% plant control. 
%
function [u, varargout]= startStdPSOKriging(ObjectiveFunction, lenIndividual, varargin)
%% Release: 0.9

%%

error( nargchk(2, 16, nargin, 'struct') );
error( nargoutchk(0, 6, nargout, 'struct') );

%%
% check parameters

checkArgument(ObjectiveFunction, 'ObjectiveFunction', 'function_handle', '1st');

%% 
% read out varargin

if nargin >= 3, LB= varargin{1}; else LB= []; end
if nargin >= 4, UB= varargin{2}; else UB= []; end

if nargin >= 5, popSize= varargin{3}; else popSize= []; end
if nargin >= 6, noGenerations= varargin{4}; else noGenerations= []; end
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

if existMPfile('Call_psoAlgorithm_surrogate_TOY_Updates_until_Error_reached')
    
  vBoundaries= [LB(:)'; UB(:)'; (1:lenIndividual)];
  
  [RESULT_surrogate, RESULT_simModel, final_surrModel, RMSE, NoUpdates] =  ...
      Call_psoAlgorithm_surrogate_TOY_Updates_until_Error_reached( ...
      ObjectiveFunction, noGenerations, lenIndividual, 10, vBoundaries, ...
      10, tolerance, zeros(lenIndividual,1)');

  %%
  
  fitness= RESULT_simModel;
  
  u= RESULT_surrogate(1:lenIndividual,1);
  
  %%
    
else
  error('Call_psoAlgorithm_surrogate_TOY_Updates_until_Error_reached not existent!');
end


%%

if nargout >= 2
  varargout{1}= fitness;
end

if nargout >= 3
  varargout{2}= [];
end

%%


