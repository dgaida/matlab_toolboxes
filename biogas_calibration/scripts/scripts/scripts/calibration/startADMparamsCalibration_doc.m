%% Preliminaries
% # Create a new folder. Inside this folder create the subfolder
% |steadystate|. 
% # Inside the new folder copy the model of your biogas plant used for
% optimization. Inside the subfolder |steadystate| copy the normal
% simulation model of your biogas plant (may also be the model used for
% optimization). TODO: test if both is possible!!! Better to use the
% optimization model. 
% # Furthermore copy the following files inside the new folder:
%
% * all |volumeflow_..._user.mat| files for all substrates and all
% recirculations between digesters.
% * |initstate_plant_id.mat| providing a reasonable initial state
% * |reference_...mat| files (TODO)
% * |fitness_params_plant_id.mat|. Set the value for |fitness_function| to
% |@fitness_calibration|.
%
% # The model inside the new folder must have the following settings:
%
% * load substrate feeds from file with user feed
% * load recirculation between digesters from file, user flow
% * load initstate from file, user
% * do not save the final simulation states
%
% # The model inside the subfolder |steadystate| must have the following
% settings:
%
% * load substrate feeds from file with const feed
% * load recirculation between digesters from file, const flow
% * load initstate from file, user
% 
%% Syntax
%       startADMparamsCalibration(plant_id)
%       startADMparamsCalibration(plant_id, method_type)
%       startADMparamsCalibration(plant_id, method_type, p_Matrix)
%       startADMparamsCalibration(plant_id, method_type, p_Matrix,
%       timespan_calib) 
%       startADMparamsCalibration(plant_id, method_type, p_Matrix,
%       timespan_calib, opt_method) 
%       startADMparamsCalibration(plant_id, method_type, p_Matrix,
%       timespan_calib, opt_method, pop_size) 
%       startADMparamsCalibration(plant_id, method_type, p_Matrix,
%       timespan_calib, opt_method, pop_size, nGenerations) 
%       
%% Description
% |startADMparamsCalibration(plant_id)| start Calibration Procedure, so
% optimization of ADM params 
%
%%
% @param |plant_id| : char with the id of the simulation model of the
% biogas plant. The plant's id is defined in the structure |plant| and has 
% to be set in the simulation model, which is
% <matlab:doc('develop_model_stepbystep') created> 
% using the toolbox's library. 
%
%%
% @param |method_type| : char defining which values out of the user files
% are used to create the values in the const files. Default: 'mean'. 
% 
% * 'last' : last known input from the volumeflow_'substrate_id'_user.mat 
% is used to create a constant substrate feed file 
% volumeflow_'substrate_id'_const.mat to calculate the initial state of
% the plant.
% * 'mean' : the mean value of the volumeflow_'substrate_id'_user.mat 
% is used to create a constant substrate feed file 
% volumeflow_'substrate_id'_const.mat to calculate the initial state of
% the plant.
% * 'median' : the median value of the volumeflow_'substrate_id'_user.mat 
% is used to create a constant substrate feed file 
% volumeflow_'substrate_id'_const.mat to calculate the initial state of
% the plant.
%
% The same applies to the recirculation sludge between the digesters.
% Their user files are also read and written to const files as defined by
% the argument |method_type|. 
%
%%
% @param |p_Matrix| : defines the lower and upper boundaries for the ADM1
% parameters to be optimized. They are in this order:
%
% # kdis disintegration rate [1/d]  
% # khyd_ch hydrolysis rate carbohydrates [1/d]
% # khyd_pr hydrolysis rate propionate [1/d]
% # khyd_li hydrolysis rate lipids [1/d]
% # km_pro max. uptake rate propionate [1/d]
% # KS_pro half sat. coeff. propionate [kgCOD/m^3]
% # km_ac max. uptake rate acetate [1/d]
% # KS_ac half sat. coeff. acetate [kgCOD/m^3]
% # km_c4 max. uptake rate valerate and butyrate [1/d]
% # KS_c4 half. sat. coeff. valerate and butyrate [kgCOD/m^3]
% # kdec_Xsu decay rate Xsu [1/d]
% # kdec_Xac decay rate Xac [1/d]
% # kdec_Xh2 decay rate Xh2 [1/d]
% # KS_h2 half sat. coeff. H2 for p12 [kg COD/m3]
% # KI_H2_pro half sat. coeff. H2 in p10 [kg COD/m3]
% # KI_H2_c4 half. sat. coeff. H2 for p8,9 [kg COD/m3]
% # KI_NH3 half. sat. coeff. NH3 in p11 [k mole N/m3]
% # pHUL_ac upper pH limit p11 [-]
% # pHLL_ac lower pH limit for p11 [-]
%
% |p_Matrix| must have two columns (min, max) and as many rows as there are
% parameters (19). At the moment the parameter boundaries are applied to
% all fermenters on the plant (see TODO). 
%
% The default matrix is:
%
%%
% |p_Matrix= [ ...
%               3.5,     0.15;    %kdis [1/d]           0.25
%
%               15,      0.01;    %khyd_ch [1/d]        10
%
%               15,      0.01;    %khyd_pr [1/d]        10
%
%               15,      0.01;    %khyd_li[1/d]         10
%               5,       2;       %km_pro [1/d]         4
%               0.4,     0.05;    %KS_pro [kgCOD/m^3]   0.1
%               5,       2;       %km_ac [1/d]          4.1
%               0.3,     0.01;    %KS_ac [kgCOD/m^3]    0.15
%               20,      10;      %km_c4 [1/d]          20
%               0.3,     0.11;    %KS_c4 [kgCOD/m^3]    0.3
%               0.03,    0.01;    %kdec_Xsu [-]         0.02
%               0.03,    0.01;    %kdec_Xac [-]         0.02
%               0.03,    0.01;    %kdec_Xh2 [-]         0.02
%               7.5e-5,  6.0e-6;  %KS_h2 [-]            7e-6
%               4e-6,    3e-8;    %KI_H2_pro [-]        3.5e-6
%               1.25e-4, 0.75e-8; %KI_H2_c4 [-]         1e-5
%               0.0085,  0.0015;  %KI_NH3 [-]           0.002
%               8.5,     6.5;     %pHUL_ac [-]          7
%               6.5,     5.0;     %pHLL_ac[-]           6
%             ];|
%
%%
% @param |timespan_calib| : double scalar defining the duration of the
% calibration scenario measured in days. Default: 50 (days). 
%
%%
% @param |opt_method| : char with the optimization method you can choose to
% solve the optimization problem:
%
% * 'GA'    : <matlab:doc('ga') genetic algorithms> using MATLAB's |Genetic
% Algorithm and Direct Search Toolbox|
% T(TM)
% * 'PSO'   : particle swarm optimization using the MATLAB toolbox 
% <http://www.mathworks.com/matlabcentral/fileexchange/7506-particle-swarm-optimization-toolbox 
% PSOt> by Brian Birge.
% * 'ISRES' : "Improved" Evolution Strategy using Stochastic Ranking using
% the <http://www3.hi.is/~tpr/index.php?page=software/sres/sres |ISRES|>
% toolbox.
% * 'DE' : <http://www.icsi.berkeley.edu/~storn/code.html Differential
% Evolution>
% * 'CMAES' : Covariance Matrix Adaptation Evolution Strategy using the
% <http://www.lri.fr/~hansen/cmaes_inmatlab.html |CMA-ES|> implementation
% (default)
%
%%
% @param |pop_size| : the population size of the population based
% optimization method, double scalar integer. Default: 20. 
%
%%
% @param |nGenerations| : the maximal number of generations the
% optimization method runs, double scalar integer. Default: 10. 
%
%% Example
%
% |startADMparamsCalibration('gummersbach')|
%  
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="calib_steadystatecalc.html">
% calib_SteadyStateCalc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc createadm1paramsfile">
% createADM1paramsfile</a>
% </html>
% ,
% <html>
% <a href="calib_biogasplantparams.html">
% calib_BiogasPlantParams</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_optimization/findoptimalequilibrium">
% biogas_optimization/findOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validatestring">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validateattributes">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="create_volumeflow_const_outof_user_substrate.html">
% create_volumeflow_const_outof_user_substrate</a>
% </html>
% ,
% <html>
% <a href="create_volumeflow_const_outof_user_digester.html">
% create_volumeflow_const_outof_user_digester</a>
% </html>
% 
%% TODOs
% # improve documentation
% # add an example
% # the lb and ub should be defined for each digester seperately
%
%% <<AuthorTag_ALSB/>>
%% References
%
% <html>
% <ol>
% <li> 
% Moles, C.G.; Mendes, P.; Banga, J.R.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\03 Parameter estimation in biochemical pathways - a comparison of global optimization methods.pdf'', 
% biogas_calibration.getHelpPath())'))">
% Parameter Estimation in Biochemical Pathways: A Comparison of Global
% Optimization Methods</a>, 
% in Genome Research, 13, pp. 2467-2474, 2003. 
% </li>
% <li> 
% Rodriguez-Fernandez, M.; Egea, J.A.; Banga, J.R.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\06 Novel metaheuristic for parameter estimation in nonlinear dynamic biological systems.pdf'', 
% biogas_calibration.getHelpPath())'))">
% Novel metaheuristic for parameter estimation in nonlinear dynamic
% biological systems</a>,  
% in BMC Bioinformatics, 7:483, 2006. 
% </li>
% <li> 
% Wenzel, A.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\08 Evolutionary Algorithm Application for Parameter Estimation of the ADM1.pdf'', 
% biogas_calibration.getHelpPath())'))">
% Evolutionary Algorithm Application for Parameter Estimation of the
% Anaerobic Digestion Model No. 1</a>,   
% in ICCC2008, IEEE 6th International Conference on Computational
% Cybernetics, Slovakia, 2008
% </li>
% <li> 
% Wichern, M.; Lübken, M.; Schlattmann, M.; Gronauer, A.; Horn, H.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\08 Investigations and mathematical simulation on decentralized anaerobic treatment.pdf'', 
% biogas_calibration.getHelpPath())'))">
% Investigations and mathematical simulation on decentralized anaerobic
% treatment of agricultural substrate from livestock farming</a>, 
% in Water Science & Technology, 58(1), pp. 67-72, 2008. 
% </li>
% <li> 
% Page, D.I.; Hickey, K.L.; Narula, R.; Main, A.L.; Grimberg, S.J.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\08 Modeling anaerobic digestion of dairy manure using the ADM1.pdf'', 
% biogas_calibration.getHelpPath())'))">
% Modeling anaerobic digestion of dairy manure using the IWA Anaerobic
% Digestion Model no. 1 (ADM1)</a>, 
% in Water Science & Technology, 58(3), pp. 689-695, 2008. 
% </li>
% <li> 
% Wolfsberger, A.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\08 modelling and control of the anaerobic digestion of energy crops.pdf'', 
% biogas_calibration.getHelpPath())'))">
% Modelling and Control of the Anaerobic Digestion of Energy Crops</a>, 
% Dissertation zur Erlangung des Doktorgrades an der Universität für
% Bodenkultur, 2008. 
% </li>
% <li> 
% Wichern, M.; Gehring, T.; Fischer, K.; Andrade, D.; Lübken, M.; Koch, K.;
% Gronauer, A.; Horn, H.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\09 monofermentation of grass silage under mesophilic conditions - measurements and math model adm1.pdf'', 
% biogas_calibration.getHelpPath())'))">
% Monofermentation of grass silage under mesophilic conditions:
% Measurements and mathematical modeling with ADM 1</a>, 
% in Bioresource Technology, 100, pp. 1675-1681, 2009. 
% </li>
% <li> 
% Schoen, M.A.; Sperl, D.; Gadermaier, M.; Goberna, M.; Franke-Whittle, I.;
% Insam, H.; Ablinger, J.; Wett, B.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\09 Population dynamics at digester overload conditions.pdf'', 
% biogas_calibration.getHelpPath())'))">
% Population dynamics at digester overload conditions</a>, 
% in Bioresource Technology, 100, pp. 5648-5655, 2009. 
% </li>
% <li> 
% Koch, K.; Lübken, M.; Gehring, T.; Wichern, M.; Horn, H.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\10 Biogas from grass silage - Measurements and modeling with ADM1.pdf'', 
% biogas_calibration.getHelpPath())'))">
% Biogas from grass silage - Measurements and modeling with ADM1</a>, 
% in Bioresource Technology, 101, pp. 8158-8165, 2010. 
% </li>
% <li> 
% Gehring, T.; Lübken, M.; Koch, K.; Horn, H.; Wichern, M.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\09 Einsatz von mathematischen Prozessmodellen zur Optimierung des anaeroben Abbauprozesses.pdf'', 
% biogas_calibration.getHelpPath())'))">
% Einsatz von mathematischen Prozessmodellen zur Optimierung des anaeroben
% Abbauprozesses</a>, 
% in Bornimer Agrartechnische Berichte, 68: "Wie viel Biogas steckt in
% Pflanzen?", pp. 96-113, 2009. 
% </li>
% </ol>
% </html>
% 


