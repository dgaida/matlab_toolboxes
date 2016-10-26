%% Syntax
%       initstate= get_initstate_outof_equilibrium(equilibrium)
%       initstate= get_initstate_outof_equilibrium(equilibrium, plant_id)
%
%% Description
% |initstate= get_initstate_outof_equilibrium(equilibrium)| gets the states
% of digesters and hydraulic delays out of given |equilibrium| and saves
% them in |initstate| struct. The returned struct can be used to start a
% simulation from the initial state. Basically an |equilibrium| contains
% information about state and substrate feed. The latter information is
% gotten calling:
% <matlab:doc('biogas_scripts/get_volumeflow_outof_equilibrium')
% biogas_scripts/get_volumeflow_outof_equilibrium>. 
%
%% <<equilibrium/>> 
%%
% @param |plant_id| : char with the ID of the plant. If you pass this
% parameter then the returned |initstate| is also saved to the file
% |initstate__plant_id_.mat|. Default it is not, then |plant_id= []|. Must
% not be the plant's ID, may also contain '_' and a digit at the end, see
% 2nd example. 
%
%%
% @return |initstate| : the initial state of a biogas plant model gotten
% out of |equilibrium|. 
%
%% Example
% 
%

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ) );

load('equilibrium_gummersbach_optimum.mat')

get_initstate_outof_equilibrium(equilibrium)

%%
% creates file initstate_gummersbach_1.mat

get_initstate_outof_equilibrium(equilibrium, 'gummersbach_1')

% clean up

delete('initstate_gummersbach_1.mat');


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc fieldnames">
% matlab/fieldnames</a>
% </html>
% ,
% <html>
% <a href="matlab:doc rmfield">
% matlab/rmfield</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_equilibrium">
% biogas_scripts/is_equilibrium</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_optimization/getregionofattraction">
% biogas_optimization/getRegionOfAttraction</a>
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
% <a href="matlab:doc biogas_scripts/createnewinitstatefile">
% biogas_scripts/createNewInitstatefile</a>
% </html>
%
%% TODOs
% # do documentation for script file
% # improve documentation
%
%% <<AuthorTag_DG/>>


