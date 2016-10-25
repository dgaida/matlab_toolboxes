%% getToolboxDevelopmentStatus
% Create a HTML file documenting the development status of the toolbox.
%
function getToolboxDevelopmentStatus(toolbox, varargin)
%% Release: 1.9

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
%

checkArgument(toolbox, 'toolbox', 'gecoc_tool', '1st');

%%

if nargin >= 2 && ~isempty(varargin{1}), 
  current_version= varargin{1}; 
  
  validateattributes(current_version, {'double'}, {'scalar'}, ...
                     mfilename, 'current Toolbox version', 2);
else
  current_version= 1.1; 
end

%%
%

base_path= toolbox.getToolboxPath();

help_path= fullfile(toolbox.getHelpPath(), toolbox.getHTMLsubfolder());

f_devState= fopen(fullfile(help_path, 'lib_development_status.html'), 'wt');

%%
%

rel_path_m= getToolboxFolderStructure(base_path);


%%
%

fprintf(f_devState, ['<html><head>', ...
                     '<title>Development Status of ', ...
                     toolbox.getToolboxName(), '</title>', ...
                     '</head><body>', ...
                     '<h1>Development Status of ', ...
                     toolbox.getToolboxName(), ' Toolbox</h1><br>']);
fprintf(f_devState, '<table>\r\n');

fprintf(f_devState, ['<tr><td>Pfad</td>', ...
                     '<td bgcolor="#00FFFF">TODOs</td>', ...
                     '<td bgcolor="#00FF00">FINAL</td>', ...
                     '<td bgcolor="#FFFF00">Contents</td>', ...
                     '<td bgcolor="#FF0000">LOOKUP</td></tr>\r\n']);
    
%%
%

find_entry= @(tocfile, entry) find(~cellfun('isempty', strfind(tocfile, entry)));

%%

for ipath= 1:numel(rel_path_m)

  %%

  path_m= fullfile(base_path, rel_path_m{ipath});

  %%
  % read publish_location.txt to get html path
  
  rel_path_html= getPublicationLocation(path_m);
  
  if isempty(rel_path_html)
    continue;
  end
  
  %%
  
  cell_pub_loc= file2cell(fullfile(path_m, 'publish_location.txt'));
  
  %%
  
  path_m_text= strrep(path_m, '\', '\\');

  %%

  fprintf(f_devState, '<tr>');

  %%

  if exist(fullfile(path_m, 'Contents.m'), 'file')

    strContents= ['<td bgcolor="#FFFF00">', ...
             '<a href= "matlab:edit(''', ...
             strrep(fullfile(path_m, 'Contents.m'), '\', '\\'), ...
             ''')">Contents.m', ...
             '</a>'];

  else

    strContents= '<td></td>';

  end

  %%

  if exist(fullfile(path_m, 'TODOs.txt'), 'file')

    fprintf(f_devState, ...
            ['<td bgcolor="#00FFFF">', ...
             '<a href= "matlab:edit(''', ...
             strrep(fullfile(path_m, 'TODOs.txt'), '\', '\\'), ...
             ''')">', strrep(fullfile(path_m, 'TODOs.txt'), '\', '\\'), ...
             '</a></td><td bgcolor="#00FFFF"></td><td></td>', strContents, ...
             '<td></td>']);

  elseif exist(fullfile(path_m, 'FINAL.txt'), 'file')

    fprintf(f_devState, ...
            ['<td bgcolor="#00FF00">', ...
             '<a href= "matlab:cd(''', path_m_text, ''')">', path_m_text, ...
             '</a></td><td></td><td bgcolor="#00FF00"></td>', strContents, ... 
             '<td></td>']);

  else

    fprintf(f_devState, ...
            ['<td bgcolor="#FF0000">', ...
             '<a href= "matlab:cd(''', path_m_text, ''')">', path_m_text, ...
             '</a></td><td></td><td></td>', strContents, ...
             '<td bgcolor="#FF0000"></td>']);

  end

  %%

  fprintf(f_devState, '</tr>\r\n');

  %%

  Files= dir( fullfile(path_m, '*.m') );

  %%

  for ifile= 1:size(Files,1)

    file_path= char(Files(ifile,1).name);

    filename_split= regexp(file_path, filesep, 'split');

    filename= char(filename_split(end));

    %%

    if strcmp(filename, 'Contents.m') || ...
       strcmp(filename, 'slblocks.m')
      continue;
    end

    %%
    
    % only publish if filename is not listed as exception
    % and if there does not exist a _doc file to a script file
    if ~isempty( find_entry(cell_pub_loc, filename) ) || ...
        ...% filename ist kein doc file aber es gibt ein doc file
        ( isempty(regexp(filename, '_doc.m', 'once')) && ...
          exist(getDocFileOfFunction(filename), 'file') )
        
      continue;
      
    end
    
    
    
    %%

    fprintf(f_devState, ...
            '<tr><td>');

    fprintf(f_devState, ...
            ['<a href= "matlab:edit(''', ...
             strrep(fullfile(base_path, rel_path_m{ipath}, filename), '\', '\\'), ...
             ''')">', ...
             strrep(fullfile(rel_path_m{ipath}, filename), '\', '\\'), ...
             '</a>']);

%     fprintf(f_devState, ...
%             ['<a href= "eval(''''''edit(fullfile(getBiogasLibPath(), ''''''', ...
%              strrep(fullfile(rel_path_m{ipath}, filename), '\', '\\'), ...
%              '''''''))'''''')">', ...
%              strrep(fullfile(rel_path_m{ipath}, filename), '\', '\\'), ...
%              '</a>']);       
           
    fprintf(f_devState, ...
            '</td>');

    %% 
    % 
    s_version= getReleaseVersionOfMfile( fullfile(path_m, filename) );

    version= str2double(s_version);

    %% 
    % test for version
    if version < current_version
      color= 'bgcolor="#FF0000"';
    elseif version < current_version + 0.2
      color= 'bgcolor="#FFFF00"';
    elseif ~isnan(version)
      color= 'bgcolor="#00FF00"';
    else
      color= '';
    end

    fprintf(f_devState, ...
            sprintf('<td %s>', color));

    fprintf(f_devState, ...
            s_version);

    fprintf(f_devState, ...
            '</td><td></td><td></td></tr>');

  end

  %%
    
end

%%

fprintf(f_devState, '</table><body></html>');

%%

fclose(f_devState);

%%


