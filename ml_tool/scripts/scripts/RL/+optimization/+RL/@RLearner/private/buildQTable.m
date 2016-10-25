%% optimization.RL.RLearner.private.buildQTable
% Generates Action value function Q
%
function [ Q ]= buildQTable(RLearner, nstates, nactions, varargin)
%% Release: 1.0

%buildQTable do exactly this
%Q: the returned initialized QTable

%%

error( nargchk(3, 5, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 4 && ~isempty(varargin{1}),
  random= varargin{1};
  % can be 0, 1 or a matrix of size Q
else
  random= 0;
end

if nargin >= 5 && ~isempty(varargin{2}),
  opt_sparse= varargin{2};
  is0or1(opt_sparse, 'opt_sparse', 5);
else
  opt_sparse= 1;
end

%% 
% check input arguments

isN(nstates, 'nstates', 2);
isN(nactions, 'nactions', 3);

%%

if (opt_sparse == 0)
  if random == 0
    Q= zeros(nstates, nactions);
  elseif all( size(random) == [nstates, nactions] )
    % then i passed an old Q 
    Q= random;
  else
    Q= rand(nstates, nactions);       % a variant
  end
else
  if random == 0
    Q= sparse(nstates, nactions);
  elseif all( size(random) == [nstates, nactions] )
    % then i passed an old Q 
    Q= random;
  else
    error('sparse random matrix not yet implemented!');

    Q= rand(nstates, nactions);       % a variant
  end
end

%%

%Q= zeros(nstates, nactions) - 1;   % a variant
%Q= zeros(nstates, nactions) + 1;   % another variant

%%


