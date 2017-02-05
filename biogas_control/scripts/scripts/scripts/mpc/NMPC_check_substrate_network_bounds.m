%% NMPC_check_substrate_network_bounds
% Check substrate_network_min/max boundaries on validity
%
function NMPC_check_substrate_network_bounds(substrate_network_min, substrate_network_max, ...
  substrate_network_min_limit, substrate_network_max_limit, substrate, plant)
%% Release: 1.3

%%

narginchk(6, 6);
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check params

is_substrate(substrate, 5);
is_plant(plant, 6);

is_substrate_network(substrate_network_min, 1, substrate, plant);
is_substrate_network(substrate_network_max, 2, substrate, plant);
is_substrate_network(substrate_network_min_limit, 3, substrate, plant);
is_substrate_network(substrate_network_max_limit, 4, substrate, plant);

%% 
% Auxiliary variables 

n_substrate= substrate.getNumSubstratesD();   % nº of substrates
n_fermenter= plant.getNumDigestersD();        % nº of fermenters

%% 
% for loop should be replaced by any(any( substrate_network_max >
% substrate_network_max_limit )) ...
% for loop wird genutzt, damit fehlermeldung richtig ausgegeben werden
% kann, halt für jedes substrat einzeln

for ifermenter= 1:n_fermenter

  %%

  for isubstrate= 1:n_substrate

    %%

    substrate_id= char(substrate.getID(isubstrate));

    % Substrate name
    vname1= ['volumeflow_', substrate_id, '_const'];

    %%
    % Substrate Min Limit
    if any( substrate_network_max(isubstrate,ifermenter) > ...
            substrate_network_max_limit(isubstrate,ifermenter) ...
          )
        warning('NMPC:substrateUB', ...
               ['The ', vname1, ' is over the maximum permited limit: %i > %i!'], ...
                substrate_network_max(isubstrate,ifermenter), ...
                substrate_network_max_limit(isubstrate,ifermenter));
    % Substrate Max Limit    
    end

    %%

    if any( substrate_network_min(isubstrate,ifermenter) < ...
            substrate_network_min_limit(isubstrate,ifermenter) ...
          )
        warning('NMPC:substrateLB', ...
               ['The ', vname1, ' is under the minimum permited limit: %i > %i!'], ...
                substrate_network_min(isubstrate,ifermenter), ...
                substrate_network_min_limit(isubstrate,ifermenter));
    end

  end
  
end

clear isubstrate ifermenter


%%



%%


