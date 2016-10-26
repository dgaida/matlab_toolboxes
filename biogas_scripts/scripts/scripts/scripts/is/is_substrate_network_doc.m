%% Syntax
%       is_substrate_network(argument, argument_number)
%       is_substrate_network(argument, argument_number, substrate)
%       is_substrate_network(argument, argument_number, substrate, plant)
%
%% Description
% |is_substrate_network(argument, argument_number)| checks if the given
% |argument| satisfies the criteria of a |substrate_network| array. These
% criteria are:
% 
% * 2-dimensional double array with real and nonnegative values
%
% In the other two calls it is checked as well, that
%
% * number of rows equals number of substrates
% * numbe rof columns equals number of digesters
%
% If any of these criteria fail, an error is thrown. The |argument| is the
% |argument_number| th argument of the calling function. 
%
% For more informations about the |substrate_network| see
% <matlab:docsearch('Definition,of,substrate_network') here>. 
%
% You also may call this function to check |substrate_network_min| and
% |substrate_network_max| arrays, at the moment they do not have their own
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
%% <<substrate/>>
%% <<plant/>>
%% Example
% 
% These calls are ok

[substrate, plant, substrate_network]= load_biogas_mat_files('koeln');

is_substrate_network(substrate_network, 4)

%%

is_substrate_network(substrate_network, 4, substrate)

%%

is_substrate_network(substrate_network, 4, [], plant)

%%

is_substrate_network(substrate_network, 4, substrate, plant)


%%
% The next call throws an error

try
  is_substrate_network([0 1], 1, substrate)
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
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_substrate">
% biogas_scripts/is_substrate</a>
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
%
%% TODOs
% # create documentation of script file
%
%% <<AuthorTag_DG/>>


