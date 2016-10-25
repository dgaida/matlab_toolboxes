%% Syntax
%       [stateGrid]= buildStateGrid(RLearner, LB, UB, nSamples)
%
%% Description
% |[stateGrid]= buildStateGrid(RLearner, LB, UB, nSamples)| generates state
% grid and returns it as |stateGrid|. The state grid is the discretized
% version of the state space which is located between lower and upper
% boundaries |LB| and |UB|. The returned |stateGrid| has as many columns as
% is the dimension of the space (determined by |numel(LB)|) and as many
% rows as is given by |nSamples^dim|. 
%
%%
% @param |RLearner| : object of the <rlearner.html
% |optimization.RL.RLearner|> class  
%
%%
% @param |LB| : lower boundary of state space. double vector or scalar.
% Dimension of |LB| defines dimension of state space. 
%
%%
% @param |UB| : upper boundary of state space. double vector or scalar.
% Must have same dimension as |UB|. 
%
%%
% @param |nSamples| : number of buckets between lower and upper boundary to
% be created for each dimension in the discrete state grid. Should be an
% integer number larger than 1. 
%
%%
% @return |stateGrid| : created state grid
%
%% Example
% 
% # A one dimensional state space

myobj= optimization.RL.RLearner(0, 5, 2, 4);

disp(myobj.stategrid)

%%
% a two dimensional state space, each dimension divided into 5 buckets. 

myobj= optimization.RL.RLearner([1 2], [6 5], 2, 5);

disp(myobj.stategrid)

%%
% an empty state space does not make that much sense

myobj= optimization.RL.RLearner([], [], 2, 1);

disp(myobj.stategrid)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href= matlab:doc('repmat')>
% matlab/repmat</a>
% </html>
% ,
% <html>
% <a href= matlab:doc('script_collection/isn')>
% script_collection/isN</a>
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
% # improve documentation
% # check documentation
% # check code
% # I think it should be possible to throw the 1st argument out of the
% method (RLearner)
%
%% <<AuthorTag_DG/>>


