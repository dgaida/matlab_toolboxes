%% Syntax
%       kill_simulation(t,x,u,flag)
%
%% Description
% |kill_simulation(t,x,u,flag)| stops simulation if real time > input
% |u|. It is a Level-1 M-file S-function in the library represented by
% 'simulation killer' block. The real time is determined calling
% <matlab:doc('tic') tic> in the beginning of the simulation and setting
% the global variable tStart to it. And at each time stepp calling
% <matlab:doc('toc') toc> comparing the difference with |u|, whoch must be
% measured in seconds. 
%
%%
% @param |t| : actual simulation time
%
%%
% @param |x| : actual state vector, here the empty vector [], since the model
% does not depend on a state
%
%%
% @param |u| : The input. Time measured in seconds. double scalar
%
%%
% @param |flag| : 
%
%   What is returned by SFUNC at a given point in time, T, depends on the
%   value of the FLAG, the current state vector, X, and the current
%   input vector, U.
%
%   FLAG   RESULT             DESCRIPTION
%   -----  ------             --------------------------------------------
%   0      [SIZES,X0,STR,TS]  Initialization, return system sizes in SYS,
%                             initial state in X0, state ordering strings
%                             in STR, and sample times in TS.
%   1      DX                 Return continuous state derivatives in SYS.
%   2      DS                 Update discrete states SYS = X(n+1)
%   3      Y                  Return outputs in SYS.
%   4      TNEXT              Return next time hit for variable step sample
%                             time in SYS.
%   5                         Reserved for future (root finding).
%   9      []                 Termination, perform any cleanup SYS=[].
%
%%
% @return : see the MATLAB documentation, resp. the parameter |flag| above
% 
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/tic')">
% matlab/tic</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/toc')">
% matlab/toc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/set_param')">
% matlab/set_param</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/global')">
% matlab/global</a>
% </html>
%
% and is called by:
%
% ('simulation killer' block)
%
%% See Also
% 
% -
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


