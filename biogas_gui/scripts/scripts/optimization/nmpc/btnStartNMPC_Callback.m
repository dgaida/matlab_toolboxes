%% btnStartNMPC_Callback
% Executes on button press in btnStartNMPC.
%
function btnStartNMPC_Callback(hObject, eventdata, handles)
% hObject    handle to btnStartNMPC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 3rd parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

%%

switch ( get(handles.popOptMethod_nmpc,'Value') )
  case 1
      method= 'GA';
  case 2
      method= 'PSO';
  case 3
      method= 'ISRES';
  case 4
      method= 'DE';
  case 5
      method= 'CMAES';
  case 6
      method= 'PS';
end

%%

no_generations= str2double( get(handles.txtNoGenerationen_nmpc, 'String') );
pop_size=       str2double( get(handles.txtPopSize_nmpc,        'String') );


%%

TSmax= str2double( get(handles.txtTSmax, 'String') );

fitness_params= load_biogas_mat_files(handles.plantID, [], 'fitness_params');
            
fitness_params.TS_feed_max= TSmax;

%% TODO
% das ist hier falsch, wenn dann muss hier plant.manure gesetzt werden,
% weiﬂ aber nicht ob das gewollt ist
%fitness_params.manurebonus= get(handles.chkManureBonus, 'Value');

%save( ['fitness_params_', handles.plantID, '.mat'], 'fitness_params' );
fitness_params.saveAsXML(['fitness_params_', handles.plantID, '.xml']);

%%

substrate_ineq= setLinearManureBonusConstraint( ...
                         handles.substrate, handles.plant, ...
                         get(handles.chkManureBonus, 'Value') );

save( ['substrate_ineq_', handles.plantID, '.mat'], 'substrate_ineq' );


%%

if strcmp(method, 'GA')
    set(handles.lblGenText,    'Visible', 'on');
    set(handles.lblGeneration, 'String', sprintf('0 / %i', no_generations));
    set(handles.lblGeneration, 'Visible', 'on');
else
    set(handles.lblGenText,    'Visible', 'off');
    set(handles.lblGeneration, 'Visible', 'off');
end
    
%%
% set mouse pointer to watch

handles.guifig= gcf;
set(gcf, 'pointer', 'watch');


%% 
% var initialization

global id_read id_write

plant_id= handles.plantID;

change_type_op= get(handles.change_type_edit, 'Value');

if change_type_op == 1
  change_type= 'percentual';
else
  change_type= 'absolute';
end

change= str2double ( get(handles.change_edit, 'String') );
N=      str2double ( get(handles.N_edit,      'String') );

timespan=        str2double ( get(handles.prediction_horizon_edit, 'String') );
control_horizon= str2double ( get(handles.control_horizon_edit,    'String') );
     
%%

if get(handles.chkParallel, 'Value') == 1
    parallel= 'multicore';
    nWorker= str2double(get(handles.txtNWorker,'String'));
else
    parallel= 'none';
    nWorker= 1;
end

% pop_size= str2double( get(handles.txtPopSize,'String') );
% nGenerations= str2double( get(handles.txtNoGenerationen,'String') );

%%

if get(handles.fit_trig_checkbox, 'Value') == 1;
    trg = 'on';
    trg_opt = str2double ( get(handles.fit_trg_edit, 'String') );
else 
    trg = 'off';
    trg_opt = -Inf;
end
    
% in the future 'useInitPop' to be used in optimization

%% 
% NMPC call

% varargout= nonlinearMPC(plant_id, method, change_type, change, N, ...
%                         timespan, control_horizon, id_read, id_write,...
%                         parallel, nWorker, pop_size, nGenerations,...
%                         OutputFcn, useInitPop, broken_sim, delete_db, ...
%                         database_name, trg, trg_opt, gui_opt);
  
                    
[equilibrium , u, fitness, plant, substrate, plant_id] = ...
                nonlinearMPC(plant_id, method, change_type, change, N, ...
                        timespan, control_horizon, id_read, id_write, ...
                        parallel, nWorker, pop_size, no_generations, ...
                        [], [], [], 'on', [], trg, trg_opt, 'on');

save nmpc_results equilibrium  u fitness plant substrate plant_id

%%
% reset mouse pointer to standard

set(handles.guifig, 'pointer', 'arrow');

%%

gui_showOptimResults(equilibrium, handles.plantID, handles.model_path, ...
                     'WindowStyle', 'modal');

%%


