%% Description of important files, objects, variables used in _GECO-C Biogas Control_ Toolbox
%
%
%% > Definition of prediction horizon <
%
% The prediction horizon of a predictive control defines the time duration
% by which the control is looking into the future. In model-based predictive
% control the prediction horizon equals the simulation duration by which
% each solution candidate is evaluated. Usually the prediction horizon is
% measured in days. As parameter a real-valued positive scalar is expected. 
%
%
%% > Definition of control horizon <
%
% The control horizon is a part of the prediction horizon and defines the
% time duration the control input may change. Both horizons start at the
% beginning of the prediction (of the simulation), but usually the control
% horizon is smaller than the prediction horizon. After the end of the
% control horizon until the end of the prediction horizon the control input
% is hold constant at the value it had at the end of the control horizon.
% Usually the control horizon is measured in days. As parameter a
% real-valued positive scalar is expected. 
%
%
%% > Definition of control sampling time <
% The sampling time of the control defines how often the control is capable
% to adapt the control input over the control horizon. Often the control
% input is kept constant over the control sampling time, resulting in a
% piecewise constant control input. Usually the control sampling time is
% measured in days. The ratio of control horizon over control samping time
% (|control_horizon| / |delta|) should be an integer. 
% 
%


