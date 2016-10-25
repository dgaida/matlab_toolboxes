%% Syntax
%       [ Q ]= buildQTable(RLearner, nstates, nactions)
%       [ Q ]= buildQTable(RLearner, nstates, nactions, random)
%       [ Q ]= buildQTable(RLearner, nstates, nactions, random, opt_sparse)
%
%% Description
% |[ Q ]= buildQTable(RLearner, nstates, nactions)| generates action value
% function |Q|. Its dimension is: number of columns is equal to number of
% actions and number of rows is equal to number of states. As this matrix
% can be become very large, there is an option to create it as sparse
% matrix, which is recommended (see |opt_sparse|). 
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
% @param |random| : can be 0, 1 or a matrix of size equal to |nstates x
% nactions|. Default: 0. 
%
% * 0 : the action value function |Q| is set to a zero matrix
% * 1 : the action value function |Q| is set to a random matrix
% * matrix : the action value function |Q| is set to the given matrix
% |random|. 
%
%%
% @param |opt_sparse| : 0 or 1. Default: 1. 
%
% * 0 : the action value function |Q| is returned as 2dim double matrix. 
% * 1 : the action value function |Q| is returned as 2dim SPARSE double
% matrix. 
%
%%
% @return |Q| : action value function (matrix)
%
%% Example
% 
% # A one dimensional state space is discretized into 4 discrete states and
% with two control inputs, each with 3 possible actions leads to 9 actions.
% Thus Q is 4 times 9. 

myobj= optimization.RL.RLearner(0, 5, 2, 4);

disp(myobj.Q)

%%
% a two dimensional state space, each dimension divided into 5 buckets. In
% total we have 5^2= 25 states and again with 2 inputs 9 possible actions. 

myobj= optimization.RL.RLearner([1 2], [6 5], 2, 5);

disp(myobj.Q)


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
% # imnprove code a little
% # I think it should be possible to throw the 1st argument out of the
% method (RLearner)
%
%% <<AuthorTag_DG/>>


