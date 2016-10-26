%% Syntax
%       mixer(t,x,u,flag, n_inputs)
%
%% Description
% The function 'mixer' mixes n_inputs substrate streams. It is a
% Level-1 M-file S-function in the library represented by the 'Mixer'
% block. 
%
%%
% @param |t| : actual simulation time
%
%%
% @param |x| : actual state vector, here the empty vector [], since the model
% does not depend on a state
%
%%
% @param |u| : The input vector $\vec{u}$, consists out of the 34 dim. ADM1
% stream 
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
% @param |n_inputs| : double scalar with the number of inputs 
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
% - 
%
% and is called by:
%
% (Mixer Block)
%
%% See Also
% 
% <html>
% <a href="configmixer.html">
% configmixer</a>
% </html>
% ,
% <html>
% <a href="divider.html">
% divider</a>
% </html>
%
%% TODOs
% # improve documentation
%
%% <<AuthorTag_DG/>>


