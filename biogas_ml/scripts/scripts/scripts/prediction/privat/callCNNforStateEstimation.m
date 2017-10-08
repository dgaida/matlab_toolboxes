%% callCNNforStateEstimation
% Call CNN to perform State Estimation
%
function [perf_temp, perf_1st_temp]= callCNNforStateEstimation(traindata, testdata, ...
          valdata, fermenter_id, ivariable, itest, index_file, y, my_bins)
%% Release: 0.9

%%

error( nargchk(9, 9, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% check arguments

checkArgument(traindata, 'traindata', 'double', '1st');
checkArgument(testdata, 'testdata', 'double', '2nd');
checkArgument(fermenter_id, 'fermenter_id', 'char', 4);

isN(itest, 'itest', 6);

%% TODO
% trainiere GerDA
% traindata(:,2:end) sind die Trainingsdaten des
% featureraumes 
% in traindata(:,1) stehen die zugehörigen
% Klassenlabels

% if ~exist(sprintf('%s_var%02i', fermenter_id, ivariable), 'dir')
%   mkdir(sprintf('%s_var%02i', fermenter_id, ivariable));
% end
% 
% cd(sprintf('%s_var%02i', fermenter_id, ivariable))

if my_bins == -1
  doregress= 'reg';
else
  doregress= '';
end

csvwrite(sprintf('traindata_%s_var%02i%s.csv', fermenter_id, ivariable, ...
  doregress), traindata);

% for ii= 1:size(traindata, 1)
%   
%   if ~exist(sprintf('cls%02i', traindata(ii,1)), 'dir')
%     mkdir(sprintf('cls%02i', traindata(ii,1)));
%   end
%   
%   % 3 channel RGB
% %   imwrite(uint8(traindata(ii,2:end,[1 1 1]).*255), sprintf('cls%02i/cls%02i-%06i.jpg', ...
% %     traindata(ii,1), traindata(ii,1), ii), 'jpg');
%    
%   % 1 channel greyscale
%   imwrite(traindata(ii,2:end), sprintf('cls%02i/cls%02i-%06i.jpg', ...
%     traindata(ii,1), traindata(ii,1), ii), 'jpg');
%   
% end

% cd ..

csvwrite(sprintf('valdata_%s_var%02i%s.csv', fermenter_id, ivariable, ...
  doregress), valdata);

%%

% cd(sprintf('var%02i', ivariable))
%   
% for ii= 1:size(testdata, 1)
%   
%   if ~exist(sprintf('cls%02i', testdata(ii,1)), 'dir')
%     mkdir(sprintf('cls%02i', testdata(ii,1)));
%   end
%   
%   cd(sprintf('cls%02i', testdata(ii,1)))
%   
%   if ~exist('test', 'dir')
%     mkdir('test');
%   end
%   
%   cd test
%   
%   % 3 channel RGB
% %   imwrite(uint8(testdata(ii,2:end,[1 1 1]).*255), sprintf('cls%02i-%06i.jpg', ...
%   %  testdata(ii,1), ii), 'jpg');
% 
%   % 1 channel greyscale
%   imwrite(testdata(ii,2:end), sprintf('cls%02i-%06i.jpg', ...
%     testdata(ii,1), ii), 'jpg');
% 
%   cd ('../..')
%   
% end
% 
% cd ('..')

csvwrite(sprintf('testdata_%s_var%02i%s.csv', fermenter_id, ivariable, ...
  doregress), testdata);


% imwrite(traindata(:,1:end)', sprintf('imgtrain%s_var%02i_labels.png', ...
%   fermenter_id, ivariable), 'png');


%% TODO
% validiere GerDA
% testdata(:,2:end) sind die Testdaten des
% featureraumes 
% in testdata(:,1) stehen die zugehörigen
% Klassenlabels

confusionmatrix= eye(my_bins + 1);



%%
% falls eine confusion matrix zurück gegeben wird von
% GerDA, dann sollte diese confusionmatrix genannt
% werden, dann gibt die folgende Funktion die
% performance zurück, hier wird nur perf_temp(itest,1)
% genutzt, aber einfach so lassen

if exist('confusionmatrix', 'var') && ~isempty(confusionmatrix)

  [perf_temp, dummy, perf_1st_temp]= classifierPerformance(confusionmatrix);   
else
  perf_temp= 0;
  perf_1st_temp= 0;
end

%% TODO
% kann bei Fertigstellung gelöscht werden

warning('CNN:notimplemented', 'Not yet implemented!');


%%


