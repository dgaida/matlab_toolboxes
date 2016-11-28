%% startStateEstimation
% Prepare simulated dataset for estimating the internal state of a biogas
% plant and start State Estimation.
%
function startStateEstimation(plant_id, varargin)
%% Release: 1.2

%%

error( nargchk(1, 10, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(plant_id, 'plant_id', 'char', '1st');

%%
% read out varargin

%% TODO: es wird kein toc aufgerufen

tic

%%

if nargin > 1 && ~isempty(varargin{1})
  parallel= varargin{1};
  validatestring(parallel, {'none', 'multicore', 'cluster'}, mfilename, 'parallel', 2);
else
  parallel= 'none'; 
end

%%

if nargin > 2 && ~isempty(varargin{2})
  nWorker= varargin{2};
  isN(nWorker, 'nWorker', 3);
else
  nWorker= 2;
end

if strcmp(parallel, 'none')
  nWorker= 1;
end

%%

if nargin > 3 && ~isempty(varargin{3})
  methods= varargin{3};
  checkArgument(methods, 'methods', 'cellstr', 4);
else
  methods= {'GerDA'};%{'RF'};
end

%%

if nargin > 4 && ~isempty(varargin{4})
  sample_times= varargin{4};
  checkArgument(sample_times, 'sample_times', 'cell', 5);
else
  % sampling times used in createDataSetForPredictor, measured in hours
  sample_times= {1, 2, 6, 12};
  %sample_times= {6};
end

%%

if nargin > 5 && ~isempty(varargin{5})
  noise_out= varargin{5};
  checkArgument(noise_out, 'noise_out', 'cell', 6);
else
  % noise added to the four measurements
  % * pH value
  % * ch4 content in biogas
  % * co2 content in biogas
  % * total biogas production
  %
  noise_out= {[0, 0, 0, 0], [0.01, 0.01, 0.01, 0.01], ...
              [0.01, 0.02, 0.02, 0.01], [0.01, 0.05, 0.05, 0.01], ...
              [0.01, 0.05, 0.05, 0.01], ...
              [0.01, 0.1, 0.1, 0.01]};
end

%%

if nargin > 6 && ~isempty(varargin{6})
  doplots= varargin{6};
  is0or1(doplots, 'doplots', 7);
else
  doplots= 0;
end

%%

if nargin > 7 && ~isempty(varargin{7})
  %
  % 4 Klassen ergibt MCR= 10 % für snh4 1. fermenter
  % 5 Klassen ergibt MCR= 14 % für snh4 1. fermenter
  % 10 Klassen auf MCR 1st ordnung schauen

  % number of classes used in the classification problem
  bins= varargin{7};
  isN(bins, 'bins', 8);
else
  bins= 15;%4;%5;
end

%%

if nargin >= 9 && ~isempty(varargin{8})
  ma_filters_out_p1= varargin{8};
  checkArgument(ma_filters_out_p1, 'ma_filters_out_p1', 'cell', 9);
else
  % 1 Nutzung des moving average filters, 0 keine Nutzung
  % zur Wahl stehen:
  % [12, 24, 3*24, 7*24, 14*24, 21*24, 31*24]
  % die erste 1 signalisiert das Originalsignal (p1), so dass hier max. 7
  % moving average filter genommen werden und immer das originalsignal
  % zusätzlich
  %
  ma_filters_out_p1= {[1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,0], [1,1,1,1,1,1,0,0], ... %2
                      [1,1,1,1,1,0,0,0], [1,1,1,1,0,0,0,0], [1,1,1,0,0,0,0,0], ... %5
                      [1,1,0,0,0,0,0,0], [1,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], ... %8
                      [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], ... %11
                      [0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0], [1,0,1,1,1,1,1,1], ... %14
                      [1,0,0,1,1,1,1,1], ...
                      [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], ... %18
                      [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], ... %21
                      [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1], ... %24
                      [1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,0], [1,1,1,1,1,1,1,0], ... %27
                      [1,1,1,1,0,1,1,0], [1,1,1,0,1,1,1,0], ... %29
                      [1,1,1,1,1,1,1,0], [1,1,1,1,1,1,0,0], [1,1,1,1,1,0,0,0], ... %32
                      [1,1,1,1,0,0,0,0], [1,1,1,0,0,0,0,0], [1,1,0,0,0,0,0,0], ... %35
                      [1,0,0,0,0,0,0,0], [1,0,0,0,0,0,0,0], [1,0,0,0,0,0,0,0], ... %38
                      [1,0,0,0,0,0,0,0], [1,0,0,0,0,0,0,0], [1,0,0,0,0,0,0,1], ... %41
                      [1,0,0,0,0,0,0,1], [1,0,0,0,0,0,0,1], [1,0,0,0,0,0,0,1]}; %44
                    
  ma_filters_out_p1= {[1,1,1,1,1,1,1,1,1,1,1,1]};                  
end

%%

if nargin >= 10 && ~isempty(varargin{9})
  ma_filters_in_p1= varargin{9};
  checkArgument(ma_filters_in_p1, 'ma_filters_in_p1', 'cell', 10);
else
  % 1 Nutzung des moving average filters, 0 keine Nutzung
  % zur Wahl stehen:
  % [12, 24, 3*24, 7*24, 14*24]
  % die erste 1 signalisiert das Originalsignal (p1), so dass hier max. 5
  % moving average filter genommen werden und immer das originalsignal
  % zusätzlich
  %
  ma_filters_in_p1= {[1,1,1,1,1,1], [1,1,1,1,1,1], [1,1,1,1,1,1], ...
                     [1,1,1,1,1,1], [1,1,1,1,1,1], [1,1,1,1,1,1], ...
                     [1,1,1,1,1,1], [1,1,1,1,1,1], [1,1,1,1,1,1], ...
                     [1,1,1,1,1,0], [1,1,1,1,0,0], [1,1,1,0,0,0], ...
                     [1,1,0,0,0,0], [1,0,0,0,0,0], [1,1,1,1,1,1], ...
                     [1,1,1,1,1,1], ...
                     [1,1,1,1,1,0], [1,1,1,1,0,0], [1,0,1,1,1,1], ... %18
                     [1,1,1,0,0,0], [1,1,0,0,0,0], [1,0,0,0,0,0], ... %21
                     [1,0,0,1,1,1], [1,0,0,0,1,1], [1,0,0,0,0,1], ... %24
                     [1,0,0,0,0,0], [1,0,1,1,1,1], [1,0,0,1,1,1], ... %27
                     [1,0,1,1,1,1], [1,0,1,1,1,1], ...
                     [1,0,0,0,0,0], [1,0,0,0,0,0], [1,0,0,0,0,0], ... %32
                     [1,0,0,0,0,0], [1,0,0,0,0,0], [1,0,0,0,0,0], ... %35
                     [1,0,0,0,0,0], [1,1,0,0,0,0], [1,1,1,0,0,0], ... %38
                     [1,1,1,1,0,0], [1,1,1,1,1,0], [1,1,0,0,0,0], ... %41
                     [1,0,1,0,0,0], [1,0,0,1,0,0], [1,0,0,0,1,0]}; %44
                   
  ma_filters_in_p1= {[1,1,1,1,1,1,1,1,1,1]};                 
end

%%

if numel(ma_filters_out_p1) ~= numel(ma_filters_in_p1)
  error('numel(ma_filters_out_p1) ~= numel(ma_filters_in_p1): %i ~= %i!', ...
         numel(ma_filters_out_p1), numel(ma_filters_in_p1));
end

%% 
% load struct files

[substrate, plant, substrate_network, plant_network, ...
 substrate_network_min, substrate_network_max, ...
 plant_network_min, plant_network_max]= load_biogas_mat_files(plant_id);
          
      
%%

% set the seed of rand
%rand('seed', clock()*clock()');
s= RandStream('mcg16807','Seed', clock()*clock()');
RandStream.setDefaultStream(s);


%%
%

if strcmp(parallel, 'cluster')
  
  % Find the Parallel Computing Toolbox scheduler
  jm= findResource('scheduler','type','local');

  % Create a distributed job on the Job Manager
  j= createJob(jm);

  warning('startStateEstimation:cluster', 'Cluster option not yet implemented!');
  
elseif strcmp(parallel, 'multicore')

  [parallel, nWorker]= setParallelConfiguration('open', parallel, nWorker);

end


%%

goal_variables= load_file('adm1_state_abbrv')';

%%

max_filter_out_p1= numel(ma_filters_out_p1{1,1});  

% 2 fermenter a 4 messungen
n_data_out= plant.getNumDigestersD() * 4;
  
max_filter_in_p1= numel(ma_filters_in_p1{1,1});

%% 
% Anzahl Substrate + pumpverbindungen zwischen fermenter
n_data_in= substrate.getNumSubstratesD() + ...
           getNumDigesterSplits(plant_network, plant_network_max);


%% TODO
% Iterationsindizes anpassen
%
for i_filter_counter= 1:numel(ma_filters_out_p1)
  %40:45%1:1%39:39%36:38%%1:1%32:32%33:36%29:30%1:1%27:28%;%1%2;

  %%

  n_sample= numel(sample_times);

  %%
  % TODO : test für paper
  %n_sample= 3;

  %%

  % oder []
  subsampling= '6h';
  subsampling= [];

  %% TODO
  % sample startet hier immer von 3, d.h. 6h

  for isample= 1:n_sample

    %%
    
    n_noise= size(noise_out,2);
    
    %%
    % TODO : test für paper
    %n_noise= 1;
    
    %% TODO
    % auf 2 gesetzt, da ich einmal ohne noise und einmal mit noise fahren
    % möchte
    for inoise= 1:n_noise     % 2

      %%
      %

      try
        if ~isempty(subsampling)
          dataset= load_file(sprintf('dataset_%ih_%in_complete_%s', ...
                  sample_times{isample}, inoise - 1, subsampling));
        else
          dataset= load_file(sprintf('dataset_%ih_%in_complete', ...
                  sample_times{isample}, inoise - 1));
        end
      catch ME
        dataset= load_file(sprintf('dataset_%ih_%in', ...
                           sample_times{isample}, inoise - 1));
      end

      %%
      % 
      try
        if ~isempty(subsampling)
          cutter= load_file(sprintf('cutter_%s_complete', subsampling));
        else
          cutter= load_file(sprintf('cutter_%ih_complete', sample_times{isample}));
        end
      catch ME
        cutter= load_file(sprintf('cutter_%ih', sample_times{isample}));
      end

      %%
      % erstelle für ausgangsfilter ein binäres spaltenauswahlmuster, das
      % muster ist:
      % - erste Messung Fermenter 1 mit den nachfolgenden Filtern
      % - zweite Messung Fermenter 1 mit den nachfolgenden Filtern
      % - ...
      % - erste Messung Fermenter 2 mit den nachfolgenden Filtern
      % - zweite Messung Fermenter 2 mit den nachfolgenden Filtern
      % - ...

      ma_filters_out_p1_total= ...
          repmat(ma_filters_out_p1{1,i_filter_counter}, 1, n_data_out);

      %%
      % Eingangsmessungen

      ma_filters_in_p1_total= ...
          repmat(ma_filters_in_p1{1,i_filter_counter}, 1, n_data_in);

      ma_filters_p1_total= [ma_filters_out_p1_total, ma_filters_in_p1_total];

      %%
      % gewünschte spalten aus datensatz ausschneiden

      dataset= dataset(:, ma_filters_p1_total == 1);

      %%
      % komplett konstante spalten werden aus Datensatz gelöscht
      dataset_flag_vec= min(dataset, [], 1) ~= max(dataset, [], 1);


      %% TODO
      % nicht möglich in parfor loop
      save(sprintf('dataset_flag_vec_%if.mat', i_filter_counter - 1), ...
                   'dataset_flag_vec');

      %

      dataset= dataset(:, dataset_flag_vec);

      %%
      % in der 1. spalte werden nachher die klassen des zustandsvektors
      % eingefügt 

      dataset= [zeros(size(dataset,1),1), dataset];

      %%
      % write range of measurements in latex file and plot data and
      % histograms if doplots == 1

      if inoise == 1 && isample == 1 && i_filter_counter == 1

        %% 
        % substratnamen und Substratanzahl sind dynamisch
        
        meas_variables= [];
        
        for isubstrate= 1:substrate.getNumSubstratesD()
          LB= sum(substrate_network_min(isubstrate,:));
          UB= sum(substrate_network_max(isubstrate,:));

          if (LB < UB)
            meas_variables= [meas_variables, {sprintf('$Q_\\text{%s}$', ...
                             char(substrate.getID(isubstrate)))}];
          end
        end
        
        %%
        % anzahl substrate, welche sich verändern sollen
        num_substrates_changing= numel(meas_variables);
        
        %% 
        % an anzahl digester anpassen
        
        for idigester= 1:plant.getNumDigestersD()
        
          meas_variables= [meas_variables, ...
                          {sprintf('$\\text{pH}_%i$', idigester), ...
                           sprintf('$Q_{\\text{biogas},%i}$', idigester), ...
                           sprintf('$V_{\\text{CH}_4,%i}$', idigester), ...
                           sprintf('$V_{\\text{CO}_2,%i}$', idigester)}];

        end
        
        %% 
        % die einheitenanzahl anpassen an anzahl substrate und digester
        
        units= [repmat({'m^3/d'}, 1, num_substrates_changing), ...
                repmat({'-', 'm^3/d', '\\%%', '\\%%'}, 1, plant.getNumDigestersD())];    

        measurement_range_header= {'component', 'min', 'max', 'unit'};

        [measurement_file, message]= ...
                fopen(sprintf('result_range_measurement.tex'), 'w');

        if (measurement_file == -1)
          disp(message);
        end
        
        disp('range of dataset for fermenters:');

        iunit= 0;

        %doplots= 1;%1

        %%
        % first go over the substrate measurements
        % since first column of dataset == zeros, + 2 and not + 1
        for i= max_filter_out_p1*n_data_out + 2:max_filter_in_p1:size(dataset,2)
          
          %%
          
          fprintf('%.2f, ..., %.2f\n', min(dataset(:,i)), max(dataset(:,i)));

          if doplots
            figure,plot(dataset(:,i));
            figure,hist(dataset(:,i));
          end

          iunit= iunit + 1;

          %% 
          %
          addNewRowInLatexTable(measurement_file, ...
              {meas_variables{iunit}, min(dataset(:,i)), max(dataset(:,i)), ...
              units{iunit}}, ...
                      {'%s', '%.2f', '%.2f', ...'%.2f', 
                       '%s'}, ...
                      i == max_filter_out_p1*n_data_out + 2, ... 
                      ...%2 .* (i >= size(dataset,2) - 5), 
                      measurement_range_header);

        end

        %%

        addNewRowInLatexTable(measurement_file, ...
                              {'\\\\\\hline\\\\'}, {'%s'}, ...
                              0, [], ...measurement_range_header, 
                              '');

        %%                             
        % for all measurememnts
        % since first column of dataset == zeros, starting with 2 and
        % not 1 

        for i= 2:max_filter_out_p1:max_filter_out_p1*n_data_out + 1
          
          %%
          
          fprintf('%.2e, ..., %.2e\n', min(dataset(:,i)), max(dataset(:,i)));

          if doplots
            figure,plot(dataset(:,i));
            figure,hist(dataset(:,i));
          end

          iunit= iunit + 1;

          %% 
          %
          addNewRowInLatexTable(measurement_file, ...
              {meas_variables{iunit}, min(dataset(:,i)), max(dataset(:,i)), ...
              units{iunit}}, ...
                      {'%s', '%.2f', '%.2f', ...'%.2f', 
                       '%s'}, ...
                      2 .* (i >= max_filter_out_p1*n_data_out + 1 - 7), ...%(i == 2), 
                      measurement_range_header);

        end

        %%

        status= fclose(measurement_file);

      end


      %%
      % streams is measured in defulat ADM units, ths kgCOD/m^3
      
      try
        if ~isempty(subsampling)
          streams= load_file(sprintf('streams_%ih_complete_%s', ...
              sample_times{isample}, subsampling));%, inoise - 1));
        else
          streams= load_file(sprintf('streams_%ih_complete', ...
              sample_times{isample}));
        end
      catch ME
        streams= load_file(sprintf('streams_%ih', ...
                           sample_times{isample}));%, inoise - 1));
      end

      %%

      if strcmp(parallel, 'cluster')

        createTask(j, @startMethodforStateEstimation, ...
                    streams, dataset, goal_variables, plant, ...
                    bins, ...
                    [], method, ...%'SVM','LDA'
                    {sample_times{isample}, inoise - 1, i_filter_counter - 1}, ...
                    cutter);%streams_test, dataset_test);

      else

        %%

        %methods= {'LDA'};%
        %methods= {'RF'};%

        %methods= {'LDA', 'RF'};

        sample_time_isample= sample_times{isample};

        %% TODO
        % parfor loop acht wohl eher weniger sinn, da methoden sehr viel
        % performance benötigen
        %par
        for imethod= 1:size(methods,2)

          [status]= startMethodforStateEstimation(...
                  streams, dataset, goal_variables, plant, ...
                  bins, ...
                  [], methods{imethod}, ...'RF', ...);%'SVM');%, 3); % LDA RF
                  {sample_time_isample, inoise - 1, i_filter_counter - 1}, ...
                  cutter);%streams, dataset);%streams_test, dataset_test);

        end

        %%

      end % end if

      %%

    end % end inoise

    %%
    
  end % end isample

%%

end % end ifilter

%%
            
if strcmp(parallel, 'cluster')
   
  % Submit the distributed job to the Job Manager
  submit(j);  
  tic;
  listJobs(jm);       % Summary of jobs currently in job manager
  listTasks(j);       % Summary of tasks belonging to job
  waitForState(j);

  % Get the results of the simulation. Matrix
  [results] = getAllOutputArguments(j);

  toc;
  listJobs(jm);       % Summary of jobs currently in job manager
  listTasks(j);       % Summary of tasks belonging to job
  plottasks(jm,j);    % grafische Darstellung des Jobs
  destroy(j);

elseif strcmp(parallel, 'multicore')

  setParallelConfiguration('close', parallel);

end

%%


