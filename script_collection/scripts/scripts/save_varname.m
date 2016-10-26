%% save_varname
% Save a variable with the given variablename in a file
%
function save_varname(variable, variablename, varargin)
%% Release: 1.7

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  filename= varargin{1};
  checkArgument(filename, 'filename', 'char', '3rd');
else
  filename= [variablename, '.mat'];
end

if nargin >= 4 && ~isempty(varargin{2}), 
  silent= varargin{2}; 
  
  is0or1(silent, 'silent', 4);
else
  silent= 0;
end

%%

checkArgument(variablename, 'variablename', 'char', '2nd');

%%

filestruct.(variablename)= variable;

try
  
  %%
  
  save( fullfile(filename), '-struct', 'filestruct', variablename );

  %%

  if silent == 0
    dispMessage(sprintf('%s saved to file %s.', variablename, filename), mfilename);
  end
  
  %%
  
catch ME
  warning('save:error', 'Could not save to file %s!', filename);
  rethrow(ME);
end
    
%%


