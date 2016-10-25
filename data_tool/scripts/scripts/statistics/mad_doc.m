%% Syntax
%        m= mad(X)
%
%% Description
% |m= mad(X)| computes the Median Absolute Deviation (MAD) of |X| (includes
% correction for consistency). If |X| is a matrix, MAD is a row vector
% containing the MAD's of the columns of |X|.
%
% Returns 1.4826 * median( | median(X) | )
%
%%
% @param |X| : double matrix (n,p), data matrix n-objects, p-variables
%
%%
% @return |m| : double vector (1,p), containing the median absolute
% deviation of columns in |X| 
%
%% Example
% # Load data from a substrate feed optimization scenario for a biogas
% plant, select columns 2 to 8 (substrate feed) and last column (fitness
% value). 

dataAnalysis= load_file('data_to_plot.mat');

X= double(dataAnalysis);
X= X(:,end);

mad(X)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('nanmedian')">
% matlab/nanmedian</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
%
%
%% See Also
%
% <html>
% <a href="matlab:doc('median')">
% matlab/median</a>
% </html>
%
%% TODOs
% # improve documentation
%
%%
% Written by Sven Serneels, University of Antwerp
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% P.J. Rousseeuw, C. Croux: 
% <a href="matlab:feval(@open, eval('sprintf(''%s\\pdfs\\93 Alternatives to the median absolute deviation.pdf'', data_tool.getHelpPath())'))">
% Alternatives to the median absolute deviation</a>, 
% Journal of American Statististical Association 88, pp. 1273-1283, 1993
% </li>
% <li> 
% M. Daszykowski, S. Serneels, K. Kaczmarek, P. Van Espen, C. Croux, B. Walczak: 
% <a href="matlab:feval(@open, eval('sprintf(''%s\\pdfs\\2007 TOMCAT.pdf'', data_tool.getHelpPath())'))">
% TOMCAT: A MATLAB toolbox for multivariate calibration techniques</a>, 
% Chemometrics and Intelligent Laboratory Systems, vol.85, issue 2, pp.
% 269-277, 2007
% </li>
% </ol>
% </html>
%


