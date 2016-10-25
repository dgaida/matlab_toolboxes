%% checkIfInXMLfile
% Checks whether given file is recorded inside given xml-file.
%
function linkOK= checkIfInXMLfile(toolbox, xml_file, html_link)
%% Release: 1.9

%%
%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

checkArgument(toolbox,   'toolbox',   'gecoc_tool', '1st');
checkArgument(xml_file,  'xml_file',  'char',       '2nd');
checkArgument(html_link, 'html_link', 'char',       '3rd');

%%

linkOK= 1;

%%

find_entry= @(tocfile, entry) find(~cellfun('isempty', regexp(tocfile, entry)));
 
%%
%
 
help_path= toolbox.getHelpPath();             
    
%%

path_xml_file= fullfile(help_path, xml_file);

%%

if ~exist(path_xml_file, 'file')
  
  linkOK= 0;
  
  return;
  
end

%%

cell_xmlfile= file2cell( path_xml_file );
  
%%
% check for links of type:
%
% toolbox/blocks/ad_models/html/calcADM1Deriv.html
%

entries= find_entry(cell_xmlfile, ['\w*+.*?"', strrep(html_link, '\', '/'), ...
                                   '"\w*+.*?']);

if isempty( entries )
  entries= find_entry(cell_xmlfile, ['\w*+.*?"', strrep(html_link, '/', '\'), ...
                                     '"\w*+.*?']);
end

if isempty( entries )
  %linkOK= 0;
  
  error('file:notfound', ['link ', strrep(html_link, '\', '/'), ' not found in file: ', ...
        '<a href= "matlab:edit(''', strrep(path_xml_file, '\', '/'), ''')">', xml_file, '</a>']);
  %disp(['<a href= "matlab:edit(''', path_xml_file, ''')">', xml_file, '</a>']);   
  
else
  
  try
    replaceinfile( strrep(html_link, '\', '/'), ...
                   lower(strrep(html_link, '\', '/')), ...
                   path_xml_file, '-nobak');
  catch ME
    disp(ME.message)
  end
  
end

%%


