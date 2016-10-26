%% get_initstate_dig_oo_equilibrium
% Create initstate file out of equilibrium, only digester user states are
% affected
%
function initstate= get_initstate_dig_oo_equilibrium(equilibrium, initstate, varargin)
%% Release: 1.6

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%% 
% Input Initialization

if nargin >= 3 && ~isempty(varargin{1})
  plant_id= varargin{1};
  checkArgument(plant_id, 'plant_id', 'char', 3);
else
  plant_id= [];
end

if nargin >= 4 && ~isempty(varargin{2})
  id_write= varargin{2};
  isN0(id_write, 'id_rw', 4);
  
  if isempty(plant_id)
    warning('varargin:obsoleteParam', 'Param id_write is not used, because plant_id is empty!');
  end
else
  id_write= [];
end

%%
% check params

is_equilibrium(equilibrium, 1);
is_initstate(initstate, 2);


%% 
% 
fields= fieldnames(initstate.fermenter);

for ifield= 1:numel(fields)
  % Select fermenter name independent of model structure
  fermenter_id= fields{ifield}; 

  % write inside initstate.fermenter.(fermenter_id).user latest state
  initstate.fermenter.(fermenter_id).user= equilibrium.fermenter.(fermenter_id).x0;
end

clear ifield

%%

if ~isempty(plant_id)
  
  %% 
  % Write Initial State / id_write
  if ~isempty(id_write)
    save ( ['initstate_', plant_id, sprintf('_%i', id_write)] , 'initstate' ); % latest state index '_%i'  
  else
    save ( ['initstate_', plant_id] , 'initstate' ); % original state
  end

end

%%


