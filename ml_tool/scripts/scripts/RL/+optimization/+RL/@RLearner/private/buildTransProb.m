%% optimization.RL.RLearner.private.buildTransProb
% Generates set of transition probability P_s_s'_a
%
function [ Ps_ss_a ]= buildTransProb(RLearner, nstates, nactions, varargin)
%% Release: 1.0

%buildTransProb do exactly this
%Ps_ss_a: the returned initialized 

%%

error( nargchk(3, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 4 && ~isempty(varargin{1}),
  random= varargin{1};
  % can be 0,1 or a struct
else
  random= 0;
end

%% 
% check input args

isN(nstates, 'nstates', 2);
isN(nactions, 'nactions', 3);

%%

Ps_ss_a= struct;

for iaction= 1:nactions

  %%
  
  if isstruct(random)
      % then i passed an old P
      Ps_ss_a.(sprintf('a%i', iaction))= random.(sprintf('a%i', iaction));
  elseif random == 0
      Ps_ss_a.(sprintf('a%i', iaction))= sparse(nstates, nstates);
  else
      error('a sparse random probability set not yet implemented!');

      Ps_ss_a.(sprintf('a%i', iaction))= ...
                 sparse(rand(nstates, nstates));     % a variant
  end

end

%%


