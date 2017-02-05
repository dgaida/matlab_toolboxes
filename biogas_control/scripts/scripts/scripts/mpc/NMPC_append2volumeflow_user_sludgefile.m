%% NMPC_append2volumeflow_user_sludgefile
% Get sludge volumetric flowrate out of equilibrium and appends it to
% volumeflow_..._user_1.mat file
%
function NMPC_append2volumeflow_user_sludgefile(equilibrium, substrate, ...
  plant, delta, lenGenomSubstrate, plant_network, plant_network_max, varargin)
%% Release: 1.3

%%

narginchk(7, 8);
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 8 && ~isempty(varargin{1})
  lenGenomPump= varargin{1};
  isN(lenGenomPump, 'lenGenomPump', 8);
else
  lenGenomPump= 1;
end

%%
% check params

is_equilibrium(equilibrium, '1st');
is_substrate(substrate, '2nd');
is_plant(plant, '3rd');
isR(delta, 'delta', 4, '+');
isN(lenGenomSubstrate, 'lenGenomSubstrate', 5);
is_plant_network(plant_network, 6, plant);
is_plant_network(plant_network_max, 7, plant);

%%
% get number of digester splits

[nSplits, digester_splits]= ...
       getNumDigesterSplits(plant_network, plant_network_max, plant);

%%
% get volumeflow for recycles out of equilibrium, only returns first value
% of the volumetric flowrate if there are more values over the control
% horizon (lenGenomPump > 1)
%

u_vflw= get_sludge_oo_equilibrium(equilibrium, substrate, plant, ...
                                  'const_first', lenGenomSubstrate, lenGenomPump, ...
                                  plant_network, plant_network_max);

%% 
% 

for isplit= 1:nSplits     

  %%
  % Fermenter Names for Output_Input  
  fermenter_id_out_in= digester_splits{isplit};         
  
  %%
  % load volumeflow_user file
  
  vname= sprintf( 'volumeflow_%s_user', fermenter_id_out_in ); 
  
  %% TODO
  % maybe use id_write here, or id_write + 1 ???
  
  if exist(fullfile(pwd, [vname, '_1.mat']), 'file')
    vdata= load_file([vname, '_1']);    % with or without file extension
  else
    vdata= [];
  end
  
  %%
  % append u_vflw to volumeflow_user
  
  vdata= NMPC_append2volumeflow_user(vdata, u_vflw(isplit), delta);
  
  %%
  % save volumeflow_user to file
  
  save_varname(vdata, vname, [vname, '_1']);
  
  %%

end

%%


