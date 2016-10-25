%% write_cell
% Write cell array of strings to text file
%
function write_cell(fid, cell)
%% Release: 1.9
% write cell array of strings to text file

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check input arguments

validateattributes(fid, {'double'}, {'scalar', 'integer'}, ...
                   mfilename, 'file identifier', 1);

checkArgument(cell, 'cell', 'cellstr', '2nd');

%%
%

for i = 1:length(cell)
  fprintf(fid, '%s\n', cell{i});
end

%%


