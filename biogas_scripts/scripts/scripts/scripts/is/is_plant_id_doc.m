%% Syntax
%       is_plant_id(argument, argument_number)
%
%% Description
% |is_plant_id(argument, argument_number)| checks if the given
% |argument| is a plant_id, an ID of a biogas plant. If it is not,
% an error is thrown. The |argument| is the |argument_number| th argument
% of the calling function. 
%
%%
% @param |argument| : The argument that will be checked. Should be a char
% containing the ID of a plant. For more information have a look here:
% <matlab:docsearch('Definition,of,plant_id') plant_id>. 
%
%%
% @param |argument_number| : char with the ordinal number of the given
% argument, so its position in the calling function. Should be in between
% '1st' and '15th'. May also be a positive integer value. If it is, then
% during output a 'th' is appended after the number. 
%
%% Example
% 
% This call is ok

is_plant_id('gummersbach', '2nd')

%%
% The next call throws an error, because of first argument not being a char

try
  is_plant_id([0 1], 5)
catch ME
  disp(ME.message)
end

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
% (all functions)
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_scripts/is_plant">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_substrate">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_fitness_params">
% biogas_scripts/is_fitness_params</a>
% </html>
%
%% TODOs
% # create documentation of script file
% # check documentation
%
%% <<AuthorTag_DG/>>


