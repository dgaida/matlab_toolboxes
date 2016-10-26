%% newbhkw
% Adds a new chp to the plant object, updates the chp list and
% some buttons on the gui.
%
function handles= newbhkw(handles, bhkw_id_name)
%% Release: 1.9

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

if ~iscellstr(bhkw_id_name) || numel(bhkw_id_name) ~= 2
  error('The 2nd parameter bhkw_id_name must be a 2dim cell string, but is %s!', ...
        class(bhkw_id_name));
end

%%

if isfield(handles, 'workspace')
  if isfield(handles.workspace, 'plant')
    handles.workspace.plant.addCHP( ...
            biogas.chp( char(bhkw_id_name{1}), ...
                        char(bhkw_id_name{2}) ) );
  else
    error('plant is not a field of handles.workspace!');
  end
else
  error('workspace is not a field of handles!');
end

%%

plant= handles.workspace.plant;

n_bhkw= plant.getNumCHPsD();

bhkwlist= cell(n_bhkw, 1);

for ibhkw= 1:n_bhkw

  bhkwlist{ibhkw}= char(plant.getCHPName(ibhkw));
  
end

%%

set( handles.listPlants, 'String', bhkwlist);
set( handles.listPlants, 'Value',  n_bhkw);

%%

set(handles.cmdDeleteBHKW, 'Enable', 'on');
set(handles.cmdEditBHKWs,  'Enable', 'on');

if plant.getNumDigestersD() > 0 && ...
   plant.getNumPumpsD() > 0

  set(handles.cmdSave,   'Enable', 'on');
  set(handles.cmdSaveAs, 'Enable', 'on');

end

%%


