%% NMPC_save_ctrl_strgy_FermenterFlow
% Save control strategy for fermenter flow of startNMPC function
%
function [plant_network_min, plant_network_max]= ...
          NMPC_save_ctrl_strgy_FermenterFlow(varargin)
%% Release: 1.4

%%

error( nargchk(8, 8, nargin, 'struct') );
error( nargoutchk(2, 2, nargout, 'struct') );

%%
% Input Initialization

substrate=         varargin{1};
plant=             varargin{2};
plant_network=     varargin{3};
plant_network_min= varargin{4};
plant_network_max= varargin{5};
equilibrium=       varargin{6};
control_horizon=   varargin{7};
delta=             varargin{8};

%%
% check params

is_substrate(substrate, '1st');
is_plant(plant, '2nd');
is_plant_network(plant_network, 3, plant);
is_plant_network(plant_network_min, 4, plant);
is_plant_network(plant_network_max, 5, plant);

is_equilibrium(equilibrium, 6);
isR(control_horizon, 'control_horizon', 7);
isR(delta, 'delta', 8);

%% 
% Auxiliary variables 

lenGenomSubstrate= fix(control_horizon/delta);

%% 
% NEW FERMENTER FLOW
% Equilibrium structure -> current vflow

[nSplits, digester_splits, digester_indices]= ...
       getNumDigesterSplits(plant_network, plant_network_max, plant);
        
%% TODO
% erweitern für lenGenomPump anstatt 1

networkFlux= get_sludge_oo_equilibrium(equilibrium, substrate, plant, ...
                                       'const_first', lenGenomSubstrate, 1, ...
                                       plant_network, plant_network_max);

%%

for isplit= 1:nSplits     

  %%
  
  ifermenterOut= digester_indices(isplit,1);
  ifermenterIn=  digester_indices(isplit,2);

  % Fermenter Names for Output_Input  
  fermenter_id_out_in= digester_splits{isplit};         

  %%

  value= networkFlux(isplit);

  % NEW FERMENTER FLOW
  % plant_network_min und max auf aktuellen wert setzen
  plant_network_min(ifermenterOut, ifermenterIn)= value;
  plant_network_max(ifermenterOut, ifermenterIn)= value;

  %% 
  % Load the 'volumeflow_substrate_id_user' if exists in the 'caller'

  try
    % This routine loads a 'filename.mat' and saves the data with the
    % same 'filename' string in workspace
    vname= sprintf('volumeflow_%s_user', fermenter_id_out_in); 
    vdata= evalin( 'caller', vname );
  catch ME
    % do not diplay a message, therefore not using disp
    ME.message;
    vdata= [];
  end

  %% 
  % save the CONTROL STRATEGY for the Fermenter flux

  vdata= NMPC_append2volumeflow_user(vdata, value, delta);

  %%
  % save Variable to caller workspace      

  assignin( 'caller', vname, vdata );

end % for

%%

clear ifermenterIn ifermenterOut fermenter_id_out_in % clear temp variables

%%


