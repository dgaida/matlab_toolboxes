%% genpath_svn
% Generate path string excluding svn folders
%
function p= genpath_svn(varargin)
%% Release: 1.5

%%

error( nargchk(0, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

mypath= genpath(varargin{:});

%%

pathes= regexp(mypath, ';', 'split');
% the last element always contains an empty string
pathes= pathes(1:end - 1);

%%

find_entry= @(cellstring, entry) find(cellfun('isempty', regexp(cellstring, entry)));

%%
% find pathes containing .svn and thwo them out of pathes 
entries= find_entry(pathes, '.svn');
                                 
pathes= pathes(entries);

% add ';' at the end of each path
pathes= cellfun(@strcat, pathes, repmat({';'}, size(pathes)), 'UniformOutput', false);

%%
% concatenate cellstring elements to row vector

p= cell2mat(pathes);

%%


