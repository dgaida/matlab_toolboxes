%% checkPumpFluxInputData
% Checks all flux text fields on validity of GUI
% <set_input_stream.html set_input_stream>.
%
function [handles, err_flag]= checkPumpFluxInputData(handles)
%% Release: 1.4

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 2, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%

n_pump_fluxes= size(handles.pumpFlux,1);

err_flag= 0;

%%

for ipumpflux= 1:n_pump_fluxes
    
  pumpflux= str2double( ...
                 get(handles.txtPumpFlux(ipumpflux,1), 'String') );

  %%
  
  if ( isnan( pumpflux ) || pumpflux < 0 )

    %%
    %warning('The given pump flow amount for %s is not valid.', ...
     %        get(handles.lblPumpFlux(ipumpflux,1), ...
      %       'String'));

    errordlg(...
        sprintf( ['Die eingegebene Menge für ''%s'' ', ...
        'ist nicht gültig!'], ...
        get(handles.lblPumpFlux(ipumpflux,1), 'String') ), ...
        'Speichern fehlgeschlagen');

    err_flag= 1;

    break;

  end
 
end

%%


