%% optimization.RL.RLearner.private.buildActionList
% Generates action list
%
function [actions]= buildActionList(RLearner, size_u, change)
%% Release: 1.0

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%% 
% check input arguments

isN(size_u, 'size_u', 2);
isR(change, 'change', 3);

%%
%

actions= zeros(3^size_u, size_u);

%%


for idim= 1:1:size_u
    
  %%
  %

  grid= [-1.0 * change, 0.0, 1.0 * change];
  grid= grid(:);

  %%
  %

  repValues= 3^(size_u - idim);

  grid= repmat(grid, 1, repValues)';
  grid= grid(:);

  %%
  %

  repGrid= 3^(idim - 1);

  actions(:,idim)= repmat(grid, repGrid, 1);

end



%%


