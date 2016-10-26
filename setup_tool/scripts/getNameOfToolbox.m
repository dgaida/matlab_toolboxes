%% getNameOfToolbox
% Return name of toolbox located in the pwd.
%
function toolName= getNameOfToolbox(tool_id)
%% Release: 1.8

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if ~ischar(tool_id)
  error(['The 1st parameter tool_id must be a ', ...
         '<a href="matlab:doc(''char'')">char</a>, but is a ', ...
         '<a href="matlab:doc(''%s'')">%s</a>!'], ...
         class(tool_id), class(tool_id));
end


%%

try
  
  current_path= pwd;
  
  % ab diesem Ordner ist der Klassenordner sichtbar bzw. im Pfad
  cd( fullfile(pwd, 'scripts', 'tool') );
  
  %%
  % if nothing installed yet, then the gecoc_tool class is not available.
  % then the path to the gecoc_tool_def has to be added manually to the
  % path. it is only added temporarily. 
  if ~exist('gecoc_tool', 'class')
    msgbox(['In the following dialog box for selecting a directory, ', ...
            'please specify the folder to gecoc_tool_def toolbox! ', ...
            'Example: C:\mTools\gecoc_tool_def_1.1'], ...
            'Path to gecoc_tool_def toolbox missing!');
    folder_name= uigetdir(pwd, 'Specify folder to gecoc_tool_def toolbox!');
                 
    addpath(fullfile(folder_name, 'scripts'));             
  end
  
  toolName= eval(sprintf('%s.getToolboxName()', tool_id));
  
  cd(current_path);
  
catch ME
  error('This function may only be called in the entry folder of the toolbox with the ID ''%s''!\n%s', ...
        tool_id, ME.message);
end

%%



%%


