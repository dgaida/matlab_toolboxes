%% getEquilibriumFromFiles
% Get equilibrium from initstate_...mat and volumeflow_..._const.mat files
%
function equilibrium= getEquilibriumFromFiles(plant_id)
%% Release: 1.5

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% read out varargin

is_plant_id(plant_id, '1st');

%%

[substrate, plant, substrate_network, plant_network, d1, d2, d3, plant_network_max]= ...
  load_biogas_mat_files(plant_id);

%%
% creates a default equilibrium structure

equilibrium= defineEquilibriumStruct(plant, plant_network);

%%
% read initstate from file and save user states in equilibrium struct

equilibrium= saveStateInEquilibriumStruct(equilibrium, plant, plant_network, 0, 1);

%%
% network_flux and network_flux_string

n_substrate= substrate.getNumSubstratesD();   % nº of substrates
n_fermenter= plant.getNumDigestersD();        % nº of fermenters

% allocation of memory for auxiliary variable
%M_substrate_vflow_current= zeros(n_substrate, n_fermenter); 

%% 
% SUBSTRATE FLOW

% for isubstrate= 1:n_substrate
% 
%   %%
%   % load volumeflow const files and write their content in equilibrium
%   % struct
%   
%   substrate_id= char(substrate.getID(isubstrate));
% 
%   vdata1= load_file(['volumeflow_', substrate_id, '_const']); % original volumeflow
%   
%   % Matrix of current substrate flow -> i.e. cell: SUBSTRATE FLOW MAX/MIN
%   M_substrate_vflow_current(isubstrate, 1:n_fermenter)= mean( vdata1(2,:) );
% 
% end

vflows= get_volumeflows_at_time(0, plant_id, 'const', 1);
M_substrate_vflow_current= repmat(vflows(:), 1, n_fermenter);

%%

%clear vdata1 isubstrate substrate_id % clear temp variables

%%
% M[substrate_network_max/min] =
% M[substrate_network].*M[volumeflow_substrate_current]
substrate_network_data= substrate_network .* M_substrate_vflow_current;  

equilibrium.network_flux= substrate_network_data(:)';

%%

% index in the substrate flux vectors networkFlux and fluxString
i_flux= 1;

%%
% write corresponding strings in equilibrium

for ifermenter= 1:n_fermenter
  
  fermenter_name= char( plant.getDigesterID(ifermenter) );

  for isubstrate= 1:n_substrate

    substrate_name= char( substrate.getID(isubstrate) );

    equilibrium.network_flux_string(1, i_flux)= ...
            {[substrate_name, '->', fermenter_name]};
    
    i_flux= i_flux + 1;
    
  end
  
end


%%
% add digester sludge

[nSplits, digester_splits]= getNumDigesterSplits(plant_network, ...
                                                 plant_network_max, plant, '->');

%%
% load volumeflow const files and write them in equilibrium struct

for isplit= 1:nSplits
  
  spl= digester_splits{isplit};
  
  spl_= strrep(spl, '->', '_');
  
  vdata1= load_file(['volumeflow_', spl_, '_const']); % original volumeflow
  
  equilibrium.network_flux(1, end + 1)= mean(vdata1(2,:));
  
  equilibrium.network_flux_string(1, end + 1)= {spl};
  
end

%%



%%


