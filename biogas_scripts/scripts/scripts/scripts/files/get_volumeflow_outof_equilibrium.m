%% get_volumeflow_outof_equilibrium
% Create all volumeflow files out of equilibrium
%
function [substrate_feed, sludge]= get_volumeflow_outof_equilibrium(plant_id, equilibrium, varargin)
%% Release: 1.4

%%

error( nargchk(2, 6, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% get parameter

if nargin >= 3 && ~isempty(varargin{1})
  id_write= varargin{1};
  
  checkArgument(id_write, 'id_write', 'char', '3rd');
  
  id_write= str2double(id_write);
else
  id_write= [];
end

%% TODO - erweitern für lenGenomPump

if nargin >= 4 && ~isempty(varargin{2})
  lenGenomSubstrate= varargin{2};
  
  isN(lenGenomSubstrate, 'lenGenomSubstrate', 4);
else
  lenGenomSubstrate= 1;
end

if nargin >= 5 && ~isempty(varargin{3})
  const_user= varargin{3};
  
  validatestring(const_user, {'const', 'user'}, mfilename, 'const_user', 5);
else
  const_user= 'const';  % user
end

if nargin >= 6 && ~isempty(varargin{4})
  writetofile= varargin{4};
  
  is0or1(writetofile, 'writetofile', 6);
else
  writetofile= 1;
end

%%
% check arguments

checkArgument(plant_id, 'plant_id', 'char', '1st');
is_equilibrium(equilibrium, '2nd');

%%

[substrate, plant, substrate_network, plant_network, ...
 substrate_network_min, substrate_network_max, ...
 plant_network_min, plant_network_max]= ...
                              load_biogas_mat_files(plant_id);

%%

n_substrate= substrate.getNumSubstratesD();

%%

[nSplits, digester_splits]= getNumDigesterSplits(plant_network, ...
                                plant_network_max, plant);

%%
% matrix with n_substrate rows and lenGenomSubstrate columns
% thus in first row there is the user substrate feed of the first
% substrate, ...
networkSubs= get_feed_oo_equilibrium(equilibrium, substrate, plant, ...
                                     'user', lenGenomSubstrate);

%% TODO
% erweitern für lenGenomPump anstatt 1

networkFlux= get_sludge_oo_equilibrium(equilibrium, substrate, plant, ...
                                       'user', lenGenomSubstrate, 1, ...
                                       plant_network, plant_network_max);
                                           
%%

if (writetofile)
  for isubstrate= 1:n_substrate
  
    substrate_id= char(substrate.getID(isubstrate));
  
    if strcmp(const_user, 'const')
      createvolumeflowfile('const', networkSubs(isubstrate, 1), ...
                           substrate_id, [], [], [], [], 1, [], id_write);
    else  % user
      createvolumeflowfile('user', networkSubs(isubstrate, :), substrate_id, ...
                           [], [], [], [], 1, [], id_write);
    end
                       
  end
end

%%
% create return values

if strcmp(const_user, 'const')
  substrate_feed= networkSubs(:, 1); % column vector
  
  sludge= networkFlux(:, 1);        % column vector
else
  substrate_feed= networkSubs; % first row, substrates of 1st substrates ...
  
  sludge= networkFlux;    % first row, first recycle of digesters, ...
end

%%

if (writetofile)
  for iflow= 1:nSplits

    flow_id= digester_splits{iflow};

    if strcmp(const_user, 'const')
      createvolumeflowfile('const', networkFlux(iflow, 1), flow_id, ...
                           [], [], [], [], 1, [], id_write);
    else % user
      createvolumeflowfile('user', networkFlux(iflow, :), flow_id, ...
                           [], [], [], [], 1, [], id_write);
    end 
    
  end
end

%%



%%


