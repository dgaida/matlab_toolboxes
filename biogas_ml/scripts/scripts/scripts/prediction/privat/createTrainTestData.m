%% createTrainTestData
% Split given dataset into train- and testdataset. 
%
function [traindata, testdata]= ...
         createTrainTestData(dataset, dataset_test, ...
                             cutting_points_test, cutter, itest)
%% Release: 1.7

%%

error( nargchk(5, 5, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% check arguments

checkArgument(dataset, 'dataset', 'double', '1st');
checkArgument(dataset_test, 'dataset_test', 'double', '2nd');
checkArgument(cutting_points_test, 'cutting_points_test', 'cell', '3rd');
checkArgument(cutter, 'cutter', 'double', '4th');
isN(itest, 'itest', 5);

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
  
  testdata_cutter= zeros(size(dataset,1), 1);

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
  % scale data

  dataset(:,2:end)= scale_Data(dataset(:,2:end));

  %%
  % erstellung von test- und traingsdatensatz 

  testdata= dataset(testdata_cutter == 1,:);
  traindata= dataset(testdata_cutter == 0,:);

  %%

end % end if isempty(dataset_test) && 0

%%


