%% btnOptimParams_optima_Callback
% Executes on button press on btnOptimParams_optima.
%
function btnOptimParams_optima_Callback(hObject, eventdata, handles)
%% Release: 1.1

% hObject    handle to btnOptimParams_optima (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%
% set handles.optParams

prompt= {'Enter the 1st parameter:',...
         'Enter the 2nd parameter:'};
name= 'Input of parameters of optimization method';
numlines= 1;
defaultanswer= {'20','20'};

answer= inputdlg(prompt,name,numlines,defaultanswer);

%%

handles.optParams.p1= str2double(answer{1});
handles.optParams.p2= str2double(answer{2});

%%

warndlg('Settings done here do not yet take effect anywhere!');

%%


