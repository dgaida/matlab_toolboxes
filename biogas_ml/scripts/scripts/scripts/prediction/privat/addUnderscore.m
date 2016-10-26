%% addUnderscore
% Add a \\ before a _ in char data
%
function data= addUnderscore(data)
%% Release: 1.5

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check argument
% do not check, because data could also be different. is checked already
% below using ischar
%checkArgument(data, 'data', 'char', '1st');

%%

if ischar(data) && ~isempty(strfind(data, '_'))
  pos= strfind(data, '_');

  data= [data(1:pos-1), '\\', data(pos:end)];
end

%%


