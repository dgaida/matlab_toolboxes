%% getRegionOfAttraction
% Get region of attraction of some (optimal) substrate feed
%
function [grid, fit_array]= getRegionOfAttraction(plant_id, equilibrium, varargin)
%% Release: 0.9

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% get further arguments

if nargin >= 3 && ~isempty(varargin{1})
  lenGenomSubstrate= varargin{1};
  
  isN(lenGenomSubstrate, 'lenGenomeSubstrate', 3);
else
  lenGenomSubstrate= 1;
end

if nargin >= 4 && ~isempty(varargin{2})
  feed_steps= varargin{2};
  
  isRn(feed_steps, 'feed_steps', 4);
else
  feed_steps= [];
end


%%
% check arguments

checkArgument(plant_id, 'plant_id', 'char', '1st');
is_equilibrium(equilibrium, '2nd');

%%
% load files

[substrate, plant, substrate_network, plant_network, ...
 substrate_network_min, substrate_network_max]= ...
                              load_biogas_mat_files(plant_id);

%fitness_params= load_file(sprintf('fitness_params_%s.mat', plant_id));
fitness_params= load_biogas_mat_files(plant_id, [], 'fitness_params');

%%

n_substrate= substrate.getNumSubstratesD();
n_digester=  plant.getNumDigestersD();

%% 
% get substrate feed out of equilibrium
% this is the substrate feed/equilibrium for which the region of attraction
% is determined

init_substrate_feed= equilibrium.network_flux;

if numel(init_substrate_feed) < n_substrate * n_digester * lenGenomSubstrate
  init_substrate_feed= ...
    reshape(init_substrate_feed(1:n_substrate * n_digester), ...
            n_substrate, n_digester);
else
  init_substrate_feed= ...
    reshape(init_substrate_feed(1:lenGenomSubstrate:n_substrate * n_digester * lenGenomSubstrate), ...
            n_substrate, n_digester);
end

% sum over digesters
init_substrate_feed= sum(init_substrate_feed, 2);


%%
% is used inside for loop, simulations are started from this state

initstate= get_initstate_outof_equilibrium(equilibrium);

%% 
% check whether the eq. substrate feed is in between substrate_min/max,
% else error

subs_min= sum(substrate_network_min, 2);
subs_max= sum(substrate_network_max, 2);

if any(subs_min > init_substrate_feed) || any(subs_max < init_substrate_feed)
  disp('LB')
  disp(subs_min)
  disp('UB')
  disp(subs_max)
  disp('substrate feed of region of attraction')
  disp(init_substrate_feed)
  
  error(['The substrate feed for which the region of attraction ', ...
         'shall be determined is out of bounds!']);
end

%%
% determine grid between substrate min/max

if isempty(feed_steps)    % set default values
  feed_steps= NaN(n_substrate, 1);
  feed_steps(1)= 5;
  feed_steps(2)= 5;
end

if numel(feed_steps) ~= n_substrate
  error('numel(feed_steps) ~= n_substrate : %i ~= %i', numel(feed_steps), n_substrate);
end

%% 
% 

feed_steps_not_nan= feed_steps(~isnan(feed_steps));
subs_min_not_nan= subs_min(~isnan(feed_steps));
subs_max_not_nan= subs_max(~isnan(feed_steps));
init_substrate_feed_not_nan= init_substrate_feed(~isnan(feed_steps));

% only two variables may be changed at the same time
if numel(feed_steps_not_nan) ~= 2
  error('numel(feed_steps_not_nan) ~= 2 : %i!', numel(feed_steps_not_nan));
end

[grid1, grid2]= meshgrid(subs_min_not_nan(1):feed_steps_not_nan(1):subs_max_not_nan(1), ...
                         subs_min_not_nan(2):feed_steps_not_nan(2):subs_max_not_nan(2));

size_grid1= size(grid1);    % is used to plot below

grid1= grid1(:);
grid2= grid2(:);
grid= [grid1, grid2];

% dimension aus fitness_params
fit_array= zeros(numel(grid1), fitness_params.nObjectives);    

%%

substrate_names= [{''}, {''}];

%%

for ifeed= 1:numel(grid1)

  %%
  % save substrate feed ifeed in volumeflow files
  
  %% 
  
  isubs= 1; % used inside for loop
  
  for isubstrate= 1:n_substrate
    
    substrate_id= char(substrate.getID(isubstrate));
  
    if ~isnan(feed_steps(isubstrate))
      createvolumeflowfile('const', grid(ifeed, isubs), substrate_id, ...
                           [], [], [], [], 1);

      substrate_names{isubs}= substrate_id;
    else
      %% TODO
      % maybe write to all substrate files which do not belong to grid a 0. 
    end
  
    isubs= isubs + 1;
    
  end
  
  %%
  % save some initial state to file, defined before this loop, because
  % state is always overwritten, to make sure we do not start from a very
  % bad state
  
  save(sprintf('initstate_%s.mat', plant_id), 'initstate');
  
  %%
  % sim biogas plant to a steady state/ save final state
  
  simBiogasPlantBasic(plant_id, [0, 750], 'on');

  %%
  % save substrate feed to file. this feed belong to equilibrium for which
  % region of attraction is determined
  % this function directly writes to all volumeflow files
  
  get_volumeflow_outof_equilibrium(plant_id, equilibrium, [], lenGenomSubstrate, 'const');
  
  %%
  % sim biogas plant to equilibrium / do not save final state
  
  [t, x, y, fitness]= simBiogasPlantBasic(plant_id, [0, 750]);

  %%  
  % collect fitness value in an array
  
  fit_array(ifeed, :)= fitness;

end

%%
% save results

save('results_RoA.mat', 'grid', 'fit_array', 'size_grid1', 'fitness_params', ...
                        'substrate_names', 'init_substrate_feed_not_nan');

%% TODO 
% make an extra function and call it here: plot_region_of_attraction

figure

%% 
% plot the stuff

X= reshape(grid(:,1), size_grid1(1), size_grid1(2));
Y= reshape(grid(:,2), size_grid1(1), size_grid1(2));

if size(fit_array, 2) == 2
  fit_vec= fit_array(:,1)*fitness_params.myWeights.w_money + fit_array(:,2);
else
  fit_vec= fit_array; % then is one dimensional
end

F1= reshape(fit_vec, size_grid1(1), size_grid1(2));

surf(X, Y, F1)

xlabel(substrate_names{1})     % names
ylabel(substrate_names{2})

view(0,90)

zlim([0 5])   % why 5?
set(gca, 'CLim', [0, 5]);

%% TODO
% that the rest is 0 is not guaranteed, depends on init_substrate_feed

title(sprintf('Region of attraction for: (%s: %f, %s: %f, rest: 0 ???)', ...
              substrate_names{1}, init_substrate_feed_not_nan(1), ...
              substrate_names{2}, init_substrate_feed_not_nan(2)));

%%


