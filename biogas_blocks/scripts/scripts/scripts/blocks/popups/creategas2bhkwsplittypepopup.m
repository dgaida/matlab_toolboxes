%% creategas2bhkwsplittypepopup
% Create popupmenu for selecting the type of splitting the gas to the
% bhkw's.
%
function creategas2bhkwsplittypepopup(id_gas2bhkwsplittype, init)
%% Release: 1.7

%%
%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

try
  gas2bhkwsplittype= evalinMWS('gas2bhkwsplittypes');
catch ME
  try 
    gas2bhkwsplittype= evalin('base', 'gas2bhkwsplittypes');
  catch ME1
    warning('evalinMWS:gas2bhkwsplittypes', ...
           ['Could not load the variable gas2bhkwsplittypes ', ...
            'out of the model''s workspace!']);
    rethrow(ME);
  end
end

if isempty(gas2bhkwsplittype)    
  return;
end

%%
% check input parameters

isN(id_gas2bhkwsplittype, 'id_gas2bhkwsplittype', 1);

is0or1(init, 'init', 2);

%%
% get the user data which is saved with this block

user_data= get_param(gcb, 'UserData');
user_data= user_data(:);


%%
%

n_types= size(gas2bhkwsplittype, 2);

if n_types <= 0
  error('gas2bhkwsplittype is empty!');
end

%%
%

popup_string= gas2bhkwsplittype(1);

% popup_string= fiftyfifty|one2one|threshold ...
for itype= 1:n_types - 1
  popup_string= strcat(popup_string, '|', gas2bhkwsplittype(itype + 1) );
end

popup_init= get_param(gcb, 'MaskStyleString');

% Xgas2bhkwsplit_typeX is the delimiter for the popupmenu gas2bhkwsplit_type
popup_menu= strrep(popup_init, 'Xgas2bhkwsplit_typeX', popup_string);

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

  if id_gas2bhkwsplittype > numel(values) || id_gas2bhkwsplittype > numel(user_data)
    error('id_gas2bhkwsplittype (%i) exceeds dimension of values (%i) or user_data (%i)!', ...
          id_gas2bhkwsplittype, numel(values), numel(user_data));
  end
  
  values(id_gas2bhkwsplittype,1)= user_data(id_gas2bhkwsplittype,1);

  set_param_tc('MaskValues', values);
    
end


%%
% save user_data

if ischar(user_data)
  user_data= {user_data};
end

if isempty(user_data)
  user_data= values;
end

if id_gas2bhkwsplittype > numel(values) || id_gas2bhkwsplittype > numel(user_data)
  error('id_gas2bhkwsplittype (%i) exceeds dimension of values (%i) or user_data (%i)!', ...
        id_gas2bhkwsplittype, numel(values), numel(user_data));
end

user_data(id_gas2bhkwsplittype,1)= values(id_gas2bhkwsplittype,1);

set_param_tc('UserData', user_data);

%%


    