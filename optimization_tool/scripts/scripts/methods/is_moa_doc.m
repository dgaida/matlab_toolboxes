%% Syntax
%       is_mo= is_moa(method)
%
%% Description
% |is_mo= is_moa(method)| checks whether given optimization |method| is a
% multi-objective algorithm. 
%
%% <<opt_method/>>
%%
% @return |is_mo| : double scalar
%
% * 1, if method is multi-objective
% * 0, else
%
%% Example
% 

is_moa('CMA-ES')

%%

is_moa('SMS-EGO')

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/set_nobjectives_in_fitness_params')">
% biogas_control/set_nObjectives_in_fitness_params</a>
% </html>
%
%% See Also
%
% <html>
% <a href="startpso.html">
% startPSO</a>
% </html>
% ,
% <html>
% <a href="startpatternsearch.html">
% startPatternSearch</a>
% </html>
% ,
% <html>
% <a href="startga_patternsearch.html">
% startGA_PatternSearch</a>
% </html>
% ,
% <html>
% <a href="startga.html">
% startGA</a>
% </html>
% ,
% <html>
% <a href="startde.html">
% startDE</a>
% </html>
% ,
% <html>
% <a href="startsimulannealing.html">
% startSimulAnnealing</a>
% </html>
% ,
% <html>
% <a href="startisres.html">
% startISRES</a>
% </html>
% ,
% <html>
% <a href="startcmaes.html">
% startCMAES</a>
% </html>
% ,
% <html>
% <a href="startfmincon.html">
% startFMinCon</a>
% </html>
% ,
% <html>
% <a href="startstdpsokriging.html">
% startStdPSOKriging</a>
% </html>
% ,
% <html>
% <a href="startpsokriging.html">
% startPSOKriging</a>
% </html>
% ,
% <html>
% <a href="startsmsemoa.html">
% startSMSEMOA</a>
% </html>
% ,
% <html>
% <a href="startsmsego.html">
% startSMSEGO</a>
% </html>
%
%% TODOs
% # has to be extended if more mo methods are implemented in the toolbox
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


