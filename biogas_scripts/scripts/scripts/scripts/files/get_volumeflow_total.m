%% get_volumeflow_total
% Get total substrate feed into plant over a given timespan
%
function Qtot= get_volumeflow_total(timespan, plant_id, vol_type, varargin)
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

isRn(timespan, 'timespan', 1);
is_plant_id(plant_id, '2nd');
is_volumeflow_type(vol_type, 3);

%%

Qtot= zeros(1, numel(timespan));

for it= 1:numel(timespan)
  Qtot(1,it)= get_volumeflow_total_at_time(timespan(it), plant_id, vol_type, accesstofile);
end

%%


