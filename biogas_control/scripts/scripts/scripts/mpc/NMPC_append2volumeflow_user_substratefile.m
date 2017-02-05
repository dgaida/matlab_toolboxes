%% NMPC_append2volumeflow_user_substratefile
% Get substrate volumetric flowrates out of equilibrium and appends them to
% volumeflow_..._user_1.mat files
%
function NMPC_append2volumeflow_user_substratefile(equilibrium, substrate, ...
  plant, delta, varargin)
%% Release: 1.3

%%

narginchk(4, 5);
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 5 && ~isempty(varargin{1})
  lenGenomSubstrate= varargin{1};
  isN(lenGenomSubstrate, 'lenGenomSubstrate', 5);
else
  lenGenomSubstrate= 1;
end

%%
% check params

is_equilibrium(equilibrium, '1st');
is_substrate(substrate, '2nd');
is_plant(plant, '3rd');
isR(delta, 'delta', 4, '+');

%%

n_substrate= substrate.getNumSubstratesD();   % nº of substrates


%%
% get volumeflow out of equilibrium
%
% matrix with n_substrate rows and lenGenomSubstrate columns
% thus in first row there is the user substrate feed of the first
% substrate, ...
% here it is just the first column thus the first value
u_vflw= get_feed_oo_equilibrium(equilibrium, substrate, plant, ...
                                'const_first', lenGenomSubstrate);

%% 
% NEW SUBSTRATE FLOW
% the current input vector (substrate flow/fermenter flow) to the current
% optimal one (use equilibrium structure).

% Substrate vector -> Substrate matrix 
for isubstrate = 1:n_substrate
  
  %%

  substrate_id= char(substrate.getID(isubstrate));
  
  %%
  % load volumeflow_user file
  
  vname= sprintf( 'volumeflow_%s_user', substrate_id ); 
  
  if exist(fullfile(pwd, [vname, '_1.mat']), 'file')
    vdata= load_file([vname, '_1']);    % with or without file extension
  else
    vdata= [];
  end
  
  %%
  % append u_vflw to volumeflow_user
  
  vdata= NMPC_append2volumeflow_user(vdata, u_vflw(isubstrate), delta);
  
  %%
  % save volumeflow_user to file
  
  save_varname(vdata, vname, [vname, '_1']);
  
  %%

end

%%


