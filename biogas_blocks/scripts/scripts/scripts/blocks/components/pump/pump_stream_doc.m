%% Syntax
%       pump_stream(t,x,u,flag)
%       pump_stream(t,x,u,flag, plant, substrate, fermenter_name_start,
%       fermenter_name_destiny, volumeflow_type, datasource_type, sensors)
%       
%% Description
%
% The function 'pump_stream' calculates the power used to pump the
% substrate mix. It is a
% Level-1 M-file S-function in the library represented by the 'Pump
% Stream (Energy)' block. 
%
%%
% The input $u$ is the volume flow rate flowing into the fermenter
% 'fermenter_name'.
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
%% <<plant/>>
%% <<substrate/>>
%% <<sensors/>>
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
% <a href="matlab:doc('create_volumeflow_from_source')">
% create_volumeflow_from_source</a>
% </html>
%
% and is called by:
%
% (pump stream block)
%
%% See Also
% 
% <html>
% <a href="pump.html">
% pump</a>
% </html>
% ,
% <html>
% <a href="pump_stream_loadfcn.html">
% pump_stream_loadfcn</a>
% </html>
% ,
% <html>
% <a href="pump_stream_closefcn.html">
% pump_stream_closefcn</a>
% </html>
% ,
% <html>
% <a href="pump_stream_init_comm.html">
% pump_stream_init_comm</a>
% </html>
% ,
% <html>
% <a href="pump_stream_config.html">
% pump_stream_config</a>
% </html>
% ,
% <html>
% <a href="hydraulic_delay.html">
% hydraulic_delay</a>
% </html>
%
%% TODOs
% # check documentation
% # check code
% # hier wird angenommen, dass gepumpte menge sich auf zwei wege splittet.
% entweder diesen block so erweitern, dass man einfach nur den stream
% pumpen kann, ohne angabe von einer datei und ohne splittung der menge.
% das was rein geht, geht auch raus. oder dafür einen eigenen block
% schreiben, evtl. einfacher. nach vorbild: pump, allerdings den ganzen
% stream pumpen. eine entsprechende biogas.pump.run methode gibt es
% bereits. da gibt man einfach 2mal die gleiche zu pumpende menge an.
% ansonsten bietet die extern option auch diese möglichkeit an, allerdings
% splittet die dann auch was. 
%
%% <<AuthorTag_DG/>>


