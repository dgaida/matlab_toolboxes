%% pump_energy_setmask
% Set the mask of the density block inside the block pump (Energy).
%
function pump_energy_setmask()
%% Release: 0.5

%%
%

id_fermenter= 1;


%%
%

values= get_param(gcb, 'MaskValues');

adm1_style_string= get_param(gcb, 'MaskStyleString');

adm1_style_string_split= regexp(adm1_style_string, ',', 'split');

fermenter_name= values(id_fermenter);


%%
%

char_find_system= 'density sensor';

sys_block= char ( find_system(gcb, 'LookUnderMasks', 'all', ...
            'FollowLinks', 'on', 'Name', char_find_system ) );

if isempty(sys_block)
   error('Could not find the system %s', char_find_system );
end

values_sys_block= get_param(sys_block, 'MaskValues');

if isempty(values_sys_block)
    error('The variable values_sys_block is empty!');
end

values_sys_block(id_fermenter)= fermenter_name;

sys_block_style_string= get_param(sys_block, 'MaskStyleString');

if isempty(sys_block_style_string)
    error('The variable sys_block_style_string is empty!');
end

sys_block_style_string_split= ...
                        regexp(sys_block_style_string, ',', 'split');

sys_block_style_string_split(1,id_fermenter)= ...
                        {adm1_style_string_split{1,id_fermenter}};

sys_block_style_string_new= '';

for iel= 1:size(sys_block_style_string_split, 2)
    sys_block_style_string_new= [sys_block_style_string_new, ...
                    char(sys_block_style_string_split(1,iel)), ','];
end

sys_block_style_string_new= sys_block_style_string_new(1:end - 1);

try
    set_param(sys_block, 'MaskStyleString', sys_block_style_string_new);
catch ME
    warning('Could not set the parameter MaskStyleString of block %s!', ...
            sys_block);

    rethrow(ME);
end

try
    set_param(sys_block, 'MaskValues', values_sys_block);
catch ME
    warning('Could not set the parameter MaskValues of block %s!', ...
            sys_block);

    rethrow(ME);
end
    
    
    