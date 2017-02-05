%% NMPC_ctrl_strgy_FermenterFlow_MinMax
% Create fermenter flow min/max of nonlinear MPC function
%
function varargout= NMPC_ctrl_strgy_FermenterFlow_MinMax(varargin)
%% Release: 1.2

%%

error( nargchk(6, 12, nargin, 'struct') );
error( nargoutchk(2, 2, nargout, 'struct') );

%%
% Input Initialization

plant=                   varargin{1};
plant_network=           varargin{2};
plant_network_min=       varargin{3};
plant_network_max=       varargin{4};
plant_network_min_limit= varargin{5};
plant_network_max_limit= varargin{6};

if nargin >= 7 && ~isempty(varargin{7})
  change_type= varargin{7};
  validatestring(change_type, {'percentual', 'absolute'}, mfilename, 'change_type', 7);
else
  change_type= 'percentual';
end

if nargin >= 8 && ~isempty(varargin{8})
  change_fermenter= varargin{8};
  checkArgument(change_fermenter, 'change_fermenter', 'double', 8);
else
  change_fermenter= 0.05;
end

if nargin >= 9 && ~isempty(varargin{9})
  trg= varargin{9};
  is_onoff(trg, 'trg', 9);
else
  trg= 'off';
end

if nargin >= 10 && ~isempty(varargin{10})
  trg_opt= varargin{10};
  isR(trg_opt, 'trg_opt', 10);
else
  trg_opt= -Inf;
end

if nargin >= 11 && ~isempty(varargin{11})
  fitness_trg= varargin{11};
  checkArgument(fitness_trg, 'fitness_trg', 'double', 11);
else
  fitness_trg= [];
end

if nargin >= 12 && ~isempty(varargin{12})
  wrng_msg= varargin{12};
  is_onoff(wrng_msg, 'wrng_msg', 12);
else
  wrng_msg= 'on';
end

%%
% check params

is_plant(plant, '1st');
is_plant_network(plant_network, 2, plant);
is_plant_network(plant_network_min, 3, plant);
is_plant_network(plant_network_max, 4, plant);
is_plant_network(plant_network_min_limit, 5, plant);
is_plant_network(plant_network_max_limit, 6, plant);


%%
% FERMENTER FLOW MIN/MAX

% Check plant_network_min/max violation
if strcmp(wrng_msg, 'on') 
    
  %%
  
  NMPC_check_plant_network_bounds(plant_network_min, plant_network_max, ...
  plant_network_min_limit, plant_network_max_limit, plant, plant_network);
  
  %%
  
end

%% 
% Change Control Strategy

nfit_trg= size( fitness_trg, 2 );
change_max= 0.25; % André original: 0.10;  finde ich etwa zu klein
change_min= 0.005; 

if strcmp( trg, 'on' ) 
    
  if nfit_trg >= 5    % fitness_trg > 5

    %%
    % fitness_trg : fitness is not changing
    if sum( abs( fitness_trg( nfit_trg - 4 : nfit_trg ) ) ) <= 0.01
      
      %%
      % increase
      if trg_opt == Inf
        change_fermenter= min( change_fermenter .* 1.1, change_max );
        assignin('caller', 'change_fermenter', change_fermenter);
      end
      
      % decrease
      if trg_opt == -Inf
        change_fermenter= max( change_fermenter .* 0.9, change_min );
        assignin('caller', 'change_fermenter', change_fermenter);
      end
      
      warning('nonlinearMPC:TriggerActive', 'Trigger active!');  
      
    end
    
  end

  %% TODO
  % macht das sinn, dass das hier steht und nicht auch in if abfrage oben,
  % dass fitness sich nicht mehr ändert? 
  if trg_opt ~= Inf && trg_opt ~= -Inf
    % factor must be positive
    isR(trg_opt, 'trg_opt', 10, '+');
    
    change_fermenter= change_fermenter .* trg_opt;
    %% TODO
    % why is this value not returned to caller?
%   assignin( 'caller', 'change_fermenter' , change_fermenter );
  end
end


%% 
% NEW FERMENTER FLOW MAX/MIN

%% 
% das funktioniert bisher nur, wenn change_fermenter ein Skalar ist.
% change_fermenter kann allerdings auch eine matrix in größe von
% plant_network sein. Ne, ich denke, dass das auch mit matrix funktioniert!
% s. bsp.. 1 - matrix geht und ich nutze .*

% set plant network min/max +/- around current plant network
if strcmp(change_type, 'percentual') 
  
  if any(change_fermenter > 1)
    error('some element in change_fermenter is larger 100 %%: %.2f %%!', ...
      100 .* max(max(change_fermenter)));
  end
  
  %%
  % M[plant_network_max/min] = M[plant_network_current_max/min]*(1 +/- 10%)
  % here we check the new PLNW min is more than PLNW min Limit and less
  % than PLNW max limit.plant_network_min.*(1 - change_fermenter) means a
  % column wise multiplication. Remember PLNW min and PLNW max are now
  % equal to the current const volume flow. So here we change PLNW max very
  % near to the const flow and 'Change' variable is what defines it.
  plant_network_min= min( max( plant_network_min.*(1 - change_fermenter), ...
        plant_network_min_limit ), plant_network_max_limit ); % LB for plant_network_min
      
  plant_network_max= max( min( plant_network_max.*(1 + change_fermenter), ...
        plant_network_max_limit ), plant_network_min_limit ); % UB for plant_network_max

else % change_type== 'absolute'
        % (plant_network_min change_fermenter .* (plant_network_min > 0)
        % means a column wise multiplication of te difference and watever
        % elements which satisfy the condition PLNW min is >0
  plant_network_min= min( max( max(plant_network_min - ...
                       change_fermenter .* (plant_network_min > 0), 0), ...
                       plant_network_min_limit ), ...
                       plant_network_max_limit ); % lb for substrate_network_min


  plant_network_max= max( min( max(plant_network_max + ...
                      change_fermenter .* (plant_network_max > 0), 0), ...
                      plant_network_max_limit ), ...
                      plant_network_min_limit ); % ub for substrate_network_max

end


%% 
% Warning ! Fermenter Flux
%all returns all non zero values in the array and abs returns absolute
%value
% this is merely an information, because it is not bad, if boundaries are
% equal
if all( abs( plant_network_max - plant_network_max_limit) < 0.00001 )
  
  warning('nonlinearMPC:PlantUBequal', 'plant_network_max/limit is identical! diff= %.2f!', ...
          sum(sum(abs( plant_network_max - plant_network_max_limit ))));

elseif all( abs( plant_network_min - plant_network_min_limit) < 0.00001 )

  warning('nonlinearMPC:PlantLBequal', 'plant_network_min/limit is identical! diff= %.2f!', ...
          sum(sum(abs( plant_network_min - plant_network_min_limit ))));

end

%%
% ich glaube nicht, dass das inkonsistent ist. es könnte bspw. sein, dass
% aus irgendeinem grund max == min für eine gewisse zeit ist, aber im
% prinzip max_limit > min_limit ist
if sum( any( ( plant_network_max ~= plant_network_min ) - ...
             ( plant_network_max_limit ~= plant_network_min_limit ) ) ...
      )
    
  warning('nonlinearMPC:PlantBoundsInconsistent', ...
          'ERROR : Plant Flow MIN/MAX & Limits are inconsistent!');
        
end
    
%% 
% Output vector
varargout= { plant_network_min, plant_network_max };

%%


