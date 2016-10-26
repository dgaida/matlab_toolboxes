%% createfermenterpopup
% Create the dropdown menu for selecting a fermenter via a block's mask.
% 
function createfermenterpopup(id_fermenter, y_text_pos, display, ...
                              init, varargin)
%% Release: 1.5

%%
%

error( nargchk(4, 6, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );
                            
%%
% check input parameters

isN(id_fermenter, 'id_fermenter', 1);

validateattributes(y_text_pos, {'double'}, {'scalar', 'nonnegative', '<=', 1}, ...
                   mfilename, 'y_text_pos', 2);
     
is0or1(display, 'display', 3);
is0or1(init, 'init', 4);


%%
%

try
  plant= evalinMWS('plant');
catch ME
  warning('evalinMWS:plant', ['Could not load the variable plant ', ...
         'out of the model''s workspace!']);
  rethrow(ME);
end

if isempty(plant)
  disp('Warning in createfermenterpopup: plant is empty!');
  return;
end

%%

if isempty(gcb)
  warning('gcb:empty', 'Current block is empty!');
  return;
end

%%
% read the user data
user_data= get_param(gcb, 'UserData');
user_data= user_data(:);

%%
% number of digesters / fermenters
n_fermenter= plant.getNumDigestersD();

if n_fermenter <= 0
  error('Serious error in the plant''s structure! No fermenter found!'); 
end


%%
% create the string which has to be displayed on the mask (decribing the
% mask)

%%
% create the string which is displayed inside the dropdown menu of the
% fermenter

popup_string= char( plant.getDigesterName(1) );

% popup_string= fermentername1|fermentername2|fermentername3 ...
for ifermenter= 1:n_fermenter - 1
  popup_string= strcat(popup_string, '|', ...
        char( plant.getDigesterName(ifermenter + 1) ) );
end

% get
popup_init= get_param(gcb, 'MaskStyleString');

popup_split= regexp(popup_init, ',', 'split');

% string für das aktuelle Popupmenu Substrat
%pop_sub= char(popup_split(1,id_substrate));

% string für das neue Popupmenu Substrat
popup_menu_fermenter= ...
    sprintf('popup(--- Bitte Fermenter wählen ---|%s)', popup_string);

%
if size(popup_split,2) >= id_fermenter + 1
  if strcmp( popup_split(1,id_fermenter), popup_split(1,id_fermenter + 1) )
    popup_split(1,id_fermenter + 1)= {popup_menu_fermenter};
  end
end

% neuen String in gesamtes Menü einfügen
popup_split(1,id_fermenter)= {popup_menu_fermenter};

popup_menu= char(popup_split(1,1));

for iel= 1:size(popup_split, 2) - 1
  popup_menu= strcat(popup_menu, ',', char(popup_split(1,iel + 1)));
end

%%

% XfermenterX is the delimiter for the popupmenu fermenter
%popup_menu= strrep(popup_init, 'XfermenterX', popup_string);
set_param_tc('MaskStyleString', popup_menu);


%%
%

% get chosen values
values= get_param_error('MaskValues');

values= values(:);

%%

if ~isempty(user_data) && init == 1
    
  if ischar(user_data)
    user_data= {user_data};
  end

  % start ist die Startposition des Strings, falls gefunden, wenn nicht
  % gefunden, dann start= {[]}, sonst start= [Zahl]
  start= regexp(popup_menu, user_data(id_fermenter, 1));

  %start= start(id_fermenter,1);

  % nicht gefunden?
  if isempty(start{:})

    values(id_fermenter, 1)= {'--- Bitte Fermenter wählen ---'};

  else

    if id_fermenter > numel(values) || id_fermenter > numel(user_data)
      error('id_fermenter (%i) exceeds dimension of values (%i) or user_data (%i)!', ...
            id_fermenter, numel(values), numel(user_data));
    end
    
    values(id_fermenter, 1)= user_data(id_fermenter, 1);

  end

  set_param_tc('MaskValues', values);
  
end


%%
%

if display == 1
    
  try 
    display_selected_fermenter(id_fermenter, y_text_pos);
  catch ME
    disp(ME.message);
    rethrow(ME);
  end
    
end


%%
% save user_data

if ischar(user_data)
  user_data= {user_data};
end

if isempty(user_data)
 user_data= values;
end

if id_fermenter > numel(values) || id_fermenter > numel(user_data)
  error('id_fermenter (%i) exceeds dimension of values (%i) or user_data (%i)!', ...
        id_fermenter, numel(values), numel(user_data));
end

user_data(id_fermenter, 1)= values(id_fermenter, 1);

set_param_tc('UserData', user_data);

%%

if nargin >= 5
    
  if strcmp( char(varargin{1}), 'Close' )

    % get chosen values
    values= get_param_error('MaskValues');

    values(id_fermenter, 1)= {'--- Bitte Fermenter wählen ---'};

    if nargin >= 6

      id_is_loaded_and_is_being_loaded= varargin{2};
      
      validateattributes(id_is_loaded_and_is_being_loaded, {'double'}, ...
                         {'vector', 'positive', 'integer', '<=', numel(values)}, ...
                         mfilename, 'id_is_loaded_and_is_being_loaded', 6);
      
      values(id_is_loaded_and_is_being_loaded, 1)= {'off'};

    end

    set_param_tc('MaskValues', values);            
        
  end
    
end

%%


