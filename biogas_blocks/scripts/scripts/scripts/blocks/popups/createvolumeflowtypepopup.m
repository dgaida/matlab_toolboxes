%% createvolumeflowtypepopup
% Create popupmenu for selecting the type of volumeflow data.
%
function createvolumeflowtypepopup(id_volumeflowtype, init)
%% Release: 1.8

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check input parameters

isN(id_volumeflowtype, 'id_volumeflowtype', 1);

is0or1(init, 'init', 2);


%%
%

try
  volumeflowtypes= evalinMWS('volumeflowtypes');
catch ME
  try
    % für neue matlab versionen gibt es probleme in mws zu schreiben,
    % deshalb wird hier aus base workspace gelesen
    volumeflowtypes= evalin('base', 'volumeflowtypes');
  catch ME1
    warning('evalinMWS:volumeflowtypes', ...
           ['Could not load the variable ''volumeflowtypes'' ', ...
            'out of the model''s workspace!']);
    rethrow(ME);
  end
end

if isempty(volumeflowtypes)
  return;
end


%%

user_data= get_param(gcb, 'UserData');
user_data= user_data(:);

%%

n_types= size(volumeflowtypes, 2);

if n_types <= 0
  error('Serious error in the array volumeflowtypes! It is empty!'); 
end

%%

popup_string= volumeflowtypes(1);

% popup_string= const|random|user ...
for itype= 1:n_types - 1
  popup_string= strcat(popup_string, '|', volumeflowtypes(itype + 1) );
end

popup_init= get_param_error('MaskStyleString');

% Xvolumeflow_typeX is the delimiter for the popupmenu volumeflow_type
popup_menu= strrep(popup_init, 'Xvolumeflow_typeX', popup_string);

%%

set_param_tc('MaskStyleString', char(popup_menu));

% get chosen values
values= get_param_error('MaskValues');

values= values(:);

if ~isempty(user_data) && init == 1
    
  if ischar(user_data)
    user_data= {user_data};
  end

  if id_volumeflowtype > numel(values) || id_volumeflowtype > numel(user_data)
    error('id_volumeflowtype (%i) exceeds dimension of values (%i) or user_data (%i)!', ...
          id_volumeflowtype, numel(values), numel(user_data));
  end
  
  values(id_volumeflowtype, 1)= user_data(id_volumeflowtype, 1);

  set_param_tc('MaskValues', values);
    
end


% if volumeflowtype is selected as 'const', then show the edit for q_const,
% else hide it
% visible_val= get_param(gcb, 'MaskVisibilities');
% 
% % Here we assume, that the Mask has four elements, and that the 4th is the
% % edit field for q_const
% if strcmp(values(id_volumeflowtype), 'const') && size(values,1) == 4
%    
%     set_param(gcb, 'MaskVisibilities', [visible_val(1:3);{'on'}]);
%     
% else
%     
%     set_param(gcb, 'MaskVisibilities', [visible_val(1:3);{'off'}]);
%     
% end


%%
%

if ischar(user_data)
  user_data= {user_data};
end

if isempty(user_data)
 user_data= values;
end

if id_volumeflowtype > numel(values) || id_volumeflowtype > numel(user_data)
  error('id_volumeflowtype (%i) exceeds dimension of values (%i) or user_data (%i)!', ...
        id_volumeflowtype, numel(values), numel(user_data));
end
  
user_data(id_volumeflowtype, 1)= values(id_volumeflowtype, 1);

set_param_tc('UserData', user_data);

%%


