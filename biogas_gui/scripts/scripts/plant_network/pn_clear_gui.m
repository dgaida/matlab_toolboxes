%% pn_clear_gui
% Clears the <gui_plant_network.html gui_plant_network>
%
function handles= pn_clear_gui(handles)
%% Release: 1.8

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%

if isfield(handles, 'plant') && isfield(handles, 'togConnect')
    
  %%
  
  n_fermenter= handles.plant.getNumDigestersD();

  for ifermenter= 1:n_fermenter

    for ifermenterIn= 1:n_fermenter + 1

      delete(handles.togConnect(ifermenter, ifermenterIn));

      if ifermenter == 1
        delete(handles.lblFermenterIn(ifermenterIn, 1));
      end

    end

    delete(handles.lblFermenterOut(ifermenter, 1));

  end

  %%
  
  handles= rmfield(handles, 'togConnect');

  handles= rmfield(handles, 'lblFermenterIn');

  handles= rmfield(handles, 'lblFermenterOut');

  %%
  
  set(handles.frmPlantNetwork, 'visible', 'off');
  set(handles.cmdSave,         'enable',  'off');

  %%
  
end

%%


