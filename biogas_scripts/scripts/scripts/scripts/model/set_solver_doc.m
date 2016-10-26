%% Syntax
%       set_solver()
%       set_solver(reltol)
%       set_solver(reltol, abstol)
%       set_solver(reltol, abstol, deltatime)
%       
%% Description
% |set_solver()| sets the solver for the <matlab:doc('gcs') gcs>. As solver
% 'ode15s' is used. The relative and absolute tolerance of the solver can
% be set by the two parameters of the function. 
%
%%
% @param |reltol| : double value defining the relative tolerance of the
% solver. Default: 1e-3.
%
%%
% @param |abstol| : double value defining the absolute tolerance of the
% solver. Default: 1e-6.
%
%%
% @param |deltatime| : maxstep of integrator, measured in days. positive
% double. Default: 0.5, that means 12 h.
%
%% Example
%
% 

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

load_biogas_system('plant_gummersbach');

set_solver(1e-4);

close_biogas_system('plant_gummersbach');

%clear; % why did I call clear here?


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('getactiveconfigset')">
% matlab/getActiveConfigSet</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('gcs')">
% matlab/gcs</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_blocks/init_biogas_plant_mdl')">
% biogas_blocks/init_biogas_plant_mdl</a>
% </html>
%
%% See Also
%
% <html>
% <a href= "matlab:doc('biogas_scripts/load_biogas_system')">
% biogas_scripts/load_biogas_system</a>
% </html>
% ,
% <html>
% <a href="close_biogas_system.html">
% biogas_scripts/close_biogas_system</a>
% </html>
%
%% TODOs
% # check documentation
% # die frage ist ob set_solver in init_biogas_plant_mdl aufgerufen werden
% sollte oder nicht besser nur beim öffnen des modells? bzw. vielleicht
% sollte man solver nur beim erstellen des modells aufrufen. ausnahme:
% maxstep. maxstep immer auf im block ausgewählte sampling time setzen, das
% unabhängig von debug machen. sampletime wird jetzt in sensors
% gespeichert. ich denke das ist jetzt ok so
%
%% <<AuthorTag_DG/>>


