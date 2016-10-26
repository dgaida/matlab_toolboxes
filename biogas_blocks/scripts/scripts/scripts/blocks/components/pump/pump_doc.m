%% Syntax
%       pump(t,x,u,flag, plant, substrate, appendDATA, deltatime, ...
%                        fermenter_id, h_friction)
%
%% Description
% |pump()| calculates the power used to pump the substrate mix. It is 
% a Level-1 M-file S-function in the library represented by the 'Pump
% (Energy)' block. 
%
%%
% @param t : actual simulation time
%
% @param x : actual state vector, here the empty vector [], since the model
% does not depend on a state
% 
% @param u : The input $u$ is the volume flow rate flowing into the 
% fermenter 'fermenter_id'.
%
%%
% @param flag : 
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
% @param plant : 
%
% @param substrate : 
%
%%
% @param appendDATA : appendDATA flag of the 'Biogas Plant Modeling' toolbox. At the
% moment it is not used, but could be used to extend the sensor, when the
% simulation model is simulated in appendDATA mode (see the block 'Biogas Plant
% Name').
%
% * 0 : appendDATA mode is off
% * 1 : appendDATA mode is on
%
% @param deltatime : time step, defining how often the biogas stream is
% written into 
% the |measurements| structure. This value is also defined in the 'Biogas
% Plant Modeling' toolbox (see the block 'Biogas Plant Name').
%
%%
% @param fermenter_id : char or cell defining the id of the fermenter
% in which the flow is flowing. The id of each
% fermenter is defined inside the structure |plant.fermenter.ids|.
%
%%
% @param h_friction : ist die Länge des gesamten Transportweges, wobei das 
% Substrat auf dem Transportweg an der Transportführung gerieben wird.
%
%%
% @return : see the MATLAB documentation, resp. the parameter |flag| above
% 
%% Example
% 
%
%% See Also
% 
% <html>
% <a href="pump_stream.html">
% pump_stream</a>
% </html>
% ,
% <html>
% <a href="pump_energy_loadfcn.html">
% pump_energy_loadfcn</a>
% </html>
% ,
% <html>
% <a href="pump_energy_closefcn.html">
% pump_energy_closefcn</a>
% </html>
%
%% TODOs
% # check documentation
% # check code
%
%% <<AuthorTag_DG/>>


