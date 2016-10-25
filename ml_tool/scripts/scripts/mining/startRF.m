%% startRF
% Start Random Forest for classification or regression
%
function [rf_model, varargout]= startRF(traindata_or_model, testdata, varargin)
%% Release: 1.6

%%

error( nargchk(2, 6, nargin, 'struct') );
error( nargoutchk(0, 7, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  regress= varargin{1};         % regression or classification
  is0or1(regress, 'regress', 3);
else
  regress= 0;
end

if nargin >= 4 && ~isempty(varargin{2})
  n_trees= varargin{2};         % number of trees
  isN(n_trees, 'n_trees', 4);
else
  n_trees= 15;
end

if nargin >= 5 && ~isempty(varargin{3})
  mtry= varargin{3};         % mtry
  isN(mtry, 'mtry', 5);
else
  mtry= 0;
end

if nargin >= 6 && ~isempty(varargin{4})
  extra_options= varargin{4};         % extra_options
  %% TODO
  % check argument
else
  extra_options= [];
end

%%
% check arguments

checkArgument(traindata_or_model, 'traindata_or_model', 'double || struct', '1st');
checkArgument(testdata, 'testdata', 'double', '2nd');

%%

train_rf= isa(traindata_or_model, 'double');

%%

if ~regress

  %%
  % classification using random forest

  if(train_rf)
    traindata= traindata_or_model;
    
    try
      rf_model= classRF_train(traindata(:,2:end), traindata(:,1), n_trees, mtry, extra_options);
    catch ME
      disp(ME.message);
      
      rf_model= [];
      varargout(1:5)= {NaN, NaN, NaN, [], []};
      
      return;
    end
  else
    rf_model= traindata_or_model;
  end
  
  %%
  % predict data
  Y_hat= classRF_predict(testdata(:,2:end), rf_model);

  % performance measure: 100 - total error
  perf= 100 * sum(Y_hat == testdata(:,1)) / size(testdata(:,1),1);

  % calc confusion matrix
  [confMatrix, confPMatrix]= calcConfusionMatrix(testdata(:,1), Y_hat);

  % calculate preformance of 1st order
  [perf_percent, dummy, perf_1st]= classifierPerformance(confPMatrix);

  %%
  
  if nargout >= 3,
    varargout{2}= perf_percent;
  end

  if nargout >= 4, 
    varargout{3}= perf_1st;
  end

  if nargout >= 5, 
    varargout{4}= confMatrix;
  end

  if nargout >= 6, 
    varargout{5}= confPMatrix;
  end

  if nargout >= 7, 
    varargout{6}= Y_hat;
  end
  
  %%
  
else
  
  %%
  
  error( nargoutchk(0, 5, nargout, 'struct') );
  
  %%
  
  if(train_rf)
    traindata= traindata_or_model;
    
    rf_model= regRF_train(traindata(:,2:end), traindata(:,1), n_trees, mtry, extra_options);
  else
    rf_model= traindata_or_model;
  end
  
  %%
  
  Y_hat= regRF_predict(testdata(:,2:end), rf_model);

  e= Y_hat - testdata(:,1);
  
  % mean squared error
  mse= 1 ./ numel(testdata(:,1)) .* e' * e;
           
  % calc root mean squared error
  perf= sqrt( mse );
  
  %%
  
  if nargout >= 3, 
    varargout{2}= mse;
  end
  
  if nargout >= 4, 
    varargout{3}= Y_hat;
  end
  
  if nargout >= 5, 
    varargout{4}= e;
  end
  
  %%
    
end

%%

if nargout >= 2,
  varargout{1}= perf;
end

%%


