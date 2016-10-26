%% set_input_stream
% Set the substrate input stream/mixture of a plant. 
%
function varargout = set_input_stream(varargin)
%% Release: 1.1

% SET_INPUT_STREAM M-file for set_input_stream.fig
%      SET_INPUT_STREAM, by itself, creates a new SET_INPUT_STREAM or raises the existing
%      singleton*.
%
%      H = SET_INPUT_STREAM returns the handle to a new SET_INPUT_STREAM or the handle to
%      the existing singleton*.
%
%      SET_INPUT_STREAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SET_INPUT_STREAM.M with the given input arguments.
%
%      SET_INPUT_STREAM('Property','Value',...) creates a new SET_INPUT_STREAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before set_input_stream_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to set_input_stream_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help set_input_stream

% Last Modified by GUIDE v2.5 10-May-2010 09:08:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @set_input_stream_OpeningFcn, ...
                   'gui_OutputFcn',  @set_input_stream_OutputFcn, ...
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
% --- Executes just before set_input_stream is made visible.
function set_input_stream_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to set_input_stream (see VARARGIN)

% Choose default command line output for set_input_stream
handles.output = hObject;

for iimage= 2:3
    
  if iimage == 2
      data= get_gecoc_logo(get(handles.figure1, 'Color'));
  else
      data= get_company_logo(get(handles.figure1, 'Color'));
  end
  
  image(data, 'Parent', handles.(sprintf('axes%i', iimage)));

  clear data;

  axis(handles.(sprintf('axes%i', iimage)), 'off');

end

handles= findPlants(handles);

if nargin >= 4 && nargin >= 5
    
    handles.model_path= char(varargin{1});
    
    handles.equilibrium= varargin{2};
    
    set(handles.popPlant, 'Enable', 'off');
    %set(handles.btnPath, 'Enable', 'off');
    
    if ~isa(handles.model_path, 'double')

        set(handles.lblPath, 'String', handles.model_path);

        handles= searchForModelFile(handles);

        if isfield(handles, 'plantID') && ~isempty( handles.plantID )
            handles= callActualizeGUI(handles);
        end
        
    else

        set(handles.lblPath, 'String', '');

    end
    
else
    
    handles.equilibrium= [];
    
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes set_input_stream wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%%
% --- Outputs from this function are returned to the command line.
function varargout = set_input_stream_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%
% --- Executes on selection change in popPlant.
function popPlant_Callback(hObject, eventdata, handles)
% hObject    handle to popPlant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%handles= saveDataToFile(handles);

% returns popPlant contents as cell array
contents= cellstr(get(hObject,'String')); 
% returns selected item from popPlant

if get(hObject,'Value') > 1

    handles.plantName= deblank(contents{get(hObject,'Value')});
    handles= callActualizeGUI(handles);

end

% Update handles structure
guidata(hObject, handles);


%%
% --- Executes during object creation, after setting all properties.
function popPlant_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popPlant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% returns popPlant contents as cell array
contents= cellstr(get(hObject,'String')); 
% returns selected item from popPlant
handles.plantName= contents{get(hObject,'Value')}; 

%handles= actualizeGui(handles);

% Update handles structure
guidata(hObject, handles);



%%
%
% function handles= loadSubstrateFlow(hObject, eventdata, handles, popid)
% 
% % returns popSubstrateFlow1 contents as cell array
% selSubstrate= deblank(char(get(hObject,'String'))); 
% % returns selected item from popSubstrateFlow1
% %selSubstrate= deblank(char(contents{get(hObject,'Value')})); 
% 
% if ( ...%get(hObject,'Value') > 1 && 
%         ~isempty(handles.substrate) )
%     [substrate_id, index]= getsubstrate_id(handles.substrate, selSubstrate);
% 
%     set(handles.('txtSubstrateFlow')(popid), ...
%                          'String', handles.substrateflow(index,1));
% end
%                 
% % Update handles structure
% guidata(hObject, handles);



%%
%
% function handles= saveSubstrateFlow(hObject, eventdata, handles, txtid)                
% 
% if ~isempty(handles.substrateflow)
%     %popObject= handles.(sprintf('popSubstrateFlow%i', txtid))(txtid);
%     lblObject= handles.('lblSubstrateFlow')(txtid,1);
%     
%     digit= str2double(get(hObject,'String'));
%     
%     if isnan(digit)
%         
%         return;
%     end
%     
%     selSubstrate= deblank(char(get(lblObject, 'String')));
%     
%     %selSubstrate= deblank(char(contents{get(popObject, 'Value')})); 
%                                    
%     [substrate_id, index]= getsubstrate_id(handles.substrate, selSubstrate);                               
%                                    
%     handles.substrateflow(index,1)= digit;
% end
% 
% % Update handles structure
% guidata(hObject, handles);


%%
% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
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
%
function handles= findPlants(handles)

% [path_config_mat]= fileparts(which('plant_plantname.mat'));
% 
% s= what(path_config_mat);
% 
% mat_files= s.mat;
% 
% for ifile= 1:size(mat_files,1)
%     
%     s= whos('-file', char(mat_files(ifile,1)));
%     
%     if strcmp( s.name, 'plant' )
%         
%        load ( char(mat_files(ifile,1)) );
%               
%        contents= get(handles.popPlant, 'String');
%        
%        if ~strcmp(plant.name, 'plantname')
%             set(handles.popPlant, 'String', {char(contents); plant.name});
%        end
%        
%        clear plant;
%               
%     end
%     
%     clear s;
%     
% end

[plant_ids, plant_names]= ...
    findExistingPlants({''}, {get(handles.popPlant, 'String')});

set(handles.popPlant, 'String', char(plant_names));


%%
% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.plantID= [];
handles.plantName= [];
handles.plant= [];
handles.substrate= [];
handles.plant_network= [];
handles.substrateflow= [];
handles.pumpFlux= [];
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


% --- Executes during object creation, after setting all properties.
function sliderSubstrate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderSubstrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in radSubstrate.
function radSubstrate_Callback(hObject, eventdata, handles)
% hObject    handle to radSubstrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radSubstrate


% --- Executes on button press in radPumpFlux.
function radPumpFlux_Callback(hObject, eventdata, handles)
% hObject    handle to radPumpFlux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radPumpFlux



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


