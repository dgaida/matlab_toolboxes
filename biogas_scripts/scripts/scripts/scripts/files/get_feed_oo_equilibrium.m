%% get_feed_oo_equilibrium
% Get substrate feed out of equilibrium and sum it up over the digesters
%
function [substrate_feed, u_vflw]= get_feed_oo_equilibrium(equilibrium, substrate, plant, ...
                                                   type, lenGenomSubstrate)
%% Release: 1.4

%%

error( nargchk(5, 5, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

is_equilibrium(equilibrium, 1);
is_substrate(substrate, '2nd');
is_plant(plant, '3rd');
validatestring(type, {'const_first', 'const_last', 'user'}, mfilename, 'type', 4);
isN(lenGenomSubstrate, 'lenGenomSubstrate', 5);

%%

n_substrate= substrate.getNumSubstratesD();   % nº of substrates
n_fermenter= plant.getNumDigestersD();        % nº of fermenters

%%

[substrate_feed, u_vflw]= get_substratefeed_oo_networkflux(equilibrium.network_flux, ...
  n_substrate, n_fermenter, lenGenomSubstrate);

%%

switch type
   
  case 'user'
  
    % do nothing
    
  case 'const_first'
    
    substrate_feed= substrate_feed(:,1);
    u_vflw= u_vflw(1:lenGenomSubstrate:end, :);
    
  case 'const_last'
    
    substrate_feed= substrate_feed(:,lenGenomSubstrate);
    u_vflw= u_vflw(lenGenomSubstrate:lenGenomSubstrate:end, :);
    
  otherwise
    
    error('Unknown type: %s', type);
    
end

%%


