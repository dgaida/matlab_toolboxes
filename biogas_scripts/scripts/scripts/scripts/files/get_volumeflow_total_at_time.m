%% get_volumeflow_total_at_time
% Get total substrate feed of plant at given time t
%
function Qtot= get_volumeflow_total_at_time(t, plant_id, vol_type, varargin)
%% Release: 1.3

%%

error( nargchk(3, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 4 && ~isempty(varargin{1}), 
  accesstofile= varargin{1}; 
  % -1 would throw an error in get_volumeflows_from (MWS)
  isZ(accesstofile, 'accesstofile', 4, -1, 1);
else
  accesstofile= 1; 
end

%%
% check arguments

isR(t, 't', 1);
is_plant_id(plant_id, '2nd');
is_volumeflow_type(vol_type, 3);

%%

vflows= get_volumeflows_at_time(t, plant_id, vol_type, accesstofile);

%%

Qtot= sum(vflows);

%%


