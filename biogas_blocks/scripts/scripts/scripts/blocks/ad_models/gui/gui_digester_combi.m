%% gui_digester_combi
% Show a gui to display the state of the fermenter during the simulation. 
%
function varargout= gui_digester_combi(varargin)
%% Release: 1.3

% GUI_DIGESTER_COMBI M-file for gui_digester_combi.fig
%      GUI_DIGESTER_COMBI, by itself, creates a new GUI_DIGESTER_COMBI or
%      raises the existing singleton*.
%
%      H = GUI_DIGESTER_COMBI returns the handle to a new
%      GUI_DIGESTER_COMBI or the handle to 
%      the existing singleton*.
%
%      GUI_DIGESTER_COMBI('CALLBACK',hObject,eventData,handles,...) calls
%      the local 
%      function named CALLBACK in GUI_DIGESTER_COMBI.M with the given input
%      arguments. 
%
%      GUI_DIGESTER_COMBI('Property','Value',...) creates a new
%      GUI_DIGESTER_COMBI or raises the existing 
%      singleton*.  Starting from the left, property value pairs are 
%      applied to the GUI before gui_digester_combi_OpeningFcn gets called.
%      An unrecognized property name or invalid value makes property
%      application stop.  All inputs are passed to
%      gui_digester_combi_OpeningFcn via varargin. 
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_digester_combi

% Last Modified by GUIDE v2.5 15-Oct-2011 18:26:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_digester_combi_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_digester_combi_OutputFcn, ...
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
function varargout = gui_digester_combi_OutputFcn(hObject, eventdata, ...
                                                  handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output(1);
%varargout{2} = handles.output(2);


%%
% --- Executes when user attempts to close fig_digester_combi.
function fig_digester_combi_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to fig_digester_combi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
  if isfield(handles, 'tmr')

    stop(handles.tmr);

  end
catch ME
  disp(ME.message)
end

% Hint: delete(hObject) closes the figure
delete(hObject);


%%
% --- Executes on button press in btnstoptimer.
function btnstoptimer_Callback(hObject, eventdata, handles)
% hObject    handle to btnstoptimer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isfield(handles, 'tmr')

  stop(handles.tmr);

end

% Update handles structure
guidata(hObject, handles);


%%
