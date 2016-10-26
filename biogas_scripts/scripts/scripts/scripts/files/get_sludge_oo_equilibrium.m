%% get_sludge_oo_equilibrium
% Get recirculation sludge out of equilibrium
%
function [sludge]= get_sludge_oo_equilibrium(equilibrium, substrate, plant, ...
                                             type, lenGenomSubstrate, varargin)
%% Release: 1.4

%%

error( nargchk(5, 8, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 6 && ~isempty(varargin{1})
  lenGenomPump= varargin{1};
  isN(lenGenomPump, 'lenGenomPump', 6);
else
  lenGenomPump= 1;
end

if nargin >= 7 && ~isempty(varargin{2})
  plant_network= varargin{2};
  is_plant_network(plant_network, 7, plant);
else
  plant_network= [];
end

if nargin >= 8 && ~isempty(varargin{3})
  plant_network_max= varargin{3};
  is_plant_network(plant_network_max, 8, plant);
else
  plant_network_max= [];
end

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

if ~isempty(plant_network) && ~isempty(plant_network_max)
  [nSplits]= getNumDigesterSplits(plant_network, plant_network_max, plant);
else
  nSplits= numel(equilibrium.network_flux) - n_substrate * n_fermenter * lenGenomSubstrate;
  nSplits= nSplits / lenGenomPump;
end

%%

if (numel(equilibrium.network_flux) ~= ...
            n_substrate * n_fermenter * lenGenomSubstrate + nSplits * lenGenomPump)
  error(['numel(equilibrium.network_flux) ~= n_substrate * n_digester * ', ...
         'lenGenomSubstrate + nSplits * lenGenomPump: %i ~= %i * %i * %i + %i * %i'], ...
         numel(equilibrium.network_flux), ...
         n_substrate, n_fermenter, lenGenomSubstrate, nSplits, lenGenomPump);
end

%%

% For example if n_substrate= 3, lenGenomSubstrate= 2 and n_fermenter= 3
% and nSplits= 2, lenGenomPump= 3
% then size(u_vflw)= [1,6]
sludge= equilibrium.network_flux(1, n_substrate * n_fermenter * lenGenomSubstrate + 1:end);

% size(sludge)= [2,3]
%
% matrix with nSplits rows and lenGenomPump columns
% thus in first row there is the user recycle between two digesters, ...
sludge= reshape(sludge, lenGenomPump, nSplits)';

%%

switch type
   
  case 'user'
  
    % do nothing
    
  case 'const_first'
    
    sludge= sludge(:,1);
    
  case 'const_last'
    
    sludge= sludge(:,lenGenomPump);
  
  otherwise
    
    error('Unknown type: %s', type);
    
end

%%


