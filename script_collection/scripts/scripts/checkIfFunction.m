%% checkIfFunction
% Check whether filename is a script or a function or something else
%
function isfunction= checkIfFunction(filename)
%% Release: 1.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(filename, 'filename', 'char', '1st');

%%

if exist(filename, 'file')
  try
    % read filename to cell of strings
    content= file2cell(filename);
  catch ME
    rethrow(ME);
  end
else
  %%
  % neither function nor script
  
  isfunction= -1;
  
  return;
end

%%

find_entry= @(tocfile, entry) find(~cellfun('isempty', regexp(tocfile, entry)));

%%
% find keyword function
% finds every line which contains the word function
pos= find_entry(content, 'function');

%%

if ~isempty(pos)
  isfunction= 0;
  
  for ipos= pos(1):pos(end)
    % delete leading and trailing white space from string
    testchar= strtrim(char(content{ipos}));
    
    % if the first 8 characters are 'function', then we have a function
    if strcmp(testchar(1: min(8,numel(testchar)) ), 'function')
      isfunction= 1;
      
      return;
    end
  end
else
  % we do not have a function but a script
  isfunction= 0;
end

%%


