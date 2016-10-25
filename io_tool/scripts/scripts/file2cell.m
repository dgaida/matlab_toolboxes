%% file2cell
% Reads a file row-wise into a <matlab:doc('cellstr') cell array of strings>
%
function str= file2cell(filename, varargin)
%% Release: 1.9
% reads a file row-wise into a cellstr

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(filename, 'filename', 'char', '1st');

%%

if nargin >= 2 && ~isempty(varargin{1})
  maxline= varargin{1};
  
  validateattributes(maxline, {'double'}, {'scalar', 'integer'}, ...
                     mfilename, 'max number of lines to read', 2);
else
  maxline= Inf;
end


%%

fid= efopen(filename, 'r'); %'rt'

str= {};

%%

while length(str) < maxline
  
  %%
  
  tline= fgetl(fid);

  if ~ischar(tline), 
    break; 
  end

  str{end + 1}= tline;
  
end

%%

fclose(fid);

%%


