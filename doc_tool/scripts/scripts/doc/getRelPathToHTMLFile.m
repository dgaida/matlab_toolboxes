%% getRelPathToHTMLFile
% Returns the relative path of a html file with respect to a given path.
%
function [rel_path]= getRelPathToHTMLFile(toolbox, html_file, varargin)
%% Release: 1.9

%%
%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

checkArgument(toolbox,   'toolbox',   'gecoc_tool', '1st');
checkArgument(html_file, 'html_file', 'char',       '2nd');

%%

if nargin >= 3 && ~isempty(varargin{1})
  actual_path= varargin{1};
else
  actual_path= pwd;
end

checkArgument(actual_path, 'actual_path', 'char', '3rd');

%%
%

rel_path= [];

%%

helpPath= toolbox.getHelpPath();

%%

html_file= fullfile(html_file);

html_file_split= regexp(html_file, filesep, 'split');

html_file= html_file_split{end};

%%

find_entry= @(fileList, entry) find(~cellfun('isempty', regexp(fileList, entry)));
 
%%

html_files= rdir([helpPath, '*\**\*.html']);

html_files_cell= cell(numel(html_files), 1);

for ifile= 1:numel(html_files)
  html_files_cell{ifile}= html_files(ifile).name;
end
  
%%

for iiter= 1:3
  
  %%

  entries= find_entry(html_files_cell, ['(.)', lower(html_file)]);

  if numel(entries) > 1
    
    %%
    % try to find html_file directly 
    
    entries= find_entry(html_files_cell, ['\\', lower(html_file)]);
    
    if (numel(entries) == 1)
      break;
    end

    %%

    warning('getRelPathToHTMLFile:FoundTooMany', ...
            'Found %i html files named %s in path %s!', ...
            numel(entries), html_file, helpPath);

    if(0) %% TODO
      for ifile= 1:numel(entries)
        disp(html_files(entries(ifile)));
      end
    end

    return;
  elseif numel(entries) == 0

    %%

    if iiter == 1
    
      html_file_split= regexp(html_file, '\.', 'split');

      html_file= [html_file_split{1}, '_doc.html'];
      
    else
      
      % throw all _doc away
      html_file_split= regexp(html_file, '_doc', 'split');

      html_file= [html_file_split{1}, '.html'];
      
    end

    if iiter <= 2
      continue;
    end

    %%

    warning('getRelPathToHTMLFile:FoundNone', ...
            'Found %i html files named %s in path %s!', ...
            numel(entries), html_file, helpPath);

    return;
  end
  
  break;

end

%%

rel_path= relativepath( html_files(entries(1)).name, actual_path );

% letzte \ löschen
rel_path= rel_path(1:end-1);


%%


