%% savePumpFluxDataToFile
% Saves volumeflow data for fluxes between fermenters on GUI
% <set_input_stream.html set_input_stream> in files. 
%
function handles= savePumpFluxDataToFile(handles)
%% Release: 1.4

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st')

%%

if isfield(handles, 'txtPumpFlux') && ~isempty(handles.txtPumpFlux)
    
  %%
  
  for iPumpFlux= 1:size(handles.txtPumpFlux,1)

    %%
    
    hObject= handles.('txtPumpFlux')(iPumpFlux,1);

    digit= str2double(get(hObject, 'String'));

    pumpFluxID= get(hObject, 'Tag');

    %%
    
    createvolumeflowfile('const', ...
        digit, ...
        pumpFluxID, ...
        [], [], [], 'm3_day', 1, handles.model_path);

  end

end

%%


