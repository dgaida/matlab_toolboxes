%% btnSave_Callback
% Executes on button press in btnSave.
%
function btnSave_Callback(hObject, eventdata, handles)
%% Release: 1.4

% hObject    handle to btnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd')

%%

if strcmp( get(handles.panSubstrate, 'Visible'), 'on')
    
  %%
  
  [handles, err_flag]= checkInputData(handles);

  %%
  
  if ~err_flag

    handles= saveDataToFile(handles);

    disp('Successfully saved substrate flow data!');

    whatwassaved= 'Substrat Mengen';

  else
    disp('Saving failed!');

    %errordlg('Speichern fehlgeschlagen!', 'Speichern fehlgeschlagen');

    return;
  end

else

  %%
  
  [handles, err_flag]= checkPumpFluxInputData(handles);

  if ~err_flag

    handles= savePumpFluxDataToFile(handles);

    disp('Successfully saved pump stream data!');

    whatwassaved= 'Fermenter Flüsse';

  else
    disp('Saving failed!');

    return;
  end

end


%%

correctpath= strcmp(get(handles.popPlant, 'enable'), 'off');

if ( correctpath )

  msgbox(sprintf(['Daten für die %s wurden erfolgreich geschrieben. ', ...
          'Sie können jetzt eine neue Simulation starten.'], ...
          whatwassaved), ...
          'Daten erfolgreich geschrieben', ...
          'none');

else

  msgbox(sprintf(['Daten für die %s wurden erfolgreich im aktuellen Pfad geschrieben. ', ...
          'Um eine neue Simulation starten zu können, müssen Sie die ', ...
          'Dateien ''volumeflow_..._const.mat'' noch vorher in den Pfad des ', ...
          'Simulationsmodells kopieren! ', ...
          'Um dies in Zukunft nicht mehr machen zu müssen, sollten Sie ', ...
          'über ''Durchsuchen...'' direkt den Pfad zum Modell angeben.'], ...
          whatwassaved), ...
          'Vorsicht: Hinweis!', 'help');

end

%%

guidata(hObject, handles);

%%


