%% Syntax
%       [t, x, y, fitness]= simBiogasPlantBasic(plant_id)
%       [t, x, y, fitness]= simBiogasPlantBasic(plant_id, timespan)
%       [...]= simBiogasPlantBasic(plant_id, timespan, savestate)
%       [...]= simBiogasPlantBasic(plant_id, timespan, savestate,
%       use_history) 
%       [...]= simBiogasPlantBasic(plant_id, timespan, savestate,
%       use_history, init_substrate_feed) 
%       [...]= simBiogasPlantBasic(plant_id, timespan, savestate,
%       use_history, init_substrate_feed, doplots) 
%       [...]= simBiogasPlantBasic(plant_id, timespan, savestate,
%       use_history, init_substrate_feed, doplots, vol_type) 
%
%% Description
% |[t, x, y, fitness]= simBiogasPlantBasic(plant_id)| 
% simulates a biogas plant created with the library of the toolbox _Biogas
% Plant Modeling_. The biogas plant model must be in the present working
% directory and must belong to the plant with the ID: |plant_id|. The
% settings of the model are not changed, therefore the feed and the initial
% state are load from file, the workspace or whatever is selected inside
% the model. 
%
%% <<plant_id/>>
%%
% @return |t| : time vector of simulation, for more information see
% <matlab:doc('matlab/sim') matlab/sim>. 
%
%%
% @return |x| : state vector of simulation model, for more information see
% <matlab:doc('matlab/sim') matlab/sim>. 
%
%%
% @return |y| : output vector of simulation model, for more information see
% <matlab:doc('matlab/sim') matlab/sim>. 
%
%%
% @return |fitness| : fitness value of simulation, calculated by
% <matlab:doc('biogas_optimization/getrecordedfitnessextended')
% biogas_optimization/getRecordedFitnessExtended>. 
%
%%
% @param |timespan| : 2dim double vector with start and end value of time
% domain. Default: [0 100]. -> meaning: 100 days. 
%
%%
% @param |savestate| : char, either 'on' or 'off'. Default: 'off'. See
% also: <matlab:doc('biogas_scripts/savestateofadm1blocks')
% biogas_scripts/setSaveStateofADM1Blocks>. 
%
% * 'on' : the final state of the ADM1 models are saved inside the
% initstate variable. If it is saved to file, the workspace, ... depends on
% the setting selected inside the model. 
% * 'off' : the infal state is not saved. 
%
%%
% @param |use_history| : 0 or 1, integer (double) or boolean. Is used
% inside the function: <getrecordedfitnessextended.html
% getRecordedFitnessExtended>. 
%
% * 0 : default behaviour, just the last row of |y| is returned as
% |fitness|. 
% * 1 : First, each column of |y| is resampled onto a sampletime of 1 day.
% Then fitness is the sum of the resampled |y| values over each column.
% Therefore the fitness value depends on the simulation duration, given by
% |t|. To |fitness| also a terminal cost is added. It is just the last
% value in |y| for each column of |y| and gets a weight of 10 %. 
%
%%
% @param |init_substrate_feed| : this is the initial substrate feed of the
% plant, before the simulation is started. This is needed to calculate the
% change of the substrate feed from the initial to the one first applied to
% the plant. If this is unknown, it is assumed, that the feed which is
% applied in the beginning of the simulation is equal to the initial feed.
% It is in the responsibility of the user to assure this, otherwise the
% returned |fitness| value of this function will not be exact. It is a double matrix
% with number of rows equal to the substrates and number of columns equal
% to number of digesters. The values are the feeds meaaured in m³/d. 
%
%%
% @param |id_write| : 
%
%%
% @param |doplots| : 0 or 1
%
%% <<vol_type/>>
%% Example
% 
%
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('sim')">
% matlab/sim</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_system')">
% biogas_scripts/load_biogas_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/close_biogas_system')">
% biogas_scripts/close_biogas_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getrecordedfitnessextended')">
% biogas_optimization/getRecordedFitnessExtended</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/evalinmws')">
% script_collection/evalinMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_optimization/simbiogasplant')">
% biogas_optimization/simBiogasPlant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/simbiogasplantextended')">
% biogas_optimization/simBiogasPlantExtended</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getrecordedfitness')">
% biogas_optimization/getRecordedFitness</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getudotnorm')">
% biogas_optimization/getudotnorm</a>
% </html>
%
%% TODOs
% # check appearance of documentation
% # create an example
% # improve documentation, especially for numel(timespan) > 2
% # add the information, that for many substrate parameters there is the
% possibility to change their values during the simulation using mat files,
% see createdailyhydrograph_mat and create_substrateparams_from_source. 
%
%% <<AuthorTag_DG/>>

    
