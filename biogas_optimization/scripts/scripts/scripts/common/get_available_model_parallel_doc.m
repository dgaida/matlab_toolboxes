%% Syntax
%       [fcn]= get_available_model_parallel(nWorker, fcn)
%       
%% Description
% |[fcn]= get_available_model_parallel(nWorker, fcn)| returns a free model,
% if we are working in parallel mode. If we are not working in parallel
% (|nWorker == 1|), then this function does nothing and just returns the
% given |fcn|. 
%
% The function runs a while loop from |i= 1| to |nWorker| and checks whether the
% file |[fcn, '_', i, '.mat']| does exist. If it does exist, then this
% means that the |i|th model is free (not simulating at the moment). Then
% this mat file is deleted and the corresponding model is load and saved
% again. The corresponding |fcn| is returned. If no mat file exists, then
% the while loop runs until some mat file is found. After the simulation
% the corresponding mat file must be created again, which is done in
% <matlab:doc('biogas_optimization/simbiogasplant')
% biogas_optimization/simBiogasPlant>. 
%
%% <<nWorker/>>
%%
% @param |fcn| : ['plant_', plant_id] specifiying the name of the original
% plant model. 
%
%%
% @return |fcn| : the name of the plant model that can be used for
% simulation. It is of type ['plant_', plant_id, |some integer|]
%
%% Example
%
%
%
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
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/lastwarn">
% matlab/lastwarn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc simulink/load_system">
% simulink/load_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc simulink/save_system">
% simulink/save_system</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_optimization/simbiogasplant">
% biogas_optimization/simBiogasPlant</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_optimization/findoptimalequilibrium">
% biogas_optimization/findOptimalEquilibrium</a>
% </html>
%
%% TODOs
% # improve documentation a bit
% # check code
% # check appearance of documentation
% # maybe add example
%
%% <<AuthorTag_DG/>>


