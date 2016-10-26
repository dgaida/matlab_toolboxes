%% createStateEstimator
% Create a State Estimator using Machine Learning methods learned by
% extensive simulations.
%
function createStateEstimator(plant_id, varargin)
%% Release: 1.1

%%

error( nargchk(1, 10, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% read out varargin

checkArgument(plant_id, 'plant_id', 'char', '1st');

%%

if nargin >= 2 && ~isempty(varargin{1})
  parallel= varargin{1};
  validatestring(parallel, {'none', 'multicore', 'cluster'}, mfilename, 'parallel', 2);
else
  parallel= 'none'; 
end

if nargin >= 3 && ~isempty(varargin{2})
  nWorker= varargin{2};
  isN(nWorker, 'nWorker', 3);  
else
  nWorker= 2;
end

if nargin >= 4 && ~isempty(varargin{3}), 
  nSimulations= varargin{3}; 
  isN(nSimulations, 'nSimulations', 4);  
else
  nSimulations= 7; % 
end

if nargin >= 5 && ~isempty(varargin{4}), 
  timespan= varargin{4};
  checkArgument(timespan, 'timespan', 'double', 5);
else
  timespan= [0 950]; % in days
end

if nargin >= 6 && ~isempty(varargin{5})
  methods= varargin{5};
  checkArgument(methods, 'methods', 'cellstr', 6);
else
  methods= {'RF'};
end

if nargin >= 7 && ~isempty(varargin{6})
  do_shutdown= varargin{6};
  is0or1(do_shutdown, 'do_shutdown', 7);
else
  do_shutdown= 0;
end

if nargin >= 8 && ~isempty(varargin{7})
  mail_address= varargin{7};
  checkArgument(mail_address, 'mail_address', 'char || cellstr', 8);
else
  mail_address= [];
end

if nargin >= 9 && ~isempty(varargin{8})
  tasks= varargin{8};
  checkArgument(tasks, 'tasks', 'cellstr', 9);
else
  tasks= {'sim', 'estimate'};
end

if nargin >= 10 && ~isempty(varargin{9}), 
  sample_times= varargin{9}; 
  checkArgument(sample_times, 'sample_times', 'cell', 10);
else
  %sample_times_s= {'1h', '2h', '12h', '24h'};
  % sampling times used in createDataSetForPredictor, measured in hours
  sample_times= {6};
end

%%

find_entry= @(mytasks, entry) find(~cellfun('isempty', regexp(mytasks, entry)));

%%
% letzter Parameter noise_in wird auf jedes Substrat angewendet und jede
% recirculation. Skalar. 

if find_entry(tasks, 'sim')

  %%
  % if nSimulations > 20, then split the number of simulations and run the
  % method in a for loop. wenn matlab abstürzt oder heap memory error, dann
  % sind je 20 Simulationen zumindest gerettet
  % if nSimulations= 21, then sims= [20; 1]
  
  fac= nSimulations/20;
  sims= 20.*ones(ceil(fac),1);
  % number of simulations in an array
  sims(ceil(fac),1)= sims(ceil(fac),1) - 20*(ceil(fac) - fac);
  
  fprintf('Doing the total number of %i simulations in %i packages of each 20 simulations.\n', ...
    nSimulations, fac);
  
  for isim= 1:numel(sims)
  
    simBiogasPlantForPrediction(plant_id, parallel, nWorker, sims(isim), ...
                                timespan, sample_times, {[0, 0, 0, 0]}, ...
                                {0});

  end
  
end

%%
% copy files into final versions if not yet existent

%% TODO
% muss nicht gemacht werden, da in startStateEstimation ein try catch
% steht, welche bei nicht vorhanden der complete Datensätze die von
% simBiogasPlantForPrediction erstellten Daten einliest. 

%%
% delete cutter file, when traing/testdata changes, then this file has to
% be rewritten. when we compare different methods on the same
% training/testdata again and again, then this file always has to be the
% same. 

% erste abfrage bedeutet, wenn nicht simuliert wurde, dann die datei nicht
% löschen, bspw. wenn man nur estimate machen möchte
% d.h. nur wenn simuliert wurde, datei löschen
if ~isempty(find_entry(tasks, 'sim')) && exist('cutting_points_test.mat', 'file')
  delete('cutting_points_test.mat');
end

%%
% TODO: letzten Parameter doplots wieder auf 0 setzen, OK

if find_entry(tasks, 'estimate')
  
  startStateEstimation(plant_id, parallel, nWorker, methods, sample_times, {[0, 0, 0, 0]}, ...
    0, 10); % do with 10 classes

end

%%

if ~isempty(mail_address)
  
  if ischar(mail_address)
    mail_address= {mail_address};
  end
  
  for iel= 1:numel(mail_address)
    
    if find_entry(tasks, 'estimate')

      send_email_wrnmsg(mail_address{iel}, 'State Estimator', ...
                        sprintf('State estimation finished! shutdown: %i.', do_shutdown), ...
                        'texfiles', {'*.tex'});

    else
      
      send_email_wrnmsg(mail_address{iel}, 'State Estimator', ...
                        sprintf('State estimation finished! shutdown: %i.', do_shutdown));
      
    end
    
  end
  
end

%%

if (do_shutdown)

  shutdown(120);
  
end

%%


