%% Syntax
%       [ s ]= discretizeState( RLearner, x, statelist )
%
%% Description
% |[ s ]= discretizeState( RLearner, x, statelist )| discretizes state |x|
% and returns nearest position |s| in given state grid |statelist|. 
%
%%
% @param |RLearner| : object of the <rlearner.html
% |optimization.RL.RLearner|> class  
%
%%
% @param |x| : 
%
%%
% @param |statelist| : 
%
%%
% @return |s| : state index
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('numerics_tool/edist')">
% numerics_tool/edist</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/repmat')">
% matlab/repmat</a>
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
% <a href="matlab:doc('numerics_tool/edist')">
% numerics_tool/edist</a>
% </html>
%
%% TODOs
% # improve documentation significantly
% # check code
% # add example
% # make todo
%
%% <<AuthorTag_DG/>>


