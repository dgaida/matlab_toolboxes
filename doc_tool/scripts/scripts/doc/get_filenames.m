%% get_filenames
% Returns filename for a given *.m file (special for class methods)
%
function [filename, filename_2nd, filename_3rd, anyexist]= get_filenames(mfile)
%% Release: 1.4

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%%
% check arguments

checkArgument(mfile, 'mfile', 'char', '1st');

%%
% make sure, that file is not a doc file, after this call

mfile= getScriptFileOfFunction(mfile);

%%
% if mfile contains the full path, then filename only contains the filename

filename_split= regexp(mfile, filesep, 'split');

filename= char(filename_split(end));

%%
% for class methods 2nd and 3rd try

if numel(filename_split) > 1
  if strfind(filename_split{end - 1}, '_doc')
    folder_2nd= filename_split{end - 1};
    folder_2nd= folder_2nd(1:end - 4);
  else
    folder_2nd= filename_split{end - 1};
  end
  
  % if folder already contains a @ delete it, its added below
  folder_2nd= strrep(folder_2nd, '@', '');

  % method is in a class and no further package
  filename_2nd= ['@', folder_2nd, filesep, filename_split{end}];

  if numel(filename_split) > 2
    % if folder already contains a + delete it, its added below
    folder_3rd= strrep(filename_split{end - 2}, '+', '');
  
    % or method is in a class and the folder above is a package - this is just
    % a suggestion
    filename_3rd= ['+', folder_3rd, filesep, ...
                   '@', folder_2nd, filesep, ...
                        filename_split{end}];
  else
    filename_3rd= filename;
  end
else
  filename_2nd= filename;
  filename_3rd= filename;
end

%%

anyexist= 0;

if exist(mfile       , 'file') || exist(filename    , 'file') || ...
   exist(filename_2nd, 'file') || exist(filename_3rd, 'file')

  anyexist= 1;
 
end

%%


