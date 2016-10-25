%% evaluate_kriging
% Create and evaluate Kriging model for approximation and return predicted
% values over a grid
%
function [X, Y, Z, Fitness, model, varargout]= ...
            evaluate_kriging(inputs, outputs, varargin)
%% Release: 1.5

%%

error( nargchk(2, 5, nargin, 'struct') );
error( nargoutchk(0, 6, nargout, 'struct') );

%%
% read out varargin

if nargin >= 3 && ~isempty(varargin{1})
  k= varargin{1};
else
  k= 5;
end

if nargin >= 4 && ~isempty(varargin{2})
  grid_size= varargin{2};
else
  grid_size= 20;
end

if nargin >= 5 && ~isempty(varargin{3})
  opt_method= varargin{3};
else
  opt_method= 'CMAES';
end


%%
% check function parameters

validateattributes(inputs,  {'double'}, {'2d', 'nonempty'}, mfilename, 'input data',  1);
validateattributes(outputs, {'double'}, {'2d', 'nonempty'}, mfilename, 'output data', 2);

if size(inputs, 1) ~= size(outputs, 1)
  error('inputs and outputs must have the same number of samples: %i ~= %i!', ...
        size(inputs, 1), size(outputs, 1));
end

if ~isa(k, 'numeric') || any(k < 1)
  error(['The 3rd parameter k must be a positive integer, ', ...
         'but is of type ', class(k), ' with min value ', ...
         num2str(min(k)), '!']);
end

if ~isa(grid_size, 'numeric') || any(grid_size < 1)
  error(['The 4th parameter grid_size must be a vector or ', ...
         'scalar containing positive integers, ', ...
         'but is of type ', class(grid_size), ' with min value ', ...
         num2str(min(grid_size)), '!']);
end

checkArgument(opt_method, 'opt_method', 'char', '5th');


%%
%

N_inputs= size(inputs, 2);
%N_outputs= size(outputs, 2);

%%
% delete duplicates
%
% alternative:
%
% [inputs, outputs]= dsmerge(inputs, outputs);
%

[inputs, outputs]= deleteDuplicates(inputs, outputs);


%%
% Attention!!! data is splitted randomly between training and validation
% data

validSet_index= randi(k, size(outputs, 1), 1);

% no k-fold cross validation
if (k == 1)
   
  % take 15 % of the data as validation data

  test_indices= randi(size(outputs, 1), round(size(outputs, 1)*0.15), 1);

  validSet_index(test_indices,:)= 0;
    
end

%%
% start kriging

if isempty(opt_method)
    
	[fit_kriging, theta_opt, model]= ...
     fitness_kriging(inputs, outputs, validSet_index, ...
                     'poly0', 'gaussian');

else

  [model, theta_opt, fit_kriging]= ...
          findOptimalKrigingModel(opt_method, inputs, outputs, ...
                                  validSet_index);
    
end


%%
% prepare to plot

if N_inputs <= 3

  %%
  %

  % test if scalar or vector
  if numel(grid_size) == 1
    grid_vec= grid_size .* ones(1, N_inputs);
  else
    grid_vec= grid_size;

    grid_vec= grid_vec(:)';

    if numel(grid_vec) ~= N_inputs
      error('grid_vec has not the correct dimension: %i ~= %i!', ...
            numel(grid_vec), N_inputs);
    end
  end

  %%

  lowerGrid= min(inputs, [], 1);
  upperGrid= max(inputs, [], 1);

  %%
  % make grid

  X_grid= gridsamp([lowerGrid; upperGrid], grid_vec);

  %%
  % predict over grid

  [Fitness_grid]= predictor(X_grid, model);

  %%
  % gilt nur für max 3 inputs

  if (size(X_grid, 2) >= 1)
    X= reshape(X_grid(:,1), grid_vec );
  else
    X= [];
  end

  if (size(X_grid, 2) >= 2)
    Y= reshape(X_grid(:,2), grid_vec );
  else
    Y= [];
  end

  if (size(X_grid, 2) >= 3)
    Z= reshape(X_grid(:,3), grid_vec );
  else
    Z= [];
  end

  %%
  % gilt nur für 1 output

  Fitness= reshape(Fitness_grid(:,1), grid_vec );

else

  X= [];
  Y= [];
  Z= [];
  Fitness= [];

end

%%
%

varargout= [];

if nargout >= 6
  varargout{1}= fit_kriging;
end

%%
%


