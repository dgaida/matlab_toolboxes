%% existMPfile
% Checks if function exists as m- or p-file
%
function doesExist= existMPfile(function_name, varargin)
%% Release: 2.9

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

global IS_DEBUG;

%%
% check arguments

if IS_DEBUG
  checkArgument(function_name, 'function_name', 'char', '1st');
end

if nargin >= 2 && ~isempty(varargin{1})
  throw_error= varargin{1};

  if IS_DEBUG
    is0or1(throw_error, 'throw_error', 2);
  end
else
  throw_error= 0;
end

%%
% m-file or p-file

if ( exist(function_name, 'file') == 2 ) || ( exist(function_name, 'file') == 6 )
  doesExist= 1;
else
  doesExist= 0; 
end

%%

if (~doesExist && throw_error)
  error('The function ''%s'' neither exists as m- nor p-file!', function_name);
end

%%


