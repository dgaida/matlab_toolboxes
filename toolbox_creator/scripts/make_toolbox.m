%% make_toolbox
% Make given toolbox
%
function make_toolbox(toolbox_id, toolbox_name, toolbox_version, toolbox_path)
%% Release: 0.2

%%

error( nargchk(4, 4, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check input arguments

checkArgument(toolbox_id, 'toolbox_id', 'char', '1st');
checkArgument(toolbox_name, 'toolbox_name', 'char', '2nd');
checkArgument(toolbox_version, 'toolbox_version', 'char', '3rd');
checkArgument(toolbox_path, 'toolbox_path', 'char', 4);

%%
% 

fprintf('Start making toolbox "%s"\n', toolbox_id);

%%
% path to all toolboxes must always be 2 folders above the path of the
% toolbox, e.g.: 'H:\wissMitarbeiter\matlab_toolboxes\'
path_toolboxes= fullfile(toolbox_path, '..', '..');

%%
% add path to subfolder scripts temporarily

addpath('scripts');

%%
% Create folder structure

tool_folder= createFolderStructure(toolbox_id, toolbox_version);

%% 
% kopiert auch svn ordner mit, OK, svn Ordner werden unten wieder gelöscht

%% TODO
% dateien > 50 MB sollten nicht mit kopiert werden, muss dann anders
% implementiert werden, also alle dateien einzeln kopieren, welche in
% script liegen und jede datei einzeln prüfen.

try
  [status,message,messageid]= copyfile(fullfile(toolbox_path, 'scripts'), ...
         fullfile(tool_folder), 'f');
       
  if (~status)
    warning(messageid, message);
    
    return;
  end
catch ME
  disp(ME.message);
  warning(messageid, message);
  return;
end

%%

new_folders= getAllSubfolders(fullfile(tool_folder), [], 1);

for ifolder= 1:numel(new_folders)

  %%
  % remove svn folders
  
  folder= fdir(fullfile(new_folders{ifolder}, '**', '*'));

  for isubfolder= 1:numel(folder.folders)
    
    if ~isempty(regexp(folder.folders{isubfolder}, '.svn', 'once'))
      if exist(folder.folders{isubfolder}, 'dir')
        rmdir( folder.folders{isubfolder}, 's' );
      end
    end
  
  end
  
end

  
%%
% include templates of setup_tool

path_setup_tool= fullfile(path_toolboxes, 'setup_tool', 'trunk');

include_templates(path_setup_tool, toolbox_id, toolbox_name, toolbox_version, tool_folder);

%%
% include templates of gecoc_tool_def

path_gecoc_tool_def= fullfile(path_toolboxes, 'gecoc_tool_def', 'trunk');

include_templates(path_gecoc_tool_def, toolbox_id, toolbox_name, toolbox_version, tool_folder);

%%
% include templates of doc_tool

path_doc_tool= fullfile(path_toolboxes, 'doc_tool', 'trunk');

make_doc(path_doc_tool, toolbox_id, toolbox_name, toolbox_version, toolbox_path);

include_templates(path_doc_tool, toolbox_id, toolbox_name, toolbox_version, tool_folder);

%%
% create build txt file and save current date and time inside
% used to detect if a newer version of the toolbox is already installed

fid= efopen( fullfile(tool_folder, sprintf('build_%s.txt', toolbox_id)), 'wt' );

fprintf(fid, '%.6f\n', now);

fclose(fid);

%%

fprintf('Finished making toolbox "%s"\n', toolbox_id);

%%


