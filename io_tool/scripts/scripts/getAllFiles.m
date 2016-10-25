%% getAllFiles
% Get path + filename to all files inside given folder and all subfolders
% as cellstring 
%
function fileList= getAllFiles(dirName)
%% Release: 1.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(dirName, 'dirName', 'char', '1st');


%%

dirData= dir(dirName);      % Get the data for the current directory
dirIndex= [dirData.isdir];  % Find the index for directories
fileList= {dirData(~dirIndex).name}';  %' Get a list of the files

if ~isempty(fileList)
  fileList= cellfun(@(x) fullfile(dirName,x),...  % Prepend path to files
                     fileList, 'UniformOutput', false);
end

subDirs= {dirData(dirIndex).name};  % Get a list of the subdirectories
validIndex= ~ismember(subDirs,{'.','..','.svn'});  % Find index of subdirectories
                                             %   that are not '.' or '..'
                                             
%%

for iDir= find(validIndex)                     % Loop over valid subdirectories
  nextDir= fullfile(dirName,subDirs{iDir});    % Get the subdirectory path
  fileList= [fileList; getAllFiles(nextDir)];  % Recursively call getAllFiles
end

%%


