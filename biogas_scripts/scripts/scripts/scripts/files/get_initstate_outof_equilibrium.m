%% get_initstate_outof_equilibrium
% Get initstate out of given equilibrium
%
function initstate= get_initstate_outof_equilibrium(equilibrium, varargin)
%% Release: 1.5

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  plant_id= varargin{1};
  checkArgument(plant_id, 'plant_id', 'char', '2nd');
else
  plant_id= [];
end

%%

is_equilibrium(equilibrium, 1);

%%

initstate.fermenter= equilibrium.fermenter;

fields= fieldnames(initstate.fermenter);

for ifield= 1:numel(fields)
  
  % set user, default and random
  initstate.fermenter.(fields{ifield}).user= initstate.fermenter.(fields{ifield}).x0;
  initstate.fermenter.(fields{ifield}).default= double( biogas.ADMstate.getDefaultADMstate() )';
  initstate.fermenter.(fields{ifield}).random= initstate.fermenter.(fields{ifield}).x0;
  
  % remove field, which was set in line 18
  initstate.fermenter.(fields{ifield})= rmfield(initstate.fermenter.(fields{ifield}), 'x0');
  
end

%%

initstate.hydraulic_delay= equilibrium.hydraulic_delay;

fields= fieldnames(initstate.hydraulic_delay);

for ifield= 1:numel(fields)
  
  % set user and default
  initstate.hydraulic_delay.(fields{ifield}).user= initstate.hydraulic_delay.(fields{ifield}).x0;
  def_state= double( biogas.ADMstate.getDefaultADMstate() )';
  initstate.hydraulic_delay.(fields{ifield}).default= def_state(1:biogas.ADMstate.dim_stream, 1);
  
  % delete field which was created in line 36
  initstate.hydraulic_delay.(fields{ifield})= rmfield(initstate.hydraulic_delay.(fields{ifield}), 'x0');
  
end

%%

if ~isempty(plant_id)
  
  save(sprintf('initstate_%s.mat', plant_id), 'initstate');
  
end

%%


