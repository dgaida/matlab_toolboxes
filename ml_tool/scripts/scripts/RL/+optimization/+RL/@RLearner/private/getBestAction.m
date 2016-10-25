%% optimization.RL.RLearner.private.getBestAction
% Returns best action of action value function at given state
%
function [ a ]= getBestAction( RLearner, Q, s )
%% Release: 1.0

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
%getBestAction return the best action for state (s)
%Q: the Qtable
%s: the current state
% Q has structure  Q(states,actions)

%% 
% check input args

checkArgument(Q, 'Q', 'double', '2nd');   % evtl. kann man noch genauere abfragen machen
isN(s, 's', 3);

%% TODO
% wenn eines der Zellen Q(s,:) 0 ist, oder sonstwie leer, dann
% über kriging model die leeren felder durch approximation bestimmen. das
% sollte vielleicht schon eine funktion früher gemacht werden, da Q in
% dieser funktion nicht zurück gegeben wird.
%

% the most negative (smallest) number, because we do minimization here
%
% TODO
% bleibe erstmal doch bei der maximierung, da reward= -fitness
%
[v a]= max( Q(s,:) );

%v

% if (v <= 0)
%    
%     v
%     Q(s,:)
%     
% end

%%


