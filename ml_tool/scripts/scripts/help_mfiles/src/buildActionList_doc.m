%% Syntax
%       [actions]= buildActionList(RLearner, size_u, change)
%
%% Description
% |[actions]= buildActionList(RLearner, size_u, change)| generates action
% list for given number of input variables |size_u|. Each input variable
% can be in-, decreased (by |change|) and left unchanged. So for each input there are
% three different actions. Thus, for all input variables together 3^|size_u|
% actions exist. This will be the number of rows of the action list
% |ations| and the number of columns equals |size_u|. In conclusion, the first row
% symbolizes the first action for all input together, and so on. 
%
%%
% @param |RLearner| : object of the <rlearner.html
% |optimization.RL.RLearner|> class  
%
%%
% @param |size_u| : number of possible input variables. scalar integer
% (double). 
%
%%
% @param |change| : max. possible change in action. double scalar. 
%
%%
% @return |actions| : action list. this a double matrix with as many
% columns as is given by |size_u| and with 3|^size_u| rows. Each row
% contains one action. 
%
%% Example
% 
%

myobj= optimization.RL.RLearner([], [], 1);

disp(myobj.actionlist)

%%

myobj= optimization.RL.RLearner([], [], 2);

disp(myobj.actionlist)

%%

myobj= optimization.RL.RLearner([], [], 3);

disp(myobj.actionlist)


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
% <a href="matlab:doc script_collection/isn">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isr">
% script_collection/isR</a>
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
% <a href="buildstategrid.html">
% optimization.RL.buildStateGrid</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # check documentation
% # I think it should be possible to throw the 1st argument out of the
% method (RLearner)
%
%% <<AuthorTag_DG/>>


