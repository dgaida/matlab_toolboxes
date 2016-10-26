%% saveDataToFile
% Save volumeflow data of substrates on GUI <set_input_stream.html
% set_input_stream> in files.
%
function handles= saveDataToFile(handles)
%% Release: 1.4

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st')

%%
%eventdata= [];

% for isubstrate= 1:size(handles.substrate.ids,2)
%    
%     hObject= handles.('txtSubstrateFlow')(isubstrate,1);
%     
%     handles= saveSubstrateFlow(hObject, eventdata, handles, isubstrate);
%     
% end

%%

if isfield(handles, 'substrate') && ~isempty(handles.substrate)
    
  %substrateflow= handles.substrateflow;
  %pumpFlux= handles.pumpFlux;

  for isubstrate= 1:handles.substrate.getNumSubstratesD()

    %%
    
    hObject= handles.('txtSubstrateFlow')(isubstrate,1);

    digit= str2double(get(hObject,'String'));

    %%
    
    createvolumeflowfile('const', ...
        digit, ...
        char(handles.substrate.getID(isubstrate)), ...
        [], [], [], 'm3_day', 1, handles.model_path);

    %%  
      
  end

end

%%


