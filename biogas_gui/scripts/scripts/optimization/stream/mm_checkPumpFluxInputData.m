%% mm_checkPumpFluxInputData
% Checks all flux text fields on validity of GUI
% <set_input_stream_min_max.html set_input_stream_min_max>.
%
%% Toolbox
% |mm_checkPumpFluxInputData| belongs to the _Biogas Plant Modeling_ Toolbox
% and is an internal function.
%
%% Release
% Approval for Release 1.4, to get the approval for Release 1.5 make a
% thorough review, Daniel Gaida 
%
%% Syntax
%       [handles, err_flag]= mm_checkPumpFluxInputData(handles)
%
%% Description
% |[handles, err_flag]= mm_checkPumpFluxInputData(handles)| checks all flux text
% fields on validity of GUI <set_input_stream_min_max.html set_input_stream_min_max>.
%
%%
% @param |handles| : handle of gui
%
%%
% @return |handles| : handle of gui
%
%%
% @return |err_flag| : 
%
%% Example
%
% 
%% Dependencies
% 
% This function calls:
%
% -
%
% and is called by:
%
% <html>
% <a href="mm_btnSave_Callback.html">
% mm_btnSave_Callback</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="set_input_stream_min_max.html">
% set_input_stream_min_max</a>
% </html>
% ,
% <html>
% <a href="stream\set_input_stream.html">
% set_input_stream</a>
% </html>
%
%% TODOs
%
%
%% Author
% Daniel Gaida, M.Sc.EE.IT
%
% Cologne University of Applied Sciences (Campus Gummersbach)
%
% Department of Automation & Industrial IT
%
% GECO-C Group
%
% daniel.gaida@fh-koeln.de
%
% Copyright 2010-2011
%
% Last Update: 17.10.2011
%
%% Function
%
function [handles, err_flag]= mm_checkPumpFluxInputData(handles)

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 2, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 1st parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

%%

n_pump_fluxes= size(handles.pumpFlux,1);

err_flag= 0;

%%

for ipumpflux= 1:n_pump_fluxes
    
  pumpfluxmin= str2double( ...
                 get(handles.txtPumpFluxMin(ipumpflux,1), 'String') );

  pumpfluxmax= str2double( ...
                 get(handles.txtPumpFluxMax(ipumpflux,1), 'String') );           

  %%
  
  if ( isnan( pumpfluxmin ) || pumpfluxmin < 0 || ...
       isnan( pumpfluxmax ) || pumpfluxmax < pumpfluxmin )

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


