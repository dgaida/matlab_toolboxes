%% adm1_with_gui_setmasks
% This function sets the masks of blocks inside the ADM1xp and ADM1DE with
% GUI block 
%
function adm1_with_gui_setmasks(id_fermenter, varargin)
%% Release: 1.3

%%

error( nargchk(1, 4, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

return;

%%

isN(id_fermenter, 'id_fermenter', 1);


%%
%keyboard;

if nargin == 1
  % such a call comes from the ADM1xp with gui block
  adm1_model= 'ADM1xp';
    
  max_id= id_fermenter;
  
elseif nargin == 4
  % such a call comes from the ADM1DE with gui block
  adm1_model= 'ADM1DE';

  id_initstatetype=  varargin{1,1};
  id_datasourcetype= varargin{1,2};
  id_savestate=      varargin{1,3};
    
  %%
  
  validateattributes(id_initstatetype, {'double'}, ...
    {'integer', 'scalar', 'positive'}, mfilename, 'id_initstatetype', 2);

  validateattributes(id_datasourcetype, {'double'}, ...
    {'integer', 'scalar', 'positive'}, mfilename, 'id_datasourcetype', 3);

  validateattributes(id_savestate, {'double'}, ...
    {'integer', 'scalar', 'positive'}, mfilename, 'id_savestate', 4);

  %%

  max_id= max([id_fermenter, id_initstatetype, id_datasourcetype, id_savestate]);

else
    
  error('You may not call this function with %i arguments', nargin);
    
end

%%
%

% get chosen values
values= get_param(gcb, 'MaskValues');

adm1_style_string= get_param(gcb, 'MaskStyleString');

adm1_style_string_split= regexp(adm1_style_string, ',', 'split');

%%

if (max_id > numel(values))
  error('At least one id (%i) exceeds size of values (%i)!', ...
        max_id, numel(values));
end

%%

fermenter_name= values(id_fermenter);


%%
% ADM1 block

sys_adm1xp= char ( find_system(gcb, 'LookUnderMasks', 'all', ...
                'FollowLinks', 'on', 'Name', 'combi - ADM1xp digester') );

if isempty(sys_adm1xp)
  error('Could not find the system ''combi - ADM1xp digester''!');
end

values_sys_adm1xp= get_param(sys_adm1xp, 'MaskValues');

if isempty(values_sys_adm1xp)
  error('The variable values_sys_adm1xp is empty!');
end

%%

if (max_id > numel(values_sys_adm1xp))
  error('At least one id (%i) exceeds size of values_sys_adm1xp (%i)!', ...
        max_id, numel(values_sys_adm1xp));
end

%%

values_sys_adm1xp(id_fermenter)= fermenter_name;

% These mask parameters only exist for the ADM1DE with GUI block
if strcmp(adm1_model, 'ADM1DE')
    
  values_sys_adm1xp(id_initstatetype)=  values(id_initstatetype);

  values_sys_adm1xp(id_datasourcetype)= values(id_datasourcetype);

  values_sys_adm1xp(id_savestate)=      values(id_savestate);

end

%%

adm1xp_style_string= char(adm1_style_string_split(1,1));

for iel= 1:numel(values_sys_adm1xp) - 1
  adm1xp_style_string= strcat(...
                 adm1xp_style_string, ',', ...
                 char(adm1_style_string_split(1,iel + 1)));
end

%%

try
  set_param(sys_adm1xp, 'MaskStyleString', adm1xp_style_string);
catch ME
  warning('Set:MaskStyleString', ...
          'Could not set the parameter MaskStyleString of block %s!', ...
          sys_adm1xp);

  rethrow(ME);
end

try
  set_param(sys_adm1xp, 'MaskValues', values_sys_adm1xp);
catch ME
  warning('Set:MaskValues', 'Could not set the parameter MaskValues of block %s!', ...
          sys_adm1xp);

  if getMATLABVersion() < 711
    rethrow(ME);
  else
    %rethrow(ME);
    disp('adm1_with_gui_setmasks: not throwing!');
  end
end


%% 
% Measurement Blocks I

find_systems= {...'combi - biogas sensor'; 
               ...'combi - pH sensor'; 
               ...%'combi - FOS/TAC sensor'; 
               ...%'combi - AcVsPro sensor';
               ...'combi - HRT sensor';
               ...'digester ALL sensor';   %% TODO change or delete
               ...'combi - OLR sensor';
               ...'combi - biomass methanogenesis sensor';
               ...'combi - biomass aci&ace sensor';
               ...'combi - TS sensor';
               ...'combi - density sensor';
               'combi - Heating'};

%%

for isystem= 1:size(find_systems, 1)

  %%
  
  sys_block= char ( find_system(gcb, 'LookUnderMasks', 'all', ...
          'FollowLinks', 'on', 'Name', char(find_systems(isystem,1)) ) );

  if isempty(sys_block)
    error('Could not find the system %s', char(find_systems(isystem,1)) );
  end

  values_sys_block= get_param(sys_block, 'MaskValues');

  if isempty(values_sys_block)
    error('The variable values_sys_block is empty!');
  end

  values_sys_block(id_fermenter)= fermenter_name;
  
  %% TODO
  % nr. nicht allgemein
  
  if strcmp( char(find_systems(isystem,1)), 'combi - Heating' )
    
    values_sys_block(6)= values(9);
    
  end

  %%
  
  sys_block_style_string= get_param(sys_block, 'MaskStyleString');

  if isempty(sys_block_style_string)
    error('The variable sys_block_style_string is empty!');
  end

  sys_block_style_string_split= ...
                          regexp(sys_block_style_string, ',', 'split');

  sys_block_style_string_split(1,id_fermenter)= ...
                          adm1_style_string_split(1,id_fermenter);

  %%
  
  sys_block_style_string_new= char(sys_block_style_string_split(1,1));

  for iel= 1:size(sys_block_style_string_split, 2) - 1
    sys_block_style_string_new= strcat(sys_block_style_string_new, ...
                    ',', char(sys_block_style_string_split(1,iel + 1)));
  end

  %sys_block_style_string_new= sys_block_style_string_new(1:end - 1);

  %%
  
  try
    set_param(sys_block, 'MaskStyleString', sys_block_style_string_new);
  catch ME
    warning('Set:MaskStyleString', ...
            'Could not set the parameter MaskStyleString of block %s!', ...
            sys_block);

    rethrow(ME);
  end

  try
    set_param(sys_block, 'MaskValues', values_sys_block);
  catch ME
    warning('Set:MaskValues', 'Could not set the parameter MaskValues of block %s!', ...
            sys_block);

    rethrow(ME);
  end

end



%% 
% Measurement Blocks II

find_systems= {...'combi - substrateflow sensor mat in'; 
               ...'combi - substrateflow sensor mat out'; 
               ...'combi - TS COD sensor in';
               ...'combi - TS COD sensor out';
               ...'combi - SS COD sensor in';
               ...'combi - SS COD sensor out';
               ...'combi - NH4 sensor in';
               ...'combi - NH4 sensor out';
               ...'combi - stream ALL sensor in';    %% TODO - löschen
               ...'combi - stream ALL sensor out';   %% TODO - löschen
               ...'combi - NH3 sensor in';
               ...'combi - NH3 sensor out';
               ...'combi - VFA sensor in';
               ...'combi - VFA sensor out';
               ...'combi - VFA matrix sensor in';
               ...'combi - VFA matrix sensor out';
               ...'combi - TAC sensor in';
               ...'combi - TAC sensor out';
               ...'combi - VS sensor in';
               ...'combi - VS sensor out'
               };
               ...'combi - pH stream sensor in'};

in_out= {...'in'; ...'out'; 
         ...'in'; 'out'; 
         ...'in'; 'out'
         };%; 'in'; 'out'; ...
         %'in'; 'out'; ... %% TODO - löschen, gehört zu stream ALL
         %'in'; 'out'; 'in'; 'out'; 'in'; 'out'; 'in'; 'out'; ...
         %'in'; 'out'; 'in'};

