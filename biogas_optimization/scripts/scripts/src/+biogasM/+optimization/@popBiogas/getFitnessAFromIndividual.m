%% biogasM.optimization.popBiogas.getFitnessAFromIndividual
% Get the fitness of the individual with respect to linear inequality
% constraints. 
%
function fitness= getFitnessAFromIndividual(obj, u)
%% Release: 1.8

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

validateattributes(u, {'double'}, {'2d'}, mfilename, 'individual',  1);

%%
%

% nRows= size(u, 1);
% 
% %%
% 
% Cinv= obj.conObj.Cinv;
% d= obj.conObj.d;
% 
% %%
% % see getScalingTransformation
% %
% % $$\vec{x} = C^{-1} \cdot \vec{x}_{sc} + \vec{d}$$
% %
% u= ( Cinv * u' + repmat(d, 1, nRows) )';

%%

if ~isempty(obj.conObj.conA)
  fitness= 1e4 .* sum(max(obj.conObj.conA * u' - obj.conObj.conb, 0));
else
  fitness= 0;
end

%%


