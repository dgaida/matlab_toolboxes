%% gui_plant_OpeningFcn
% Executes just before <gui_plant.html gui_plant> is made visible.
%
function gui_plant_OpeningFcn(hObject, eventdata, handles, varargin)
%% Release: 1.3

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_plant (see VARARGIN)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

% Choose default command line output for gui_plant
handles.output= hObject;
% current path
%handles.p_path= pwd;


%%
   
data= get_gecoc_logo(get(handles.figure1, 'Color'));

image(data, 'Parent', handles.axes1);

clear data;

axis(handles.axes1, 'off');
    

%%


% search and default Selection of "plant" file to edit
% plantfilesearch= dir('plant_*.mat');
% 
% if size(plantfilesearch,1) == 0
%     handles.p_file= 'no file selected';
% else
%     handles.p_file= plantfilesearch(1).name;
% end

% pfad zu erste gefundene plant wird zurück gegeben 
[plant_ids, plant_names, path_config_mat, path_to_file]= ...
    findExistingPlants([], {get(handles.popPlants, 'String')}, 1);

set(handles.popPlants, 'String', plant_names);

% erste zeile enthält: "choose plant"
set(handles.popPlants, 'Value', 2);

%contents= cellstr( get(handles.popPlants, 'String') );

% erste zeile enthält: "choose plant"
plant_id= deblank( char( plant_ids{ ...
                            get(handles.popPlants, 'Value') - 1 ...
                                       } ) );

handles.p_path= path_to_file;
handles.p_file= sprintf('plant_%s.xml', plant_id);

%%

handles= gui_plant_init_gui(handles, 1, plant_id );

%%

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_plant wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%%


