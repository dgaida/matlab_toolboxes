%% callGerDAforStateEstimation
% Call GerDA to perform State Estimation
%
function [perf_temp, perf_1st_temp]= callGerDAforStateEstimation(traindata, testdata, ...
          my_dim_low, fermenter_id, itest, goal_variable)
%% Release: 0.9

%%

error( nargchk(6, 6, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% check arguments

checkArgument(traindata, 'traindata', 'double', '1st');
checkArgument(testdata, 'testdata', 'double', '2nd');
isN(my_dim_low, 'my_dim_low', 3);
checkArgument(fermenter_id, 'fermenter_id', 'char', 4);
isN(itest, 'itest', 5);
checkArgument(goal_variable, 'goal_variable', 'char', 6);

%% TODO
% trainiere GerDA
% traindata(:,2:end) sind die Trainingsdaten des
% featureraumes 
% in traindata(:,1) stehen die zugehörigen
% Klassenlabels

% Hinweis: in my_dim_low steht die Anzahl der Klassen
% für diese Variable - 1, also auf diese Dimension
% transformiert LDA runter

disp(my_dim_low)

sp_train= sparse(traindata(:,2:end));
sp_test= sparse(testdata(:,2:end));

libsvmwrite(sprintf('traindata_%s_%s_%i', fermenter_id, goal_variable, itest), ...
         traindata(:,1), sp_train);
libsvmwrite(sprintf('testdata_%s_%s_%i', fermenter_id, goal_variable, itest), ...
         testdata(:,1), sp_test);


%dlmwrite(sprintf('traindata_%s_%s_%i.txt', ...
 %        fermenter_id, goal_variable, itest), ...
  %       traindata, ' ');

%dlmwrite(sprintf('testdata_%s_%s_%i.txt', ...
 %        fermenter_id, goal_variable, itest), ...
  %       testdata, ' ');

%% TODO
% validiere GerDA
% testdata(:,2:end) sind die Testdaten des
% featureraumes 
% in testdata(:,1) stehen die zugehörigen
% Klassenlabels

confusionmatrix= eye(my_dim_low + 1);



%%
% falls eine confusion matrix zurück gegeben wird von
% GerDA, dann sollte diese confusionmatrix genannt
% werden, dann gibt die folgende Funktion die
% performance zurück, hier wird nur perf_temp(itest,1)
% genutzt, aber einfach so lassen

if exist('confusionmatrix', 'var') && ~isempty(confusionmatrix)

  [perf_temp, dummy, perf_1st_temp]= classifierPerformance(confusionmatrix);   

end

%% TODO
% kann bei Fertigstellung gelöscht werden

warning('GerDA:notimplemented', 'Not yet implemented!');


%%


