%% Syntax
%       [ a ]= getBestAction( RLearner, Q, s )
%
%% Description
% |[ a ]= getBestAction( RLearner, Q, s )| returns best action |a| of
% action value function |Q| at given state |s|. The returned action is the
% index of the best action. The best action is the one that maximizes the
% action value function |Q| for the given state |s|. 
%
%%
% @param |RLearner| : object of the <RLearner.html
% |optimization.RL.biogasRLearner|> class  
%
%%
% @param |Q| : action value function
%
%%
% @param |s| : index of current state. integer >= 1. 
%
%%
% @return |a| : best action. thats the index of the best action not the
% action itself. 
%
%% Example
% 
% because method is private creating an example is not easy
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href= matlab:doc('max')>
% matlab/max</a>
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
% <a href="e_greedy_selection.html">
% optimization.RL.RLearner.e_greedy_selection</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="rlearner.html">
% optimization.RL.RLearner</a>
% </html>
%
%% TODOs
% # improve documentation
% # check documentation
% # check code
% # Rlearner wird nicht genutzt - kann man den löschen?
%
%% <<AuthorTag_DG/>>