%%

for isystem= 1:size(find_systems,1)
    
  %%
  
  sys_block= char ( find_system(gcb, 'LookUnderMasks', 'all', ...
          'FollowLinks', 'on', 'Name', char(find_systems(isystem,1)) ) );

  if isempty(sys_block)
     error('Could not find the system %s', char(find_systems(isystem,1)) );
  end

  values_sys_block= get_param(sys_block, 'MaskValues');

  if isempty(values_sys_block)
      error('The variable values_sys_block is empty!');
  end

  values_sys_block(id_fermenter)= fermenter_name;

  values_sys_block(2)= in_out(isystem,1);


  %%
  % create the string for the block

  sys_block_style_string= get_param(sys_block, 'MaskStyleString');

  sys_block_style_string_split= ...
                          regexp(sys_block_style_string, ',', 'split');

  sys_block_style_string_split(1,id_fermenter)= ...
                          adm1_style_string_split(1,id_fermenter);

  %%
  
  sys_block_style_string_new= char(sys_block_style_string_split(1,1));

  for iel= 1:size(sys_block_style_string_split, 2) - 1
    sys_block_style_string_new= strcat(sys_block_style_string_new, ...
                    ',', char(sys_block_style_string_split(1,iel + 1)));
  end

  %sys_block_style_string_new= sys_block_style_string_new(1:end - 1);

  %%
  
  try
    set_param(sys_block, 'MaskStyleString', sys_block_style_string_new);
  catch ME
    warning('Set:MaskStyleString', ...
            'Could not set the parameter MaskStyleString of block %s!', ...
            sys_block);

    rethrow(ME);
  end

  try
    set_param(sys_block, 'MaskValues', values_sys_block);
  catch ME
    warning('Set:MaskValues', 'Could not set the parameter MaskValues of block %s!', ...
            sys_block);

    rethrow(ME);
  end
        
end

%%
% heating



%%


