%% Syntax
%       x= get_digester_state_outof_initstate(initstate)
%
%% Description
% |x= get_digester_state_outof_initstate(initstate)| gets digester state
% out of initstate.mat as double matrix. 
%
%%
% @param |initstate| : struct containing initial states of digesters in the
% plant. 
%
%%
% @return |x| : double matrix with 37 rows and as many columns as there are
% digesters on the plant. Contains the user state of |initstate| as column
% vectors for all digesters. 
%
%% Example
% 
%

initstate= createNewInitstatefile('gummersbach');

x= get_digester_state_outof_initstate(initstate);

disp(x);

delete('initstate_gummersbach.mat');

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc biogas_scripts/is_initstate">
% biogas_scripts/is_initstate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc fieldnames">
% matlab/fieldnames</a>
% </html>
%
% and is called by:
%
% (the user)
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
%
%% TODOs
% # do documentation for script file
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


