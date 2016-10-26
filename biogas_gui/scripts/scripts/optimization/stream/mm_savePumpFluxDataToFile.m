%% mm_savePumpFluxDataToFile
% Saves plant_network_min/max_....mat files on GUI
% <set_input_stream_min_max.html set_input_stream_min_max>. 
%
%% Toolbox
% |mm_savePumpFluxDataToFile| belongs to the _Biogas Plant Modeling_ Toolbox
% and is an internal function.
%
%% Release
% Approval for Release 1.4, to get the approval for Release 1.5 make a
% thorough review, Daniel Gaida 
%
%% Syntax
%       handles= mm_savePumpFluxDataToFile(handles)
%
%% Description
% |handles= mm_savePumpFluxDataToFile(handles)| saves 
% plant_network_min/max_....mat files on GUI <set_input_stream_min_max.html
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
function handles= mm_savePumpFluxDataToFile(handles)

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 1st parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

%%

if isfield(handles, 'txtPumpFluxMin') && ~isempty(handles.txtPumpFluxMin)
    
  %%
  % Inf wird wieder überschrieben dort wo es verbindungen gibt
  % s. unten

  for ifermenterOut= 1:size(handles.plant_network,1)

    for ifermenterIn= 1:size(handles.plant_network,2)

      if handles.plant_network(ifermenterOut, ifermenterIn) > 0

        handles.plant_network_max(ifermenterOut, ifermenterIn)= Inf;

      end

    end

  end

  %%

  for iPumpFlux= 1:size(handles.txtPumpFluxMin,1)

    hObject= handles.('txtPumpFluxMin')(iPumpFlux,1);
    pumpFluxIDOut= str2double(get(hObject, 'Tag'));

    hObjectMax= handles.('txtPumpFluxMax')(iPumpFlux,1);
    pumpFluxIDIn= str2double(get(hObjectMax, 'Tag'));

    digit= str2double(get(hObject, 'String'));

    handles.plant_network_min(pumpFluxIDOut,pumpFluxIDIn)= digit;

    digit= str2double(get(hObjectMax, 'String'));

    handles.plant_network_max(pumpFluxIDOut,pumpFluxIDIn)= digit;

  end

  %%
  
  filename= fullfile(handles.model_path, ...
            sprintf('plant_network_min_%s.mat', handles.plantID));

  save( filename, '-struct', 'handles', 'plant_network_min');

  %%



  %%

  filename= fullfile(handles.model_path, ...
            sprintf('plant_network_max_%s.mat', handles.plantID));

  save( filename, '-struct', 'handles', 'plant_network_max'); 

end

%%


