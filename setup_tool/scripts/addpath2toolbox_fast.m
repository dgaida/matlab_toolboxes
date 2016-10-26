%% addpath2toolbox_fast
% Add paths of toolbox to MATLAB path reading 'path_install.txt'
%
function err_flag= addpath2toolbox_fast(bibpath)
%% Release: 1.5

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

if exist('checkArgument', 'file') == 2
  % if path to script_collection tool is not yet set, then this function is
  % not known
  checkArgument(bibpath, 'bibpath', 'char', '1st');
else
  if ~ischar(bibpath)
    error(['The 1st parameter bibpath must be a ', ...
           '<a href="matlab:doc(''char'')">char</a>, but is a ', ...
           '<a href="matlab:doc(''%s'')">%s</a>!'], ...
           class(bibpath), class(bibpath));
  end
end

err_flag= 0;

%%
% get data from file 'path_install.txt'

try
  paths2tool= importdata(fullfile(bibpath, 'path_install.txt'));
catch ME
  fprintf('Error importing data of file %s!\n', fullfile(bibpath, 'path_install.txt'));
   
  err_flag= -1;
  return;
  %rethrow(ME);
end

%%
% concatenate paths by pathsep if paths2tool is a cellstr
% it is a cell string if paths in file are written line by line
% in the new toolbox versions it is written in one file delimited by ;, so
% this is only to work with both kind of files

if iscellstr(paths2tool)
  
  paths_cell= paths2tool;
  
  paths2tool= [];
  
  for iel= 1:numel(paths_cell)
    
    paths2tool= [paths2tool, paths_cell{iel}, pathsep];
    
  end
  
end


%%
% erzeuge eine Warnung um alte zu löschen, da 3 Zeilen
% später auf eine Warnung geprüft wird, die von addpath
% erzeugt wird 
lastwarn('');

%%

addpath(paths2tool); % könnte die Warnung werfen: 
% Warning: Name is nonexistent or not a directory
% passiert genau dann nach der erzeugung der hilfe der toolbox, da dann rn
% und help_mfiles ordner gelöscht werden. und diese sind noch in
% path_install.txt eingetragen. in dem fall wird dann unten err_flag= -1
% gesetzt, damit erzwungen wird, dass path_install.txt neu geschrieben wird

%%

[warnmsg, msgid]= lastwarn;

%%
% I use || because there might come other warnings, e.g. if
% 'path_install.txt' is corrupted. then it has to be created anew as well. 

if ~isempty(warnmsg) || strcmp(msgid, 'MATLAB:dispatcher:pathWarning')
  
  err_flag= -1;
  return;
  
end

%%


