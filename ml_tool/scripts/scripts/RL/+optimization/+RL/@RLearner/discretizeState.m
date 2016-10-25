%% optimization.RL.RLearner.discretizeState
% Discretizes state
%
function [ s ]= discretizeState( RLearner, x, statelist )
%% Release: 0.8

%DiscretizeState check which entry in the state list is more close to x and
%return the index of that entry.

%[d  s] = min(dist(statelist,x'));

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%% TODO
% check input arguments



%%

offset= min(statelist, [], 1);

statelist= statelist - repmat(offset, size(statelist, 1), 1);

%%

range= max(statelist, [], 1) - min(statelist, [], 1);

%%

if (all(range ~= 0))
  statelist= statelist ./ repmat(range, size(statelist, 1), 1);
else
  error('some range == 0!');
end

%%

x= x - offset;
x= x ./ range;

x= repmat(x, size(statelist, 1), 1);

%%

[d  s]= min( numerics.math.edist(statelist, x) );

%%


