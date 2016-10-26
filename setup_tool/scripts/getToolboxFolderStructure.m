%% getToolboxFolderStructure
% Get the structure of the m-files containing folders of the toolbox.
%
function rel_path_m= getToolboxFolderStructure(tool_path)
%% Release: 1.7

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check input parameter

if ~ischar(tool_path)
  error(['The 1st parameter tool_path must be a ', ...
         '<a href="matlab:doc(''char'')">char</a>, but is a ', ...
         '<a href="matlab:doc(''%s'')">%s</a>!'], ...
         class(tool_path), class(tool_path));
end

%%

folderList= getAllSubfolders(tool_path);

%%

rel_path_m= {''};

%%
% damit rel_path unten ohne führenden filesep gespeichert wird

if ~strcmp(tool_path(end), filesep)
  tool_path= [tool_path, filesep];
end

%%

for ifolder= 1:numel(folderList)
  
  %%
  
  if exist(fullfile(folderList{ifolder}, 'InPath.txt'), 'file')
    
    rel_path= strrep(folderList{ifolder}, tool_path, '');
    
    rel_path_m= [rel_path_m, {rel_path}];
    
  end
  
  %%
  
end

%%


