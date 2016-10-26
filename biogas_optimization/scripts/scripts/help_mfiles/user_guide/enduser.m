%% Introduction
% 
% With this toolbox you can find the optimal operating point of a biogas
% plant. The optimal operating point is a steady state. The variables you
% can change to achieve this optimal operating point are:
%
% * substrate feed
% * recirculation between digesters
% * digester state varaibles
% * parameters of the Anaerobic Digestion Model
%
% Therefore you can do a substrate feed optimization as well as a parameter
% optimization using this toolbox. In case you want to do a parameter
% optimization, have a look at the tool <matlab:doc('biogas_calibration')
% biogas_calibration> which calls this toolbox. If you want to control the
% substrate feed in a closed loop control have a look at the toolbox
% <matlab:doc('biogas_control') biogas_control> which calls this toolbox as
% well. 
%
%%
% The most important function in this toolbox is
% <matlab:doc('findoptimalequilibrium') findOptimalEquilibrium> which
% starts the optimization. If you want to optimize the substrate feed or
% the recirculation sludge have a look at the gui
% <matlab:doc('biogas_gui/gui_optimization') biogas_gui/gui_optimization>
% which simplifies your life and calls the mentioned function.
%
%%
%
%


