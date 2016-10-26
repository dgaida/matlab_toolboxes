%% get_cutting_points_test
% Get cutting_points_test out of file or given cutter
%
function cutting_points_test= get_cutting_points_test(cutter, varargin)
%% Release: 1.5

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  k= varargin{1};
  isN(k, 'k', 2);
else
  k= 5;
end

%%
% check argument

checkArgument(cutter, 'cutter', 'double', '1st');

%%
% 5-times repeated sub-sampling validation with 1/3 validation
% dataset and 2/3 trainingdataset
% fände ich besser als wie 5-fold cross validation, da bei 5-fold
% crossvalidation die 5 testdatensätze nur 1/5 betragen und
% trainingsdatensatz 4/5, dieser testdatensatz ist mir zu klein, da
% ich befürchte, dass es einige sehr ähnliche datensätze gibt, was
% bei dem extrem leave-one-out cross validation zu dem besten
% ergebnis führen müsste allerdings zu einer absoluten
% zu guten überschätzung des testfehlers bzw. der wirklichen güte

try
  cutting_points_test= load_file('cutting_points_test');
catch ME
  
  warning('cutting_points_test:notfound', 'Could not find cutting_points_test.mat!');
  
  disp(ME.message)
  
  n_sims= numel(cutter);

  a0= randperm(n_sims);

  %% 
  % 
  if k ~= 1
    test_part= fix(1/k * n_sims);
  else % if just one fold, then take 1/3 of data as test data, 2/3 as train data
    test_part= fix(1/3 * n_sims);  
  end
  
  %% 
  % running until k
  
  %cutting_points_test= cell(1,k);
  
  %for ik= 1:k
  %  cutting_points_test{1,ik}= a0((ik - 1)*test_part + 1:ik*test_part);
  %end
  
  % if k==1, then only the first 1/3 of simulations of a0 are used as test
  % data, the rest of the simulations will be training data
  cutting_points_test= mat2cell(a0(1:test_part*k), 1, test_part.*ones(1,k));
  
  %%
  
  disp('Creating the file cutting_points_test.mat! This file should only be created once.');
  
  save('cutting_points_test.mat', 'cutting_points_test');     
  
end


%%


