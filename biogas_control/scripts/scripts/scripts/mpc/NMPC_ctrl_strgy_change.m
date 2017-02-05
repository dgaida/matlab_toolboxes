%% NMPC_ctrl_strgy_change
% Sets change for substrate and fermenter flow
%
function varargout= NMPC_ctrl_strgy_change(varargin)
%% Release: 1.7

%%

narginchk(5, 5);
error( nargoutchk(2, 2, nargout, 'struct') );

%%
% Input Initialization

change=            varargin{1};
substrate=         varargin{2};
plant=             varargin{3};
plant_network=     varargin{4};
plant_network_max= varargin{5};

%%
% check params

checkArgument(change, 'change', 'double', '1st');
is_substrate(substrate, '2nd');
is_plant(plant, '3rd');
is_plant_network(plant_network, 4, plant);
is_plant_network(plant_network_max, 5, plant);

                
%% 
% Auxiliary variables 

n_substrate= substrate.getNumSubstratesD();   % nº of substrates
n_fermenter= plant.getNumDigestersD();        % nº of fermenters

n_fermenter_net= n_fermenter * n_substrate; % total of fermenters and substrates 
n_fermenter_eq=  numel(change);

%%

if n_fermenter_eq ~= 1 && n_fermenter_eq < n_fermenter_net
  error(['The 1st parameter change either must be a scalar, ', ...
         'or a vector with at least %i elements, but has only %i elements!'], ...
         n_fermenter_net, numel(change));
end

%% 
% Change : strategy substrate_network

if ( numel(change) >= n_fermenter_net ) 
  change_substrate= reshape( change(1:n_substrate*n_fermenter), ...
                             n_substrate, n_fermenter );
else
  % case change is constant for all substrates.
  change_substrate= change; % change is a scalar
end

%% 
% Change : strategy plant_network

if ( numel(change) >= n_fermenter_net ) 
  
  %%
  
  change_fermenter= zeros( size( plant_network ));

  %%
  
  [nSplits, digester_splits, digester_indices]= ...
       getNumDigesterSplits(plant_network, plant_network_max, plant);
                          
  %%
  
  for isplit= 1:nSplits     
    
    %%
    
    n_fermenter_net= n_fermenter_net + 1;

    if numel(change) < n_fermenter_net
      error('Size of parameter change is too small! Must be at least %i, but is %i!', ...
            n_fermenter_net, numel(change));
    end

    change_fermenter(digester_indices(isplit,1), digester_indices(isplit,2))= ...
      change( n_fermenter_net ); 

  end % for 
  
  %%
  
  if numel(change) > n_fermenter_net
    warning('NMPC_ctrl_strgy_change:change', ...
            'Parameter change has too many elements! Is %i, should be %i!', ...
            numel(change), n_fermenter_net);
  end
  
else
  % case change is constant for all fermenters.
  change_fermenter= change; % change is a scalar
end

%%
% Output
varargout= { change_substrate, change_fermenter };

%%


