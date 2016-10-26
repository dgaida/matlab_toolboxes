%% startMethodforStateEstimation
% Start training of a State Estimator for a biogas plant's state using
% a pattern recognition method.
%
function [status]= startMethodforStateEstimation(...
                streams, dataset, goal_variables, plant, bins, ...
                varargin)
%% Release: 1.3

%%

error( nargchk(5, 12, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% read out varargin

if nargin >= 6 && ~isempty(varargin{1}),
  dim_low= varargin{1};
  isN(dim_low, 'dim_low', 6);
else
  dim_low= bins - 1;
end

if nargin >= 7 && ~isempty(varargin{2}),
  method= varargin{2};
  validatestring(method, {'LDA', 'LDA_PCA', 'RF', 'RF_PCA', 'SVM', 'GerDA', 'DNN'}, ...
                 mfilename, 'method', 7);
else
  method= 'RF';
end

if nargin >= 8 && ~isempty(varargin{3}),
  index_file= varargin{3};
  checkArgument(index_file, 'index_file', 'cell', 8);
else
  index_file= {0, 0, 0};
end

%%
% cutter gibt an bis zu welchem datensatz in 'dataset' eine simulation
% geht. cutter ist ein double array. das ist wichtig damit eine simulation
% entweder zu den test- oder trainingsdaten gehört

if nargin >= 9 && ~isempty(varargin{4}),
  cutter= varargin{4};
  checkArgument(cutter, 'cutter', 'double', 9);
else
  cutter= [];
end

%%
%

if nargin >= 10 && ~isempty(varargin{5}),
  streams_test= varargin{5};
  checkArgument(streams_test, 'streams_test', 'struct', 10);
else
  streams_test= [];
end

if nargin >= 11 && ~isempty(varargin{6}),
  dataset_test= varargin{6};
  checkArgument(dataset_test, 'dataset_test', 'double', 11);
else
  dataset_test= [];
end

if nargin >= 12 && ~isempty(varargin{7})
  min_class_ub= varargin{7};
  isN(min_class_ub, 'min_class_ub', 12);
else
  min_class_ub= 1000;
end

%% 
% check parameters

checkArgument(streams, 'streams', 'struct', '1st');
checkArgument(dataset, 'dataset', 'double', '2nd');
checkArgument(goal_variables, 'goal_variables', 'cellstr', '3rd');
is_plant(plant, 4);
% because -1 signalizes regression
isZ(bins, 'bins', 5, -1);

%%

regress= 0;

% bins == -1, bedeutet regression
if bins == -1 
  if strcmp(method, 'RF') || strcmp(method, 'RF_PCA')
    regress= 1;
  else
    error('bins == -1 && ~strcmp(method, RF)');
  end
end

%%

n_fermenter= plant.getNumDigestersD();

n_variables= numel(goal_variables);


%%

state_digester_header= {'component', 'min', 'max', 'step', 'step \\%%', 'unit'};

%%
% collects the performances for each variable and digester
total_performance=     zeros(n_variables, n_fermenter);
% collects the minimal performance for each variable and digester gotten
% -> minimal performance over the classes, thus the result of the worst
% class
total_min_performance= zeros(n_variables, n_fermenter);

% collects the performances for each variable and digester, neglecting
% misclassifications with the neighbouring class
total_performance1storder=     zeros(n_variables, n_fermenter);
% collects the performances for each variable and digester, neglecting
% misclassifications with the neighbouring class -> here the worst class is
% collected
total_min_performance1storder= zeros(n_variables, n_fermenter);

%%
% collects the min/max of the digester states of the complete dataset
digester_state_dataset_min= zeros(n_variables, n_fermenter);
digester_state_dataset_max= zeros(n_variables, n_fermenter);
  
%%

if strcmp(method, 'LDA') || strcmp(method, 'LDA_PCA')
    
  TransMatnorms= [];
  ClassMeanMs= [];
  alphas= [];

end

%%

for idigester= 1:n_fermenter%2:2%1:n_fermenter

  %%
  
  fermenter_id= char(plant.getDigesterID(idigester));

  % wird in ADM1 Einheiten gemessen, d.h. kgCOD/m^3
  stream= streams.(fermenter_id);

  if ~isempty(streams_test)
    stream_test= streams_test.(fermenter_id);
  end

  %%

  if strcmp(method, 'LDA') || strcmp(method, 'LDA_PCA')
    TransMatnorms.(fermenter_id)= [];
    ClassMeanMs.(fermenter_id)= [];
    alphas.(fermenter_id)= [];
  end

  %%

  [state_file, message]= ...
      fopen(sprintf('result_range_digester_%i_%s_%ih_%in_%if.tex', ...
             idigester, method, index_file{1}, index_file{2}, ...
             index_file{3}), 'w');
           
  if state_file == -1
    disp(message);
  end

  %%

  performance=         zeros(n_variables,1);
  performance1storder= zeros(n_variables,1);

  %%

  commentForPrinting= repmat({''}, n_variables, 1);

  %%

  for ivariable= 1:n_variables%26:26%11:11%26:26%1:n_variables

    %%
    
    goal_variable= char(goal_variables{ivariable});

    % y is measured in getDefaultMeasurementUnit, thus g/l, etc., not
    % anymore in kgCOD/m^3. same holds for mini and maxi. the unit returned
    % returns the unit in which y is measured
    [y, yclass, unit, mini, maxi]= ...
                getVectorOutOfStream(stream, goal_variable, bins);

    %%
    % initialize variables to given values, because they are overwritten in
    % each for loop run
    
    my_bins= bins;
    my_dim_low= dim_low;

    %%
    % merge classes which have too few elements with neighbour class
    
    [yclass, my_bins, commentForPrinting(ivariable,1)]= ...
      mergeTooSmallClasses(~regress && isempty(dataset_test), yclass, ...
                           my_bins, min_class_ub);

    if nargin < 6 % if dim_low is not given by the user, set it to number of 
      % classes - 1
      my_dim_low= my_bins - 1;
    end
    
    %%

    if ~regress
      dataset(:,1)= yclass;
    else
      % y measured in g/l, ...
      dataset(:,1)= y;
    end

    %%

    if isempty(dataset_test)
      %% TODO - aktuell macht es keine Sinn 5-fold cross validation zu machen
      % da ich die Parameter der ML Methoden nicht ändere, je nach fold. 
      n_tests= 1;%5;     % 5-fold cross-validation
    else
      n_tests= 1;

      [min_class]= min(histc(yclass, 0:my_bins - 1));

      [y, yclass, unit]= ...
              getVectorOutOfStream(stream_test, goal_variable, ...
                                   bins, mini, maxi);

      if ~regress
        dataset_test(:,1)= yclass;
      else
        dataset_test(:,1)= y;
      end
    end

    perf_temp=     zeros(n_tests, 1); % performance over the tests
    perf_1st_temp= zeros(n_tests, 1);
    max_std=       zeros(n_tests, 1);

    %%
    % get cutting points, based on a 5-fold cross-validation
    
    cutting_points_test= get_cutting_points_test(cutter, n_tests);

    %% TODO
    %% TODO - WICHTIG!
    % wenn man cross validation macht, muss man auch parameter für das ML
    % Modell in jedem Test ändern, ansonsten macht das keinen sinn. also
    % bspw. für RF Anzahl der trees abhängig vom test machen. 
    
    %parfor itest= 1:n_tests
    for itest= 1:n_tests        % n-fold cross validation

      %%
      % create train- and testdata

      [traindata, testdata]= createTrainTestData(dataset, dataset_test, ...
                           cutting_points_test, cutter, itest);

      %%
      % add noise to test- and/or trainingdata
      % does nothing at the moment
      % es gibt 2 Stellen wo Rauschen hinzugefügt wird:
      % 1) in dem datensatz dataset selbst, direkt als datei gespeichert,
      % wird in createDataSetForPredictor erzeugt
      % 2) hier.
      % was macht mehr Sinn? wo ist der Unterschied?
      %
      [traindata, testdata]= addNoiseToTestTrainData(traindata, testdata);

      %%

      if exist('min_class', 'var')
        if ~regress && min_class < 1000
          fprintf('Warning: min_class= %i!\n', min_class);
        end
      end

      %%

      if(1)

        if strcmp(method, 'RF') || strcmp(method, 'RF_PCA')

          %%
          % do subsampling
          
          mappedX= pca(traindata(:,2:end));
          %mappedX= compute_mapping(traindata(:,2:end), 'PCA', 1);
          
          [mXsort, mXindex]= sortrows(mappedX(:,1));
          
          traindata= traindata(mXindex, :);
          
          nth_train= 3;   % do not use each training sample but each nth. to use all set to 1
          
          %%
          
          if strcmp(method, 'RF_PCA')
          
            %%

            mydataPCA= [traindata(:,2:end); testdata(:,2:end)];

            [pc,s,v,d,pr]= pca(mydataPCA);

            num_pcas= 20;
            
            rat_dim= round(size(traindata, 2) / num_pcas);

            traindata= [traindata(:, 1), pc(1:size(traindata, 1), 1:num_pcas)];
            testdata= [testdata(:, 1), pc(size(traindata, 1) + 1:end, 1:num_pcas)];
            
            % if using less training data use more trees
            % and use more trees depend on the ratio of dimensions
            n_trees= rat_dim * 20 * nth_train; % 60
            
          else
            n_trees= 20 * nth_train; % 60
          end
          
          %%
          
          traindata= traindata(1:nth_train:end,:);
          
          %%
          
          [perf_temp(itest,1), perf_1st_temp(itest,1), max_std(itest,1)]= ...
            callRFforStateEstimation(traindata, testdata, ...
            fermenter_id, ivariable, itest, index_file, y, my_bins, ...
            goal_variable, regress, n_trees);

          %%

        elseif strcmp(method, 'SVM')

          perf_temp(itest, 1)= startSVM(traindata, testdata, regress);

          %%

        elseif strcmp(method, 'LDA') || strcmp(method, 'LDA_PCA')

          %%
          
          if strcmp(method, 'LDA_PCA')

            %%

            mydataPCA= [traindata(:,2:end); testdata(:,2:end)];

            [pc,s,v,d,pr]= pca(mydataPCA);

            num_pcas= 20;

            traindata= [traindata(:, 1), pc(1:size(traindata, 1), 1:num_pcas)];
            testdata= [testdata(:, 1), pc(size(traindata, 1) + 1:end, 1:num_pcas)];

          end
          
          %%
          
          [gefundenmatrix, confusionmatrix, TransMatnorm, ClassMeanM, alpha]= ...
              startLDA(traindata, testdata, my_dim_low);

          %%

          if ~isempty(confusionmatrix)

            [perf_temp(itest,1), dummy, perf_1st_temp(itest,1)]= ...
                classifierPerformance(confusionmatrix);   

            %%

            TransMatnorms.(fermenter_id).(goal_variable)= TransMatnorm;
            ClassMeanMs.(fermenter_id).(goal_variable)= ClassMeanM;
            alphas.(fermenter_id).(goal_variable)= alpha;

          else

            perf_temp(itest,1)= NaN;%[];
            perf_1st_temp(itest,1)= NaN;%[];

          end
          
          %%
          
        elseif strcmp(method, 'GerDA')

          [perf_temp(itest,1), perf_1st_temp(itest,1)]= ...
                callGerDAforStateEstimation(traindata, testdata, ...
                            my_dim_low, fermenter_id, itest, goal_variable);
          
          %%
          
        elseif strcmp(method, 'DNN')

          %%
          
          [perf_temp(itest,1)]= ...
                callDNNforStateEstimation(traindata, testdata, ...
                            fermenter_id, ivariable, itest, index_file, y, my_bins);
          
          %%
          
          perf_1st_temp(itest,1)= 100;
          
        else

          warning('method:notknown', 'Unknown method!!!');

        end

      else
        filename= sprintf('testdata%i_test%i.csv', ivariable, itest);
        csvwrite(filename, testdata);

        filename= sprintf('traindata%i_test%i.csv', ivariable, itest);
        csvwrite(filename, traindata);

        confusionmatrix= zeros(my_bins);
      end % if(1)

    end % end itest

    %%

    disp('max_std: ');
    disp(max_std);
    mean(max_std)

    %%

    perf_temp=         perf_temp(~isnan(perf_temp));
    perf_1st_temp= perf_1st_temp(~isnan(perf_1st_temp));

    performance(ivariable, 1)=         mean(perf_temp);
    performance1storder(ivariable, 1)= mean(perf_1st_temp);

    std_perf= std(perf_temp);
    disp(std_perf)

    %%

    if min(y) < 1e-2

      step_d= (max(y) - min(y))/my_bins;

      fprintf(...
      'Performance for %s%s (%.2e, ..., %.2e, ..., %.2e) %s: %.2f %%\n', ...
          goal_variable, commentForPrinting{ivariable,1}, ...
          min(y), step_d, max(y), unit, performance(ivariable, 1));

      goal_variable_= addUnderscore(goal_variable);

      addNewRowInLatexTable(state_file, ...
          {[goal_variable_, commentForPrinting{ivariable,1}], ...
          min(y), max(y), step_d, 100/my_bins, unit}, ...
          {'%s', '%.2e', '%.2e', '%.2e', '%.2f', '%s'}, ...
          (ivariable == 1) + 2*(ivariable == n_variables), ...
          state_digester_header);

    else

      step_d= (max(y) - min(y))/my_bins;

      fprintf(...
      'Performance for %s%s (%.2f, ..., %.2f, ..., %.2f) %s: %.2f %%\n', ...
          goal_variable, commentForPrinting{ivariable,1}, ...
          min(y), step_d, max(y), unit, performance(ivariable, 1));

      goal_variable_= addUnderscore(goal_variable);

      addNewRowInLatexTable(state_file, ...
          {[goal_variable_, commentForPrinting{ivariable,1}], ...
          min(y), max(y), step_d, 100/my_bins, unit}, ...
          {'%s', '%.2f', '%.2f', '%.2f', '%.2f', '%s'}, ...
          (ivariable == 1) + 2*(ivariable == n_variables), ...
          state_digester_header);

    end

    %%

    if exist('confusionmatrix', 'var') && ~isempty(confusionmatrix)

      total_min_performance(ivariable, idigester)= ...
          min(diag(confusionmatrix));

      total_min_performance1storder(ivariable, idigester)= ...
                                       min( ...
                    diag(confusionmatrix) + ...
                    [0; diag(confusionmatrix, -1)] + ...
                      [diag(confusionmatrix, 1); 0] ...
                                          );

    else

      total_min_performance(ivariable, idigester)= 0;
      total_min_performance1storder(ivariable, idigester)= 0;

    end

    %%
    % y is measured in default measurement unit, thus g/l, etc.
    digester_state_dataset_min(ivariable, idigester)= min(y);
    digester_state_dataset_max(ivariable, idigester)= max(y);

