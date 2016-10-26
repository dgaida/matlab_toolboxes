%% createtimevaluepopup
% Create the drop down menu for selecting the timegrid.
%
function createtimevaluepopup()
%% Release: 1.5

%%

error( nargchk(0, 0, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

% get chosen values
values= get_param_error('MaskValues');

values= values(:);

if strcmp( values( 2 ), 'on' )
  DEBUG= 1;
else
  DEBUG= 0;
end

timegrid= char( values( 3 ) );

%%
% get if elements of gui are enabled
enable_val= get_param(gcb, 'MaskEnables');

if isempty(enable_val)
  return;
end

%%

if DEBUG == 1
    
  % the first stays the same, this is plant_id
  set_param_tc('MaskEnables', {char(enable_val(1));'on';'on';'on'});
  
  switch timegrid
    case 'day'
      endtime= 30;
    case 'hour'
      endtime= 23;
    case 'min'
      endtime= 59;
    case 'sec'
      endtime= 59;
    case 'each'
      endtime= 0;

      set_param_tc('MaskEnables', {char(enable_val(1));'on';'on';'off'});
      
    otherwise
      warning('timegrid:invalid', 'timegrid is invalid: %s!', timegrid);
      endtime= 1;
  end

else
    
  endtime= 0;

  set_param_tc('MaskEnables', {char(enable_val(1));'on';'off';'off'});
    
end

%%

popup_string= '1';

% popup_string= 1|2|3 ...
for itime= 1:endtime - 1
  popup_string= strcat(popup_string, '|', sprintf('%i', itime + 1) );
end

%%

popup_init= get_param_error('MaskStyleString');

[str_pop, str_start, str_end]= ...
        regexp(popup_init, 'popup(\w*)', 'match', 'start', 'end');

popup_menu= sprintf('%s(%s)', popup_init(1:str_end(2)), popup_string);

%set_param(gcb, 'MaskSelfModifiable', 'on');

%%

set_param_tc('MaskStyleString', popup_menu);
    
%%


