%% Syntax
%       rescale_paretoset_SMSEMOA(LBold, UBold, LBnew, UBnew)
%       rescale_paretoset_SMSEMOA(LBold, UBold, LBnew, UBnew, path2file)
%       
%% Description
% |rescale_paretoset_SMSEMOA(LBold, UBold, LBnew, UBnew, path2file)| 
%
%%
% @param |LBold| : 
%
%%
% @param |UBold| : 
%
%%
% @param |LBnew| : 
%
%%
% @param |UBnew| : 
%
%%
% @param |path2file| : usually pwd
%
%% Example
%
%

cd( fullfile( getBiogasLibPath(), 'examples' ) );

%%
% create LB and UB

substrate_network_max= [30,0;15,0;0,0;30,0;0,0;0,0;0,0;0,0;0,0;0,0];
substrate_network_min= [0,0;5,0;0,0;0,0;0,0;0,0;0,0;0,0;0,0;0,0];

UBnew= [25,0;15,0;0,0;30,0;0,0;0,0;0,0;0,0;0,0;0,0];
LBnew= [5,0;5,0;0,0;0,0;0,0;0,0;0,0;0,0;0,0;0,0];

%%

rescale_paretoset_SMSEMOA(substrate_network_min, substrate_network_max, LBnew, UBnew)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc biogas_optimization/popbiogas">
% biogas_optimization/popBiogas</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/load">
% matlab/load</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_control/startnmpcatequilibrium">
% biogas_control/startNMPCatEquilibrium</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_optimization/rescale_paretoset_smsego">
% biogas_optimization/rescale_paretoset_SMSEGO</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_optimization/rescale_population_cmaes">
% biogas_optimization/rescale_population_CMAES</a>
% </html>
%
%% TODOs
% # improve documentation
% # check appearance of documentation
% # check script
% # update is called by and see also
% # do TODO
%
%% <<AuthorTag_DG/>>


