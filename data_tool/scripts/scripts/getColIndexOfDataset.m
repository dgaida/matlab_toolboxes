%% getColIndexOfDataset
% Get column index of specified column name of the given dataset
%
function col_index= getColIndexOfDataset(myDataset, colname)
%% Release: 1.4

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

checkArgument(myDataset, 'myDataset', 'dataset', '1st');
checkArgument(colname, 'colname', 'char', '2nd');

%%

find_entry= @(tocfile, entry) find(~cellfun('isempty', strfind(tocfile, entry)));

%%

varnames= get(myDataset, 'VarNames');

%%

entries= find_entry(varnames, colname);

%%

if ~isempty( entries )

  col_index= entries;
  
else
  
  col_index= -1;
  
end

%%


