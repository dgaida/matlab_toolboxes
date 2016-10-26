%% Syntax
%       initstate= createinitstatefile(type, plant_id, unit, id)
%       initstate= createinitstatefile(type, plant_id, unit, id, ...
%                                       user_state)
%       initstate= createinitstatefile(type, plant_id, unit, id, ...
%                                       user_state, accesstofile)
%
%% Description
% |initstate= createinitstatefile(type, plant_id, unit, id)| creates the
% initial state file for all state-dependent blocks in the 
% biogas library, respectively in the actual model. First, if existent, the
% file is load (on default: from the modelworkspace), then parts of it are
% overwritten and then saved (on default: in the modelworkspace) again, see
% parameter |accesstofile|. For new MATLAB versions (>= 7.11) the
% modelworkspace may not be written and evaluated during runtime anymore,
% so then |initstate| is load and saved from file. For more informations on
% this particular issue see the functions:
% <eval_initstate_inmws.html eval_initstate_inMWS> and
% <assign_initstate_inmws.html assign_initstate_inMWS>. If
% |initstate| does not exist in the specified location a
% <matlab:doc('warning') warning> is thrown, but no error.
%
%%
% @param |type| : type of initial state (char):
%
% * 'random'  : random state, a random state is created and written inside
% the |initstate| variable
% * 'default' : default state, the default state is written inside the
% |initstate| variable 
% * 'user'    : user defined state, the given |user_state| is written into
% the |initstate| variable 
%
%%
% @param |plant_id| : char with the id of the plant ==
% |plant__plant_id_.id|
%
%%
% @param |unit| : id of the unit (component) you want to set the state for.
%
% * 'fermenter'       : the state of digesters is set
% * 'hydraulic_delay' : the state of hydraulic delays (used in pumps) is
% set
%
%%
% @param |id| : char with the id of the unit, e.g. 'main', 'fermenter2nd', ...
%
%%
% @return |initstate| : the initstate structure containing the double
% column vector containing the initial state 
% which was saved inside the structure at the given location.
%
%%
% |createinitstatefile(type, plant_id, unit, id, user_state)| lets you
% specify the state vector for the to be set |id|. 
%
%%
% @param |user_state| : double row or column vector, 
% this parameter is only used if |type| == 'user'. It is the 
% initial state vector defined by the user. 
%
%%
% |createinitstatefile(type, plant_id, unit, id, user_state, accesstofile)|
% lets you specify different locations instead of the
% <matlab:doc('simulink.modelworkspace') modelworkspace>. 
%
%%
% @param |accesstofile| : double scalar
%
% * 1, then really load and save the state from/to a file
% * 0, then the state isn't load/saved from/to a file, but is, as always, 
% returned by the function (good for optimization purpose -> speed) and
% load/saved from/to the base workspace (even better for optimization
% purpose -> speed) 
% * -1, then the state is load/saved from/to the model workspace (default).
% In the newest MATLAB versions, from 7.11 on, it is not allowed anymore to 
% save into the modelworkspace while the model is running. So then we
% also load and save from/to a file using
% <eval_initstate_inmws.html eval_initstate_inMWS> and 
% <assign_initstate_inmws.html assign_initstate_inMWS>.
%
%% Example
% 
% Create an |initstate| variable in the base workspace. The 'user' field of
% the 'main' digester of the plant with the ID 'gummersbach' is overwritten
% by the default state.
%

createinitstatefile('user', 'gummersbach', 'fermenter', 'main', ...
                    double(biogas.ADMstate.getDefaultADMstate()), 0);

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="eval_initstate_inmws.html">
% eval_initstate_inMWS</a>
% </html>
% ,
% <html>
% <a href="assign_initstate_inmws.html">
% assign_initstate_inMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isz')">
% script_collection/isZ</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/save')">
% matlab/save</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/load')">
% matlab/load</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/evalin')">
% matlab/evalin</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/assignin')">
% matlab/assignin</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validatestring')">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_optimization/setinitstateinworkspace')">
% biogas_optimization/setInitStateInWorkspace</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('script_collection/getmatlabversion')">
% script_collection/getMATLABVersion</a>
% </html>
% ,
% <html>
% <a href="createvolumeflowfile.html">
% createvolumeflowfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/evalinmws')">
% script_collection/evalinMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/assigninmws')">
% script_collection/assigninMWS</a>
% </html>
%
%% TODOs
% # create documentation for script file
%
%% <<AuthorTag_DG/>>


