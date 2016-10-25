%% Syntax
%       [ a, greedy ]= e_greedy_selection( RLearner, Q , s, epsilon )
%
%% Description
% |[ a ]= e_greedy_selection( RLearner, Q , s, epsilon )| returns the index
% of the best action. This is an epsilon greedy strategy, so with chance
% |epsilon| a random action is chosen and with chance (1 - |epsilon|) the
% optimal action is chosen. 
%
%%
% @param |RLearner| : object of the <rlearner.html
% |optimization.RL.RLearner|> class  
%
%%
% @param |Q| : action value function. a double matrix. 
%
%%
% @param |s| : index of current state. integer >= 1. 
%
%%
% @param |epsilon| : defining
% how often a random action is chosen. 0 <= epsilon <= 1. If epsilon == 0,
% then no action is chosen randomly, if epsilon == 1, then all actions are
% chosen randomly.
%
%%
% @return |a| : action due to epsilon greedy strategy
%
%%
% @return |greedy| : if 1, then best (greedy) action is returned. if 0,
% then a randomly selected action is returned
%
%% Example
% 
% # A one dimensional state space is discretized into 4 discrete states and
% with two control inputs, each with 3 possible actions leads to 9 actions.
% Thus Q is 4 times 9. 

myobj= optimization.RL.RLearner(0, 5, 2, 4);

[ a, greedy ]= e_greedy_selection( myobj, myobj.Q, 1, 0.5);

disp(a)
disp(greedy)

%%
% a two dimensional state space, each dimension divided into 5 buckets. In
% total we have 5^2= 25 states and again with 2 inputs 9 possible actions. 

myobj= optimization.RL.RLearner([1 2], [6 5], 2, 5, [], [], 1);



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href= matlab:doc('rand')>
% matlab/rand</a>
% </html>
% ,
% <html>
% <a href= matlab:doc('randi')>
% matlab/randi</a>
% </html>
% ,
% <html>
% <a href="getbestaction.html">
% optimization.RL.RLearner.private.getBestAction</a>
% </html>
% ,
% <html>
% <a href= matlab:doc('script_collection/isr')>
% script_collection/isR</a>
% </html>
%
% and is called by:
%
% -
%
%% See Also
% 
% <html>
% <a href="rlearner.html">
% optimization.RL.RLearner</a>
% </html>
% ,
% <html>
% <a href="getbestaction.html">
% optimization.RL.RLearner.private.getBestAction</a>
% </html>
%
%% TODOs
% # improve documentation
% # check documentation
% # improve example
% # Rlearner wird nicht genutzt - kann man den löschen?
%
%% <<AuthorTag_DG/>>


