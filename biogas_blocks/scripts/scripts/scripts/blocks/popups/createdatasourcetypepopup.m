%% createdatasourcetypepopup
% Create dropdown menu for selecting the type of data source of system
% blocks.
%
function createdatasourcetypepopup(id_datasourcetype, init)
%% Release: 1.6

%%
%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

try
  datasourcetypes= evalinMWS('datasourcetypes');
catch ME
  try
    % für neue matlab versionen gibt es probleme in mws zu schreiben,
    % deshalb wird hier aus base workspace gelesen
    datasourcetypes= evalin('base', 'datasourcetypes');
  catch ME1
    warning('evalinMWS:datasourcetypes', ...
           ['Could not load the variable datasourcetypes ', ...
            'out of the model''s workspace!']);
    rethrow(ME);
  end
end

if isempty(datasourcetypes)
  return;
end

%%
% check input parameters

isN(id_datasourcetype, 'id_datasourcetype', 1);
  
is0or1(init, 'init', 2);


%%
%

user_data= get_param(gcb, 'UserData');
user_data= user_data(:);

%%

n_types= size(datasourcetypes, 2);

if n_types <= 0
  error('Serious error in the array datasourcetypes! It is empty!'); 
end

%%

popup_string= char(datasourcetypes(1));

% popup_string= const|random|user ...
for itype= 1:n_types - 1
  popup_string= strcat(popup_string, '|', datasourcetypes(itype + 1) );
end

popup_init= get_param(gcb, 'MaskStyleString');

popup_split= regexp(popup_init, ',', 'split');

% string für das neue Popupmenu Substrat
popup_menu_datasource= ...
    sprintf('popup(--- Bitte Datenquelle wählen ---|%s)', ...
             char(popup_string));

% neuen String in gesamtes Menü einfügen
popup_split(1,id_datasourcetype)= {popup_menu_datasource};

popup_menu= char(popup_split(1,1));

for iel= 1:size(popup_split, 2) - 1
  popup_menu= strcat(popup_menu, ',', char(popup_split(1,iel + 1)));
end

%%
% Xvolumeflow_typeX is the delimiter for the popupmenu datasource_type
%popup_menu= strrep(popup_init, 'Xdatasource_typeX', popup_string);

set_param_tc('MaskStyleString', char(popup_menu));

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

  % split the string to become only the popupmenu for the initstatetype
  % variable
  popup_menu_split= regexp(popup_menu, ',', 'split');

  % start ist die Startposition des Strings, falls gefunden, wenn nicht
  % gefunden, dann start= {[]}, sonst start= [Zahl]
  % hier wird geschaut ob user_data etwas gespeichert wird, was zu dem
  % Menu passt
  %start = regexp(popup_menu_split{1,1}{1,id_datasourcetype},
  %user_data(id_datasourcetype, 1)); 
  start= regexp(popup_menu_split{1,id_datasourcetype}, ...
                 user_data(id_datasourcetype, 1));

  %start= start(1,id_datasourcetype);

  % nicht gefunden?
  if isempty(start{:})

    values(id_datasourcetype, 1)= {'--- Bitte Datenquelle wählen ---'};

  else

    if id_datasourcetype > numel(values) || id_datasourcetype > numel(user_data)
      error('id_datasourcetype (%i) exceeds dimension of values (%i) or user_data (%i)!', ...
            id_datasourcetype, numel(values), numel(user_data));
    end
    
    values(id_datasourcetype, 1)= user_data(id_datasourcetype, 1);

  end

  % 
  set_param_tc('MaskValues', values);
        
end


%%
%

if ischar(user_data)
  user_data= {user_data};
end

if isempty(user_data)
  user_data= values;
end

if id_datasourcetype > numel(values) || id_datasourcetype > numel(user_data)
  error('id_datasourcetype (%i) exceeds dimension of values (%i) or user_data (%i)!', ...
        id_datasourcetype, numel(values), numel(user_data));
end
    
user_data(id_datasourcetype, 1)= values(id_datasourcetype, 1);

set_param_tc('UserData', user_data);

%%


