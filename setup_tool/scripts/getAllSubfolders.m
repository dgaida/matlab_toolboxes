%% getAllSubfolders
% Returns a cell array of strings with paths to subfolders of given folder. 
%
function folderList= getAllSubfolders(current_path, varargin)
%% Release: 1.8

%%

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin > 1 && ~isempty(varargin{1})
  rel_abs= varargin{1};
else
  rel_abs= 'abs';
end

if nargin > 2 && ~isempty(varargin{2})
  inc_svn= varargin{2};
else
  inc_svn= 0;
end

%%
% check input parameters

if ~ischar(current_path)
  error(['The 1st parameter current_path must be a ', ...
         '<a href="matlab:doc(''char'')">char</a>, but is a ', ...
         '<a href="matlab:doc(''%s'')">%s</a>!'], ...
         class(current_path), class(current_path));
end

validatestring(rel_abs, {'rel', 'abs'}, ...
               mfilename, 'rel_abs', 2);

validateattributes(inc_svn, {'double'}, ...
                   {'scalar', 'nonnegative', '<=', 1, 'integer'}, ...
                   mfilename, 'inc_svn', 3);


%%

find_entry= @(cellstring, entry) find(cellfun('isempty', regexp(cellstring, entry)));

%%

names= fdir( fullfile(current_path, '**', '*') );

%%
% nehme nicht svn Ordner
if ~inc_svn
  folders= names.folders(find_entry(names.folders, '.svn'));
else
  folders= names.folders;
end

% nehme nur ordner welche tiefer als der aktuelle pfad sind
folderList= folders(cellfun(@numel, folders) > numel(current_path));

%%

if strcmp(rel_abs, 'rel')
  
  for ifolder= 1:numel(folderList)
    folderList{ifolder}= strrep(folderList{ifolder}, current_path, '');
  end
  
end

%%


