%% mm_saveDataToFile
% Save substrate_network_min/max_...mat on GUI 
% <set_input_stream_min_max.html set_input_stream_min_max>.
%
%% Toolbox
% |mm_saveDataToFile| belongs to the _Biogas Plant Modeling_ Toolbox
% and is an internal function.
%
%% Release
% Approval for Release 1.4, to get the approval for Release 1.5 make a
% thorough review, Daniel Gaida 
%
%% Syntax
%       handles= mm_saveDataToFile(handles)
%
%% Description
% |handles= mm_saveDataToFile(handles)| saves
% substrate_network_min/max_...mat on GUI <set_input_stream_min_max.html
% set_input_stream_min_max>. 
%
%%
% @param |handles| : handle of gui
%
%%
% @return |handles| : handle of gui
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
function handles= mm_saveDataToFile(handles)

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 1st parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

%%

if isfield(handles, 'substrate') && ~isempty(handles.substrate)
   
  %%
  
  n_substrates= handles.substrate.getNumSubstratesD();

  for isubstrate= 1:n_substrates

    %%
    
    for ifermenter= 1:handles.plant.getNumDigestersD()          

      %%
      
      hObject= handles.('txtSubstrateFlowMin')(...
               isubstrate + (ifermenter - 1)*n_substrates,1);

      digit= str2double(get(hObject,'String'));

      handles.substrate_network_min(isubstrate,ifermenter)= digit;

      hObject= handles.('txtSubstrateFlowMax')(...
               isubstrate + (ifermenter - 1)*n_substrates,1);

      digit= str2double(get(hObject,'String'));

      handles.substrate_network_max(isubstrate,ifermenter)= digit;

    end

  end

  %%
  
  filename= fullfile(handles.model_path, ...
            sprintf('substrate_network_min_%s.mat', handles.plantID));

  save( filename, '-struct', 'handles', 'substrate_network_min');

  %%
  
  filename= fullfile(handles.model_path, ...
            sprintf('substrate_network_max_%s.mat', handles.plantID));

  save( filename, '-struct', 'handles', 'substrate_network_max'); 

end

%%


