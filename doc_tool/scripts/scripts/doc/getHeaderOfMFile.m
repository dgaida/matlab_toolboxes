%% getHeaderOfMFile
% Get first line of mfile usually containing the name of the file
%
function header= getHeaderOfMFile(mfile)
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
if anyexist
  
  if exist(mfile, 'file')
    header= file2cell(mfile, 1);
  elseif exist(filename, 'file')
    header= file2cell(filename, 1);
  elseif exist(filename_2nd, 'file')
    header= file2cell(filename_2nd, 1);
  else
    header= file2cell(filename_3rd, 1);
  end
  
  header= header{:};

  % '%% ' thrown away
  header= header(4:end);
else
  header= '';
  warning('file:notexist', 'file %s does not exist!', mfile);
end

%%


