%% gui_plant_deletepump
% Deletes selected pump out of list and plant object, updates list and
% some buttons.
%
function handles= gui_plant_deletepump(handles)
%% Release: 1.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%

index= get(handles.listPumps, 'Value');

if isfield(handles, 'workspace')
  if isfield(handles.workspace, 'plant')
  
    n_pumps= handles.workspace.plant.getNumPumpsD();

  else
    error('plant is not a field of handles.workspace!');
  end
else
  error('workspace is not a field of handles!');
end

handles.workspace.plant.deletePump(index);

%%

index_list= true(1,n_pumps);

index_list(1,index)= 0;

liststring= get(handles.listPumps, 'String');

liststring= liststring(index_list);

set(handles.listPumps, 'String', liststring);

%%

if index < n_pumps
  set(handles.listPumps, 'Value', index);
else
  set(handles.listPumps, 'Value', index - 1);
end

%%

if n_pumps <= 1 % because now its zero

  set(handles.cmdDeletePump, 'Enable', 'off');
  set(handles.cmdEditPump,   'Enable', 'off');
  set(handles.cmdSave,       'Enable', 'off');
  set(handles.cmdSaveAs,     'Enable', 'off');

else

  set(handles.cmdDeletePump, 'Enable', 'on');
  set(handles.cmdEditPump,   'Enable', 'on');

  if handles.workspace.plant.getNumDigestersD() > 0 && ...
     handles.workspace.plant.getNumCHPsD() > 0

    set(handles.cmdSave,   'Enable', 'on');
    set(handles.cmdSaveAs, 'Enable', 'on');

  end
    
end

%%


