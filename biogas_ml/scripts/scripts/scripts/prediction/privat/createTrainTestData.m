%% createTrainTestData
% Split given dataset into train- and testdataset. 
%
function [traindata, testdata, valdata, lowLimit, maxLimit]= ...
         createTrainTestData(dataset, dataset_test, ...
                             cutting_points_test, cutter, itest, IDXkm, icluster, ...
                             numsamples)
%% Release: 1.7

%%

error( nargchk(8, 8, nargin, 'struct') );
error( nargoutchk(0, 5, nargout, 'struct') );

%%
% check arguments

checkArgument(dataset, 'dataset', 'double', '1st');
checkArgument(dataset_test, 'dataset_test', 'double', '2nd');
checkArgument(cutting_points_test, 'cutting_points_test', 'cell', '3rd');
checkArgument(cutter, 'cutter', 'double', '4th');
isN(itest, 'itest', 5);

% numsamples is the number of all samples in the original dataset. the
% dataset given to this function could just contain the samples that belong
% to cluster icluster. to properly create the split of testdata_cutter we
% need to know the complete numberof samples
isN(numsamples, 'numsamples', 8);

%%

if isempty(dataset_test) && 0

  %% WARNING
  % never split dataset between traindata and testdata randomly
  
  %dataset_sort= sortrows(dataset, 1);
  
%   traindata= zeros(size(dataset_sort(1:2:end - 40,:)));
%   testdata= zeros(size(dataset_sort(2:2:end - 40,:)));
% 
%   ipos_train= 1;
%   ipos_test= 1;
% 
%   %%
%   
%   for ibin= 1:my_bins
% 
%     %%
%     
%     dataset_class= dataset_sort(dataset_sort(:,1) == ibin - 1, :);
% 
%     perm_vec= randperm(size(dataset_class, 1))';
% 
%     dataset_class= sortrows([perm_vec, dataset_class], 1);
% 
% 
%     %%
% 
%     traindata(ipos_train:ipos_train + ...
%                        size(dataset_class(1:2:end,:), 1) - 1,:)= ...
%                             dataset_class(1:2:end,2:end);
% 
%     testdata(ipos_test:ipos_test + ...
%                       size(dataset_class(2:2:end,:), 1) - 1,:)= ...
%                            dataset_class(2:2:end,2:end);
% 
%     %%
% 
%     ipos_train= ipos_train + size(dataset_class(1:2:end,:), 1);
%     ipos_test= ipos_test + size(dataset_class(2:2:end,:), 1);
% 
%     %%
% 
%     checkdata= 0;
% 
%     if checkdata
% 
%         size_mat= size(dataset_class(1:2:end,3:end),2);
% 
%         dir1= dataset_class(1:2:end,3:round(size_mat/3));
%         dir2= dataset_class(1:2:end,round(size_mat/3) + 1:2*round(size_mat/3));
%         dir3= dataset_class(1:2:end,2*round(size_mat/3) + 1:end);
% 
%         dir1_ms= diag(dir1*dir1');
%         dir2_ms= diag(dir2*dir2');
%         dir3_ms= diag(dir3*dir3');
% 
%         scatter3(dir1_ms, dir2_ms, dir3_ms);
% 
%         hold on
% 
%         dir1= dataset_class(2:2:end,3:round(size_mat/3));
%         dir2= dataset_class(2:2:end,round(size_mat/3) + 1:2*round(size_mat/3));
%         dir3= dataset_class(2:2:end,2*round(size_mat/3) + 1:end);
% 
%         dir1_ms= diag(dir1*dir1');
%         dir2_ms= diag(dir2*dir2');
%         dir3_ms= diag(dir3*dir3');
% 
%         scatter3(dir1_ms, dir2_ms, dir3_ms, 'r');
% 
%         hold off;
% 
%     end
% 
%     %%
% 
%   end % end ibin

elseif ~isempty(dataset_test)

  traindata= dataset;
  testdata= dataset_test;

% das ist das was aktuell gemacht wird    
else

  cutting_pp= cutting_points_test{itest};
  
  testdata_cutter= zeros(numsamples, 1);
  
  train_simulations= 1:numel(cutter);
  train_simulations(cutting_pp)= [];

  %% TODO
  % funktioniert nur für itest == 1
  if exist('cutting_points_val.mat', 'file')
  
    load('cutting_points_val.mat');
    
  else
    
    val_simulations= randi(numel(train_simulations), round(numel(cutter)*0.1), 1);     % 5 simulations
    val_simulations= train_simulations(val_simulations);

    %%
    %% TODO: besser ich erstelle val_simulations in startMethodforStateEstimation
    % so wie in get_cutting_points_test und speichere die einmal erstellte ab
    % und lade diese wieder
    save('cutting_points_val.mat', 'val_simulations');

  end
  
  %%

  for icut= cutting_pp

    if icut - 1 <= 0
      % first simulation, mark 1st to cutter(icut) element with 1
      testdata_cutter(1:cutter(icut), 1)= ones(cutter(icut), 1);
    else
      % from previous end + 1, to current end mark with 1
      testdata_cutter(cutter(icut - 1) + 1:cutter(icut), 1)= ...
            ones(cutter(icut) - cutter(icut - 1), 1);
    end

  end
  
  %%
  % to avoid that testdata also appears in traindata, make testdata 2
  valdata_cutter= testdata_cutter .* 2;
  
  for icut= val_simulations

    if icut - 1 <= 0
      % first simulation, mark 1st to cutter(icut) element with 1
      valdata_cutter(1:cutter(icut), 1)= ones(cutter(icut), 1);
    else
      % from previous end + 1, to current end mark with 1
      valdata_cutter(cutter(icut - 1) + 1:cutter(icut), 1)= ...
            ones(cutter(icut) - cutter(icut - 1), 1);
    end

  end

  %%
  % scale data

  [dataset(:,2:end), lowLimit, maxLimit]= scale_Data(dataset(:,2:end));

  %%
  % erstellung von test- und traingsdatensatz 

  % if we cluster dataset into clusters, then teh dataset below contains
  % only the data from icluster, so we also have to filter out the correct
  % values from the cutter
  testdata_cutter= testdata_cutter(IDXkm == icluster);

  testdata= dataset(testdata_cutter == 1,:);
  
  
  %traindata= dataset(testdata_cutter == 0,:);
  traindata= dataset(valdata_cutter == 0,:);
  valdata= dataset(valdata_cutter == 1,:);
  
  %%

end % end if isempty(dataset_test) && 0

%%


