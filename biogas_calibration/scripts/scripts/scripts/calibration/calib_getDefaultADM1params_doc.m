%% Syntax
%       p_Matrix= calib_getDefaultADM1params()
%       [p_Matrix, p_ids]= calib_getDefaultADM1params()
%       [p_Matrix, p_ids, p_names]= calib_getDefaultADM1params()
%       
%% Description
% |p_Matrix= calib_getDefaultADM1params()| returns a double column vector
% with the default ADM1 parameters used for parameter calibration. They
% are in this order:
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
%%
% @return |p_Matrix| : double column vector with the default values of the
% ADM1 parameters listed above. 
%
%%
% |[p_Matrix, p_ids]= calib_getDefaultADM1params()| additionally returns
% the IDs of the parameters as cell string vector. 
%
%%
% @return |p_ids| : cell string vector with the IDs of the ADM parameters
% listed above. The IDs are: 'kdis', 'khyd_ch', ...
%
%%
% |[p_Matrix, p_ids, p_names]= calib_getDefaultADM1params()| additionally
% returns the names of the ADM1 parameters as cell string vector.
%
%%
% @return |p_names| : the names of the ADM1 parameters listed above as cell
% string vector. 
%
%% Example
%
%

calib_getDefaultADM1params()

%%

[p_Matrix, p_ids, p_names]= calib_getDefaultADM1params();

disp('p_ids: ')
disp(p_ids)
disp('p_names: ')
disp(p_names)

%% Dependencies
% 
% This function calls:
%
% -
%
% and is called by:
%
% <html>
% <a href="matlab:doc createadm1paramsfile">
% createADM1paramsfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc createparamsboundsfiles">
% createParamsBoundsfiles</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="calib_steadystatecalc.html">
% calib_SteadyStateCalc</a>
% </html>
% ,
% <html>
% <a href="calib_biogasplantparams.html">
% calib_BiogasPlantParams</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


