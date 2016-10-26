%% get_substratefeed_oo_networkflux
% Get substrate feed out of network flux
%
function [substratefeed, u_vflw]= get_substratefeed_oo_networkflux(networkflux, ...
  n_substrate, n_digester, lenGenomSubstrate)
%% Release: 1.3

%%

error( nargchk(4, 4, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

isRn(networkflux, 'networkflux', 1);
isN(n_substrate, 'n_substrate', 2);
isN(n_digester, 'n_digester', 3);
isN(lenGenomSubstrate, 'lenGenomSubstrate', 4);

%%

if numel(networkflux) < n_substrate * n_digester * lenGenomSubstrate
  error(['numel(networkflux) (%i) < ', ...
         'n_substrate (%i) * n_digester (%i) * lenGenomSubstrate (%i)'], ...
        numel(networkflux), n_substrate, n_digester, lenGenomSubstrate);
end

%%
% For example if n_substrate= 3, lenGenomSubstrate= 2 and n_fermenter= 2
% then size(u_vflw)= [1,12]
u_vflw= networkflux(1, 1:n_substrate * n_digester * lenGenomSubstrate);

% size(u_vflw)= [6,2]
u_vflw= reshape(u_vflw, n_substrate * lenGenomSubstrate, n_digester);

% size(substrate_feed)= [6,1]
substratefeed= sum(u_vflw, 2);

% size(substrate_feed)= [3,2]
%
% matrix with n_substrate rows and lenGenomSubstrate columns
% thus in first row there is the user substrate feed of the first
% substrate, ...
substratefeed= reshape(substratefeed, lenGenomSubstrate, n_substrate)';

%%


