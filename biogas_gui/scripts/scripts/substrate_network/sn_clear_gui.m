%% sn_clear_gui
% Clears the <gui_substrate_network.html gui_substrate_network>
%
function handles= sn_clear_gui(handles)
%% Release: 1.8

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%

if isfield(handles, 'plant') && isfield(handles, 'txtDistribution')

  %%
  
  n_fermenter= handles.plant.getNumDigestersD();
  n_substrate= handles.substrate.getNumSubstratesD();

  for ifermenter= 1:n_fermenter

    for isubstrate= 1:n_substrate

      delete(handles.txtDistribution(isubstrate, ifermenter));

      if ifermenter == 1
        delete(handles.lblSubstrate(isubstrate, 1));
      end

    end

    delete(handles.lblFermenter(ifermenter, 1));

  end

  %%
  
  handles= rmfield(handles, 'txtDistribution');

  handles= rmfield(handles, 'lblFermenter');

  handles= rmfield(handles, 'lblSubstrate');

  %%
  
  set(handles.frmSubstrateNetwork, 'visible', 'off');
  set(handles.cmdSave,             'enable',  'off');

  %%
  
end

%%


