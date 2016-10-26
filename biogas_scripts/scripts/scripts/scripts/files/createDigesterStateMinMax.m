%% createDigesterStateMinMax
% Create digester_state_min/max files out of initstate file.
%
function varargout= createDigesterStateMinMax(plant_id, varargin)
%% Release: 1.8

%%

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%
% check params

checkArgument(plant_id, 'plant_id', 'char', '1st');

%%

if nargin >= 2 && ~isempty(varargin{1})
  id_read= varargin{1};
  isN(id_read, 'id_read', 2);
else
  id_read= [];
end

if nargin >= 3 && ~isempty(varargin{2})
  savetofile= varargin{2};
  is0or1(savetofile, 'savetofile', 3);
else
  savetofile= 1;
end

%%

try
  [substrate, plant]= load_biogas_mat_files(plant_id);
catch ME
  rethrow(ME);
end

%% 
% READ Initial State 
% Read from which initial state
if ~isempty(id_read)
  % latest state index '_%i'
  initstate= load_file(['initstate_', plant_id, sprintf('_%i', id_read)]); 
else
  initstate= load_file(['initstate_', plant_id]); % original state
end

%%

n_fermenter= plant.getNumDigestersD();

%%

digester_state_min= zeros(biogas.ADMstate.dim_state, n_fermenter);
digester_state_max= zeros(biogas.ADMstate.dim_state, n_fermenter);

%%
% Read Out Initial State from initstate_'plant_id'.mat
for ifermenter= 1:n_fermenter
  fermenter_id= char(plant.getDigesterID(ifermenter));

  if isfield(initstate.fermenter, fermenter_id)

    digester_state_min(:,ifermenter)= ...
                    initstate.fermenter.(fermenter_id).user;
    digester_state_max(:,ifermenter)= ...
                    initstate.fermenter.(fermenter_id).user;

  else

    error('%s is not a field of initstate.fermenter!', fermenter_id);

  end
end

%%

if savetofile
  %% 
  % DIGESTER STATE MAX/MIN 
  % Save latest interactions i.e. 'digester_state_max_plant'  
  save ( [ 'digester_state_min_', char(plant_id) ] , 'digester_state_min' );   
  save ( [ 'digester_state_max_', char(plant_id) ] , 'digester_state_max' );
end

%%

if nargout > 0
  varargout{1}= digester_state_min;
else
  if savetofile == 0
    error('digester_state_min/max not saved to file and not returned as variable!');
  end
end
  
if nargout > 1
  varargout{2}= digester_state_max;
end

if nargout > 2
  varargout{3}= initstate;
end

%%


