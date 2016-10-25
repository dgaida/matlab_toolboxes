%% create_product_page
% Create help product page for toolbox
%
function []= create_product_page(toolbox)
%% Release: 1.1

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check arguments

checkArgument(toolbox, 'toolbox', 'gecoc_tool', '1st');

%%

help_path= toolbox.getHelpPath();

help_path_doc_tool= fullfile( doc_tool.getToolboxPath(), 'scripts', ...
                              'help', 'doc_tool', 'doc_creation_files' );


%%

myTemplate= file2cell( fullfile( help_path_doc_tool, 'tool_product_page_template.html' ) );

%% TODO - für biogaslibrary soll die seite gerade nicht in html 
% ordner erstellt werden, für alle anderen schon, also invers zu
% htmlsubfolder

filename= fullfile( help_path, 'html', [toolbox.getToolboxID(), '_product_page.html'] );

%%

cell2file(filename, myTemplate(1:5), 'wt');

%%

cell2file(filename, {['<title>', toolbox.getToolboxName(), '</title>']}, 'a');

cell2file(filename, myTemplate(7:34), 'a');

cell2file(filename, {['<h1>', toolbox.getToolboxName(), '</h1>']}, 'a');

cell2file(filename, myTemplate(36:90), 'a');


%%

if exist(fullfile(help_path, 'helpblockbycat.xml'), 'file') == 2

  cell2file(filename, myTemplate(91:124), 'a');
  
end

%%

cell2file(filename, myTemplate(127:176), 'a');
 
%%
% TODO


%%
% User's Guide

cell2file(filename, myTemplate(200:220), 'a');

cell2file(filename, {['Provides tutorials and comprehensive information ', ...
                      'about the ', toolbox.getToolboxName()]}, 'a');

cell2file(filename, myTemplate(223:232), 'a');


%%
% TODO


%%

cell2file(filename, myTemplate(257:268), 'a');


%%
% TODO Demos


%%

cell2file(filename, myTemplate(344:end), 'a');


%%


