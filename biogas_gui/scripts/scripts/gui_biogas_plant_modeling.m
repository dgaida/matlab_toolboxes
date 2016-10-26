%% gui_biogas_plant_modeling
% Call different tasks possible using the _Biogas Plant Modeling_ Toolbox. 
%
%% Toolbox
% |gui_biogas_plant_modeling| belongs to the _Biogas Plant Modeling_
% Toolbox. 
%
%% Release
% Approval for Release 1.3, to get the approval for Release 1.4 make the
% TODO, Daniel Gaida 
%
%% Syntax
%       gui_biogas_plant_modeling()
%       
%% Description
% |gui_biogas_plant_modeling()| opens a gui, where you can call different
% tasks, which are possible using the _Biogas Plant Modeling_ Toolbox.  
%
%% Example
% |gui_biogas_plant_modeling()|
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="gui_plant.html">
% gui_plant</a>
% </html>
% ,
% <html>
% <a href="gui_substrate.html">
% gui_substrate</a>
% </html>
% ,
% <html>
% <a href="plant_network\gui_plant_network.html">
% gui_plant_network</a>
% </html>
% ,
% <html>
% <a href="substrate_network\gui_substrate_network.html">
% gui_substrate_network</a>
% </html>
% ,
% <html>
% <a href="gui_optimization.html">
% gui_optimization</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See also
% 
%
%% TODOs
% # make the gui nicer
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
% Last Update: 13.10.2011
%
%% Function
%
function varargout = gui_biogas_plant_modeling(varargin)
% GUI_BIOGAS_PLANT_MODELING M-file for gui_biogas_plant_modeling.fig
%      GUI_BIOGAS_PLANT_MODELING, by itself, creates a new
%      GUI_BIOGAS_PLANT_MODELING or raises the existing 
%      singleton*.
%
%      H = GUI_BIOGAS_PLANT_MODELING returns the handle to a new
%      GUI_BIOGAS_PLANT_MODELING or the handle to 
%      the existing singleton*.
%
%      GUI_BIOGAS_PLANT_MODELING('CALLBACK',hObject,eventData,handles,...)
%      calls the local 
%      function named CALLBACK in GUI_BIOGAS_PLANT_MODELING.M with the
%      given input arguments. 
% 
%      GUI_BIOGAS_PLANT_MODELING('Property','Value',...) creates a new
%      GUI_BIOGAS_PLANT_MODELING or raises the 
%      existing singleton*.  Starting from the left, property value pairs
%      are 
%      applied to the GUI before gui_biogas_plant_modeling_OpeningFcn gets
%      called.  An 
%      unrecognized property name or invalid value makes property
%      application 
%      stop.  All inputs are passed to gui_biogas_plant_modeling_OpeningFcn
%      via varargin. 
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help
% gui_biogas_plant_modeling 

% Last Modified by GUIDE v2.5 21-Oct-2010 22:14:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_biogas_plant_modeling_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_biogas_plant_modeling_OutputFcn, ...
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
% --- Executes just before gui_biogas_plant_modeling is made visible.
function gui_biogas_plant_modeling_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_biogas_plant_modeling (see VARARGIN)

% Choose default command line output for gui_biogas_plant_modeling
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_biogas_plant_modeling wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%%
% --- Outputs from this function are returned to the command line.
function varargout = gui_biogas_plant_modeling_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%
% --- Executes on button press in btn_gui_plant.
function btn_gui_plant_Callback(hObject, eventdata, handles)
% hObject    handle to btn_gui_plant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

gui_plant();


%%
% --- Executes on button press in btn_gui_plant_network.
function btn_gui_plant_network_Callback(hObject, eventdata, handles)
% hObject    handle to btn_gui_plant_network (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

gui_plant_network();


%%
% --- Executes on button press in btn_gui_substrate.
function btn_gui_substrate_Callback(hObject, eventdata, handles)
% hObject    handle to btn_gui_substrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

gui_substrate();


%%
% --- Executes on button press in btn_gui_substrate_network.
function btn_gui_substrate_network_Callback(hObject, eventdata, handles)
% hObject    handle to btn_gui_substrate_network (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

gui_substrate_network();


%%
% --- Executes on button press in btn_set_input_stream.
function btn_set_input_stream_Callback(hObject, eventdata, handles)
% hObject    handle to btn_set_input_stream (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set_input_stream();


%%
% --- Executes on button press in btn_sim_biogas_plant.
function btn_sim_biogas_plant_Callback(hObject, eventdata, handles)
% hObject    handle to btn_sim_biogas_plant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cd(fullfile(getBiogasLibPath(), 'examples/model/Gummersbach'));

uiopen('plant_gummersbach.mdl', 1);


%%
% --- Executes on button press in btn_optimize_biogas_plant.
function btn_optimize_biogas_plant_Callback(hObject, eventdata, handles)
% hObject    handle to btn_optimize_biogas_plant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cd(fullfile(getBiogasLibPath(), 'examples/optimization/Gummersbach'));

gui_optimization();


%%


