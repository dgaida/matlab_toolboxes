%% checkLinksInXMLfile
% Checks if links in given xml-file are ok or a dead end.
%
function linksOK= checkLinksInXMLfile(toolbox, filename)
%% Release: 1.9

%%
%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

checkArgument(toolbox,  'toolbox',  'gecoc_tool', '1st');
checkArgument(filename, 'filename', 'char',       '2nd');

%%

linksOK= 1;

%%

find_entry= @(tocfile, entry) find(~cellfun('isempty', regexp(tocfile, entry)));
 
%%
%
 
help_path= toolbox.getHelpPath();             
    
%%

path_to_file= fullfile(help_path, filename);

cell_mfile= file2cell( path_to_file );
  
%%
% check for links of type:
%
% target="toolbox/blocks/ad_models/html/calcADM1Deriv.html"
%

entries= find_entry(cell_mfile, '"\w*+.*?.html"');

if ~isempty( entries )

  for ientry= 1:numel(entries)
    
    [tokens]= regexp( char( cell_mfile( entries(ientry) ) ), ...
                      '"(\w+.*?)"', 'tokens' );
                 
    html_file= fullfile(help_path, toolbox.getHTMLsubfolder(), char( tokens{1,1} ));
    
    if ~exist( html_file, 'file' )  
      warning('link:notvalid', ['link ', char( cell_mfile( entries(ientry) ) ), ...
               ' not valid in file: ']);
      disp(['<a href= "matlab:opentoline(''', path_to_file, ''',' ...
           num2str(entries(ientry)), ', 0)">', filename, ' at ', ...
           num2str(entries(ientry)), '</a>']);   
      
      linksOK= 0;       
    end
                 
  end
  
end

%%


