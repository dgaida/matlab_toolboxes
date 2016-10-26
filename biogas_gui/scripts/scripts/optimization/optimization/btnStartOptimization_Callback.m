%% btnStartOptimization_Callback
% Executes on button press on btnStartOptimization.
%
function btnStartOptimization_Callback(hObject, eventdata, handles)
%% Release: 1.5

% hObject    handle to btnStartOptimization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

switch ( get(handles.popOptMethod,'Value') )
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
  case 7
      method= 'SMS-EMOA';
end

%%

no_generations= str2double( get(handles.txtNoGenerationen_optima, 'String') );
popSize=        str2double( get(handles.txtPopSize_optima,        'String') );


%%

TSmax= str2double( get(handles.txtTSmax, 'String') );

fitness_params= load_biogas_mat_files(handles.plantID, [], 'fitness_params');
            
fitness_params.TS_feed_max= TSmax;

%% TODO
% das ist hier falsch, wenn dann muss hier plant.manure gesetzt werden,
% weiﬂ aber nicht ob das gewollt ist
%fitness_params.manurebonus= get(handles.chkManureBonus, 'Value');

%% TODO
% warning! changing value of nObjectives

% if (fitness_params.nObjectives < 2)
%   fitness_params.nObjectives= 2;
% end

%%

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

if get(handles.chkParallel, 'Value') == 1
    parallel= 'multicore';
    nWorker=  str2double(get(handles.txtNWorker,'String'));
else
    parallel= 'none';
    nWorker=  1;
end

%%

[equilibrium, u, fitness]= ...
    findOptimalEquilibrium(handles.plantID, method, 0, parallel, nWorker, ...
                           popSize, no_generations, ...
    @(options,state,flag)gaoutputfcn_slider(options,state,flag, handles), ...
    [], handles.optParams);

%equilibrium
%u
%fitness

%%
% reset mouse pointer to standard

set(handles.guifig, 'pointer', 'arrow');

%%

gui_showOptimResults(equilibrium, handles.plantID, handles.model_path, ...
                     'WindowStyle', 'modal');

%%


