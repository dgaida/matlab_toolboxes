%% Syntax
%       [s, msg] = replaceinfile(str1, str2, infile)
%       [s, msg] = replaceinfile(str1, str2, infile, outfile)
%       [s, msg] = replaceinfile(str1, str2)
%
%% Description
% |[s, msg] = replaceinfile(str1, str2, infile)| replaces |str1| with |str2| in
% |infile|, original file is saved as "infile.bak". 
%
%%
% |[s, msg] = replaceinfile(str1, str2, infile, outfile)| writes contents
% of |infile| to |outfile|, |str1| replaced with |str2|. NOTE! if |outputfile| is
% '-nobak' the backup file will be deleted. 
%
%%
% |[s, msg] = replaceinfile(str1, str2)| opens gui for the infile, replaces
% |str1| with |str2| in infile, original file is saved as "infile.bak". 
%
%%
% in:  str1      string to be replaced
%
%      str2      string to replace with
%
%      infile    file to search in
%
%      outfile   outputfile (optional) if '-nobak'
%
%%
% out: s         status information, 0 if succesfull
%
%      msg       messages from calling PERL 
%
%% Examples
%
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc matlab/uigetfile">
% matlab/uigetfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/matlabroot">
% matlab/matlabroot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/movefile">
% matlab/movefile</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc doc_tool/checkifinxmlfile">
% doc_tool/checkIfInXMLfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc doc_tool/checklinksinmfile">
% doc_tool/checkLinksInMfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc doc_tool/replacetoolboxtagbytext">
% doc_tool/replaceToolboxTagByText</a>
% </html>
%
%% See Also
% 
% -
% 
%% Author
% Pekka Kumpulainen 30.08.2000
%
% 16.11.2008 fixed for paths having whitespaces, 
%
% 16.11.2008 dos rename replaced by "movefile" to force overwrite
%
% 08.01.2009 '-nobak' option to remove backup file, fixed help a little..
%
%%
% TAMPERE UNIVERSITY OF TECHNOLOGY  
%
% Measurement and Information Technology
%
% www.mit.tut.fi
%
%% TODOs
% # check documentation
% # check code
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <a href="http://www.mathworks.com/matlabcentral/fileexchange/18909-replace-strings-in-text-file">
% www.mathworks.com/matlabcentral/fileexchange
% </a>
% </html>
%


