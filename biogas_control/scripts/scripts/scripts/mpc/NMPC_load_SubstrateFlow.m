%% NMPC_load_SubstrateFlow 
% Load substrate flow & max/min of startNMPC function
%
function [substrate_network_min, substrate_network_max]= ...
          NMPC_load_SubstrateFlow(varargin)
%% Release: 1.4

%%

error( nargchk(3, 4, nargin, 'struct') );
error( nargoutchk(2, 2, nargout, 'struct') );

%%
% Input Initialization

substrate=         varargin{1};
substrate_network= varargin{2};
plant=             varargin{3};

if nargin >= 4 && ~isempty(varargin{4})
  id_read= varargin{4};
  isN0(id_read, 'id_read', 4);
else
  id_read= [];
end

%%
% check params

is_substrate(substrate, '1st');
is_substrate_network(substrate_network, 2, substrate, plant);
is_plant(plant, '3rd');

%% 
% Auxiliary variables 

n_substrate= substrate.getNumSubstratesD();   % nº of substrates
n_fermenter= plant.getNumDigestersD();        % nº of fermenters

% allocation of memory for auxiliary variable
M_substrate_vflow_current= zeros(n_substrate, n_fermenter); 

%% 
% SUBSTRATE FLOW

for isubstrate= 1:n_substrate

  %%
  
  substrate_id= char(substrate.getID(isubstrate));

  % This routine loads a 'filename.mat' and saves the data with the same
  % 'filename' string in workspace 

  %% TODO
  % be careful: volumeflow const files are used! is this correct???
  % I think it is ok, because it is only called once in the beginning of
  % nonlinearMPC. I do not know why volumeflow_..._const is assigned to the
  % workspace of the calling function?
  
  % Read Out original Substtrate feed from volumeflow_'substrate_id'_const.mat
  if ~isempty(id_read)
    % latest volumeflow index '_%i'
    vdata1= load_file(['volumeflow_', substrate_id, sprintf('_const_%i', id_read)]);  
  else
    vdata1= load_file(['volumeflow_', substrate_id, '_const']); % original volumeflow
  end

  %% TODO
  % not needed
  % assignin( 'caller' , ['volumeflow_', substrate_id, '_const'] , vdata1);

  % Matrix of current substrate flow -> i.e. cell: SUBSTRATE FLOW MAX/MIN
  M_substrate_vflow_current(isubstrate, 1:n_fermenter)= mean( vdata1(2,:) );

end

%%

clear vdata1 isubstrate substrate_id % clear temp variables

%%
% M[substrate_network_max/min] =
% M[substrate_network].*M[volumeflow_substrate_current] *(1 +/- change: 10%) 
substrate_network_min= substrate_network .* M_substrate_vflow_current;  
substrate_network_max= substrate_network .* M_substrate_vflow_current;

%%

