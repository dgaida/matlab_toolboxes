%% Syntax
%       residual4plotAnalysis(r)
%       residual4plotAnalysis(r, new_fig)
%
%% Description
% |residual4plotAnalysis(r)| can be used to analyse a residual vector
% |r|. For more information see the reference.
%
%%
% The 4-plot consists of the following:
%
% # Run sequence plot to test fixed location and variation. 
% # Lag Plot to test randomness.
% # Histogram to test (normal) distribution.
% # Normal probability plot to test normal distribution.
%
%%
% @param |r| : double random vector
%
%%
% @param |new_fig| : 0 or 1. If 1, then a new figure is created. If 0, then
% in the currently open figure the plot is created. If no figure is open,
% then a new figure is created as well.
%
%% Example
%
% # Plot of a normally distributed residual

residual4plotAnalysis(randn(100,1));

%%
% # Plot of an uniformly distributed residual

residual4plotAnalysis(rand(100,1));

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc hist">
% matlab/hist</a>
% </html>
% ,
% <html>
% <a href="matlab:doc subplot">
% matlab/subplot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc normplot">
% matlab/normplot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc plot">
% matlab/plot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc bar">
% matlab/bar</a>
% </html>
% ,
% <html>
% <a href="matlab:doc scatter">
% matlab/scatter</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc histfit">
% matlab/histfit</a>
% </html>
% ,
% <html>
% <a href="matlab:doc normrnd">
% matlab/normrnd</a>
% </html>
%
%% TODOs
% # Add reference
% # clean up code, improve documentation inside script
% # make documentation for script file
% # for third plot use histfit, but first understand how I plotted third
% plot
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Fortuna, L.; Graziani, S.; Rizzo, A.; Xibilia, M.G.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\2007 - Soft Sensors for Monitoring and Control of Industrial Processes - Fortuna_L Graziani_S.pdf'', 
% data_tool.getHelpPath())'))"> 
% Soft Sensors for Monitoring and Control of Industrial Processes</a>,
% Advances in Industrial Control, Springer Verlag, 2007. 
% </li>
% <li>
% http://www.itl.nist.gov/div898/handbook/eda/section3/4plot.htm
% </li>
% </ol>
% </html>
%


