%% get_accesstofile_from_datasource_type
% Return scalar accesstofile out of char datasource_type
%
function accesstofile= get_accesstofile_from_datasource_type(datasource_type)
%% Release: 1.4

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check param

validatestring(datasource_type, {'file', 'workspace', 'modelworkspace'}, ...
               mfilename, 'datasource_type', 1);

%%

if strcmp(datasource_type, 'file')
  accesstofile= 1;
elseif strcmp(datasource_type, 'workspace')
  accesstofile= 0;
elseif strcmp(datasource_type, 'modelworkspace')
  accesstofile= -1;
else
  error('Unknown datasource_type: %s', datasource_type);
end

%%


