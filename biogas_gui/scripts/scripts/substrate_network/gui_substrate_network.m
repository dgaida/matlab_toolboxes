%% gui_substrate_network
% GUI for editing the substrate_network structure of the _Biogas Plant
% Modeling_ Toolbox.
%
function varargout = gui_substrate_network(varargin)
%% Release: 1.4

% GUI_SUBSTRATE_NETWORK M-file for gui_substrate_network.fig
%      GUI_SUBSTRATE_NETWORK, by itself, creates a new GUI_SUBSTRATE_NETWORK or raises the existing
%      singleton*.
%
%      H = GUI_SUBSTRATE_NETWORK returns the handle to a new GUI_SUBSTRATE_NETWORK or the handle to
%      the existing singleton*.
%
%      GUI_SUBSTRATE_NETWORK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SUBSTRATE_NETWORK.M with the given input arguments.
%
%      GUI_SUBSTRATE_NETWORK('Property','Value',...) creates a new GUI_SUBSTRATE_NETWORK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_substrate_network_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_substrate_network_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_substrate_network

% Last Modified by GUIDE v2.5 07-Oct-2011 20:39:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_substrate_network_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_substrate_network_OutputFcn, ...
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
% --- Executes just before gui_substrate_network is made visible.
function gui_substrate_network_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_substrate_network (see VARARGIN)

% Choose default command line output for gui_substrate_network
handles.output = hObject;

%%
   
data= get_gecoc_logo(get(handles.figure1, 'Color'));

image(data, 'Parent', handles.axes1);

clear data;

axis(handles.axes1, 'off');
    
%%

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_substrate_network wait for user response (see UIRESUME)
% uiwait(handles.figure1);



%%
% --- Outputs from this function are returned to the command line.
function varargout = gui_substrate_network_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%


