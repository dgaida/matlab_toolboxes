%% Syntax
%       ADM1DE(t,x,u,flag, sensors, plant, substrate, substrate_network,
%       plant_network, fermenter_id, initstate_type, datasource_type,
%       savestate, onoff)
%
%% Description
% |ADM1DE(t,x,u,flag, sensors, plant, substrate, substrate_network,
% plant_network, fermenter_id, initstate_type, datasource_type, savestate,
% onoff)| is an implementation of the 
% anaerobic digestion model No. 1 (ADM1) as Differential Equation (DE)
% system. The model is implemented as a clone of the ADM1xp model of the
% Simba toolbox. It is a
% Level-1 M-file S-function in the library represented by the 'ADM1DE'
% block.
%
% If you find differences between both versions, then please contact the
% author of this model. 
%
%%
% @param t : actual simulation time
%
% @param x : actual state vector, here a 37 dim vector
%
% @param u : The input vector $\vec{u}$ is the ADM1 stream flowing into the
% fermenter, so a 34 dim vector.
%
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
%% <<sensors/>>
%% <<plant/>>
%% <<substrate/>>
%% <<substrate_network/>>
%% <<plant_network/>>
%%
% @param fermenter_id : char or cell defining the id of the fermenter
% which is modelled by this function. The id of each
% fermenter is defined inside the structure |plant.fermenter.ids|.
%
%%
% @param initstate_type : what kind of initial state should be used:
% random, user, default, etc.?
%
%%
% @param datasource_type : from what source should the state be read : 
% file, workspace, etc.
%
%%
% @param savestate : should the state be saved at the end of the simulation
%
%%
% @param |onoff| : switches heating on or off
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
% <a href="matlab:doc biogas_scripts/get_accesstofile_from_datasource_type">
% biogas_scripts/get_accesstofile_from_datasource_type</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_initstate_from">
% biogas_scripts/get_initstate_from</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/save_initstate_to">
% biogas_scripts/save_initstate_to</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_sensors')">
% biogas_scripts/is_sensors</a>
% </html>
%
% and is called by:
%
% (ADM1 block)
%
%% See Also
% 
% <html>
% <a href="makestoichiometry.html">
% makeStoichiometry</a>
% </html>
% ,
% <html>
% <a href="callback_adm1_gui.html">
% Callback_ADM1_gui</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/evalinmws')">
% script_collection/evalinMWS</a>
% </html>
%
%% TODOs
% # extend the function, such that it is possible to call the function as 
% |ADM1DE(t,x,u,flag)|
% # lade p_adm1xp nur bei der Initialisierung, vielleicht ein neues Modell
% daraus machen - das ist alt
% # check documentation
% # check code
% # improve documentation
% # add reference to paper
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% D. Batstone, J. Keller, I. Angelidaki, S. Kalyuzhnyi, S. Pavlostathis,
% A. Rozzi, W. Sanders, H. Siegrist, and V. Vavilin. Anaerobic Digestion
% Model No.1 (ADM1). IWA Task Group for Mathematical Modelling of Anaerobic
% Digestion Processes, 2002. Scientific and Technical Report No. 13.
% </li>
% <li> 
% D. Batstone, J. Keller, I. Angelidaki, S. Kalyuzhnyi, S. Pavlostathis,
% A. Rozzi, W. Sanders, H. Siegrist, and V. Vavilin: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\02 The IWA Anaerobic Digestion Model No 1 (ADM1).pdf'', 
% biogas_blocks.getHelpPath())'))">
% The IWA Anaerobic Digestion Model No 1 (ADM1)</a>, 
% Water Science and Technology, vol. 45(10), pp. 65-73, 2002. 
% </li>
% </ol>
% </html>
%


