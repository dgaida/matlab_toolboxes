%% create_sensor_network
% Create network of sensors, which are inside the simulation model
%
function sensors= create_sensor_network(varargin)
%% Release: 1.5

%%

error( nargchk(1, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 1 && ~isempty(varargin{1})
  if ischar(varargin{1})
    plant_id= varargin{1};
    
    error( nargchk(1, 1, nargin, 'struct') );
  else
    plant= varargin{1};
    is_plant(plant, '1st');
    
    error( nargchk(4, 4, nargin, 'struct') );
  end
else
  error('The first parameter may not be empty!');
end

if nargin == 4
  
  %%
  
  substrate= varargin{2};
  plant_network= varargin{3};
  plant_network_max= varargin{4};
  
  %%

  is_substrate(substrate, '2nd');
  is_plant_network(plant_network, 3, plant);
  is_plant_network(plant_network_max, 4, plant);

else
  
  [substrate, plant, substrate_network, plant_network, ...
   substrate_network_min, substrate_network_max, plant_network_min, plant_network_max]= ...
   load_biogas_mat_files(plant_id);
  
end

%%

myplannet= NET.convertArray(plant_network, 'System.Double', size(plant_network));
myplan_max= NET.convertArray(plant_network_max, 'System.Double', size(plant_network_max));

sensors= biogas.sensors.create_sensor_network(plant, substrate, ...
                                              myplannet, myplan_max);

%%

% sensors.saveAsXML(sprintf('sensors_%.xml', plant_id));

%%


