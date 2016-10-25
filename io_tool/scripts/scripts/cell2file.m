%% cell2file
% Write <matlab:doc('cellstr') cell array of strings> to file
%
function cell2file(file, str, flag)
%% Release: 1.9
% write cellstring to file

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check input arguments

checkArgument(file, 'file', 'char', '1st');

checkArgument(str, 'str', 'cellstr', '2nd');

%%

if nargin == 2, 
  flag= 'w'; 
end

%%

checkArgument(flag, 'flag', 'char', '3rd');

%%

fid= efopen(file, flag);

%%

write_cell(fid, str);

%%

fclose(fid);

%%


