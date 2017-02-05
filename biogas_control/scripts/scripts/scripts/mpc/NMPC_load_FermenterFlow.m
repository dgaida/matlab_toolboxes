%% NMPC_load_FermenterFlow
% Load fermenter flow & max/min of startNMPC function
%
function [plant_network_min, plant_network_max]= ...
          NMPC_load_FermenterFlow(varargin)
%% Release: 1.5

%%

error( nargchk(4, 5, nargin, 'struct') );
error( nargoutchk(2, 2, nargout, 'struct') );

%%
% Input Initialization

plant=             varargin{1};
plant_network=     varargin{2};
plant_network_min= varargin{3};
plant_network_max= varargin{4};

if nargin >= 5 && ~isempty(varargin{5})
  id_read= varargin{5};
  
  isN0(id_read, 'id_read', 5);
else
  id_read= [];
end

%%
% check params

is_plant(plant, '1st');
is_plant_network(plant_network, 2, plant);
is_plant_network(plant_network_min, 3, plant);
is_plant_network(plant_network_max, 4, plant);

%% 
% FERMENTER FLOW

[nSplits, digester_splits, digester_indices]= ...
       getNumDigesterSplits(plant_network, plant_network_max, plant);
        
%%

for isplit= 1:nSplits     

  %%
  
  ifermenterOut= digester_indices(isplit,1);
  ifermenterIn=  digester_indices(isplit,2);

  % Fermenter Names for Output_Input  
  fermenter_id_out_in= digester_splits{isplit};         

  % This routine loads a 'filename.mat' and saves the data with the
  % same 'filename' string in workspace 

  % Read Out original Substtrate feed from volumeflow_'fermenter_id'_const.mat
  if ~isempty(id_read)
    % latest volumeflow index '_%i'
    vdata1= load_file( sprintf('volumeflow_%s_const_%i', ...
            fermenter_id_out_in, id_read) ); 
  else
    vdata1= load_file( sprintf('volumeflow_%s_const', ...
            fermenter_id_out_in) ); % original volumeflow
  end

  %%

  %assignin( 'caller', sprintf('volumeflow_%s_const', fermenter_id_out_in), vdata1)

  %%
  % Current fermenter flow -> i.e. cell: FERMENTER FLOW MAX/MIN
  plant_network_min(ifermenterOut, ifermenterIn)= min( vdata1(2,:) );
  plant_network_max(ifermenterOut, ifermenterIn)= max( vdata1(2,:) );

end    

%%
% clear temp variables
clear vdata1 ifermenterIn ifermenterOut fermenter_id_out_in 

%%


