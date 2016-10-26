%% newfermenter
% Adds a new digester to the plant object, updates the digester list and
% some buttons on the gui.
%
function handles= newfermenter(handles, fermenter_id_name)
%% Release: 1.9

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

if ~iscellstr(fermenter_id_name) || numel(fermenter_id_name) ~= 2
  error('The 2nd parameter fermenter_id_name must be a 2dim cell string, but is %s!', ...
        class(fermenter_id_name));
end

%%

if isfield(handles, 'workspace')
  if isfield(handles.workspace, 'plant')
    % fügt auch gleich substrate_transport zu digester zu
    handles.workspace.plant.addDigester( ...
            biogas.digester( char(fermenter_id_name{1}), ...
                             char(fermenter_id_name{2}) ) );
  else
    error('plant is not a field of handles.workspace!');
  end
else
  error('workspace is not a field of handles!');
end

%%

try
  plant= handles.workspace.plant;
catch ME
  error('plant is not a field of handles.workspace!');
end

n_fermenter= plant.getNumDigestersD();

fermenterlist= cell(n_fermenter, 1);

for ifermenter= 1:n_fermenter

  fermenterlist{ifermenter}= char(plant.getDigesterName(ifermenter));

end

%%

set( handles.listDigesters, 'String', fermenterlist);
set( handles.listDigesters, 'Value',  1);

%%

set(handles.cmdDeleteFermenter, 'Enable', 'on');
set(handles.cmdEditFermenters,  'Enable', 'on');

if plant.getNumCHPsD() > 0 && ...
   plant.getNumPumpsD() > 0

  set(handles.cmdSave,   'Enable', 'on');
  set(handles.cmdSaveAs, 'Enable', 'on');

end

%%
    

