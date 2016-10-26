%% Syntax
%       chps(t,x,u,flag, sensors, plant, gas2bhkwsplittype)
%
%% Description
% |chps(t,x,u,flag, sensors, plant, gas2bhkwsplittype)|
% transfers the incoming biogas to the connected bhkws (combined heat and
% power units) depending on the chosen gas2bhkw splittype
% (|gas2bhkwsplittype|). It is a
% Level-1 M-file S-function in the library represented by the 'Biogas
% Distributor' block. 
%
% calculates the electrical and thermal energy, which is produced by 
% the bhkw (combined heat and power unit) |bhkw_id| out of the biogas
% (methane) produced by the connected
% fermenters. 
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
% The input vector $\vec{u}(t)$, consists out of the concatenation of the 
% biogas volume streams for each fermenter, each defined as
%
% $$\vec{u}_i(t) := \left( h2_i(t), ch4_i(t), co2_i(t) \right)^T$$
%
% $i= 1, ..., N$, where N is the number of fermenters on the plant.
%
% With:
%
% $$
% \begin{tabular}{lll}
% $h2(t)$ & Hydrogen & $\left[ \frac{m^3}{d} \right]$ \\
% $ch4(t)$ & Methane & $\left[ \frac{m^3}{d} \right]$ \\
% $co2(t)$ & Carbon dioxide & $\left[ \frac{m^3}{d} \right]$
% \end{tabular}
% $$
%
% So
%
% $$u(t) := \left( \vec{u}_1(t), ..., \vec{u}_N(t) \right)^T$$
%
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
%% <<plant/>>
%%
% @param |gas2bhkwsplittype| : char or cell defining how the biogas stream
% should be distributed.
%
% * 'fiftyfifty': splits the biogas equally over the connected (available)
% bhkws.
%
% * 'one2one': makes a one to one connection: 
% biogas of fermenter 1 is transfered to bhkw 1
% biogas of fermenter 2 is transfered to bhkw 2
% ...
% The no. is as it is defined in the plant.
%
% * 'threshold': the first bhkw gets the whole biogas, until its percentual
% power utilization is over its defined threshold, which is always 100 %
% Then the second bhkw gets the rest of the biogas, etc. if there is a
% third, fourth bhkw...
% In plant.bhkw.ids the first, second, etc. bhkw is defined
%
%%
% @return : see the MATLAB documentation, resp. the parameter |flag| above
% 
%% Example
% |chps(..., sensors, plant, 'fiftyfifty')|
% 
% The first four parameters are abbreviated by the dots (...). With the
% other parameters the total
% biogas stream is equally distributed to the chps. 
%
%% Dependencies
% 
% This function calls:
%
% -
%
% and is called by:
%
% (biogas 2 bhkw library block)
%
%% See Also
% 
% -
%
%% TODOs
% # make the number of input and output ports dynamically dependent on the
% amount of available bhkws and fermenters (s. divider Block)
% # improve documentation a lot
%
%% <<AuthorTag_DG/>>


