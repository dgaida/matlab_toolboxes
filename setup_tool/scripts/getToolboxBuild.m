%% getToolboxBuild
% Get build date and time of given toolbox
%
function datetime= getToolboxBuild(varargin)
%% Release: 1.8

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin == 2
  % then toolbox_id and path to toolbox are given
  toolbox_id= varargin{1};
  base_path= varargin{2};
  
  checkArgument(toolbox_id, 'toolbox_id', 'char', '1st');
  checkArgument(base_path, 'base_path', 'char', '2nd');
elseif nargin == 1
  % either toolbox or toolbox_id is given
  if ischar(varargin{1})
    toolbox_id= varargin{1};
    
    base_path= [];    % exist unten müsste dann überall im Pfad nach Datei suchen
  else
    toolbox= varargin{1};
    
    checkArgument(toolbox, 'toolbox', 'gecoc_tool', '1st');
    
    try
  
      %%
      % both functions could throw an error, when toolbox is not know, thus not
      % installed yet

      base_path= toolbox.getToolboxPath();

      toolbox_id= toolbox.getToolboxID();

    catch ME
      datetime= [];
      
      return;
    end
  end
end

%%

%%
% old toolbox versions do not have the build file yet, therefore check

filename= fullfile( base_path, sprintf('build_%s.txt', toolbox_id) );

%%

if exist(filename, 'file')

  %%
  % just get the first line
  %% 
  % ist ok, problem in install_tool gelöst, diese funktion wird gar nicht
  % aufgerufen, wenn keine version irgendeiner toolbox existiert.
  % should not use file2cell here, because this function is called by
  % install_tool, so other may not yet be installed
  content= file2cell( filename, 1 );

  %%
  % the first line contains a double number representing the date and time

  datetime= str2double(content{1});

else
  datetime= [];
end

%%



%%


