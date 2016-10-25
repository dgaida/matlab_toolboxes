%% startSVM
% Start Support Vector Machines to perform classification or regression
%
function [perf_temp, perf_1st_temp, varargout]= ...
           startSVM(traindata, testdata, regress, varargin)
%% Release: 1.0

%%

error( nargchk(3, 4, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%% TODO
% I do not think that this parameter is needed

if nargin >= 4 && ~isempty(varargin{1})
  write_files= varargin{1};
  is0or1(write_files, 'write_files', 4);
else
  write_files= 0;
end

%%
% check arguments

checkArgument(traindata, 'traindata', 'double', '1st');
checkArgument(testdata, 'testdata', 'double', '2nd');
is0or1(regress, 'regress', 3);

%%

if ~regress
  
  %%
  % data must be normalized
  
  data= [traindata(:,2:end); testdata(:,2:end)];
  
  data_norm= zscore(data);
  
  traindata= [traindata(:,1) data_norm(1:size(traindata,1),:)];
  testdata=  [testdata(:,1) data_norm(size(traindata,1)+1:end,:)];
  
  %%
  
  if (write_files)

    %%
    
    sp_train= sparse(traindata(:,2:end));
    sp_test=  sparse(testdata(:,2:end));

    v_label= traindata(:,1);

    %%

    % only needed, if we want to run svm outside of matlab

    libsvmwrite('data_train.txt', v_label, sp_train);
    libsvmwrite('data_test.txt', testdata(:,1), sp_test);

  end

  %% TODO
  % optimize parameters for dataset
  
  mygamma= 0.01;
  myC= 500;
  
  svm_params= ['-s 0 -t 2 -g ', num2str(mygamma), ' -c ', num2str(myC)];
  
  %%
  
  train_target= traindata(:,1);
  train_data= traindata(:,2:end);
  
  test_target= testdata(:,1);
  test_data= testdata(:,2:end);
    
  %%
  
  svm_model= svmtrain(train_target, train_data, svm_params);

  %%
  
  [predict_label]= svmpredict(test_target, test_data, svm_model);

  %%
  
  perf_temp= 100 * sum(predict_label == test_target) / numel(test_target);
  
  %%
  
  [confMatrix, confPMatrix]= calcConfusionMatrix(test_target, predict_label);

  [dummy2, dummy, perf_1st_temp]= classifierPerformance(confPMatrix);
  
  %%
  
  if nargout >= 3
    varargout{1}= confMatrix;
  else
    varargout{1}= [];
  end
  
  if nargout >= 4
    varargout{2}= predict_label;
  else
    varargout{2}= [];
  end

  %%
  
else

  error('Not yet implemented!');

end

%%


