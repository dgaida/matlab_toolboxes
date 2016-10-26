%% callRFforStateEstimation
% Call Random Forests to perform State Estimation
%
function [perf_temp, perf_1st_temp, varargout]= ...
                callRFforStateEstimation(traindata, testdata, ...
                fermenter_id, ivariable, itest, index_file, y, my_bins, ...
                goal_variable, regress, varargin)
%% Release: 1.5

%%

error( nargchk(10, 12, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%

if nargin >= 11 && ~isempty(varargin{1})
  n_trees= varargin{1};         % number of trees
  isN(n_trees, 'n_trees', 11);
else
  n_trees= 15;
end

if nargin >= 12 && ~isempty(varargin{2})
  train_rf= varargin{2};         
  is0or1(train_rf, 'train_rf', 12);
else
  train_rf= 1;
end

%%
% check arguments

checkArgument(traindata, 'traindata', 'double', '1st');
checkArgument(testdata, 'testdata', 'double', '2nd');
checkArgument(fermenter_id, 'fermenter_id', 'char', '3rd', 'on');
isN(ivariable, 'ivariable', 4);
isN(itest, 'itest', 5);
checkArgument(index_file, 'index_file', 'cell', 6);
checkArgument(y, 'y', 'double', 7);
isN(my_bins, 'my_bins', 8);
checkArgument(goal_variable, 'goal_variable', 'char', 9);
is0or1(regress, 'regress', 10);

%%

if ~regress

  %%
  % classification using random forest

  if train_rf
    [rf_model, perf_temp, ~, perf_1st_temp, confMatrix, confPMatrix]= ...
              startRF(traindata, testdata, 0, n_trees);
                                                   
    if ~isempty(fermenter_id)   
      %% 
      if ~(exist('RF', 'dir') == 7)
        [status,message,messageid]= mkdir('RF');
        if (status == 0)
          error(messageid, message);
        end
      end
  
      save(sprintf('RF/rf_model_classify_%s_v%02i_%ih_%in_%if_%it.mat', ...
           fermenter_id, ivariable, ...
           index_file{1}, index_file{2}, index_file{3}, itest), 'rf_model');
    end                                          
  else
    %% TODO
    rf_model= load_file( ...
      sprintf(['../matlab_promo/result_perform_digesters_RF_%ih_%in_%if/', ...
               'rf_model_classify_%s_v%02i_%ih_%in_%if_%it.mat'], ...
               index_file{1}, index_file{2}, index_file{3}, fermenter_id, ...
               ivariable, index_file{1}, index_file{2}, index_file{3}, itest) );    
             
    [rf_model, perf_temp, ~, perf_1st_temp, confMatrix, confPMatrix]= ...
              startRF(rf_model, testdata, 0, n_trees);                                           
  end
  
  %%
  
  if nargout >= 3
    if ~isempty(confMatrix)
      % the function returns the max of the std. deviation, so this actually
      % is the max value, not the mean. the documentation of the function
      % itself is a little bit misleading
      mean_std_dev= getStdDevOfConfMatrix(confMatrix);
    else
      % passiert, wenn startRF oben einen Fehler wirft, dann ist confMatrix
      % []
      mean_std_dev= NaN;
    end

    %%

    step_d= (max(y) - min(y))/my_bins;

    % the standard deviation is measured in classes, here it gets a meaning
    % and a unit
    max_std= mean_std_dev * step_d;
    
    varargout{1}= max_std;
  else
    varargout{1}= [];
  end

  %%

  if (perf_1st_temp < 97)

    disp('perf_temp: ')
    disp(perf_temp)
    disp('perf_1st_temp: ')
    disp(perf_1st_temp)
    disp('confPMatrix: ')
    disp(confPMatrix) 
    disp('confMatrix: ')
    disp(confMatrix)
    disp('goal_variable: ')
    disp(goal_variable)

  else
    % temporär für paper
    disp('perf_1st_temp: ')
    disp(perf_1st_temp)

  end

else

  %%
  % Regression using random forest

  [rf_model, perf_temp]= startRF(traindata, testdata, 1, n_trees);     
  
  save(sprintf('rf_model_regress_%s_v%02i_%ih_%in_%if_%it.mat', ...
          fermenter_id, ivariable, ...
          index_file{1}, index_file{2}, index_file{3}, itest), 'rf_model');

  %%
  
  perf_1st_temp= [];
  varargout{1}= [];

  %%
  
end % end if ~regress

%%


