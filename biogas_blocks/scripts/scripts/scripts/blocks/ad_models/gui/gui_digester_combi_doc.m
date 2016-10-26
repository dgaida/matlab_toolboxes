%% Syntax
%       gui_digester_combi()
%       gui_digester_combi(plant)
%       gui_digester_combi(plant, fermenter_name)
%       
%% Description
% |gui_digester_combi()| opens a gui, where the state of the fermenter is
% shown during the simulation. The gui is opened by the ADM1 blocks ' with
% gui'.
%
%%
% |gui_digester_combi(plant)| shows the state of the 1st fermenter in the
% |plant| object.
% 
%% <<plant/>>
%%
% |gui_digester_combi(plant, fermenter_name)| shows the fermenter with name
% |fermenter_name| in the gui. The named fermenter must be defined inside
% the |plant| object.
%
%%
% @param |fermenter_name| : char or cell with the name of the fermenter.
%
%% Example
% 
%

[substrate, plant]= load_biogas_mat_files('gummersbach');

mygui= gui_digester_combi(plant, 'Hauptfermenter');

%%
% directly after the gui is opened, close it again, otherwise the timer is
% running endless

handle= guidata(mygui);

% stop timer
stop(handle.tmr);      

% close figure
delete(handle.guifig);

%% Dependencies
% 
% This function calls:
%
% -
%
% and is called by:
%
% <html>
% <a href="matlab:doc('callback_adm1_gui')">
% Callback_ADM1_gui</a>
% </html>
%
%% See also
% 
% <html>
% <a href="matlab:doc('adm1de')">
% ADM1DE</a>
% </html>
%
%% TODOs
% # make the gui more safe
% # improve documentation
%
%% <<AuthorTag_DG/>>


