%% Syntax
%       [substrate_network_min, substrate_network_max]=
%       change_bounds_substrate_stock(substrate_network_min,
%       substrate_network_max, substrate_stock, timespan, control_horizon, 
%       substrate_network) 
%       [substrate_network_min, substrate_network_max]=
%       change_bounds_substrate_stock(substrate_network_min,
%       substrate_network_max, substrate_stock, timespan, control_horizon, 
%       substrate_network, soft_feed) 
%
%% Description
% |[substrate_network_min, substrate_network_max]=
% change_bounds_substrate_stock(substrate_network_min,
% substrate_network_max, substrate_stock, timespan, control_horizon,
% substrate_network)| changes |substrate_network_min/max| based on
% available substrates (|substrate_stock|). 
%
% First of all |substrate_network_max| is reduced such that it fits to the
% available substrates. If over some prediction horizon there won't be
% enough substrate as is given by |substrate_network_max|, then
% |substrate_network_max| is reduced accordingly. If less than 2 m³/d will
% be fed, then max boundary is set to 2 m³/d until it is set to 0 m³/d.
% This is done because otherwise the substrate will never be depleted. 
%
% If a substrate is bounded, then |substrate_network_min_limit| should be 0
% for this substrate. This is not checked or assured by this method. 
%
%% <<substrate_network_min/>>
%% <<substrate_network_max/>>
%%
% @param |substrate_stock| : column vector with total amount of available
% substrates in m³. Vector must have as many rows as there are substrates.
% If a substrate is not bounded, then the corresponding value should be
% <matlab:doc('matlab/inf') Inf>. 
%
%%
% @param |timespan| : prediction horizon, measured in days
%
%% <<control_horizon/>>
%% <<substrate_network/>>
%%
% @param |soft_feed| : default: 1. 
%
% * 0 : substrate_network_max is set to 0 for those substrates that are not
% available anymore
% * 1 : substrate_network_max is decreased incrementally, if not enough
% substrate will be available over the prediction horizon |timespan|. Here
% not the prediction horizon is used, but |timespan / 4|. Using the
% prediction horizon is too conservativ, then too small amounts of the
% substrate are fed. difficult (impossible) to determine optimal time
% domain. 
%
%%
% @return |substrate_network_min| : is left to the original value but if it
% is higher as the max boundary, it is set to the max boundary. 
%
%%
% @return |substrate_network_max| : is decreased depending on the available
% substrates over the time horizon. 
%
%% Example
%
% # here the first substrate is bounded, there is not enough for the next
% 50 days. so max is decreased accordingly for the first substrate

[substrate_network, substrate_network_min, substrate_network_max]= ...
  load_biogas_mat_files('gummersbach', [], ...
    {'substrate_network', 'substrate_network_min', 'substrate_network_max'});

disp(substrate_network_min)

disp(substrate_network_max)

[substrate_network_min, substrate_network_max]= ...
  change_bounds_substrate_stock(substrate_network_min, substrate_network_max, ...
  [500 Inf Inf]', 50, 10, substrate_network, 1);

disp(substrate_network_min)

disp(substrate_network_max)


%%
% # here the first substrate is bounded, there is not enough for the next
% 50 days. so max is decreased accordingly for the first substrate, but not
% lower as 2 m³/d

[substrate_network, substrate_network_min, substrate_network_max]= ...
  load_biogas_mat_files('gummersbach', [], ...
    {'substrate_network', 'substrate_network_min', 'substrate_network_max'});

disp(substrate_network_min)

disp(substrate_network_max)

[substrate_network_min, substrate_network_max]= ...
  change_bounds_substrate_stock(substrate_network_min, substrate_network_max, ...
  [20 Inf Inf]', 50, 10, substrate_network, 1);

disp(substrate_network_min)

disp(substrate_network_max)


%%
% # here there is not enough as well for the first substrate, but there is
% still something, here we do not want to have a soft feed change, see the
% last parameter is set to 0. 

[substrate_network, substrate_network_min, substrate_network_max]= ...
  load_biogas_mat_files('gummersbach', [], ...
    {'substrate_network', 'substrate_network_min', 'substrate_network_max'});

disp(substrate_network_min)

disp(substrate_network_max)

[substrate_network_min, substrate_network_max]= ...
  change_bounds_substrate_stock(substrate_network_min, substrate_network_max, ...
  [5 Inf Inf]', 50, 10, substrate_network, 0);

disp(substrate_network_min)

disp(substrate_network_max)


%%
% # here there is not enough as well for the first substrate, actually there
% is nothing anymore, here we do not want to have a soft feed change, see the
% last parameter is set to 0. 

[substrate_network, substrate_network_min, substrate_network_max]= ...
  load_biogas_mat_files('gummersbach', [], ...
    {'substrate_network', 'substrate_network_min', 'substrate_network_max'});

disp(substrate_network_min)

disp(substrate_network_max)

[substrate_network_min, substrate_network_max]= ...
  change_bounds_substrate_stock(substrate_network_min, substrate_network_max, ...
  [0 Inf Inf]', 50, 10, substrate_network, 0);

disp(substrate_network_min)

disp(substrate_network_max)



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/repmat')">
% matlab/repmat</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isrn')">
% script_collection/isRn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_substrate_network')">
% biogas_scripts/is_substrate_network</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/startnmpcatequilibrium')">
% biogas_control/startNMPCatEquilibrium</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_control/startnmpc')">
% biogas_control/startNMPC</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/createdefaultsubstratestock')">
% biogas_control/createDefaultSubstrateStock</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_gui/gui_nmpc')">
% biogas_gui/gui_nmpc</a>
% </html>
%
%% TODOs
% # check script and documentation
% # check appearance of documentation
% # improve documentation
% # make todos
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Findeisen, R. and Allgöwer, F.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\02 An Introduction to Nonlinear Model Predictive Control.pdf'', 
% biogas_control.getHelpPath())'))">
% An Introduction to Nonlinear Model Predictive Control</a>, 
% 21st Benelux Meeting on Systems and Control, vol. 11, 2002
% </li>
% <li> 
% Gaida, D.; Sousa Brito, André Luis; Wolf, Christian; Bäck, Thomas;
% Bongards, Michael and McLoone, Seán: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\162.pdf'', 
% biogas_control.getHelpPath())'))">
% Optimal Control of Biogas Plants using Nonlinear Model Predictive Control</a>, 
% ISSC 2011, Trinity College Dublin, 2011. 
% </li>
% <li> 
% Gaida, D.; Wolf, Christian; Bäck, Thomas and Bongards, Michael: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\ThA3-01.pdf'', 
% biogas_control.getHelpPath())'))">
% Nonlinear Model Predictive Substrate Feed Control of Biogas Plants</a>, 
% 20th Mediterranean Conference on Control & Automation (MED), Barcelona,
% 2012. 
% </li>
% <li> 
% Sousa Brito, André Luis: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\Thesis_Brito_final_online.pdf'', 
% biogas_control.getHelpPath())'))">
% Optimization of full-scale Biogas Plants using Nonlinear Model Predictive Control</a>, 
% Master Thesis, Cologne University of Applied Sciences, 2011.
% </li>
% <li> 
% Venkatesan, Ashwin Kumar: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\NMPC Final Report.pdf'', 
% biogas_control.getHelpPath())'))">
% Optimization of Substrate Feed in a Biogas Plant using Non-linear Model Predictive Control</a>, 
% Master Thesis, Cologne University of Applied Sciences, 2012.
% </li>
% </ol>
% </html>
%


