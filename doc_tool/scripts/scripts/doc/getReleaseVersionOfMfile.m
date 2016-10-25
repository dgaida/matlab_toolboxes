%% getReleaseVersionOfMfile
% Get Release version of m-file in toolbox
%
function version= getReleaseVersionOfMfile(mfile)
%% Release: 1.9

%%
% 

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(mfile, 'mfile', 'char', '1st');

%%
% get script file in case doc file was given

mfile= getScriptFileOfFunction(mfile);

%%
% if mfile contains the full path, then filename only contains the filename

[filename, filename_2nd, filename_3rd, anyexist]= get_filenames(mfile);

%%
% the 2nd exist looks for the filename in the full matlab path, the first
% call, in case mfile contains the path to the file, just looks in the
% given path
if anyexist
  if exist(mfile, 'file')
    content= file2cell(mfile);
  elseif exist(filename, 'file')
    content= file2cell(filename);
  elseif exist(filename_2nd, 'file')
    content= file2cell(filename_2nd);
  else
    content= file2cell(filename_3rd);
  end
else
  version= '';
  warning('file:notexist', 'file %s does not exist!', mfile);
  return;
end

%%
%

find_entry= @(tocfile, entry) find(~cellfun('isempty', regexp(tocfile, entry)));


%%
%

pos= find_entry(content, '%% Release');


%%
%

if ~isempty(pos)

  %%
  
  [dum1, dum2, dum3, dum4, tokens]= ...
               regexp(char(content(pos(1))), '%% Release: (\w+.*?\w+)');

  %%
  %

  version= char(tokens{:});
              
else

  version= '';
  
end

%%
%


