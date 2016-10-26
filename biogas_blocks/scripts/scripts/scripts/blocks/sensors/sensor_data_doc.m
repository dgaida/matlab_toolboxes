%% Syntax
%       sensor_data(t,x,u,flag)
%       sensor_data(t,x,u,flag, sensors, processvalue, id_in_array, index,
%       noisy, substrate) 
%
%% Description
% 
%
%%
% @param |t| : actual simulation time
%
%%
% @param |x| : actual state vector, here the empty vector [], since the model
% does not depend on a state
%
%%
% @param |u| : 
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
%% <<sensors/>>
%%
% @param |processvalue| : process value as char, sensor_id
%
%%
% @param |id_in_array| : id in sensor array, often ''
%
%%
% @param |index| : index in sensor
%
%%
% @param |noisy| : 0 or 1
%
% 0 : get nominal measurement values
% 1 : get noisy measurement values. such that they are noisy, the senosr
% must be noisy (see sensors.xml)
%
%% <<substrate/>>
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
% (sensor data Block)
%
%% See Also
% 
% -
%
%% TODOs
% # improve documentation a lot
% # improve script
%
%% <<AuthorTag_DG/>>


