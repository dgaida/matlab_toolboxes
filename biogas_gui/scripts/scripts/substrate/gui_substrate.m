%% gui_substrate
% GUI to define substrate characteristics. 
%
function varargout = gui_substrate(varargin)
%% Release: 1.8

% GUI_SUBSTRATE M-file for gui_substrate.fig
%      GUI_SUBSTRATE, by itself, creates a new GUI_SUBSTRATE or raises the existing
%      singleton*.
%
%      H = GUI_SUBSTRATE returns the handle to a new GUI_SUBSTRATE or the handle to
%      the existing singleton*.
%
%      GUI_SUBSTRATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SUBSTRATE.M with the given input arguments.
%
%      GUI_SUBSTRATE('Property','Value',...) creates a new GUI_SUBSTRATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_substrate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_substrate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_substrate

% Last Modified by GUIDE v2.5 07-Oct-2011 20:58:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_substrate_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_substrate_OutputFcn, ...
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
% --- Executes just before gui_substrate is made visible.
function gui_substrate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_substrate (see VARARGIN)

% Choose default command line output for gui_substrate
handles.output = hObject;

%%
   
data= get_gecoc_logo(get(handles.figure1, 'Color'));

image(data, 'Parent', handles.axes1);

clear data;

axis(handles.axes1, 'off');

%%

substrate_classes= biogas.substrate.classes;

char_cell= cell(substrate_classes.Count, 1);

for isubstrate= 1:substrate_classes.Count
  char_cell{isubstrate, 1}= char( substrate_classes.Item(isubstrate - 1) );
end
    
set(handles.popSubstrateClass, 'String', char_cell);

%%

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_substrate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%%
% --- Outputs from this function are returned to the command line.
function varargout = gui_substrate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

  
%%
% --- Executes during object creation, after setting all properties.
function txtpHvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtpHvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtCSBtotal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtCSBtotal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtCSBfilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtCSBfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtTS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtTS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtDichte_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtDichte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtAlkalinity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtAlkalinity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtoTS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtoTS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtNH4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtNH4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function listSubstrate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listSubstrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtRohprotein_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtrohprotein (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtRohfaser_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtrohfaser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtRohfett_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtrohfett (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtCosts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtCosts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes on button press in radrohparams.
function radRohParams_Callback(hObject, eventdata, handles)
% hObject    handle to radrohparams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radrohparams
 

%%
% --- Executes on button press in radCSBfracts.
function radCSBfracts_Callback(hObject, eventdata, handles)
% hObject    handle to radCSBfracts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radCSBfracts


%%    
% --- Executes during object creation, after setting all properties.
function txtfLI_XC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtfLI_XC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtfPR_XC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtfPR_XC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%    
% --- Executes during object creation, after setting all properties.
function txtfCH_XC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtfCH_XC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtfXI_XC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtfXI_XC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtfSI_XC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtfSI_XC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtfXP_XC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtfXP_XC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtPropion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPropion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtEssig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtEssig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtButter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtButter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtADF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtADF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtNDF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtNDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtADL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtADL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtValerian_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtValerian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes on selection change in popSubstrateClass.
function popSubstrateClass_Callback(hObject, eventdata, handles)
% hObject    handle to popSubstrateClass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popSubstrateClass contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popSubstrateClass


%%
% --- Executes during object creation, after setting all properties.
function popSubstrateClass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popSubstrateClass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
%
function panRadio_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in panRadio 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

%%

s_panRadio_SelectionChangeFcn(hObject, eventdata, handles);

%%


