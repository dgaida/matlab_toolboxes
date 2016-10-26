%% createinitstatetypepopup
% Create dropdown menu for selecting the type of initial states of system
% blocks.
%
function createinitstatetypepopup(id_initstatetype, init)
%% Release: 1.8

%%
%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

try
  initstatetypes= evalinMWS('initstatetypes');
catch ME
  try
    % für neue matlab versionen gibt es probleme in mws zu schreiben,
    % deshalb wird hier aus base workspace gelesen
    initstatetypes= evalin('base', 'initstatetypes');
  catch ME1
    warning('evalinMWS:initstatetypes', ['Could not load the variable initstatetypes ', ...
            'out of the model''s workspace!']);
    rethrow(ME);
  end
end

if isempty(initstatetypes)    
  return;
end

%%
% check input parameters

isN(id_initstatetype, 'id_initstatetype', 1);

is0or1(init, 'init', 2);
                 
%%
%

user_data= get_param(gcb, 'UserData');

user_data= user_data(:);

%%

n_types= size(initstatetypes, 2);

if n_types <= 0
  error('Serious error in the initstatetypes structure! It is empty!'); 
end


%%
%

popup_string= initstatetypes(1);

% popup_string= const|random|user ...
for itype= 1:n_types - 1
  popup_string= ...
        strcat(popup_string, '|', initstatetypes(itype + 1) );
end

popup_init= get_param(gcb, 'MaskStyleString');

% Xvolumeflow_typeX is the delimiter for the popupmenu volumeflow_type
popup_menu= strrep(popup_init, 'Xinitstate_typeX', popup_string);

set_param_tc('MaskStyleString', char(popup_menu));

%%
%

% get chosen values
values= get_param_error('MaskValues');

values= values(:);

if ~isempty(user_data) && init == 1
    
  if ischar(user_data)
    user_data= {user_data};
  end

  % split the string to become only the popupmenu for the initstatetype
  % variable
  popup_menu_split= regexp(popup_menu, ',', 'split');

  % start ist die Startposition des Strings, falls gefunden, wenn nicht
  % gefunden, dann start= {[]}, sonst start= [Zahl]
  start= regexp(popup_menu_split{1,1}{1,id_initstatetype}, ...
                user_data(id_initstatetype, 1));
  %start = regexp(popup_menu_split{1,id_initstatetype},
  %user_data(id_initstatetype, 1)); 

  %start= start(1,id_initstatetype);

  % nicht gefunden?
  if isempty(start{:})

    values(id_initstatetype, 1)= {'--- Bitte Startzustandstyp wählen ---'};

  else

    values(id_initstatetype, 1)= user_data(id_initstatetype, 1);

  end

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

user_data(id_initstatetype, 1)= values(id_initstatetype, 1);

set_param_tc('UserData', user_data);

%%


