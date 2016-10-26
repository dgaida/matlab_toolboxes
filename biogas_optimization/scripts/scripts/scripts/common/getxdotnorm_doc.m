%% Syntax
%       xdotnorm= getxdotnorm(plant, sensors, t)
%       
%% Description
% |xdotnorm= getxdotnorm(plant, sensors, t)| calculates the integral over
% the change of some process variables of the biogas plant. If the change
% per hour of one variable is higher than some threshold, then this value
% is integrated over the simulation time |t|. This function may only be
% called after a simulation was performed, due to |sensors| and |t|. At the
% end the calculated value is divided by the simulation duration (duration
% of the integral), respectively. 
%
% At the moment the following process values and corresponding thresholds
% are used:
%
% * VFA/TAC : 0.01 gHAceq/gCaCO3eq per 1 hour and per digester
% * H2 : 0.001 m³/d per 1 hour and per digester
% * VFA : 0.1 gHAceq./l per 1 hour and per digester
%
%% <<plant/>>
%% <<sensors/>>
%%
% @param |t| : time vector returned by the simulation. 
%
%%
% @return |xdotnorm| : 1/T * int [ ( xdot(t)' * xdot(t) ) > threshold ] dt
%
%% Example
%
%

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/isrn">
% script_collection/isRn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc data_tool/deleteduplicates">
% data_tool/deleteDuplicates</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/interp1">
% matlab/interp1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/diff">
% matlab/diff</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_optimization/getrecordedfitnessextended">
% biogas_optimization/getRecordedFitnessExtended</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_optimization/getudotnorm">
% biogas_optimization/getudotnorm</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_optimization/getrecordedfitness">
% biogas_optimization/getRecordedFitness</a>
% </html>
%
%% TODOs
% # improve documentation
% # add code documentation
% # add an example
% # make todos
%
%% <<AuthorTag_DG/>>


