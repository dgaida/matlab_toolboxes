%% Preliminaries
% # This function depends on the MATLAB Kriging Toolbox DACE
% <http://www2.imm.dtu.dk/~hbn/dace/>
% so this toolbox has to be installed first. 
%
%% Syntax
%       opt_inputs= getOptimalInputUsingKriging(minmax, inputs, outputs,
%       LB, UB) 
%       opt_inputs= getOptimalInputUsingKriging(minmax, inputs, outputs,
%       LB, UB, opt_method) 
%
%% Description
% |opt_inputs= getOptimalInputUsingKriging(minmax, inputs, outputs, LB,
% UB)| 
%
%% Example
%
% 

mydata= load_file('data_to_plot.mat');

inputs= double(mydata(:, 2:3));

outputs= double(mydata(:, end - 1:end));

LB= [35 20];
UB= [40 30];

[opt_inputs, paretofront]= ...
  getOptimalInputUsingKriging('min', inputs, outputs, LB, UB);



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="fitness_kriging.html">
% fitness_kriging</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('optimization_tool/startsmsemoa')">
% optimization_tool/startSMSEMOA</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('optimization_tool/startcmaes')">
% optimization_tool/startCMAES</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validatestring')">
% matlab/validatestring</a>
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
% <a href="matlab:doc('optimization_tool/findoptimalequilibrium')">
% optimization_tool/findOptimalEquilibrium</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc(data_tool/plot3dsurface_alpha')">
% data_tool/plot3dsurface_alpha</a>
% </html>
%
%% TODOs
% # improve documentation and create it for script
% # add reference
% # add further optimization methods
% # improve documentation
% # add example
% # test example
%
%% <<AuthorTag_DG/>>
%% References
% # 
%


