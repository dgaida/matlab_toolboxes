%% assign_initstate_inMWS
% Assigns initstate in modelworkspace, for new MATLAB versions saves it in
% file
%
function assign_initstate_inMWS(plant_id, initstate)
%% Release: 1.9

%%
%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(plant_id, 'plant_id', 'char', '1st');
is_initstate(initstate, '2nd');


%%
% for old MATLAB versions |initstate| is saved in MWS
%
if getMATLABVersion() < 711

  %%
  
  try

    assigninMWS('initstate', initstate);

  catch ME

    warning('assigninMWS:error', 'assigninMWS initstate problem!');
    rethrow(ME);

  end

else % new matlab version does not allow setting mws during runtime anymore

  %%

  bdroot_split= regexp( bdroot, '_', 'split' );

  %%
  % initialize the state with initial conditions
  %
  if size(bdroot_split, 2) >= 3 && ~isnan( str2double(bdroot_split{1,end}) )

    % we are in parallel mode
    filename= sprintf('initstate_%s_%s.mat', plant_id, ...
                      bdroot_split{1,end});

  else
    
    filename= sprintf('initstate_%s.mat', plant_id);

  end

  %%

  try
    save_varname(initstate, 'initstate', filename);
  catch ME
    rethrow(ME);
  end
  
  %%

end
  
%%


