%% optimization.RL.RLearner.private.buildStateGrid
% Generates state grid
%
function [stateGrid]= buildStateGrid(RLearner, LB, UB, nSamples)
%% Release: 1.0

%%

error( nargchk(4, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check input params

if numel(LB) ~= numel(UB)
  error('The parameters LB and UB must be of same dimension, but %i ~= %i!', ...
        numel(LB), numel(UB));
end

%%

LB= LB(:);
UB= UB(:);

isN(nSamples, 'nSamples', 4);

%%
%

dim= numel(LB);

stateGrid= zeros(nSamples^dim, dim);

%%
%

for idim= 1:1:dim

  %%
  %

  grid= LB(idim) : ( UB(idim) - LB(idim) ) / ( nSamples - 1 ) : UB(idim);
  grid= grid(:);

  %%
  %

  repValues= nSamples^(dim - idim);

  grid= repmat(grid, 1, repValues)';
  grid= grid(:);

  %%
  %

  repGrid= nSamples^(idim - 1);

  stateGrid(:,idim)= repmat(grid, repGrid, 1);

end

%%


