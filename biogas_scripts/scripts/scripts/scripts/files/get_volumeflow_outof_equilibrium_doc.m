%% Syntax
%       get_volumeflow_outof_equilibrium(plant_id, equilibrium)
%       get_volumeflow_outof_equilibrium(plant_id, equilibrium, id_write)
%       get_volumeflow_outof_equilibrium(plant_id, equilibrium, id_write,
%       lenGenomSubstrate) 
%       get_volumeflow_outof_equilibrium(plant_id, equilibrium, id_write,
%       lenGenomSubstrate, const_user) 
%       get_volumeflow_outof_equilibrium(plant_id, equilibrium, id_write,
%       lenGenomSubstrate, const_user, writetofile) 
%       [substrate_feed, sludge]=
%       get_volumeflow_outof_equilibrium(plant_id, equilibrium, ...) 
%
%% Description
% |get_volumeflow_outof_equilibrium(plant_id, equilibrium)| returns the
% volumeflow out of the given |equilibrium| which must belong to the given
% plant ID |plant_id|. The volumeflow is the substrate feed and the sludge
% pumped between digesters. Both are also saved to the standard files
% 'volumeflow_..._const.mat'. Basically an |equilibrium| contains
% information about state and substrate feed. The first information is
% gotten, calling:
% <matlab:doc('biogas_scripts/get_initstate_outof_equilibrium')
% biogas_scripts/get_initstate_outof_equilibrium>. 
%
%%
% @param |plant_id| : char with the plant's ID
%
%% <<equilibrium/>> 
%
%%
% @param |id_write| : char only needed when |writetofile == 1|. |id_write|
% is shown in the filename, usually it is a number. 
%
%%
% @param |lenGenomSubstrate| : number of steps the substrate feed has
% inside the given |equilibrium|. scalar integer. Default: 1.
%
%%
% @param |const_user| : char. 
%
% * 'const' : even if |lenGenomSubstrate > 1| only the first volumeflow is
% returned in |substrate_feed| and saved in file, if |writetofile| is 1.
% Filenames have 'const' in their name. 
% * 'user' : if |lenGenomSubstrate > 1| then the complete feed is written
% in 'user' files (only if |writetofile| is 1) and returned in
% |substrate_feed|. if |lenGenomSubstrate == 1|, then 'user' files with a
% constant substrate feed are created. 
%
%%
% @param |writetofile| : defines if volumeflow variables are saved to
% harddisk or not
%
% * 0 : do not save volumeflow variables to harddisk, just return them 
% * 1 : write the volumeflow variables in files calling
% <createvolumeflowfile.html biogas_scripts/createvolumeflowfile>. 
%
%%
% @return |substrate_feed| : is a matrix with number of rows equal to
% number of substrates and number of columns equal to |lenGenomSubstrate|.
% The content of the cells is the feed of the substrates measured in m³/d.
%
%%
% @return |sludge| : is a matrix with number of rows equal to
% number of splits (see: <..\getnumdigestersplits.html
% biogas_scripts/getNumDigesterSplits>) and number of columns equal to
% |lenGenomPump|, which is always 1 in the current implementation.  
% The content of the cells is the feed of the sludge pumped between
% digesters measured in m³/d. 
%
%% Example
% 
%

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ) );

load('equilibrium_gummersbach_optimum.mat')

[substrate_feed, sludge]= get_volumeflow_outof_equilibrium('gummersbach', equilibrium, '2');

disp(substrate_feed)
disp(sludge)

%%

% [substrate_feed, sludge]= get_volumeflow_outof_equilibrium('sunderhook', equilibriumInit, [], 2, 'const', 0)

% [substrate_feed, sludge]= get_volumeflow_outof_equilibrium('sunderhook', equilibriumInit, [], 2, 'user', 0)

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
% <a href="matlab:doc biogas_scripts/load_biogas_mat_files">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/createvolumeflowfile">
% biogas_scripts/createvolumeflowfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/getnumdigestersplits">
% biogas_scripts/getNumDigesterSplits</a>
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
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_initstate_outof_equilibrium">
% biogas_scripts/get_initstate_outof_equilibrium</a>
% </html>
%
%% TODOs
% # do documentation for script file
% # improve documentation
% # see TODOs
%
%% <<AuthorTag_DG/>>


