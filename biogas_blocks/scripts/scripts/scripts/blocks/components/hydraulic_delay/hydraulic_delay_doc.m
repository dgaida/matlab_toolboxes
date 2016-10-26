%% Syntax
%       hydraulic_delay(t,x,u,flag)
%       hydraulic_delay(t,x,u,flag, DEBUG, deltatime, plant, ...
%               fermenter_name_start, fermenter_name_destiny, ...
%               initstate_type, datasource_type, savestate, ...
%               time_constant, V_min)
%
%% Description
%
% The function 'hydraulic_delay' implements an hydraulic delay. It is 
% a Level-1 M-file S-function in the library represented by the 'Hydraulic
% Delay' block. 
% 
% Das Modell
% entspricht einem Tank mit einem Wehrüberlauf, wobei der Ablauf über den
% Überlauf erfolgt. V_min ist das Volumen ab dem ein Überlauf statt
% findet. Dieser Block entspricht dem hvz Block aus Simba. Die Bedeutung
% von time_constant wird im Modell unten erklärt.
%
%% 
% @param |t| : actual simulation time
%
%%
% @param |x| : actual state vector
%
%%
% @param |u| : 34 dim ADM1 stream
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
% @param DEBUG, deltatime, plant : well known
%
%%
% @param |fermenter_name_start| : char or struct of the id, where the pump
% input is connected
%
% @param |fermenter_name_destiny| : char or struct of the id, where the pump
% output is connected, where the pumped flow is going to
%
%%
% @param |initstate_type| : type of the initial state of the hydraulic delay
%
% * 'random'
% * 'default'
% * 'user'
%
%%
% @param |datasource_type| : source type of the pump
%
% * 'file'
% * 'workspace'
% * 'modelworkspace'
%
%%
% @param |savestate| : save the state at the end of the simulation
%
% * 1 : save the state
% * 0 : do not save the state
%
%%
% time_constant, V_min : specific parameters of the hydraulic delay
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/load_file')">
% load_file</a>
% </html>
%
% and is called by:
%
% (block "hydraulic delay" of library)
%
%% See Also
% 
% <html>
% <a href="hydraulic_delay_loadfcn.html">
% hydraulic_delay_loadfcn</a>
% </html>
% ,
% <html>
% <a href="hydraulic_delay_closefcn.html">
% hydraulic_delay_closefcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/pump_stream')">
% biogas_blocks/pump_stream</a>
% </html>
%
%% TODOs
% # check input parameters
% # improve documentation
% # check code
%
%% <<AuthorTag_DG/>>


