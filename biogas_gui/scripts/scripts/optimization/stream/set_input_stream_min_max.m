%% set_input_stream_min_max
% Set the substrate input stream/mixture min and max of a plant. 
%
%% Toolbox
% |set_input_stream_min_max| belongs to the _Biogas Plant Modeling_ Toolbox.
%
%% Release
% Approval for Release 1.1, to get the approval for Release 1.2 make the
% TODO, Daniel Gaida 
%
%% Syntax
%       set_input_stream_min_max()
%       
%% Description
% |set_input_stream_min_max()| opens a gui, where you can select a plant and set
% the substrate flow min/max for this plant.
%
%% Example
% |set_input_stream_min_max()|
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="mm_callActualizeGUI.html">
% mm_callActualizeGUI</a>
% </html>
%
% and is called by:
%
% (the user)
% 
%% See also
% 
% <html>
% <a href="matlab:doc('findexistingplants')">
% findExistingPlants</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('loadplantstructure')">
% loadPlantStructure</a>
% </html>
% ,
% <html>
% <a href="searchForModelFile.html">
% searchForModelFile</a>
% </html>
% ,
% <html>
% <a href="loadPlantNetworkBoundsFromFile.html">
% loadPlantNetworkBoundsFromFile</a>
% </html>
% ,
% <html>
% <a href="loadSubstrateNetworkBoundsFromFile.html">
% loadSubstrateNetworkBoundsFromFile</a>
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
function varargout = set_input_stream_min_max(varargin)
% SET_INPUT_STREAM_MIN_MAX M-file for set_input_stream_min_max.fig
%      SET_INPUT_STREAM_MIN_MAX, by itself, creates a new SET_INPUT_STREAM_MIN_MAX or raises the existing
%      singleton*.
%
%      H = SET_INPUT_STREAM_MIN_MAX returns the handle to a new SET_INPUT_STREAM_MIN_MAX or the handle to
%      the existing singleton*.
%
%      SET_INPUT_STREAM_MIN_MAX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SET_INPUT_STREAM_MIN_MAX.M with the given input arguments.
%
%      SET_INPUT_STREAM_MIN_MAX('Property','Value',...) creates a new SET_INPUT_STREAM_MIN_MAX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before set_input_stream_min_max_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to set_input_stream_min_max_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help set_input_stream_min_max

% Last Modified by GUIDE v2.5 17-Oct-2011 13:28:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @set_input_stream_min_max_OpeningFcn, ...
                   'gui_OutputFcn',  @set_input_stream_min_max_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


%%
% --- Outputs from this function are returned to the command line.
function varargout = set_input_stream_min_max_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
if isfield(handles, 'output')
    varargout{1} = handles.output;
else
    varargout{1} = [];
end


%%
% --- Executes on selection change in mm_popPlant.
function mm_popPlant_Callback(hObject, eventdata, handles)
% hObject    handle to mm_popPlant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%handles= saveDataToFile(handles);

% returns mm_popPlant contents as cell array
contents= cellstr(get(hObject,'String')); 
% returns selected item from mm_popPlant

if get(hObject,'Value') > 1

    handles.plantName= deblank(contents{get(hObject,'Value')});
    handles= mm_callActualizeGUI(handles);

end

% Update handles structure
guidata(hObject, handles);


%%
% --- Executes during object creation, after setting all properties.
function mm_popPlant_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mm_popPlant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% returns mm_popPlant contents as cell array
contents= cellstr(get(hObject,'String')); 
% returns selected item from mm_popPlant
handles.plantName= contents{get(hObject,'Value')}; 

%handles= actualizeGui(handles);

% Update handles structure
guidata(hObject, handles);


%%
% --- Executes when user attempts to close set_input_stream_min_max.
function set_input_stream_min_max_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to set_input_stream_min_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%delete(hObject);

%return;

%saveDataToFile(handles);

delete(handles.axes2);
delete(handles.axes3);

% Hint: delete(hObject) closes the figure
delete(hObject);


%%
% --- Executes during object creation, after setting all properties.
function set_input_stream_min_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_input_stream_min_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.plantID= [];
handles.plantName= [];
handles.plant= [];
handles.substrate= [];
handles.plant_network= [];
%handles.substrateflow= [];
%handles.pumpFlux= [];
handles.model_path= [];

guidata(hObject, handles);


%%
% --- Executes on slider movement.
function sliderSubstrate_Callback(hObject, eventdata, handles)
% hObject    handle to sliderSubstrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


%%
% --- Executes during object creation, after setting all properties.
function sliderSubstrate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderSubstrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%%
% --- Executes on button press in radSubstrate.
function radSubstrate_Callback(hObject, eventdata, handles)
% hObject    handle to radSubstrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radSubstrate


%%
% --- Executes on button press in radPumpFlux.
function radPumpFlux_Callback(hObject, eventdata, handles)
% hObject    handle to radPumpFlux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radPumpFlux


%%
% --- Executes when selected object is changed in radPanel.
function radPanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in radPanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

radTag= get(eventdata.NewValue, 'Tag');

if strcmp(radTag, 'radSubstrate')
    
    set(handles.panSubstrate, 'Visible', 'on');
    set(handles.panPumpFlux, 'Visible', 'off');

else

    set(handles.panSubstrate, 'Visible', 'off');
    set(handles.panPumpFlux, 'Visible', 'on');
    
end


%%
% --- Executes when selected object is changed in radpanelFermenter.
function radpanelFermenter_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in radpanelFermenter 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

radTag= get(eventdata.NewValue, 'Tag');
radTagOld= get(eventdata.OldValue, 'Tag');

if (str2double(radTagOld) <= size(handles.panFermenter, 1))
    set(handles.panFermenter(str2double(radTagOld),1), 'Visible', 'off');
end

if (str2double(radTag) <= size(handles.panFermenter, 1))
    set(handles.panFermenter(str2double(radTag),1), 'Visible', 'on');
end  

%%


