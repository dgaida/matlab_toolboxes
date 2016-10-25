%% Syntax
%       [ Ps_ss_a ]= buildTransProb(RLearner, nstates, nactions)
%       [ Ps_ss_a ]= buildTransProb(RLearner, nstates, nactions, random)
%
%% Description
% |[ Ps_ss_a ]= buildTransProb(RLearner, nstates, nactions)| generates set
% of transition probability P_s_s'_a which is returned as |Ps_ss_a|.
% |Ps_ss_a| is a struct which contains for each action a sparse 2d matrix
% with dimension equal to |nstates x nstates|. 
%
%%
% @param |RLearner| : object of the <rlearner.html
% |optimization.RL.RLearner|> class  
%
%%
% @param |nstates| : number of states in the state space. double
% integer scalar.
%
%%
% @param |nactions| : number of possibe actions in each state. double
% integer scalar. 
%
%%
% @param |random| : can be 0, 1 or a struct. Default: 0. 
%
% * 0 : the set of transition probability P_s_s'_a is set to a struct containing
% zero matrices. 
% * 1 : the set of transition probability P_s_s'_a is set to a struct containing
% random matrices. Not yet implemented. The reason is that P_s_s'_a
% contains sparse matrices and then each element is set to a random number,
% does not make sense to use sparse then. 
% * struct : the set of transition probability P_s_s'_a is set to the given struct
% |random|. The struct must contain for each action a sparse matrix with
% dimension |nstates x nstates|. 
%
%%
% @return |P_s_ss_a| : set of transition probability P_s_s'_a
%
%% Example
% 
% # A one dimensional state space is discretized into 4 discrete states and
% with two control inputs, each with 3 possible actions leads to 9 actions.
% Thus Q is 4 times 9. 

myobj= optimization.RL.RLearner(0, 5, 2, 4, [], [], 1);

disp(myobj.Ps_ss_a)

%%
% a two dimensional state space, each dimension divided into 5 buckets. In
% total we have 5^2= 25 states and again with 2 inputs 9 possible actions. 

myobj= optimization.RL.RLearner([1 2], [6 5], 2, 5, [], [], 1);

disp(myobj.Ps_ss_a)


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
% <a href= matlab:doc('sparse')>
% matlab/sparse</a>
% </html>
% ,
% <html>
% <a href= matlab:doc('script_collection/isn')>
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href= matlab:doc('script_collection/is0or1')>
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="rlearner.html">
% optimization.RL.RLearner</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="rlearner.html">
% optimization.RL.RLearner</a>
% </html>
% ,
% <html>
% <a href="buildactionlist.html">
% optimization.RL.buildActionList</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # check documentation
% # improve code a little
% # I think it should be possible to throw the 1st argument out of the
% method (RLearner)
%
%% <<AuthorTag_DG/>>


