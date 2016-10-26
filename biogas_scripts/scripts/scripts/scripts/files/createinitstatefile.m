%% createinitstatefile
% Create (edit) the initstate MAT-file using user defined entries.
%
function [initstate]= createinitstatefile(type, plant_id, unit, id, varargin)
%% Release: 1.9

%%

error( nargchk(4, 6, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check input parameters

if nargin >= 5 && ~isempty(varargin{1}), 
  user_state= varargin{1}; 
else
  user_state= []; 
end

if nargin >= 6 && ~isempty(varargin{2}), 
  accesstofile= varargin{2}; 
  isZ(accesstofile, 'accesstofile', 6, -1, 1);
else
  accesstofile= -1; 
end

%%

validatestring(type, {'random', 'default', 'user'}, mfilename, 'type', 1);
checkArgument(plant_id, 'plant_id', 'char', '2nd');
validatestring(unit, {'fermenter', 'hydraulic_delay'}, mfilename, 'unit', 3);
checkArgument(id, 'id', 'char', '4th');

%%

if strcmp(type, 'user')
  checkArgument(user_state, 'user_state', 'double', '5th');
  
  if isempty(user_state)
    error('The 5th argument user_state is empty!');
  end
end


%%
% get initstate from file, workspace or model workspace
initstate= get_initstate_from(plant_id, accesstofile);


%%

switch type

  case 'random'

    %%

    [LB, UB]= biogas.ADMstate.getBoundsForADMstate();

    LB= double(LB);
    UB= double(UB);
    
    if ( numel(LB) ~= biogas.ADMstate.dim_state ) || ...
       ( numel(UB) ~= biogas.ADMstate.dim_state )
     
      error('Either LB (%i) or UB (%i) is not of correct size: %i!', ...
            numel(LB), numel(UB), biogas.ADMstate.dim_state);
     
    end

    init_state= ...
        ones(1, biogas.ADMstate.dim_state) * diag( LB ) + ...
        rand(1, biogas.ADMstate.dim_state) * diag( UB - LB );

    init_state= init_state';


  case 'default'

    %%

    init_state= double( biogas.ADMstate.getDefaultADMstate() )';


  case 'user'

    %%

    init_state= user_state(:);

  otherwise
    
    error('Unknown type: %s!', type);

end


%%

if strcmp(unit, 'hydraulic_delay')

  init_state= init_state(1:biogas.ADMstate.dim_stream, 1);

elseif init_state(biogas.ADMstate.pos_pTOTAL, 1) == 0

  init_state(biogas.ADMstate.pos_pTOTAL, 1)= 1.0;

end


%%

initstate.(unit).(id).(type)= init_state;


%%

save_initstate_to(initstate, plant_id, accesstofile);
    
%%


