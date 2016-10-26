%% checkInputData
% Checks all substrate text fields on validity of GUI
% <set_input_stream.html set_input_stream>.
%
function [handles, err_flag]= checkInputData(handles)
%% Release: 1.4

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 2, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%

n_substrate= handles.substrate.getNumSubstratesD();

err_flag= 0;

%%

for isubstrate= 1:n_substrate
    
  %%
  
  substrateflow= str2double( ...
                 get(handles.txtSubstrateFlow(isubstrate,1), 'String') );

  %%
  
  if ( isnan( substrateflow ) || substrateflow < 0 )

    %%
    %warning('The given substrate amount for %s is not valid.', ...
     %        get(handles.lblSubstrateFlow(isubstrate,1), ...
      %       'String'));

    errordlg(...
        sprintf( ['Die eingegebene Substratmenge für ''%s'' ', ...
        'ist nicht gültig!'], ...
        get(handles.lblSubstrateFlow(isubstrate,1), 'String') ), ...
        'Speichern fehlgeschlagen');

    err_flag= 1;

    break;

  end

end

%%


