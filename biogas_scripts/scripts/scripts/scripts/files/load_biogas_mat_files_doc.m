%% Syntax
%       [substrate, plant]= load_biogas_mat_files(plant_id)
%       [substrate, plant]= load_biogas_mat_files(plant_id, setting)
%       [substrate, plant]= load_biogas_mat_files(plant_id, setting,
%       {'substrate', 'plant'}) 
%       [substrate, plant, 
%        substrate_network, plant_network]= load_biogas_mat_files(plant_id)
%       [substrate, plant, 
%        substrate_network, plant_network,
%        substrate_network_min, substrate_network_max]= load_biogas_mat_files(plant_id) 
%       [substrate, plant, 
%        substrate_network, plant_network,
%        substrate_network_min, substrate_network_max,
%        plant_network_min, plant_network_max]= load_biogas_mat_files(plant_id)
%       [substrate, plant, 
%        substrate_network, plant_network,
%        substrate_network_min, substrate_network_max,
%        plant_network_min, plant_network_max,
%        digester_state_min, digester_state_max]= load_biogas_mat_files(plant_id)
%       [substrate, plant, 
%        substrate_network, plant_network,
%        substrate_network_min, substrate_network_max,
%        plant_network_min, plant_network_max,
%        digester_state_min, digester_state_max,
%        substrate_eq, substrate_ineq]= load_biogas_mat_files(plant_id)
%       [substrate, plant, 
%        substrate_network, plant_network,
%        substrate_network_min, substrate_network_max,
%        plant_network_min, plant_network_max,
%        digester_state_min, digester_state_max,
%        substrate_eq, substrate_ineq,
%        fitness_params]= load_biogas_mat_files(plant_id)
%       [substrate, plant, 
%        substrate_network, plant_network,
%        substrate_network_min, substrate_network_max,
%        plant_network_min, plant_network_max,
%        digester_state_min, digester_state_max,
%        substrate_eq, substrate_ineq,
%        fitness_params, equilibria]= load_biogas_mat_files(plant_id)
%
%% Description
% |load_biogas_mat_files| loads all |*.mat| and |*.xml| files used for
% simulating a biogas 
% plant created with the _Biogas Plant Modeling_ Toolbox. Furthermore it
% makes a quick check in proving the reliability (the 'correctness') of
% the loaded data. 
%
%%
% |[substrate, plant]= load_biogas_mat_files(plant_id)| loads the |*.xml| 
% files |substrate__plant_id_.xml| and |plant__plant_id_.xml|. Both files
% are always read out of the <matlab:doc('getconfigpath')
% config_mat> folder. 
%
%% <<plant_id/>>
%%
% @param |setting| : char with relative path (no '../') to a subfolder where the file
% should be read from first. If there is no file, then the file is just
% read using <load_file.html load_file> without path specifications.
%
%%
% @return <matlab:doc('create_config_mat_files_simu') |substrate|>,
% <matlab:doc('create_config_mat_files_simu') |plant|>
%
%%
% @param |{'substrate', 'plant'}| : char or cell array of one respectively
% more than one file, that should be returned. Pass the names of the to be
% returned variables as they are specified as return arguments in this help
% file. The variables are returned in the same order as they are given.
%
% Example: |[substrate, plant_network]= load_biogas_mat_files(plant_id, [],
% {'substrate', 'plant_network'})|. 
%
%%
% |[substrate, plant, ...
%   substrate_network, plant_network]= load_biogas_mat_files(plant_id)|
%   loads furthermore the |*.mat| files |substrate_network__plant_id_.mat|
%   and |plant_network__plant_id_.mat|. 
%
% @return <matlab:doc('create_config_mat_files_simu') |substrate_network|>, 
% <matlab:doc('create_config_mat_files_simu') |plant_network|>
% 
%%
% |[substrate, plant, ...
%   substrate_network, plant_network, ...
%   substrate_network_min, substrate_network_max]=
%   load_biogas_mat_files(plant_id)| 
%   loads furthermore the |*.mat| files
%   |substrate_network_min__plant_id_.mat|
%   and |substrate_network_max__plant_id_.mat|. 
%
% @return <matlab:doc('define_lb_ub_optim') |substrate_network_min|>, 
% <matlab:doc('define_lb_ub_optim') |substrate_network_max|>
% 
%%
% |[substrate, plant, ...
%   substrate_network, plant_network, ...
%   substrate_network_min, substrate_network_max, ...
%   plant_network_min, plant_network_max]= load_biogas_mat_files(plant_id)|
%   loads furthermore the |*.mat| files |plant_network_min__plant_id_.mat|
%   and |plant_network_max__plant_id_.mat|. 
%
% @return <matlab:doc('define_lb_ub_optim') |plant_network_min|>, 
% <matlab:doc('define_lb_ub_optim') |plant_network_max|>
% 
%%
% |[substrate, plant, ...
%   substrate_network, plant_network, ...
%   substrate_network_min, substrate_network_max, ...
%   plant_network_min, plant_network_max, ...
%   digester_state_min, digester_state_max]= load_biogas_mat_files(plant_id)|
%   loads furthermore the |*.mat| files |digester_state_min__plant_id_.mat|
%   and |digester_state_max__plant_id_.mat|. 
%
% @return <matlab:doc('define_lb_ub_optim') |digester_state_min|>, 
% <matlab:doc('define_lb_ub_optim') |digester_state_max|>
% 
%%
% |[substrate, plant, ...
%   substrate_network, plant_network, ...
%   substrate_network_min, substrate_network_max, ...
%   plant_network_min, plant_network_max, ...
%   digester_state_min, digester_state_max, ...
%   params_min, params_max]= load_biogas_mat_files(plant_id)|
%   loads furthermore the |*.mat| files |params_min__plant_id_.mat|
%   and |params_max__plant_id_.mat|. 
%
% @return <matlab:doc('define_lb_ub_optim') |params_min|>, 
% <matlab:doc('define_lb_ub_optim') |params_max|>
% 
%%
% |[substrate, plant, ...
%   substrate_network, plant_network, ...
%   substrate_network_min, substrate_network_max, ...
%   plant_network_min, plant_network_max, ...
%   digester_state_min, digester_state_max, ...
%   params_min, params_max, ...
%   substrate_eq, substrate_ineq]= load_biogas_mat_files(plant_id)|
%   loads furthermore the |*.mat| files |substrate_eq__plant_id_.mat| and
%   |substrate_ineq__plant_id_.mat|. 
%
% @return <matlab:doc('define_nonlcon_optim') |substrate_eq|>,
% <matlab:doc('define_nonlcon_optim') |substrate_ineq|>
% 
%%
% |[substrate, plant, ...
%   substrate_network, plant_network, ...
%   substrate_network_min, substrate_network_max, ...
%   plant_network_min, plant_network_max, ...
%   digester_state_min, digester_state_max, ...
%   params_min, params_max, ...
%   substrate_eq, substrate_ineq, ...
%   fitness_params]= load_biogas_mat_files(plant_id)|
%   loads furthermore the |*.xml| file |fitness_params__plant_id_.xml|. 
%
% @return |fitness_params| : see <matlab:docsearch('Definition,of,fitness_params') here>
% 
%%
% |[substrate, plant, ...
%   substrate_network, plant_network, ...
%   substrate_network_min, substrate_network_max, ...
%   plant_network_min, plant_network_max, ...
%   digester_state_min, digester_state_max, ...
%   params_min, params_max, ...
%   substrate_eq, substrate_ineq, ...
%   fitness_params, equilibria]= load_biogas_mat_files(plant_id)|
%   loads furthermore the |*.mat| file |equilibriaInitPop__plant_id_.mat|. 
%
% @return |equilibria|, if |equilibria| is not empty, then it is also assigned
% to the base workspace of matlab
% 
%% Example
% 

