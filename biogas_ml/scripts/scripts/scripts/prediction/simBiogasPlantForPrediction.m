%% simBiogasPlantForPrediction
% Run the simulation model in a loop to create data for predicting the
% internal state of a biogas plant. 
%
function [varargout]= simBiogasPlantForPrediction(plant_id, varargin)
%% Release: 1.3

%%
%

error( nargchk(1, 8, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%% 
% 

tic
                  
%%
% read out varargin

checkArgument(plant_id, 'plant_id', 'char', '1st');

%%
%

if nargin > 1 && ~isempty(varargin{1}) 
  parallel= varargin{1}; % do we run simulations in parallel or on a cluster
  validatestring(parallel, {'none', 'multicore', 'cluster'}, mfilename, 'parallel', 2);
else
  parallel= 'none';     % default: simulations are run one after the other
end

%%
%

if nargin > 2 && ~isempty(varargin{2})
  nWorker= varargin{2};   % number of workers (multicore) or PCs (cluster)
  isN(nWorker, 'nWorker', 3);
else
  nWorker= 2;
end

if strcmp(parallel, 'none') % if no parallel computation set worker to 1
  nWorker= 1;
end

%%

if nargin > 3 && ~isempty(varargin{3}), 
  n_simulations= varargin{3};   % number of simulations
  isN(n_simulations, 'n_simulations', 4);
else
  n_simulations= 7; % 
end

if nargin > 4 && ~isempty(varargin{4}), 
  timespan= varargin{4};    % duration of one simulation in days
  checkArgument(timespan, 'timespan', 'double', 5);
else
  timespan= [0 950]; % in days
end

%%
%

if nargin >= 6 && ~isempty(varargin{5}), 
  sample_times= varargin{5}; 
  checkArgument(sample_times, 'sample_times', 'cell', 6);
else
  %sample_times_s= {'1h', '2h', '12h', '24h'};
  % sampling times used in createDataSetForPredictor, measured in hours
  sample_times= {1, 2, 6, 12};
end

%%
% TODO: has no effect anymore, replaced by
% parameter |noisy|.
%

if nargin >= 7 && ~isempty(varargin{6}), 
  noise_out= varargin{6}; 
  checkArgument(noise_out, 'noise_out', 'cell', 7);
else
  %%
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
% TODO: has no effect anymore, replaced by
% parameter |noisy|.
%

if nargin >= 8 && ~isempty(varargin{7}), 
  noise_in= varargin{7}; 
  checkArgument(noise_in, 'noise_in', 'cell', 8);
else
  % noise added to the substrate feed used in createDataSetForPredictor
  noise_in= {0, 0, 0, 0, 0.01, 0.01};
end

if numel(noise_out) ~= numel(noise_in)
  error('noise_out and noise_in do not have the same dimension: %i ~= %i!', ...
        numel(noise_out), numel(noise_in));
end

%% 
% load struct files

[substrate, plant, substrate_network, plant_network, ...
 substrate_network_min, substrate_network_max, ...
 plant_network_min, plant_network_max]= ...
          load_biogas_mat_files(plant_id);
          

%%
% load biogas plant

fcn= ['plant_', plant_id];

load_biogas_system(fcn, parallel, nWorker);


%%

n_fermenter= plant.getNumDigestersD();

% set the seed of rand
%rand('seed', clock()*clock()');
% see help "updating your random number generator syntax"
s= RandStream('mcg16807','Seed', clock()*clock()');
RandStream.setDefaultStream(s);


%%
%
% cutter is a row vector
% for each sample time a different cutter row vector is needed
cutter_array= zeros(numel(sample_times), n_simulations);

%%

for isim= 1:n_simulations

  %%
  % create volumeflow files
  
  varname1= sprintf('dataset_%ih_%in', sample_times{1}, 1 - 1);

  createSubstrateFeedsForStateEstimation(substrate, ...
                 substrate_network_min, substrate_network_max, ...
                 plant, plant_network, plant_network_min, plant_network_max, ...
                 timespan, varname1);

  %%
  %

  fprintf('Start Simulation %i of %i\n', isim, n_simulations);

  try
    sim(fcn, timespan);
  catch ME
    warning('sim:error', 'sim failed!');
    disp(ME.message);
    
    %%
    % relax the solver
    
    %% TODO
    % wird bei aufruf von sim die init_biogas_mdl aufgerufen?
    % dann bringt das hier nichts
    
    if(0) %TODO
      set_solver(1e-4, 1e-6, min(cell2mat(sample_times))/24); 

      try
        sim(fcn, timespan);
      catch ME
        warning('sim:error', 'sim failed!');
        disp(ME.message);

        %%
        % adapt stuff



        %%

        continue;
      end
    else
      continue;
    end
    
  end

  %%
  %

  try
    sensors= evalinMWS('sensors');
  catch ME
    rethrow(ME);
  end

  %%
  %

  for idigester= 1:n_fermenter

    fermenter_id= char(plant.getDigesterID(idigester));

    %%
    
    for isample= 1:numel(sample_times)

      %%
      
      %for inoise= 1:size(noise_out,2)
      for inoise= 1:2
        
        noisy= logical(inoise - 1);

        %% 
        % data in streamtemp is measured in default ADM units, thus most of
        % the time kgCOD/m^3
        [datatemp, streamtemp]= ...
            createDataSetForPredictor(sensors, plant, fermenter_id, ...
                                      sample_times{isample}, ...
                                      0, [0 0 0 0], [], [], noisy, true);
                                    ...noise_in{inoise}, noise_out{inoise});

        %%
        % load already existing data, if it is existent from previous
        % simulations 
        % in this file all needed measurement data is saved for all
        % digesters, thus only when idigester == 1 it needs to be loaded
        varname1= sprintf('dataset_%ih_%in', sample_times{isample}, inoise - 1);

        if idigester == 1
          if exist(sprintf('%s.mat', varname1), 'file')
            [dataset]= load_file(varname1);
            eval(sprintf('%s= dataset;', varname1));
          else
            eval(sprintf('%s= [];', varname1));
          end
        end

        %%
        % load already existing data, if it is existent from previous
        % simulations 
        
        varname2= sprintf('streams_%ih', sample_times{isample});

        % this file is independent of noise, thus does not contain noisy
        % values
        if idigester == 1 && inoise == 1
          if exist(sprintf('%s.mat', varname2), 'file')
            [streams]= load_file(varname2);
            eval(sprintf('%s= streams;', varname2));
          else
            for idigester2= 1:n_fermenter
              fermenter_id2= char(plant.getDigesterID(idigester2));
              eval(sprintf('%s.%s= [];', varname2, fermenter_id2));
            end
          end
        end

        %%

        %% TODO
        % why is this in a try catch?
        
        try
          size_dataset_2= eval( sprintf('size(%s, 2)', varname1) );

          isempty_dataset= eval( sprintf('isempty(%s)', varname1) );
        catch ME
          size_dataset_2= size(datatemp, 2);
          isempty_dataset= 0;
        end

        size_streams_2= ...
            eval( sprintf('size(%s.%s, 2)', varname2, fermenter_id) );

        isempty_streams= ...
            eval( sprintf('isempty(%s.%s)', varname2, fermenter_id) );


        %%

        if ( size_dataset_2 == size(datatemp, 2) && ...
                 ...size(ys.(fermenter_id), 2) == size(ytemp, 2) && ...
             size_streams_2 == size(streamtemp, 2) ) || ...
             isempty_dataset || isempty_streams 
             %s.(fermenter_id))   

          %datasets.(fermenter_id)= [datasets.(fermenter_id); datatemp];
          if idigester == 1

              eval(sprintf('%s= [%s; datatemp];', varname1, varname1));

              save(sprintf('%s.mat', varname1), varname1);
              
              %%
        
              size_dataset_1= eval( sprintf('size(%s, 1)', varname1) );

              cutter_array(isample, isim)= size_dataset_1;

              %%

              eval(sprintf('clear %s;', varname1));

          end

          %ys.(fermenter_id)= [ys.(fermenter_id); ytemp];  

          if inoise == 1
              eval(sprintf('%s.%s= [%s.%s; streamtemp];', ...
                  varname2, fermenter_id, varname2, fermenter_id));
          end

          %streams_1h.(fermenter_id)= [streams_1h.(fermenter_id); streamtemp];

        end

      end

    end

  end

  %%

  for isample= 1:numel(sample_times)

    varname= sprintf('streams_%ih', sample_times{isample});

    save(sprintf('%s.mat', varname), varname);
    
  end
  
  %%
    
end

%%

for isample= 1:numel(sample_times)
    
  cutter= cutter_array(isample, :);
  
  %%
  % if a simulation was cancelled, then cutter contains a 0 at that
  % position, delete this cell
  
  cutter(cutter == 0)= [];

  %%

  cutter_filename= sprintf('cutter_%ih.mat', sample_times{isample});

  if exist(cutter_filename, 'file')
    mycutter= load_file(cutter_filename);
    mycutter= [mycutter, cutter];
    cutter= mycutter;
  end

  %%

  save( cutter_filename, 'cutter' );

end

%%
%

close_biogas_system(fcn);


%%
% filter data for complete outliers

for isample= 1:numel(sample_times)

  %%
  % filter dataset
  
  %for inoise= 1:size(noise_out,2)
  for inoise= 1:2
        
    varname1= sprintf('dataset_%ih_%in', sample_times{isample}, inoise - 1);

    [dataset]= load_file(varname1);
  
    for i= 1:size(dataset, 2)

      try
        dataset(:,i)= filterData(dataset(:,i), [], [], 7);
      catch ME
        disp(ME.message);
      end
      
    end
    
    eval(sprintf('%s= dataset;', varname1));
    
    save(sprintf('%s.mat', varname1), varname1);

  end
  
  %%
  
  %%
  % filter stream data
  
  varname= sprintf('streams_%ih', sample_times{isample});

  %%
  
  [streams]= load_file(varname);
  
  %%
  
  for idigester= 1:plant.getNumDigestersD()
  
    fermenter_id= char(plant.getDigesterID(idigester));
    
    for i= 1:size(streams.(fermenter_id), 2)
    
      try
        streams.(fermenter_id)(:,i)= filterData(streams.(fermenter_id)(:,i), [], [], 7);
      catch ME
        disp(ME.message);
      end
      
    end
    
    eval(sprintf('%s= streams;', varname));
    
    save(sprintf('%s.mat', varname), varname);

  end
  
end

%%
%

toc

%%
%

varargout{1}= [];

%%


