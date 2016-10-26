%% mkdirOnDemand
% Make dir on demand
%
function mkdirOnDemand(folder)
%% Release: 1.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
%

checkArgument(folder, 'folder', 'char', '1st');

%%

if ~exist(folder, 'dir')
  mkdir(folder);
end

%%


