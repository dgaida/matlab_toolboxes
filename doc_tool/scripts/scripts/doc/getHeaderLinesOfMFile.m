%% getHeaderLinesOfMFile
% Get first lines (3) of mfile describing the function briefly
%
function headerlines= getHeaderLinesOfMFile(mfile)
%% Release: 1.4

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

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
%% TODO
% should work for class methods, but does not work, because to look for
% class methods exist('+numerics/@math/approxEq.m') must be used
% TODO not completely solved yet, but quite a lot of class methods are
% found now
if anyexist
  
  % only get frst 5 lines
  if exist(mfile, 'file')
    header= file2cell(mfile, 5);
  elseif exist(filename, 'file')
    header= file2cell(filename, 5);
  elseif exist(filename_2nd, 'file')
    header= file2cell(filename_2nd, 5);
  else
    header= file2cell(filename_3rd, 5);
  end
  
  headerlines= '';

  for iline= 1:5
    line= header{iline};

    if numel(line) > 0 && strcmp(line(1), '%')
      headerlines= [headerlines, '\n', line];
    else
      break;
    end
  end

  %%
  % throw away first \n
  headerlines= headerlines(3:end);
  
  % replace % with %%, because we want to print it
  headerlines= strrep(headerlines, '%', '%%');

  headerlines= sprintf(headerlines);
  
else
  
  headerlines= '';
  warning('file:notexist', 'file %s does not exist!', mfile);
  
end

%%


