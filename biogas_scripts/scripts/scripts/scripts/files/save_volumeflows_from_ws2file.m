%% save_volumeflows_from_ws2file
% Save volumeflow variables existing in workspace to mat file
%
function save_volumeflows_from_ws2file(plant_id, vol_type, varargin)
%% Release: 1.3

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% read out varargin

%% TODO
% maybe add write_id as further parameter

if nargin >= 3 && ~isempty(varargin{1})
  do_backup= varargin{1};
  is0or1(do_backup, 'do_backup', 3);
else
  do_backup= 0;
end

if nargin >= 4 && ~isempty(varargin{2})
  mypath= varargin{2};
  checkArgument(mypath, 'mypath', 'char', 4);
else
  mypath= pwd;
end

%%
% check arguments

is_plant_id(plant_id, '1st');
is_volumeflow_type(vol_type, 2);

%%

[substrate]= ..., plant, plant_network, plant_network_max]= ...
  load_biogas_mat_files(plant_id, [], ...
  {'substrate'});..., 'plant', 'plant_network', 'plant_network_max'});

%%

varname_pat= ['volumeflow_%s_', vol_type];
filename_pat= ['volumeflow_%s_', vol_type, '.mat'];

%%

for isubstrate= 1:substrate.getNumSubstratesD()
  
  %%
  
  substrate_id= char(substrate.getID(isubstrate));
  
  %%
  
  varname= sprintf(varname_pat, substrate_id);
  
  %%
  % load from workspace - get volumeflow
  
  try
    var= evalin('base', varname);
  catch ME
    disp(ME.message);
    
    continue;
  end
  
  %%
  
  filename= fullfile(mypath, sprintf(filename_pat, substrate_id));
  
  %%
  
  if do_backup
    
    if exist(filename, 'file')
      copyfile(filename, [filename, '_copy']);
    end
    
  end
  
  %%
  % create file
  
  try
    save_varname(var, varname, filename, 0);
  catch ME
    disp(ME.message);
  end
  
  %%
  
end

%%


