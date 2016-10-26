%% Syntax
%       rel_path = relativepath( target_path, actual_path )
%
%% Description
% |relativepath| returns the relative path from an actual path to the target path.
% Both arguments must be strings with absolute paths.
% The actual path is optional, if omitted the current dir is used instead.
% In case the volume drive letters don't match, an absolute path will be returned.
% If a relative path is returned, it always starts with '.\' or '..\'
%
%%
% @param |target_path| : Path which is targetted
%
%%
% @param |actual_path| : Start for relative path (optional, default =
% current dir) 
%
%% Example
% 

relativepath( 'C:\local\data\matlab' , 'C:\local' ) 

relativepath( 'A:\MyProject\'        , 'C:\local' ) 

%%
% both calls are the same

relativepath( 'C:\local\data\matlab' , cd         )

relativepath( 'C:\local\data\matlab'              )

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc matlab/fileparts">
% matlab/fileparts</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/filesep">
% matlab/filesep</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc doc_tool/getrelpathtohtmlfile">
% doc_tool/getRelPathToHTMLFile</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc matlab/path">
% matlab/path</a>
% </html>
% ,
% <html>
% <a href="http://www.mathworks.com/matlabcentral/fileexchange/3857-absolutepath-m">
% www.mathworks.com/matlabcentral/fileexchange/3857-absolutepath-m</a>
% </html>
% 
%% Author
%   Jochen Lenz
%
%% TODOs
% # check documentation
% # check code
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <a href="http://www.mathworks.com/matlabcentral/fileexchange/3858-relativepath-m">
% www.mathworks.com/matlabcentral/fileexchange
% </a>
% </html>
%


