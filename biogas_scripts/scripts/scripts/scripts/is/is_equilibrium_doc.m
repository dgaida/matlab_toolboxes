%% Syntax
%       is_equilibrium(argument, argument_number)
%
%% Description
% |is_equilibrium(argument, argument_number)| checks if the given
% |argument| is an equilibrium struct. If it is not,
% an error is thrown. The |argument| is the |argument_number| th argument
% of the calling function. 
%
% For more informations about the struct |equilibrium| see
% <matlab:docsearch('Definition,of,equilibrium') here>. 
%
%%
% @param |argument| : The argument that will be checked. Should be an
% |equilibrium| struct. 
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

[substrate, plant, substrate_network, plant_network]= ...
  load_biogas_mat_files('geiger');

myEquilibrium= defineEquilibriumStruct(plant, plant_network);

is_equilibrium(myEquilibrium, 4)

%%
% The next call throws an error

test.u= 1;

try
  is_equilibrium(test, '1st')
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
% ,
% <html>
% <a href="matlab:doc matlab/isfield">
% matlab/isfield</a>
% </html>
%
% and is called by:
%
% (all functions)
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_optimization/defineequilibriumstruct">
% biogas_optimization/defineEquilibriumStruct</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_substrate">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_plant">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validateattributes">
% matlab/validateattributes</a>
% </html>
%
%% TODOs
% # create documentation of script file
%
%% <<AuthorTag_DG/>>


