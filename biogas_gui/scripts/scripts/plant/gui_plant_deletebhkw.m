%% gui_plant_deletebhkw
% Deletes selected bhkw out of list and plant object, updates list and
% some buttons.
%
function handles= gui_plant_deletebhkw(handles)
%% Release: 1.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%

index= get(handles.listPlants, 'Value');

if isfield(handles, 'workspace')
  if isfield(handles.workspace, 'plant')
  
    n_bhkw= handles.workspace.plant.getNumCHPsD;

  else
    error('plant is not a field of handles.workspace!');
  end
else
  error('workspace is not a field of handles!');
end

handles.workspace.plant.deleteCHP(index);

%%

index_list= true(1,n_bhkw);

index_list(1,index)= 0;

liststring= get(handles.listPlants, 'String');

liststring= liststring(index_list);

set(handles.listPlants, 'String', liststring);

%%

if index < n_bhkw
  set(handles.listPlants, 'Value', index);
else
  set(handles.listPlants, 'Value', index - 1);
end

%%

if n_bhkw <= 1 % because now its zero

  set(handles.cmdDeleteBHKW, 'Enable', 'off');
  set(handles.cmdEditBHKWs,  'Enable', 'off');
  set(handles.cmdSave,       'Enable', 'off');
  set(handles.cmdSaveAs,     'Enable', 'off');

else

  set(handles.cmdDeleteBHKW, 'Enable', 'on');
  set(handles.cmdEditBHKWs, 'Enable', 'on');

  if handles.workspace.plant.getNumDigestersD() > 0 && ...
     handles.workspace.plant.getNumPumpsD() > 0

    set(handles.cmdSave,   'Enable', 'on');
    set(handles.cmdSaveAs, 'Enable', 'on');

  end
    
end

%%


