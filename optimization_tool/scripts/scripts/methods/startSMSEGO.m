%% startSMSEGO
% Prepare and start SMS-EGO S-Metric Selection based Efficient Global Optimization for
% multi-objective optimization problems to minimize the given fitness function. 
%
function [paretoset, varargout]= startSMSEGO(fitnessfcn, LB, UB, varargin)
%% Release: 1.4

%%

error( nargchk(3, 4, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%%
% check parameters

checkArgument(fitnessfcn, 'fitnessfcn', 'function_handle', '1st');

%%

LB= LB(:)';
UB= UB(:)';

if numel(LB) ~= numel(UB)
  error('LB and UB must be of the same size: %i ~= %i!', ...
        numel(LB), numel(UB));
end


%% 
% read out varargin

if nargin >= 4 && ~isempty(varargin{1})
  maxIter= varargin{1}; 
  
  isN(maxIter, 'maxIter', 4);
else
  maxIter= 25;    % max number of objective function evaluations
end


%% 
% open worker pool

[parallel]= setParallelConfiguration('open', 'none', 1);

                 
%% 
% start SMS-EGO

%%
% m-file or p-file
if existMPfile('SMSEGO')
    
  try
    [paretoset, paretofront, models, parameters, objectives, eval]= ...
      SMSEGO(fitnessfcn, LB, UB, [], maxIter);
  catch ME

    warning('SMSEGO:Error', 'SMS-EGO failed!');
    disp(ME.message);

    disp(get_stack_trace(ME));

    paretoset= [];
    paretofront= [];
    models= [];
    parameters= [];
    objectives= [];
    eval= [];
    
  end

else

  errordlg('The SMS-EGO algorithm is not installed!');
  error('The SMS-EGO algorithm is not installed!');

end


%%

if nargout >= 2
  varargout{1}= paretofront;
end
if nargout >= 3
  varargout{2}= models;
end
if nargout >= 4
  varargout{3}= {parameters, objectives, eval};
end

%%
% close worker pool

setParallelConfiguration('close', parallel);


%%


