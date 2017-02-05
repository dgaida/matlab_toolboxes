%% NMPC_check_plant_network_bounds
% Check boundaries plant_network_min/max for validity
%
function NMPC_check_plant_network_bounds(plant_network_min, plant_network_max, ...
  plant_network_min_limit, plant_network_max_limit, plant, plant_network)
%% Release: 1.3

%%

narginchk(6, 6);
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check params

is_plant_network(plant_network_min, 1, plant);
is_plant_network(plant_network_max, 2, plant);
is_plant_network(plant_network_min_limit, 3, plant);
is_plant_network(plant_network_max_limit, 4, plant);
is_plant(plant, 5);
is_plant_network(plant_network, 6, plant);

%%



%% 
% for loop should be replaced by any(any( plant_network_max >
% plant_network_max_limit )) ...
% for loop wird genutzt, damit fehlermeldung richtig ausgegeben werden
% kann, halt für jedes substrat einzeln

[nSplits, digester_splits, digester_indices]= ...
     getNumDigesterSplits(plant_network, plant_network_max, plant);

%%

for isplit= 1:nSplits     

  ifermenterOut= digester_indices(isplit,1);
  ifermenterIn=  digester_indices(isplit,2);

  % Fermenter Names for Output_Input  
  fermenter_id_out_in= digester_splits{isplit};         

  % Fermenter name 
  vname1= sprintf('volumeflow_%s_const', fermenter_id_out_in);

  % Fermenter Max Limit
  if any( plant_network_max(ifermenterOut, ifermenterIn) > ...
          plant_network_max_limit(ifermenterOut, ifermenterIn) )
    warning('NMPC:fermenterflowUB', ...
           ['The ', vname1, ' is over the maximum permited limit: %i > %i!'], ...
           plant_network_max(ifermenterOut, ifermenterIn), ...
           plant_network_max_limit(ifermenterOut, ifermenterIn));
  end

  % Fermenter Min Limit 
  if any( plant_network_min(ifermenterOut, ifermenterIn) < ...
          plant_network_min_limit(ifermenterOut, ifermenterIn) )
    warning('NMPC:fermenterflowLB', ...
           ['The ', vname1, ' is under the minimum permited limit: %i < %i!'], ...
           plant_network_min(ifermenterOut, ifermenterIn), ...
           plant_network_min_limit(ifermenterOut, ifermenterIn));
  end

end % for

clear vname1 ifermenterIn ifermenterOut fermenter_id_out_in % clear temp variables

%%



%%


