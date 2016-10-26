%% Syntax
%       unit= getDefaultMeasurementUnit(symbol)
%
%% Description
% |unit= getDefaultMeasurementUnit(symbol)| returns the default unit for a
% state vector component used for visualization. Often the unit 'kgCOD/m^3'
% is converted into g/l, as it is easier to understand. 
%
%%
% @param |symbol| : char defining the state vector component: e.g. 'Sac',
% 'Ssu', ...
%
%%
% @return |unit| : char containing the unit
%
%% Example
%
% 

getDefaultMeasurementUnit('Sac')


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc nargchk">
% matlab/nargchk</a>
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
% <a href="getvectoroutofstream.html">
% getVectorOutOfStream</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="createstateestimator.html">
% createStateEstimator</a>
% </html>
%
%% TODOs
%
%
%% <<AuthorTag_DG/>>


