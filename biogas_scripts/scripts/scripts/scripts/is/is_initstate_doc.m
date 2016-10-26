%% Syntax
%       is_initstate(argument, argument_number)
%
%% Description
% |is_initstate(argument, argument_number)| checks if the given
% |argument| is an initstate struct. If it is not,
% an error is thrown. The |argument| is the |argument_number| th argument
% of the calling function. 
%
% For more informations about the struct |initstate| see
% <matlab:docsearch('Definition,of,initstate') here>. 
%
%%
% @param |argument| : The argument that will be checked. Should be an
% |initstate| struct. 
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

% createinitstatefile_plant('user', 'gummersbach', ...
%                     repmat(double(biogas.ADMstate.getDefaultADMstate())', 1, 2), ...
%                    0);
 
initstate= createNewInitstatefile('gummersbach');

is_initstate(initstate, 1)

% clean up, because createNewInitstatefile creates initstate mat file

delete('initstate_gummersbach.mat')

%%
% The next call throws an error

test.u= 1;

try
  is_initstate(test, '1st')
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
% <html>
% <a href="matlab:doc biogas_scripts/get_initstate_dig_oo_equilibrium">
% biogas_scripts/get_initstate_dig_oo_equilibrium</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_scripts/createinitstatefile">
% biogas_scripts/createinitstatefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/createinitstatefile_plant">
% biogas_scripts/createinitstatefile_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/createnewinitstatefile">
% biogas_scripts/createNewInitstatefile</a>
% </html>
% ,
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
% # improve and check documentation
% # in Bsp. oben wird eigentlich kein gültiges initstate erzeugt, da
% hydraulic_delays fehlen, prüfung darauf fehlt auch noch
%
%% <<AuthorTag_DG/>>


