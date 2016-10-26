%% Syntax
%       fitness_sensor(t,x,u,flag)
%       fitness_sensor(t,x,u,flag, sensors, plant, substrate,
%       fitness_params) 
%
%% Description
% |fitness_sensor(t,x,u,flag)| calculates fitness of a simulation. It is a
% Level-1 M-file S-function in the library represented by 'fitness 
% sensor' block. It calls the fitness function given in |fitness_params|
% which needs the parameters |sensors, plant| and |substrate|. It only
% calls the fitness function when |t| == 0 or the difference between |t|
% and the last call is greater equal |deltatime|, otherwise the last
% fitness value is returned. 
%
%%
% @param |t| : actual simulation time
%
%%
% @param |x| : actual state vector, here the empty vector [], since the model
% does not depend on a state
%
%%
% @param |u| : one-dimensional signal, not used, dummy
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
% |fitness_sensor(t,x,u,flag, sensors, plant, substrate,
% fitness_params)| measures and saves the measured fitness inside the
% object |sensors|, which is provided by the library of the 
% _Biogas Plant Modeling_ toolbox and is available via the model workspace
% (see the function 
% <matlab:doc('biogas_blocks/init_biogas_plant_mdl') init_biogas_plant_mdl>).
%
%% <<sensors/>>
%% <<plant/>>
%% <<substrate/>>
%% <<fitness_params/>>
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
% <a href="matlab:doc('matlab/feval')">
% matlab/feval</a>
% </html>
%
% and is called by:
%
% fitness sensor block
%
%% See Also
%
% <html>
% <a href="matlab:doc('biogas_blocks/fitness_costs')">
% fitness_costs</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/fitness_calibration')">
% fitness_calibration</a>
% </html>
%
%% TODOs
% # the first mentioned call does not make sense yet
% # improve documentation
% # check code
%
%% <<AuthorTag_DG/>>
%% References
%
%


