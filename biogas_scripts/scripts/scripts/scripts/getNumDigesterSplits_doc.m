%% Syntax
%       nSplits= getNumDigesterSplits(plant_network, plant_network_max)
%       [nSplits, digester_splits]= getNumDigesterSplits(plant_network,
%       plant_network_max, plant) 
%       [nSplits, digester_splits]= getNumDigesterSplits(plant_network,
%       plant_network_max, plant, delimiter) 
%       [nSplits, digester_splits, digester_indices]=
%       getNumDigesterSplits(...) 
%       
%% Description
% |nSplits= getNumDigesterSplits(plant_network, plant_network_max)|
% returns number of splits between digesters on the plant. If you want to
% split the outlet of a digester into two or more pieces you have to use
% one or more pumps to pump the outlet into two or more digesters or the
% final storage tank. The number of such splits, which are defined by
% |plant_network| and |plant_network_max| are returned by this function. To
% each split one |volumeflow_..._....mat| file must exist. 
%
%% <<plant_network/>>
%% <<plant_network_max/>>
%%
% @return |nSplits| : number of splits between digesters on the plant
%
%%
% |[nSplits, digester_splits]= getNumDigesterSplits(plant_network,
% plant_network_max, plant)|
%
%% <<plant/>>
%%
% @parameter |delimiter| : delimiter, default: '_', could also be '->',
% char.
%
%%
% @return |digester_splits| : the ids of the tank between which the sludge
% is pumped is returned connected by |delimiter|. cell of strings. 
%
%%
% |[nSplits, digester_splits, digester_indices]= getNumDigesterSplits(...)|
% 
%%
% @return |digester_indices| : The indices of the digesters are returned,
% coresponding to |digester_splits|. matrix: two dimensional row vectors
% containing the indices. Number of rows: |nSplits|. 
%
%% Example
%
% # Example: Here we have two digesters and one final storage tank. Here we
% only have one split, because the outlet of the second digester is pumped
% back to the 1st digester and is pumped to the final storage tank. This
% can be seen by the 2nd row of |plant_network|. 

plant_network= [ 0 1 0; 1 0 1 ];
plant_network_max= [ 0 Inf 0; 10 0 Inf ];

getNumDigesterSplits(plant_network, plant_network_max)

%%
% here the output of the first digester is connected with the input of the
% 2nd digester and the final storage tank. the 1st connection is pumpable.
% the output of the 2nd digester is connected with the input of the 1st
% digester and the input of the final sorage tank. Thus we have two splits
% on the plant. The output of the 1st and 2nd digester is splitted once. 
%
% Remark: If we split a stream twice, the amount of one part of it must be
% specified. This is done by |plant_network_max|. This amount is then
% pumped by the pump and the rest of the stream is put into the other part
% of the stream. Only the ids of the pumped stream is returned as
% |digester_splits| and |digester_indices|, see below. 

plant_network= [ 0 1 1; 1 0 1 ];
plant_network_max= [ 0 10 Inf; 10 0 Inf ];

getNumDigesterSplits(plant_network, plant_network_max)

%%
% 

[substrate, plant, substrate_network, plant_network, ...
 substrate_network_min, substrate_network_max, ...
 plant_network_min, plant_network_max]= load_biogas_mat_files('gummersbach');

[nSplits, digester_splits, digester_indices]= ...
       getNumDigesterSplits(plant_network, ...
                            plant_network_max, plant);

disp('nSplits: ');
disp(nSplits);
disp('digester_splits: ');
disp(digester_splits);
disp('digester_indices: ');
disp(digester_indices);

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_network')">
% biogas_scripts/is_plant_network</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_ml/createsubstratefeedsforstateestimation')">
% biogas_ml/createSubstrateFeedsForStateEstimation</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_ml/startstateestimation')">
% biogas_ml/startStateEstimation</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getequilibriumfromfiles')">
% biogas_optimization/getEquilibriumFromFiles</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_volumeflow_outof_equilibrium')">
% biogas_scripts/get_volumeflow_outof_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_volumeflow_files')">
% biogas_scripts/load_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/plot_volumeflow_files')">
% biogas_scripts/plot_volumeflow_files</a>
% </html>
%
%% See Also
%
% <html>
% <a href="getnumrecirculations.html">
% getNumRecirculations</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_gui/gui_plant_network')">
% biogas_gui/gui_plant_network</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%
%% <<AuthorTag_DG/>>


