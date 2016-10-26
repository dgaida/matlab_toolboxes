%% mm_btnSave_Callback
% Executes on button press in mm_btnSave.
%
%% Toolbox
% |mm_btnSave_Callback| belongs to the _Biogas Plant Modeling_ Toolbox
% and is an internal function.
%
%% Release
% Approval for Release 1.4, to get the approval for Release 1.5 make a
% thorough review, Daniel Gaida 
%
%% Syntax
%       mm_btnSave_Callback(hObject, eventdata, handles)
%
%% Description
% |mm_btnSave_Callback(hObject, eventdata, handles)| saves min/max bounds of
% substrates or volumeflow files for fluxes between fermenter on 
% GUI <set_input_stream_min_max.html set_input_stream_min_max> in files.
%
%%
% @param |hObject| : 
%
%%
% @param |eventdata| : 
%
%%
% @param |handles| : handle of gui
%
%% Example
%
% 
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="mm_saveDataToFile.html">
% mm_saveDataToFile</a>
% </html>
% ,
% <html>
% <a href="mm_checkInputData.html">
% mm_checkInputData</a>
% </html>
% ,
% <html>
% <a href="mm_savePumpFluxDataToFile.html">
% mm_savePumpFluxDataToFile</a>
% </html>
% ,
% <html>
% <a href="mm_checkPumpFluxInputData.html">
% mm_checkPumpFluxInputData</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="set_input_stream_min_max.html">
% set_input_stream_min_max.fig</a>
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
function mm_btnSave_Callback(hObject, eventdata, handles)
% hObject    handle to mm_btnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 3rd parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

%%

if strcmp( get(handles.panSubstrate, 'Visible'), 'on')
    
  %%
  
  [handles, err_flag]= mm_checkInputData(handles);

  %%
  
  if ~err_flag

      handles= mm_saveDataToFile(handles);

      disp('Successfully saved substrate flow data!');

      whatwassaved= 'Substrat Grenzen';

  else
      disp('Saving failed!');

      %errordlg('Speichern fehlgeschlagen!', 'Speichern fehlgeschlagen');

      return;
  end

else

  %%
  
  [handles, err_flag]= mm_checkPumpFluxInputData(handles);

  if ~err_flag

      handles= mm_savePumpFluxDataToFile(handles);

      disp('Successfully saved pump stream data!');

      whatwassaved= 'Fermenter Fluss Grenzen';

  else
      disp('Saving failed!');

      return;
  end
    
end


%%

correctpath= strcmp(get(handles.mm_popPlant, 'enable'), 'off');

if ( correctpath )

  msgbox(sprintf(['Daten für die %s wurden erfolgreich geschrieben. ', ...
            'Sie können jetzt einen Optimierungsprozess starten.'], ...
            whatwassaved), ...
            'Daten erfolgreich geschrieben', ...
            'none');
  
else
    
  if strcmp(whatwassaved, 'Substrat Grenzen')
        
    msgbox(sprintf(['Daten für die %s wurden erfolgreich im aktuellen Pfad geschrieben. ', ...
            'Um einen neuen Optimierungsprozess starten zu können, müssen Sie die ', ...
            'Dateien ''substrate_network_min_....mat'' und ', ...
            '''substrate_network_max_....mat'' noch vorher in den Pfad des ', ...
            'Optimierungsmodells kopieren! ', ...
            'Um dies in Zukunft nicht mehr machen zu müssen, sollten Sie ', ...
            'über ''Durchsuchen...'' direkt den Pfad zum Optimierungsmodell angeben.'], ...
            whatwassaved), ...
            'Vorsicht: Hinweis!', 'help');
    
  else
        
    msgbox(sprintf(['Daten für die %s wurden erfolgreich im aktuellen Pfad geschrieben. ', ...
            'Um einen neuen Optimierungsprozess starten zu können, müssen Sie die ', ...
            'Dateien ''plant_network_min_....mat'' und ', ...
            '''plant_network_max_....mat'' noch vorher in den Pfad des ', ...
            'Optimierungsmodells kopieren! ', ...
            'Um dies in Zukunft nicht mehr machen zu müssen, sollten Sie ', ...
            'über ''Durchsuchen...'' direkt den Pfad zum Optimierungsmodell angeben.'], ...
            whatwassaved), ...
            'Vorsicht: Hinweis!', 'help');
        
  end
    
end

%%

guidata(hObject, handles);

%%


