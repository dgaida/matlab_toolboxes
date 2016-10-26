%% gui_plant_enable_elements
% En-/Disable elements on <gui_plant.html gui_plant>
%
function handles= gui_plant_enable_elements(handles, value)
%% Release: 1.9

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

validatestring(value, {'on', 'off'}, mfilename, 'value', 2);
               
%%

set(handles.but_fileselect, 'enable', value);
set(handles.edit_Tout,      'enable', value);
set(handles.edit_name,      'enable', value);

%%

if ~isempty(get(handles.listPlants,    'Value'))  && ...
            get(handles.listPlants,    'Value')   && ...
   ~isempty(get(handles.listDigesters, 'Value'))  && ...
            get(handles.listDigesters, 'Value')   && ...
   ~isempty(get(handles.listPumps,     'Value'))  && ...
            get(handles.listPumps,     'Value')   && ...
   ~isempty(get(handles.listPlants,    'String')) && ...
   ~isempty(get(handles.listDigesters, 'String')) && ...
   ~isempty(get(handles.listPumps,     'String'))
 
  set(handles.cmdSave,   'enable', value);
  set(handles.cmdSaveAs, 'enable', value);  
  
else
  set(handles.cmdSave,   'enable', 'off');
  set(handles.cmdSaveAs, 'enable', 'off');
end

%%

set(handles.btnNewPlant,   'enable', value);
set(handles.listDigesters, 'enable', value);
set(handles.listPlants,    'enable', value);
set(handles.listPumps,     'enable', value);

%%

if ~isempty(get(handles.listPlants, 'Value'))  && ...
            get(handles.listPlants, 'Value')   && ...
   ~isempty(get(handles.listPlants, 'String'))
  set(handles.cmdDeleteBHKW, 'enable', value);
  set(handles.cmdEditBHKWs,  'enable', value);
else
  set(handles.cmdDeleteBHKW, 'enable', 'off');
  set(handles.cmdEditBHKWs,  'enable', 'off');
end

%%

if ~isempty(get(handles.listDigesters, 'Value'))  && ...
            get(handles.listDigesters, 'Value')   && ...
   ~isempty(get(handles.listDigesters, 'String'))
  set(handles.cmdDeleteFermenter, 'enable', value);
  set(handles.cmdEditFermenters,  'enable', value);
else
  set(handles.cmdDeleteFermenter, 'enable', 'off');
  set(handles.cmdEditFermenters,  'enable', 'off');
end

%%

if ~isempty(get(handles.listPumps, 'Value'))  && ...
            get(handles.listPumps, 'Value')   && ...
   ~isempty(get(handles.listPumps, 'String'))
  set(handles.cmdDeletePump, 'enable', value);
  set(handles.cmdEditPump,   'enable', value);
else
  set(handles.cmdDeletePump, 'enable', 'off');
  set(handles.cmdEditPump,   'enable', 'off');
end

%%

set(handles.cmdAddBHKW,      'enable', value);
set(handles.cmdAddFermenter, 'enable', value);
set(handles.cmdAddPump,      'enable', value);

set(handles.popPlants,       'enable', value);

%%


