%% setInitStateInWorkspace
% Read the initial states out of equilibrium and set them in the
% selected workspace.
%
function setInitStateInWorkspace(equilibrium, plant, plant_network, ...
                                 initstate_type_hydraulic_delay, varargin)
%% Release: 1.3

%%

error( nargchk(4, 5, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% read out varargin

if nargin >= 5 && ~isempty(varargin{1}), 
  accesstofile= varargin{1}; 
  isZ(accesstofile, 'accesstofile', 5, -1, 1);
else
  accesstofile= -1; 
end

%%
% check input params

is_equilibrium(equilibrium, '1st');
is_plant(plant, '2nd');
is_plant_network(plant_network, 3, plant);

validatestring(initstate_type_hydraulic_delay, {'default', 'user'}, ...
               mfilename, 'initstate_type_hydraulic_delay', 4);


%%

plant_id= char(plant.id);


%% 
% setInitStateInWorkspace for digesters. updates the initstate variable or
% file with the equilibrium values for digesters

change_initstate_oo_equilibrium(equilibrium, plant_id, accesstofile);


%% 

[nRecirculations, digester_recirculations]= getNumRecirculations(plant_network, plant);

%%
% for hydraulic delays
%
for ireci= 1:nRecirculations

  %%
  
  fermenter_out_in= digester_recirculations{ireci};
  
  %%
  
  try

    createinitstatefile(initstate_type_hydraulic_delay, plant_id, ...
      'hydraulic_delay', fermenter_out_in, ...
      equilibrium.hydraulic_delay.( fermenter_out_in ).x0, accesstofile);

  catch ME
    rethrow(ME);
  end

end


%%
    

    