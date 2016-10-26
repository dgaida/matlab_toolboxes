%% pump_stream_eval_loop_check
% En-/Disables visualization of parameters on the mask of pump stream block
% depending on hydraulic delay checkbox
%
function pump_stream_eval_loop_check(id_checkbox)
%% Release: 1.3

%%

narginchk(1, 1);
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check input parameter

isN(id_checkbox, 'id_checkbox', 1);

%%

% get chosen values
values= get_param(gcb, 'MaskValues');

if isempty(values)
  warning('MaskValues:empty', 'The variable values of block %s is empty!', gcb);
  return;
end

%%

enable_val= get_param(gcb, 'MaskEnables');

if isempty(enable_val)
  warning('MaskEnables:empty', 'The variable enable_val of block %s is empty!', gcb);
  return;
end

%%
% hydraulic delay checkbox
% 4 items on the gui are either set to on or off
mycell= repmat(values(id_checkbox), 4, 1);

set_param_tc('MaskEnables', [enable_val(1:id_checkbox); ...
             mycell; enable_val(id_checkbox+5:end)]);
  
%%


