%% gui_plant_deletefermenter
% Deletes selected fermenter out of list and plant object, updates list and
% some buttons.
%
function handles= gui_plant_deletefermenter(handles)
%% Release: 1.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%

index= get(handles.listDigesters, 'Value');

if isfield(handles, 'workspace')
  if isfield(handles.workspace, 'plant')
    
    n_fermenter= handles.workspace.plant.getNumDigestersD();
    
  else
    error('plant is not a field of handles.workspace!');
  end
else
  error('workspace is not a field of handles!');
end

handles.workspace.plant.deleteDigester(index);

%%

index_list= true(1,n_fermenter);

index_list(1,index)= 0;

liststring= get(handles.listDigesters, 'String');

liststring= liststring(index_list);

set(handles.listDigesters, 'String', liststring);

%%

if index < n_fermenter
  set(handles.listDigesters, 'Value', index);
else
  set(handles.listDigesters, 'Value', index - 1);
end

%%

if n_fermenter <= 1 % because now its zero
   
  set(handles.cmdDeleteFermenter, 'Enable', 'off');
  set(handles.cmdEditFermenters,  'Enable', 'off');
  set(handles.cmdSave,            'Enable', 'off');
  set(handles.cmdSaveAs,          'Enable', 'off');

else

  set(handles.cmdDeleteFermenter, 'Enable', 'on');
  set(handles.cmdEditFermenters,  'Enable', 'on');

  if handles.workspace.plant.getNumCHPsD() > 0 && ...
     handles.workspace.plant.getNumPumpsD() > 0

    set(handles.cmdSave,   'Enable', 'on');
    set(handles.cmdSaveAs, 'Enable', 'on');

  end
    
end

%%


