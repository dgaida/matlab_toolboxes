%% Preliminaries
% # The simulation model of the biogas plant must be load.
% # The name of the substrate feed block must be: 'Substrate Mixer
% (Digester)'. This is true by default. 
%
%% Syntax
%       set_volumeflow_type(fcn, type)
%
%% Description
% |set_volumeflow_type(fcn, type)| sets the volumeflow of the substrate
% feed block either to user, random or const (see |type|). This affects
% only a load model. After the model was closed and opened again the
% setting may be as before this method was called. 
%
%%
% @param |fcn| : char containing the name of the simulation model
% without file extension, e.g. 'plant_gummersbach'. 
%
%%
% @param |type| : char
%
% * 'const' : a constant substrate feed, the files volumeflow_..._const.mat
% are used (if feed is load from file). 
% * 'user' : a user defined substrate feed, the files volumeflow_..._user.mat
% are used (if feed is load from file). 
% * 'random' : a random substrate feed, the files volumeflow_..._random.mat
% are used (if feed is load from file). 
%
%% Example
%
%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

load_biogas_system('plant_gummersbach');

% seems to throw an error during publication
%set_volumeflow_type('plant_gummersbach', 'user');

close_biogas_system('plant_gummersbach');


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/dispmessage')">
% script_collection/dispMessage</a>
% </html>
% ,
% <html>
% <a href="matlab:doc find_system">
% matlab/find_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validatestring')">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/get_param_error')">
% script_collection/get_param_error</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/set_param_tc')">
% script_collection/set_param_tc</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/nmpc_simbiogasplantextended')">
% biogas_control/NMPC_simBiogasPlantExtended</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="load_biogas_system.html">
% load_biogas_system</a>
% </html>
% ,
% <html>
% <a href="close_biogas_system.html">
% close_biogas_system</a>
% </html>
% ,
% <html>
% <a href="setsavestateofadm1blocks.html">
% setSaveStateofADM1Blocks</a>
% </html>
%
%% TODOs
% # check appearance of documentation
% # look at TODO in script
%
%% <<AuthorTag_DG/>>

    
    