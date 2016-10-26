%% Syntax
%       round_value= round_float(value)
%       round_value= round_float(value, digits)
%
%% Description
% |round_value= round_float(value, digits)| rounds |value| using the MATLAB
% function <matlab:doc('round') |round|>. But it rounds not to the nearest
% integer, but to the nearest float with the by |digits| specified number
% of fractional digits. As a default, |digits| is set to 2.
%
%%
% @param |value| : the to be round value, may also be a vector or matrix.
%
%%
% @param |digits| : number of wanted fractional digits of the round value
% |round_value|. My also be a vector or matrix. If it is a vector or
% matrix, then a vector respectively matrix is returned with the values of
% |value| rounded to the given digits.
%
%%
% @return |round_value| : rounded |value| with |digits| fractional digits.
%
%% Examples
% 
% 

numerics.math.round_float(5.1234, 2)

%%
%
%

numerics.math.round_float([5.1234, 2.5678], 2)

%%
%
% 

numerics.math.round_float(5.1234, [2, 1])

%%
%
% 

try
  numerics.math.round_float(5.1234, [2.1, -1])
catch ME
  disp(ME.message)
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc round">
% matlab/round</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('gui_digester_combi')">
% gui_digester_combi</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('fitness_rl_costs')">
% fitness_RL_costs</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('fitness_calib')">
% fitness_calib</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('fitness_calibration')">
% fitness_calibration</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('fitness_costs')">
% fitness_costs</a>
% </html>
% ,
% <html>
% ...
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_gui/gui_substrate')">
% biogas_gui/gui_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/rlearner')">
% ml_tool/optimization.RL.RLearner</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc approxeq">
% numerics.math.approxEq</a>
% </html>
% ,
% <html>
% <a href="matlab:doc math">
% numerics.math</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


