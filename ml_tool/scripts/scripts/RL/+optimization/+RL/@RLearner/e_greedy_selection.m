%% optimization.RL.RLearner.e_greedy_selection
% Returns the index of the best action 
%
function [ a, greedy ]= e_greedy_selection( RLearner, Q , s, epsilon )
%% Release: 1.0

% e_greedy_selection selects an action using Epsilon-greedy strategy
% Q: the Qtable
% s: the current state

%%

error( nargchk(4, 4, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% check input arguments

checkArgument(Q, 'Q', 'double', '2nd');   % evtl. kann man noch genauere abfragen machen
isN(s, 's', 3);   
isR(epsilon, 'epsilon', 4, '+');    % darf nur zwischen 0 und 1 sein

%%

actions= size(Q, 2);

randnr= rand();

%randnr
%epsilon

if (randnr > epsilon) 
  a= getBestAction(RLearner, Q, s);   
  greedy= 1;
else
  % selects a random action based on a uniform distribution
  % 
  a= randi(actions, 1, 1);
  greedy= 0;
end

%%


