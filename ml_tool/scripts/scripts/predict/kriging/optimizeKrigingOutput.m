%% optimizeKrigingOutput
% Find inputs which min- or maximize the output of a Kriging model
%
function [opt_inputs, varargout]= optimizeKrigingOutput(minmax, models, LB, UB, varargin)
%% Release: 0.4

%%

error( nargchk(4, 5, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

if nargin >= 5 && ~isempty(varargin{1})
  opt_method= varargin{1};
else
  % 
  opt_method= 'SMS-EMOA';
end

%%
% check arguments

validatestring(minmax, {'min', 'max'}, mfilename, 'minmax', 1);

if strcmp(minmax, 'max')
  error('minmax = max not implemented!');
end

%%
  
switch (opt_method)

  %%

  case 'SMS-EMOA'

    [paretoset, paretofront]= ...
                    startSMSEMOA(@(u)fit_fun(u, models), numel(models), ...
                                 [], LB, UB, 5, 200);        

  %%
  
  if nargout >= 2,
    varargout{1}= {paretofront};
  else
    varargout{1}= [];
  end
  
  %%

  case 'CMAES'          

    error('not yet implemented!');
    
    [u]= startCMAES(fit_fun, [], LB, UB, 5, 200, 'none', 1);                             

  %%

  otherwise
    error('Unknown opt_method: %s!', opt_method);

end

%%

opt_inputs= paretoset;

%%



%%

function out= fit_fun(u, models)

%%

out= zeros(size(u, 1), numel(models));

%%

for imodel= 1:numel(models)
  
  %%
  
  model= models{imodel};
  
  out(:, imodel)= predictor(u, model);
  
  %%

end

%%


