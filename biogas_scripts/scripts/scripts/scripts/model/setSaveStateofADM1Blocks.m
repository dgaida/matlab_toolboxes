%% setSaveStateofADM1Blocks
% Set the savestate checkbox on the gui of the 'ADM1 with gui' block.
%
function setSaveStateofADM1Blocks(fcn, value)
%% Release: 1.9

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

global IS_DEBUG;

%%

if IS_DEBUG
  
  checkArgument(fcn, 'fcn', 'char', '1st');

  validatestring(value, {'on', 'off'}, mfilename, 'value', 2);

end

%%

if getMATLABVersion() <= 708
  disp('setSaveStateofADM1Blocks: Suppressing warning LibraryVersion!');
  % warning OFF LibraryVersion
  warning('off', 'Simulink:SL_RefBlockUnknownParameter');
end

%%
% throw away file extension

str= regexp(fcn, '\.mdl', 'split');

fcn= str{1};

%%

sys_adm1xps= char ( find_system(fcn, 'LookUnderMasks', 'all', ...
                'FollowLinks', 'on', 'Name', 'combi - ADM1xp digester') );

%%

if isempty(sys_adm1xps)
  warning('find_system:ADM1xp', ...
          'Could not find any ''combi - ADM1xp digester'' block!');
end

%%

for imodel= 1:size(sys_adm1xps,1)%2

  sys_adm1xp= sys_adm1xps(imodel,:);

  sys_adm1xp_split= regexp(sys_adm1xp, '/', 'split');

  sys_adm1xp= char(sys_adm1xp_split{1});

  for isplit= 2:size(sys_adm1xp_split,2) - 1

    sys_adm1xp= strcat(sys_adm1xp, '/', char(sys_adm1xp_split{isplit}));

  end

  %%
  
  values_sys_adm1xp= get_param(sys_adm1xp, 'MaskValues');

  values_sys_adm1xp{4,1}= value;

  try
    set_param(sys_adm1xp, 'MaskValues', values_sys_adm1xp);
    disp(['setSaveStateofADM1Blocks: Successfully set ', ...
          '''combi - ADM1xp digester'' block: ', value, '!']);
  catch ME
    disp(ME.message);
    rethrow(ME);
  end
  
end

%%

if getMATLABVersion() <= 708
  % warning On LibraryVersion
  warning('on', 'Simulink:SL_RefBlockUnknownParameter');
end

%%

    
    