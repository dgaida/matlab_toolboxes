%% NMPC_save_ctrl_strgy_SubstrateFlow
% Save control strategy substrate flow of nonlinearMPC function
%
function [substrate_network_min, substrate_network_max]= ...
          NMPC_save_ctrl_strgy_SubstrateFlow(varargin)
%% Release: 1.4

%%

error( nargchk(7, 7, nargin, 'struct') );
error( nargoutchk(2, 2, nargout, 'struct') );

%%
% Input Initialization

substrate=             varargin{1};
plant=                 varargin{2};
substrate_network_min= varargin{3};
substrate_network_max= varargin{4};
equilibrium=           varargin{5};
control_horizon=       varargin{6};
nSteps=                varargin{7};

%% TODO - OK
% as control_horizon, nSteps and delta are connected, you do not have to
% pass all three parameters, two should be enough, the 3rd should be
% calculated 
% maybe write a little function calcSteps(control_horizon, delta)... and
% call it here and everywhere else
            

%%
% check params

is_substrate(substrate, '1st');
is_plant(plant, '2nd');
is_substrate_network(substrate_network_min, 3, substrate, plant);
is_substrate_network(substrate_network_max, 4, substrate, plant);
is_equilibrium(equilibrium, 5);

isR(control_horizon, 'control_horizon', 6, '+');
isN(nSteps, 'nSteps', 7);

delta=    fix(control_horizon/nSteps); 

lenGenomSubstrate= nSteps;

%% TODO - DOES NOT seem to be needed?!
% Must be passed as a parameter

lenGenomPump= 1;


%% 
% Auxiliary variables 

n_substrate= substrate.getNumSubstratesD();   % nº of substrates
n_fermenter= plant.getNumDigestersD();        % nº of fermenters

%% 
%

% save the CONTROL STRATEGY for the substrates
% matrix with n_substrate rows and lenGenomSubstrate columns
% thus in first row there is the user substrate feed of the first
% substrate, ...
% here it is just the first column thus the first value
u_vflw= get_feed_oo_equilibrium(equilibrium, substrate, plant, ...
                                'const_first', lenGenomSubstrate);

%% 
% NEW SUBSTRATE FLOW
% the current input vector (substrate flow/fermenter flow) to the current
% optimal one (use equilibrium structure).

% Substrate vector -> Substrate matrix 
for isubstrate = 1:n_substrate
  
  %%
  
  for ifermenter = 1:n_fermenter
    % current substrate flow from optimization 
    substrate_network_max(isubstrate, ifermenter)= ...
    equilibrium.network_flux(1, 1 + (isubstrate - 1) * lenGenomSubstrate + ...
                                (ifermenter - 1) * n_substrate * lenGenomSubstrate);

    substrate_network_min(isubstrate, ifermenter)= ...
    equilibrium.network_flux(1, 1 + (isubstrate - 1) * lenGenomSubstrate + ...
                                (ifermenter - 1) * n_substrate * lenGenomSubstrate);
  end

  %% 
  % save the CONTROL STRATEGY for the Volumeflow saving
  substrate_id= char(substrate.getID(isubstrate));

  %% 
  % Load the 'volumeflow_substrate_id_user' if exists in the 'caller'
  
  try
    % This routine loads a 'filename.mat' and saves the data with the
    % same 'filename' string in workspace
    vname= sprintf( 'volumeflow_%s_user', substrate_id ); 
    vdata= evalin( 'caller', vname );

    %eval( sprintf('%s=%s;', vname1, 'vdata1') );
  catch ME
    ME.message;
    vdata= [];
  end

  %%
  
  vdata= NMPC_append2volumeflow_user(vdata, u_vflw(isubstrate), delta);

  %%
  % save Variable to caller workspace      

  assignin('caller', vname, vdata );

  %%
  
end

%%

clear ifermenter isubstrate % clear temp variables  
    
%%