%         addNewRowInLatexTable(perform_file, {goal_variable, ...
%                 performance(ivariable, 1), min(diag(confusionmatrix))}, ...
%                 {'%s', '%.2f', '%.2f'}, ...
%                 (ivariable == 1), state_perform_header);

      %confusionmatrix

  end

  %%

  fprintf(...
      '\nTotal performance for state estimation of fermenter %s: %.2f %%\n\n', ...
      fermenter_id, mean(performance));

  total_performance(:,idigester)= performance;

  total_performance1storder(:,idigester)= performance1storder;

%     addNewRowInLatexTable(perform_file, {'\\hline\nmean', ...
%                 mean(performance)}, ...
%                 {'%s', '%.2f'}, 2);

  %%
  
  save('ws_temp_results.mat', 'total_performance', 'total_performance1storder');
  
  %%

  status= fclose(state_file);

end

%%

saveResultsInLatexFile(total_performance, total_performance1storder, ...
          goal_variables, method, index_file, commentForPrinting);

%%
% contains min respectively max of y values, measured in g/l (repsectively
% default measurement unit) 
% contains 37 rows and number of digester columns
% arrays
save('digester_state_dataset_min.mat', 'digester_state_dataset_min');
save('digester_state_dataset_max.mat', 'digester_state_dataset_max');

%%

if strcmp(method, 'LDA') || strcmp(method, 'LDA_PCA')
  
  if ~(exist(method, 'dir') == 7)
    mkdir(method);
  end
  
  save(sprintf('%s/TransMatnorms_%ih_%in_%if.mat', method, ...
    index_file{1}, index_file{2}, index_file{3}), 'TransMatnorms');
  save(sprintf('%s/ClassMeanMs_%ih_%in_%if.mat', method, ...
    index_file{1}, index_file{2}, index_file{3}), 'ClassMeanMs');
  save(sprintf('%s/alphas_%ih_%in_%if.mat', method, ...
    index_file{1}, index_file{2}, index_file{3}), 'alphas');

end

%%


