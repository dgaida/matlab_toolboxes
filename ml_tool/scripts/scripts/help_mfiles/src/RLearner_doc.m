%% Syntax
%       optimization.RL.RLearner()
%       optimization.RL.RLearner(LB)
%       optimization.RL.RLearner(LB, UB)
%       optimization.RL.RLearner(LB, UB, size_u)
%       optimization.RL.RLearner(LB, UB, size_u, nSamples)
%       optimization.RL.RLearner(LB, UB, size_u, nSamples, change)
%       optimization.RL.RLearner(LB, UB, size_u, nSamples, change,
%       p_epsilon) 
%       optimization.RL.RLearner(LB, UB, size_u, nSamples, change,
%       p_epsilon, usePs_ss_a)        
%
%% Description
% |optimization.RL.RLearner| creates a basic Reinforcement learner.
%
%%
% @param |LB| : lower bound of to be created state grid. A double vector or
% scalar, if dimension of state space is one dimensional. 
%
%%
% @param |UB| : upper bound of to be created state grid. A double vector or
% scalar, if dimension of state space is one dimensional. Must have same
% dimension as has |LB|. 
%
%%
% @param |size_u| : number of control inputs. integer.
%
%%
% @param |nSamples| : number of buckets between lower and upper boundary to
% be created for each dimension in the discrete state grid. Should be an
% integer number larger than 1. 
%
%%
% @param |change| : max. possible change in the control inputs. double
% scalar. 
%
%%
% @param |p_epsilon| : Reinforcement Learning parameter epsilon, defining
% how often a random action is chosen. 0 <= epsilon <= 1. If epsilon == 0,
% then no action is chosen randomly, if epsilon == 1, then all actions are
% chosen randomly.
%
%%
% @param |usePs_ss_a| : if 1, then transition probability Ps_ss_a is
% created during the learning process. Warning, this option could use a
% large amount of memory. If 0, then it's not used.
%
%% Example
%
% # A one dimensional state space is discretized into 4 discrete states and
% with two control inputs, each with 3 possible actions leads to 9 actions.

myobj= optimization.RL.RLearner(0, 5, 2, 4, [], [], 1);

disp(myobj)

%%
% a two dimensional state space, each dimension divided into 5 buckets. In
% total we have 5^2= 25 states and again with 2 inputs 9 possible actions. 

myobj= optimization.RL.RLearner([1 2], [6 5], 2, 5, [], [], 1);

disp(myobj)


%% See Also
%
% <html>
% <a href="e_greedy_selection.html">
% optimization.RL.RLearner.e_greedy_selection</a>
% </html>
% ,
% <html>
% <a href="discretizestate.html">
% optimization.RL.RLearner.discretizeState</a>
% </html>
% ,
% <html>
% <a href="runepisodes.html">
% optimization.RL.RLearner.runEpisodes</a>
% </html>
% ,
% <html>
% <a href="updatesarsa_e.html">
% optimization.RL.RLearner.updateSARSA_e</a>
% </html>
% ,
% <html>
% <a href="buildactionlist.html">
% optimization.RL.RLearner.private.buildActionList</a>
% </html>
% ,
% <html>
% <a href="buildqtable.html">
% optimization.RL.RLearner.private.buildQTable</a>
% </html>
% ,
% <html>
% <a href="buildstategrid.html">
% optimization.RL.RLearner.private.buildStateGrid</a>
% </html>
% ,
% <html>
% <a href="buildtransprob.html">
% optimization.RL.RLearner.private.buildTransProb</a>
% </html>
%
%% TODOs
% # improve documentation significantly
% # check code
% # improve example
% # make todo
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Richard S. Sutton and Andrew G. Barto: 
% <a href="http://webdocs.cs.ualberta.ca/~sutton/book/ebook/the-book.html" target="_top">
% Reinforcement Learning: An Introduction</a>, The MIT Press, Cambridge, 1998
% </li>
% </ol>
% </html>
%


