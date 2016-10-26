%% get_volumeflows_at_time
% Get volumeflows of plant at time t out of volumeflow variables or files
%
function vflows= get_volumeflows_at_time(t, plant_id, vol_type, varargin)
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

substrate= load_biogas_mat_files(plant_id);

%%
% get volumeflows out of file or workspace

volumeflows= get_volumeflows_from(substrate, vol_type, accesstofile);

%%

fields= fieldnames(volumeflows);

vflows= zeros(numel(fields), 1);

%%

for iel= 1:numel(fields)

  %%
  
  [time, index]= get_nearest_el_in_vec(volumeflows.(fields{iel})(1,:), t, 'abs');
  
  %%
  
  vflows(iel)= volumeflows.(fields{iel})(2,index);
  
end

%%



%%


