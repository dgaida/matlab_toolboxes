%% Syntax
%       mydatestr0= tonight()
%       mydatestr0= tonight(hour)
%       
%% Description
% |mydatestr0= tonight(hour)| returns the given |hour| this evening as date
% string format 0: 'dd-mmm-yyyy HH:MM:SS'. Can be useful to start a timer
% this evening or tonight, respectively. Have a look at the function
% <matlab:doc('startat') startat>. 
%
%%
% @param |hour| : a natural number giving the hour. May be a number between
% 0 and 24. There all numbers between 0 and 12 are interpreted as pm, thus
% 13 and 1 yield the same result as well as 24 and 12. Same for all numbers
% in between. Default: 8 pm. 
%
%%
% @return |mydatestr0| : today at the given |hour| in datestr format 0,
% which is 'dd-mmm-yyyy HH:MM:SS'. 
%
%% Example
% 
% 

tonight(24)

tonight(12)

%%

tonight

%%

tonight(5)

%%

tonight(0)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc matlab/clock">
% matlab/clock</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/datestr">
% matlab/datestr</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isn0">
% script_collection/isN0</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_control/startnmpc">
% biogas_control/startNMPC</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc matlab/startat">
% matlab/startat</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/now">
% matlab/now</a>
% </html>
%
%% TODOs
% # create documentation for script file
% # maybe update is called by
%
%% <<AuthorTag_DG/>>

    
    