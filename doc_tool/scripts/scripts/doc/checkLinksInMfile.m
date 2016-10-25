%% checkLinksInMfile
% Checks if links in given m-file are ok or a dead end.
%
function linksOK= checkLinksInMfile(toolbox, path_to_file)
%% Release: 1.9

%%
%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

checkArgument(toolbox,      'toolbox',      'gecoc_tool', '1st');
checkArgument(path_to_file, 'path_to_file', 'char',       '2nd');

%%

linksOK= 1;

%%

find_entry= @(tocfile, entry) find(~cellfun('isempty', regexp(tocfile, entry)));
 
%%

current_path= pwd;

%%

path_parts= regexp(strrep(path_to_file, '/', '\'), '\', 'split');

path= fullfile(path_parts{1:end-1});

%%
%

pub_location= getPublicationLocation(path);
  
cd( fullfile(toolbox.getHelpPath(), pub_location) );             
    
%%

cell_mfile= file2cell( path_to_file );
  
%%
% check for links of type:
%
% <html>
% <a href="..\..\io\html\file2cell.html">
% file2cell</a>
% </html>
%

%% 
% findet auch Sonderzeichen wie . und /
%
%entries= find_entry(cell_mfile, '\w*<a href="(.+).html">\w*');
entries= find_entry(cell_mfile, '.*?<a href="(.+).html">.*?');

if ~isempty( entries )

  for ientry= 1:numel(entries)
    
    %%
    
    [tokens]= regexp( char( cell_mfile( entries(ientry) ) ), ...
                   '.*?<a href="(.+)">.*?', 'tokens' );
                 
    if ~exist( char( tokens{1,1} ), 'file' )  

      %%

      warning('link:notvalid', ['link ', ...
              strrep(...
              strrep(char( cell_mfile( entries(ientry) ) ), '\', '\\'), ...
              '%', ''), ...
              ' not valid in file: ']);
             
      %%
      
      disp(['<a href= "matlab:opentoline(''', path_to_file, ''',', ...
            num2str(entries(ientry)), ', 0)">', path_parts{end}, ' at ', ...
            num2str(entries(ientry)), '</a>']);   
      
      %%
      % es wurde mit cd in den ordner der aktuellen html datei gewechselt
      
      [rel_path]= getRelPathToHTMLFile(toolbox, char( tokens{1,1} ), pwd);
      
      %%
      
      if ~isempty(rel_path)
        disp(sprintf('Correct path is: %s', rel_path));
        
        choice= 'Yes';%
        %choice= questdlg('Should entry be replaced?','Replace Entry?','Yes','No','Yes');
        
        if strcmp(choice, 'Yes')
          try
            replaceinfile( char( tokens{1,1} ), ...
                           rel_path, path_to_file, '-nobak');
          catch ME
            disp(ME.message)
          end
        end
        
        %cell_mfile( entries(ientry) )= '';
      end
      
      %%
      
      linksOK= 0;       
    end
                 
  end
  
end

%%
% check for links of type:
%
% <make_helptoc.html make_helptoc>
%

%entries= find_entry(cell_mfile, '.*?<(.+).html .*?>.*?');
entries= find_entry(cell_mfile, '.*?<(.+).html.*?.*?');

entries_href= find_entry(cell_mfile, '.*?<a href="(.+).html">.*?');

%%

for ii= 1:numel(entries_href)
  
  entries= entries(entries ~= entries_href(ii));

end

%%

if ~isempty( entries )

  for ientry= 1:numel(entries)
    
    %%
    %
    
    % ignore http links to the internet
    % and matlab help references
    if ~isempty( regexp( char( cell_mfile( entries(ientry) ) ), ...
                   'http://', 'once') ) || ...
       ~isempty( regexp( char( cell_mfile( entries(ientry) ) ), ...
                   'matlab:doc', 'once') )
    	continue;
    end
    
    %%
    % 
    [tokens]= regexp( char( cell_mfile( entries(ientry) ) ), ...
                   '.*?<(.+) .*?>.*?', 'tokens' );
                 
    if isempty(tokens)
      [tokens]= regexp( char( cell_mfile( entries(ientry) ) ), ...
                   '.*?<(.+).*?.*?', 'tokens' );
    end
                 
    %%
    
    tokens= regexp(char( tokens{1,1} ), '#', 'split');
    tokens= regexp(char( tokens{1,1} ), ' ', 'split');
    tokens= { strtrim( char( tokens{1,1} ) ) };
    
    %%
        
    if ~exist( char( tokens{1,1} ), 'file' ) 
      %%
      %
      
      warning('link:notvalid', ['link ', ...
              strrep( ...
              strrep(char( cell_mfile( entries(ientry) ) ), '\', '\\'), ...
              '%', ''), ...
              ' not valid in file: ']);
      disp(['<a href= "matlab:opentoline(''', path_to_file, ''',', ...
            num2str(entries(ientry)), ', 0)">', path_parts{end}, ' at ', ...
            num2str(entries(ientry)), '</a>']);          
          
      %%
      % es wurde mit cd in den ordner der aktuellen html datei gewechselt
      
      [rel_path]= getRelPathToHTMLFile(toolbox, char( tokens{1,1} ), pwd);
      
      %%
      
      if ~isempty(rel_path)
        disp(sprintf('Correct path is: %s', rel_path));
        
        %% TODO
        %choice= questdlg('Should entry be replaced?','Replace Entry?','Yes','No','Yes');
        choice= 'Yes';
        
        if strcmp(choice, 'Yes')
          try
            replaceinfile( char( tokens{1,1} ), ...
                           rel_path, path_to_file, '-nobak');
          catch ME
            disp(ME.message)
          end
        end
        
        %cell_mfile( entries(ientry) )= '';
      end
          
      %%
      
      linksOK= 0;       
    end
                 
  end
  
end

%%

cd(current_path);

%%


