%% Syntax
%       pub_location= getPublicationLocation(path)
%
%% Description
% |pub_location= getPublicationLocation(path)| returns the folder in which 
% the help files of the given |path| are published. Therefore it reads the
% file |publish_location.txt|. This function depends on the format of the
% file |publish_location.txt|. It just returns the first line not beginning
% with a '%'.
%
%%
% @param |path| : char with the full path to the folder of interest
%
%%
% @return |pub_location| : path to the folder in which the html files of
% the given |path| will be published
%
%% Example
%
% 

getPublicationLocation( fullfile(doc_tool.getToolboxPath(), 'scripts/doc') )

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href=matlab:doc fopen">
% doc fopen</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="checklinksinmfile.html">
% checkLinksInMfile</a>
% </html>
% ,
% <html>
% <a href="publish_toolbox.html">
% publish_toolbox</a>
% </html>
% 
%% See Also
%
% -
%
%% TODOs
%
%
%% <<AuthorTag_DG/>>


