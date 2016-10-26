%% pump_stream_setmasks
% Set the mask of the hydraulic delay block inside the block pump stream
% (Energy).
%
function errflag= pump_stream_setmasks(id_fermenter_start, id_fermenter_destiny, ...
         id_initstatetype, id_datasourcetype, id_savestate, id_time_constant, ...
         id_V_min, id_initstatetype_delay, id_datasourcetype_delay, ...
         id_savestate_delay, id_time_constant_delay, id_V_min_delay)
%% Release: 1.3

%%

narginchk(12, 12);
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

isN(id_fermenter_start, 'id_fermenter_start', 1);
isN(id_fermenter_destiny, 'id_fermenter_destiny', 2);
isN(id_initstatetype, 'id_initstatetype', 3);
isN(id_datasourcetype, 'id_datasourcetype', 4);
isN(id_savestate, 'id_savestate', 5);
isN(id_time_constant, 'id_time_constant', 6);
isN(id_V_min, 'id_V_min', 7);
isN(id_initstatetype_delay, 'id_initstatetype_delay', 8);
isN(id_datasourcetype_delay, 'id_datasourcetype_delay', 9);
isN(id_savestate_delay, 'id_savestate_delay', 10);
isN(id_time_constant_delay, 'id_time_constant_delay', 11);
isN(id_V_min_delay, 'id_V_min_delay', 12);

%%

errflag= 1;

% get chosen values
values= get_param(gcb, 'MaskValues');

if isempty(values)
  warning('MaskValues:empty', 'The variable values of block %s is empty!', gcb);
  return;
end

%%

pump_stream_style_string= get_param(gcb, 'MaskStyleString');

if isempty(pump_stream_style_string)
  warning('MaskStyleString:empty', ['The variable pump_stream_style_string of ', ...
           'block %s is empty!'], gcb);
  return;
end

%%

pump_stream_style_string_split= regexp(pump_stream_style_string, ',', 'split');

%%
% block of hydraulic delay
sys_delay= char ( find_system(gcb, 'LookUnderMasks', 'all', ...
          'FollowLinks', 'on', 'Name', 'pump stream - hydraulic delay') );

%%

if ~isempty(sys_delay)

  %%
  % get params of hyraulic delay
  values_sys_delay= get_param_error('MaskValues', sys_delay);

  %%
  % copy params of pump block to hydraulic delay block
  values_sys_delay(id_fermenter_start)= values(id_fermenter_start);

  values_sys_delay(id_fermenter_destiny)= values(id_fermenter_destiny);

  values_sys_delay(id_initstatetype_delay)= values(id_initstatetype);

  values_sys_delay(id_datasourcetype_delay)= values(id_datasourcetype);

  values_sys_delay(id_savestate_delay)= values(id_savestate);

  values_sys_delay(id_time_constant_delay)= values(id_time_constant);

  values_sys_delay(id_V_min_delay)= values(id_V_min);


  %%
  % create string
  % mask style string of hydraulic delay
  sys_delay_style_string= get_param_error('MaskStyleString', sys_delay);

  %%
  
  sys_delay_style_string_split= regexp(sys_delay_style_string, ',', 'split');

  %%
  % copy elements from pump block to hydraulic delay block
  
  sys_delay_style_string_split(1,id_fermenter_start)= ...
               pump_stream_style_string_split(1,id_fermenter_start);

  sys_delay_style_string_split(1,id_fermenter_destiny)= ...
               pump_stream_style_string_split(1,id_fermenter_destiny);

  sys_delay_style_string_split(1,id_initstatetype_delay)= ...
               pump_stream_style_string_split(1,id_initstatetype);

  sys_delay_style_string_split(1,id_datasourcetype_delay)= ...
               pump_stream_style_string_split(1,id_datasourcetype);

  sys_delay_style_string_split(1,id_savestate_delay)= ...
               pump_stream_style_string_split(1,id_savestate);

  sys_delay_style_string_split(1,id_time_constant_delay)= ...
               pump_stream_style_string_split(1,id_time_constant);

  sys_delay_style_string_split(1,id_V_min_delay)= ...
               pump_stream_style_string_split(1,id_V_min);

  %% TODO
  % das kann man auch besser machen

  sys_delay_style_string_new= '';

  for iel= 1:size(sys_delay_style_string_split, 2)
    sys_delay_style_string_new= ...
                  [sys_delay_style_string_new, ...
                   char(sys_delay_style_string_split(1,iel)), ','];
  end

  sys_delay_style_string_new= sys_delay_style_string_new(1:end - 1);

  %%
  % set hydraulic delay block
  
  set_param_tc('MaskStyleString', sys_delay_style_string_new, sys_delay);
  
  set_param_tc('MaskValues', values_sys_delay, sys_delay);
  
  %%

end

%%
% no error occured
errflag= 0;

%%


