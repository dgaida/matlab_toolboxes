%% save_substrate_network_to
% Save substrate_network to file, workspace or model workspace
%
function save_substrate_network_to(substrate_network, plant_id, varargin)
%% Release: 1.3

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1}), 
  accesstofile= varargin{1}; 
  isZ(accesstofile, 'accesstofile', 3, -1, 1);
else
  accesstofile= -1; 
end

%%
% check arguments

is_substrate_network(substrate_network, 1);
checkArgument(plant_id, 'plant_id', 'char', '2nd');


%%

if accesstofile == 0

  % write the new substrate_network into the base workspace
  assignin('base', 'substrate_network', substrate_network);

elseif accesstofile == -1

  if getMATLABVersion() < 711

    try
      assigninMWS('substrate_network', substrate_network);
    catch ME

      warning('assigninMWS:error', 'assigninMWS error');
      rethrow(ME);

    end

  else
    
    %%

    bdroot_split= regexp( bdroot, '_', 'split' );

    %%
    % initialize the state with initial conditions
    %
    if size(bdroot_split, 2) >= 3 && ~isnan( str2double(bdroot_split{1,end}) )

      filename= sprintf('substrate_network_%s_%s.mat', plant_id, ...
                        bdroot_split{1,end});
    else
      filename= sprintf('substrate_network_%s.mat', plant_id);
    end

    %%

    save (filename, 'substrate_network');

    %%

  end

elseif accesstofile == 1

  %% 
  % write substrate_network to file in the current folder
  
  filename= sprintf('substrate_network_%s.mat', plant_id);
  save (filename, 'substrate_network');

else

  error('The value for accesstofile %i is not well chosen!', accesstofile);

end

%%


