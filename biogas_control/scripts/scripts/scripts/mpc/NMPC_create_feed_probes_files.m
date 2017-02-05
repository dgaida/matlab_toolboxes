%% NMPC_create_feed_probes_files
% Creates probes_substrate_id_user/const.mat files in mpc subfolder if the
% same files do exist in parent folder
%
function NMPC_create_feed_probes_files(substrate, time, varargin)
%% Release: 1.3

%%

narginchk(2, 3);
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  num_steps= varargin{1};
  isN(num_steps, 'num_steps', 3);
else
  num_steps= 1;
end

%%
% check arguments

is_substrate(substrate, '1st');
isR(time, 'time', 2);

%%

if num_steps > 1
  vol_type= 'user';
else
  vol_type= 'const';
end

n_substrate= substrate.getNumSubstratesD();

%%

for isubstrate= 1:n_substrate
  
  %%
  
  substrate_id= char(substrate.getID(isubstrate));
  
  % lesen aus parent folder, wir sind in mpc unterordner
  filename= sprintf('../probes_%s_%s_measured.mat', substrate_id, vol_type);
  
  %%
  
  if exist(filename, 'file')
    
    %%
    
    probes= load_file(filename);
    
    % get index of current time in probes
    [el, index]= get_nearest_el_in_vec(probes(:,1), time, 'abs');
    
    % create a constant probe used over the prediction horizon
    myprobe= [[0; 100], repmat(probes(index,2:end), 2, 1)];
    
    %% 
    % speichern in unterordner mpc, da wir schon in UO mpc sind, einfach so
    % speichern
    
    save_varname(myprobe, sprintf('probes_%s_%s', substrate_id, vol_type));
    
    %%
    
  end
  
end

%%



%%


