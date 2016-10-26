%% newpump
% Adds a new pump to the plant object, updates the pump list and
% some buttons on the gui.
%
function handles= newpump(handles, pump_start_destiny)
%% Release: 1.9

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

if ~iscellstr(pump_start_destiny) || numel(pump_start_destiny) ~= 2
  error('The 2nd parameter pump_start_destiny must be a 2dim cell string, but is %s!', ...
        class(pump_start_destiny));
end

%%

if isfield(handles, 'workspace')
  if isfield(handles.workspace, 'plant')
    handles.workspace.plant.addPump( ...
            biogas.pump( char(pump_start_destiny{1}), ...
                        char(pump_start_destiny{2}) ) );
  else
    error('plant is not a field of handles.workspace!');
  end
else
  error('workspace is not a field of handles!');
end

%%

plant= handles.workspace.plant;

n_pump= plant.getNumPumpsD();

pumplist= cell(n_pump, 1);

for ipump= 1:n_pump

  pumplist{ipump}= char(plant.getPumpID(ipump));
  
end

%%

set( handles.listPumps, 'String', pumplist);
set( handles.listPumps, 'Value',  n_pump);

%%

set(handles.cmdDeletePump, 'Enable', 'on');
set(handles.cmdEditPump,   'Enable', 'on');

if plant.getNumDigestersD() > 0 && ...
   plant.getNumPumpsD() > 0

  set(handles.cmdSave,   'Enable', 'on');
  set(handles.cmdSaveAs, 'Enable', 'on');

end

%%


