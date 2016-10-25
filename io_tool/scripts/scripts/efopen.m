%% efopen
% File open with error message
%
function fid= efopen(fname, varargin)
%% Release: 1.9
% file open with error message

%%

error( nargchk(1, nargin, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check input arguments

checkArgument(fname, 'fname', 'char', '1st');

%%

%if exist(fname, 'file')
  [fid, m]= fopen(fname, varargin{:});
% else
%   warning('efopen:nofile', 'file %s does not exist!', fname);
%   fid= -1;
%   m= '';
% end

%%

if fid == -1
  error('efopen:nofile', 'could not open: %s\n%s', fname, m);
end


%%


