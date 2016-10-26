%% gui_digester_combi_OpeningFcn
% Executes just before gui_digester_combi is made visible.
%
function gui_digester_combi_OpeningFcn(hObject, eventdata, handles, ...
                                       varargin)
%% Release: 1.4
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_digester_combi (see VARARGIN)

%%

error( nargchk(3, 5, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%
% Choose default command line output for gui_digester_combi
handles.output = hObject;
   
%%

if nargin >= 4
  plant= varargin{1};
  is_plant(plant, 4);
else
  plant= biogas.plant();
  warning('plant:useDefault', 'Using the default plant structure!');
end

if nargin >= 5
  fermenter_name= varargin{2};
  checkArgument(fermenter_name, 'fermenter_name', 'char || cell', 5);
  fermenter_name= char(fermenter_name);
else
  if (plant.getNumDigestersD() > 0)
    fermenter_name= char(plant.getDigesterName(1));
  else
    fermenter_name= '';
  end
end

handles.plant= plant;
handles.fermenter_name= fermenter_name;

%%

try
  set( handles.lblfermenter_name, 'String', fermenter_name);
catch ME
  warning('set:String', ['Could not set the parameter String of ', ...
           'handles.lblfermenter_name!']);
  rethrow(ME);
end

% get fermenter id
try
  [handles.fermenter_id, f_index]= plant.getDigesterByName(fermenter_name);
catch ME
  disp(ME.message);
  handles.fermenter_id= '';
  f_index= 1;
end

%%

if f_index < 4
   
  pos= get(hObject, 'Position');

  set(hObject, 'Position', [75 + 150 * ( f_index - 1 ), pos(2), ...
                            pos(3), pos(4)]);
    
end


%%

% if timer does not exist already
if ~isfield(handles, 'tmr') && ~strcmp(handles.fermenter_id, '')
 
  handles.guifig= gcf;

  % timer updating after every 2 secs
  handles.tmr= timer('TimerFcn', {@TmrFcn, handles.guifig}, ...
                     'BusyMode', 'Queue', ...
                     'ExecutionMode', 'FixedRate', 'Period', 2);    

  guidata(handles.guifig, handles);

  start(handles.tmr);

end

%%

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_digester_combi wait for user response (see UIRESUME)
% uiwait(handles.fig_digester_combi);
%%


