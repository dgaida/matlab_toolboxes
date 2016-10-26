%% Syntax
%       [digester_state_min, digester_state_max]=
%       setStateBoundsToEqState(equilibrium) 
%       [...]= setStateBoundsToEqState(equilibrium, plant_id) 
%
%% Description
% |[digester_state_min, digester_state_max]=
% setStateBoundsToEqState(equilibrium)| sets digester bounds
% |digester_state_min| and |digester_state_max| to states inside
% |equilibrium| struct. 
%
%% <<equilibrium/>>
%%
% @param |plant_id| : ID of plant. If you give this argument, then
% digester_state_min/max are saved in pwd. Default: [], then they are not
% saved. 
%
%%
% @return |digester_state_min| : double array 37 x n_fermenter with the
% lower bound. Is equal to the states saved in |equilibrium|. 
%
%%
% @return |digester_state_max| : double array 37 x n_fermenter with the
% upper bound. Is equal to the states saved in |equilibrium|, thus min
% equal to max. 
%
%% Example
% 
%

% try
%   [substrate, plant]= load_biogas_mat_files('gummersbach');
% catch ME
%   disp(ME.message);
% end

equilibrium= load_file('equilibrium_gummersbach');

%%

[digester_state_min, digester_state_max]= ...
            setStateBoundsToEqState(equilibrium, []);

%%

temp= get(0,'format');

format shortE;

disp(digester_state_min)
disp(digester_state_max)

format(temp)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('nargchk')">
% matlab/nargchk</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('nargoutchk')">
% matlab/nargoutchk</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_equilibrium')">
% biogas_scripts/is_equilibrium</a>
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
% <a href="matlab:doc('biogas_control/startnmpc')">
% biogas_control/startNMPC</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_control/nmpc_load_fermenterflow')">
% biogas_control/NMPC_load_FermenterFlow</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_save_ctrl_strgy_fermenterflow')">
% biogas_control/NMPC_save_ctrl_strgy_FermenterFlow</a>
% </html>
%
%% TODOs
% # improve documentation a bit
% # check appearance of documentation
%
%% <<AuthorTag_ALSB/>>


