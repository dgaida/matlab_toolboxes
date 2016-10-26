%% rename_volumeflow_files
% Rename volumeflow files, adds, replaces or deletes write_ids. 
%
function rename_volumeflow_files(plant_id, id_old, id_new, varargin)
%% Release: 1.3

%%

error( nargchk(3, 6, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% read out varargin

if nargin >= 4 && ~isempty(varargin{1})
  do_backup= varargin{1};
  is0or1(do_backup, 'do_backup', 4);
else
  do_backup= 0;
end

if nargin >= 5 && ~isempty(varargin{2})
  flow_type= varargin{2};
  % check argument
  is_volumeflow_type(flow_type, 5);
else
  flow_type= 'user';
end

if nargin >= 6 && ~isempty(varargin{3})
  keep_orgs= varargin{3};
  is0or1(keep_orgs, 'keep_orgs', 6);
else
  keep_orgs= 0;
end

%%

checkArgument(plant_id, 'plant_id', 'char', '1st');

if ~isempty(id_old)
  isN(id_old, 'id_old', 2);
end

if ~isempty(id_new)
  isN(id_new, 'id_new', 3);
end

%%

[substrate, plant, plant_network, plant_network_max]= ...
  load_biogas_mat_files(plant_id, [], ...
  {'substrate', 'plant', 'plant_network', 'plant_network_max'});

%%

if ~isempty(id_old)
  filename_pat_old= ['volumeflow_%s_', flow_type, '_', int2str(id_old), '.mat'];
else
  filename_pat_old= ['volumeflow_%s_', flow_type, '.mat'];
end

if ~isempty(id_new)
  filename_pat_new= ['volumeflow_%s_', flow_type, '_', int2str(id_new), '.mat'];
else
  filename_pat_new= ['volumeflow_%s_', flow_type, '.mat'];
end

%%

for isubstrate= 1:substrate.getNumSubstratesD()
  
  %%
  
  substrate_id= char(substrate.getID(isubstrate));
  
  %%
  
  filename_old= sprintf(filename_pat_old, substrate_id);
  filename_new= sprintf(filename_pat_new, substrate_id);
  
  %%
  
  if do_backup
    
    copyfile(filename_old, [filename_old, '_copy']);
    
  end
  
  %%
  % rename file
  
  if keep_orgs
    copyfile(filename_old, filename_new);
  else
    movefile(filename_old, filename_new);
  end
  
  %%
  
end

%% 
% sludge files

[nSplits, digester_splits]= getNumDigesterSplits(plant_network, ...
                                                 plant_network_max, plant);

%%

for isplit= 1:nSplits
  
  %%
  
  fermenter_id_out_in= digester_splits{isplit};
  
  %%
  
  filename_old= sprintf(filename_pat_old, fermenter_id_out_in);
  filename_new= sprintf(filename_pat_new, fermenter_id_out_in);
  
  %%
  
  if do_backup
    
    copyfile(filename_old, [filename_old, '_copy']);
    
  end
  
  %%
  % rename file
  
  if keep_orgs
    copyfile(filename_old, filename_new);
  else
    movefile(filename_old, filename_new);
  end
  
  %%
  
end

%%



%%