try
  [substrate, plant, substrate_network, plant_network]= ...
      load_biogas_mat_files('gummersbach');
catch ME
  disp(ME.message);
end

%%

try
  [plant, plant_network]= ...
      load_biogas_mat_files('koeln', [], {'plant', 'plant_network'});
catch ME
  disp(ME.message);
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="load_file.html">
% load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkdimensionofvariable')">
% script_collection/checkDimensionOfVariable</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_id')">
% biogas_scripts/is_plant_id</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_path2xml_configfile')">
% biogas_scripts/get_path2xml_configfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('load_admparam_vec_from_file')">
% load_ADMparam_vec_from_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('getconfigpath')">
% getConfigPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/assignin')">
% matlab/assignin</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('init_biogas_plant_mdl')">
% init_biogas_plant_mdl</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('adm1_analysis_reachability')">
% ADM1_analysis_reachability</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('adm1_analysis_substrate')">
% ADM1_analysis_substrate</a>
% </html>
% ,
% <html>
% <a href="createdigesterstateminmax.html">
% createDigesterStateMinMax</a>
% </html>
% ,
% <html>
% <a href="createnewinitstatefile.html">
% createNewInitstatefile</a>
% </html>
% ,
% <html>
% ...
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_ml/startstateestimation')">
% biogas_ml/startStateEstimation</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:edit('load_biogas_mat_files.m')">
% edit load_biogas_mat_files.m</a>
% </html>
%
%% TODOs
% # load also eq and ineq for plant network and digester states
% # do the documentation for the script file
% # improve documentation a bit
%
%% <<AuthorTag_DG/>>


