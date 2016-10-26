%% Syntax
%       nRecirculations= getNumRecirculations(plant_network)
%       nRecirculations= getNumRecirculations(plant_network, plant)
%       [...]= getNumRecirculations(plant_network, plant, delimiter)
%       [nRecirculations, digester_recirculations, digester_indices]=
%       getNumRecirculations(...) 
%       
%% Description
% |nRecirculations= getNumRecirculations(plant_network)| returns number of
% recirculations between digesters on the plant. A recirculation is when
% you pump (a part of) the outlet of a digester into the input of another
% digester, which is modelled after the other digester inside the |plant|
% object. Those connections are modelled by pumps inside the Simulink
% model. The pump inside a recirculating connection must contain a
% hydraulic delay to avoid a numerical loop in the model. A pump inside a
% forward connection does not need such a hydraulic delay. 
%
%% <<plant_network/>>
%%
% @return |nRecirculations| : number of recirculations between digesters on
% the plant
%
%% <<plant/>>
%%
% @parameter |delimiter| : delimiter, default: '_', could also be '->',
% char.
%
%%
% @return |digester_recirculations| : cell array of chars, symbolizing
% from where to where the sludge is pumped. It has as many columns as
% is given by |nRecirculations|. 
%
%%
% @return |digester_indices| : double matrix with 2 columns and
% |nRecirculations| rows. The content of each row is the indice of the
% digesters involved in the recirculation. 
%
%% Example
%
% 

plant_network= [ 0 1 0; 1 0 1 ];

getNumRecirculations(plant_network)

%%
% here the output of the first digester is conencted with the input of the
% 2nd digester and the final storage tank. the 1st connection is pumpable.
% the output of the 2nd digester is connected with the input of the 1st
% digester and the input of the final sorage tank. Thus we have two splits
% on the plant. The output of the 1st and 2nd digester is splitted once.
% But only the 2nd one is recirculated, the other one is pumped forward
% (from 1st to 2nd digester) 

plant_network= [ 0 1 1; 1 0 1 ];

getNumRecirculations(plant_network)

%%
% 

[substrate, plant, substrate_network, plant_network, ...
 substrate_network_min, substrate_network_max, ...
 plant_network_min, plant_network_max]= load_biogas_mat_files('gummersbach');

[nRecirculations, digester_recirculations, digester_indices]= ...
       getNumRecirculations(plant_network, plant);

disp('nRecirculations: ');
disp(nRecirculations);
disp('digester_recirculations: ');
disp(digester_recirculations);
disp('digester_indices: ');
disp(digester_indices);

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_network')">
% biogas_scripts/is_plant_network</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_optimization/defineequilibriumstruct')">
% biogas_optimization/defineEquilibriumStruct</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/savestateinequilibriumstruct')">
% biogas_optimization/saveStateInEquilibriumStruct</a>
% </html>
%
%% See Also
%
% <html>
% <a href="getnumdigestersplits.html">
% getNumDigesterSplits</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


