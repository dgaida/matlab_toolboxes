%% get_biogas_block_params
% Get params from biogas blocks
%
function [plant_id, DEBUG, showGUIs, appendDATA]= get_biogas_block_params()
%% Release: 1.3

%%

narginchk(0, 0);
error( nargoutchk(4, 4, nargout, 'struct') );

%%
% get chosen values
values= get_param_error('MaskValues');

%%
% Umwandlung von cell in char
plant_id= char( values(1) );

if strcmp( values( 2 ), 'on' )
  DEBUG= 1;
else
  DEBUG= 0;
end

showGUIs= DEBUG;

appendDATA= 1;%DEBUG;

%%


