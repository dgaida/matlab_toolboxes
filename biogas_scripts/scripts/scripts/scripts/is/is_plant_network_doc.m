%% Syntax
%       is_plant_network(argument, argument_number)
%       is_plant_network(argument, argument_number, plant)
%
%% Description
% |is_plant_network(argument, argument_number)| checks if the given
% |argument| satisfies the criteria of a |plant_network| array. These
% criteria are:
% 
% * 2-dimensional double array with real and nonnegative values
%
% In the other call it is checked as well, that
%
% * number of rows equals number of digesters
% * numbe rof columns equals number of digesters plus one (final storage
% tank) 
%
% If any of these criteria fail, an error is thrown. The |argument| is the
% |argument_number| th argument of the calling function. 
%
% For more informations about the |plant_network| see
% <matlab:docsearch('Definition,of,plant_network') here>. 
%
% You also may call this function to check |plant_network_min| and
% |plant_network_max| arrays, at the moment they do not have their own
% function. 
%
%%
% @param |argument| : The argument that will be checked. Should be a 2-dim
% double array satisfying all criteria above. 
%
%%
% @param |argument_number| : a positive integer value specifying the
% |argument| 's position in the calling function. 
%
%% <<plant/>>
%% Example
% 
% These calls are ok

[substrate, plant, substrate_network, plant_network]= ...
  load_biogas_mat_files('koeln');

is_plant_network(plant_network, 4)

%%

is_plant_network(plant_network, 4, plant)

%%
% The next call throws an error

try
  is_plant_network([0 1], 1, plant)
catch ME
  disp(ME.message)
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/isn">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validateattributes">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_plant">
% biogas_scripts/is_plant</a>
% </html>
%
% and is called by:
%
% (all functions)
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_scripts/is_plant_network">
% biogas_scripts/is_plant_network</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_substrate">
% biogas_scripts/is_substrate</a>
% </html>
%
%% TODOs
% # create documentation of script file
%
%% <<AuthorTag_DG/>>


