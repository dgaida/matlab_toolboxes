%% Syntax
%       is_fitness_params(argument, argument_number)
%
%% Description
% |is_fitness_params(argument, argument_number)| checks if the given
% |argument| is an |biooptim.fitness_params| C# object. If it is not,
% an error is thrown. The |argument| is the |argument_number| th argument
% of the calling function. 
%
% For more informations about the C# object |fitness_params| see
% <matlab:docsearch('Definition,of,fitness_params') here>. 
%
%%
% @param |argument| : The argument that will be checked. Should be an
% |biooptim.fitness_params| C# object. 
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

myfitness_params= load_biogas_mat_files('gummersbach', [], 'fitness_params');

is_fitness_params(myfitness_params, 4)

%%
% The next call throws an error

test= 1;

try
  is_fitness_params(test, '1st')
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
% <a href="matlab:doc biogas_scripts/is_equilibrium">
% biogas_scripts/is_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/load_fitness_params">
% biogas_scripts/load_fitness_params</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validateattributes">
% matlab/validateattributes</a>
% </html>
%
%% TODOs
% # create documentation of script file
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


