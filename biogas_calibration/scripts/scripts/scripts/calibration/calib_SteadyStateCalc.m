%% calib_SteadyStateCalc
% Get a steady state to be able to start ADM1 parameter calibration
%         
function calib_SteadyStateCalc( plant_id, method_type, varargin) 
%% Release: 1.4

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check arguments

checkArgument(plant_id, 'plant_id', 'char', '1st');
validatestring(method_type, {'mean', 'median', 'last'}, mfilename, 'method_type', 2);

% timespan
if nargin >= 3 && ~isempty(varargin{1}), 
  timespan= varargin{1}; 
  isR(timespan, 'timespan', 3, '+');
else
  timespan= 500; % days
end

% id where to read from
if nargin >= 4 && ~isempty(varargin{2}), 
  id_read= varargin{2}; 
  isN(id_read, 'id_read', 4);
else
  id_read= []; 
end


%%
% Initialization

%%
% Load plant's data [ substrate, plant, ... ]
%
[ substrate, plant, substrate_network, plant_network, ...
 substrate_network_min, substrate_network_max, plant_network_min, ...
 plant_network_max ]= load_biogas_mat_files(plant_id);
                                
%%
% SUBSTRATE FLOW
% create volumeflow_const files in this folder and in the subfolder steadystate

create_volumeflow_const_outof_user_substrate(plant_id, method_type, id_read);

%% 
% FERMENTER FLOW
% create volumeflow_const files in this folder and in the subfolder steadystate

create_volumeflow_const_outof_user_digester(plant_id, method_type, id_read);

%%
% NEW STATES SIMULATION 
% simulate the system once at the current equilibrium to get the current
% fitness in the database, just for comparison with the final equilibrium.

% copy initstate to subfolder steadystate
copyfile( fullfile(pwd, ...
          sprintf('initstate_%s.mat', plant_id) ), fullfile(pwd, 'steadystate') );

%%
% copy fitness params file

copyfile( fullfile(pwd, ...
          sprintf('fitness_params_%s.xml', plant_id) ), fullfile(pwd, 'steadystate') );

%% 
% CHANGE FOLDER
cd ('steadystate')

%%
% the model in teh subfolder steadystate must be the ordinary model
% load substrates from file with const feed
% load recirculation from file const
% load initstate from file, user
%

fcn= ['plant_', plant_id];

% OPEN BIOGAS MODEL
load_biogas_system(fcn);

% SET SAVESTATE OF ADM1 BLOCKS
setSaveStateofADM1Blocks(fcn, 'on');

try
  sim(fcn, timespan);
catch ME
  warning('sim:failure', 'sim failed!');
  disp(ME.message);

  for imessage= 1:size(ME.cause,1)
    disp(ME.cause{imessage,1}.message);
  end
end
            
% RESET SAVESTATE OF ADM1 BLOCKS
setSaveStateofADM1Blocks(fcn, 'off');

% CLOSE BIOGAS MODEL
close_biogas_system(fcn);           


%%
% Digester States and Initial State Saving
% this function does not have to create the files digester_state_min and
% digester_state_max in the subfolder steadystate, thus the 3rd argument is
% 0.

[digester_state_min, digester_state_max]= createDigesterStateMinMax(plant_id, [], 0);

%% 
% Calib Folder
cd ..

% copy new initstate file to calibration folder
copyfile( fullfile(pwd, 'steadystate', ...
          sprintf('initstate_%s.mat', plant_id) ) , pwd );

% Saves the digester states
save ( [ 'digester_state_min_', char(plant_id) ] , 'digester_state_min' );   
save ( [ 'digester_state_max_', char(plant_id) ] , 'digester_state_max' ); 

%%

cd ('steadystate')

%%
% set min and max for substrates to substrate feed const value

[substrate_network_min, substrate_network_max]= ...
          NMPC_load_SubstrateFlow(substrate, substrate_network, plant, []);
        
% set min and max for recirculation to const values

[plant_network_min, plant_network_max]= ...
  NMPC_load_FermenterFlow( plant, plant_network, plant_network_min, ...
                           plant_network_max );        
        
%%

cd ..

%%

save ( [ 'substrate_network_min_', char(plant_id) ] , 'substrate_network_min' );   
save ( [ 'substrate_network_max_', char(plant_id) ] , 'substrate_network_max' ); 

save ( [ 'plant_network_min_', char(plant_id) ] , 'plant_network_min' );   
save ( [ 'plant_network_max_', char(plant_id) ] , 'plant_network_max' ); 

%%


