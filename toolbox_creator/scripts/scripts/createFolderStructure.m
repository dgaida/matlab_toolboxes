%% createFolderStructure
% Create folder structure of new toolbox
%
function tool_folder= createFolderStructure(toolbox_id, toolbox_version)
%% Release: 0.3

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check input arguments

checkArgument(toolbox_id, 'toolbox_id', 'char', '1st');
checkArgument(toolbox_version, 'toolbox_version', 'char', '2nd');

%%

% if exist('new_toolbox', 'dir')
%   rmdir('new_toolbox', 's');
% end

if ~exist('new_toolbox', 'dir')
  mkdir('new_toolbox'); % inside this folder the nwe toolbox is created
end

% falls alter Ordner noch existiert, dann löschen
if exist(fullfile('new_toolbox', [toolbox_id, '_', toolbox_version]), 'dir')
  rmdir( fullfile('new_toolbox', [toolbox_id, '_', toolbox_version]), 's' );
end

% falls nicht existiert, dann neu erstellen, da das schon mal scheitern
% kann, wird das wiederholt bis es klappt
if ~exist(fullfile('new_toolbox', [toolbox_id, '_', toolbox_version]), 'dir')
  s= 0;
  while(~s)
    try
      [s, mess, messid]= mkdir('new_toolbox', [toolbox_id, '_', toolbox_version]);
    catch ME
      
    end
  end
end

%% 

tool_folder= fullfile('new_toolbox', [toolbox_id, '_', toolbox_version]);


%%
% help

if ~exist(fullfile(tool_folder, 'help'), 'dir')
  mkdir(tool_folder, 'help');
end
if ~exist(fullfile(tool_folder, 'help', toolbox_id), 'dir')
  mkdir(fullfile(tool_folder, 'help'), toolbox_id);
end
if ~exist(fullfile(tool_folder, 'help', toolbox_id, 'html'), 'dir')
  mkdir(fullfile(tool_folder, 'help', toolbox_id), 'html');
end


%%
% copy template folder inside new toolbox

copyfile(fullfile('templates', 'doc_files'), ...
         fullfile('new_toolbox', [toolbox_id, '_', toolbox_version], ...
                  'help', toolbox_id, 'html', 'doc_files'));

%%


