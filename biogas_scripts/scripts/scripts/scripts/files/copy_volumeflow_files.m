%% copy_volumeflow_files
% Copy volumeflow files of given plant between two paths
%
function copy_volumeflow_files(plant_id, pathfrom, path2, varargin)
%% Release: 1.3

%%

error( nargchk(3, 6, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 4 && ~isempty(varargin{1})
  vol_type= varargin{1};
  is_volumeflow_type(vol_type, 4);
else
  vol_type= 'user';
end

if nargin >= 5 && ~isempty(varargin{2})
  id_write= varargin{2};
  isN(id_write, 'id_write', 5);
else
  id_write= [];
end

if nargin >= 6 && ~isempty(varargin{3})
  do_backup= varargin{3};
  is0or1(do_backup, 'do_backup', 6);
else
  do_backup= 0;
end

%%
% check arguments

is_plant_id(plant_id, '1st');
checkArgument(pathfrom, 'pathfrom', 'char', 2);
checkArgument(path2, 'path2', 'char', 3);

%%

substrate= load_biogas_mat_files(plant_id, [], {'substrate'});

%%

if isempty(id_write)
  filename_pat= ['volumeflow_%s_', vol_type, '.mat'];
else
  filename_pat= ['volumeflow_%s_', vol_type, '_', num2str(id_write), '.mat'];
end

%%

for isubstrate= 1:substrate.getNumSubstratesD()
  
  %%
  
  substrate_id= char(substrate.getID(isubstrate));
  
  %%
  
  filenamefrom= fullfile(pathfrom, sprintf(filename_pat, substrate_id));
  filename2= fullfile(path2, sprintf(filename_pat, substrate_id));
  
  %%
  
  if do_backup
    
    if exist(filename2, 'file')
      copyfile(filename2, [filename2, '_copy']);
    end
    
  end
  
  %%
  % create file
    
  try
    copyfile(filenamefrom, filename2);
  catch ME
    disp(ME.message);
  end
  
  %%
  
end

%%



%%


