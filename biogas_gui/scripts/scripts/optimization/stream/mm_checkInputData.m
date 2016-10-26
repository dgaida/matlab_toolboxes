%% mm_checkInputData
% Checks all substrate min/max text fields on validity of GUI
% <set_input_stream_min_max.html set_input_stream_min_max>.
%
%% Toolbox
% |mm_checkInputData| belongs to the _Biogas Plant Modeling_ Toolbox
% and is an internal function.
%
%% Release
% Approval for Release 1.4, to get the approval for Release 1.5 make a
% thorough review, Daniel Gaida 
%
%% Syntax
%       [handles, err_flag]= mm_checkInputData(handles)
%
%% Description
% |[handles, err_flag]= mm_checkInputData(handles)| checks all substrate 
% min/max text fields on validity of GUI <set_input_stream_min_max.html
% set_input_stream_min_max>. 
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
function [handles, err_flag]= mm_checkInputData(handles)

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 2, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 1st parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

%%

n_substrate= handles.substrate.getNumSubstratesD();

err_flag= 0;

%%

for isubstrate= 1:n_substrate
    
  for ifermenter= 1:handles.plant.getNumDigestersD()          

    %%
    
    fermenterName= char(handles.plant.getDigesterName(ifermenter));

    substrateflowmin= str2double( ...
      get(handles.txtSubstrateFlowMin(isubstrate + ...
                    (ifermenter - 1)*n_substrate,1), 'String') );

    substrateflowmax= str2double( ...
      get(handles.txtSubstrateFlowMax(isubstrate + ...
                    (ifermenter - 1)*n_substrate,1), 'String') );           

    %%
    
    if ( isnan( substrateflowmin ) || substrateflowmin < 0 || ...
         isnan( substrateflowmax ) || substrateflowmax < substrateflowmin )

      %%
      %warning('The given substrate amount for %s is not valid.', ...
       %        get(handles.lblSubstrateFlow(isubstrate,1), ...
        %       'String'));

      errordlg(...
          sprintf( ['Die eingegebene Substratmenge für ''%s'' ', ...
          'von Fermenter ''%s'' ist nicht gültig!'], ...
          get(handles.lblSubstrateFlow(isubstrate,1), 'String'), ...
          fermenterName), ...
          'Speichern fehlgeschlagen');

      err_flag= 1;

      break;

    end

    %%
    
    if err_flag == 1
      break;
    end

  end
 
end

%%


