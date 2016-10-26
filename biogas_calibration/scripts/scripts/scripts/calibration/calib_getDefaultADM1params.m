%% calib_getDefaultADM1params
% Get default values of ADM params used in calibration
%
function [p_Matrix, varargout]= calib_getDefaultADM1params()
%% Release: 1.9

%%

error( nargchk(0, 0, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%

p_Matrix = [ ...
             0.25;   %kdis disintegration rate [1/d]  
             10;     %khyd_ch hydrolysis rate carbohydrates [1/d]  
             10;     %khyd_pr hydrolysis rate propionate [1/d]    
             10;     %khyd_li hydrolysis rate lipids [1/d]    
             4;      %km_pro max. uptake rate propionate [1/d]
             0.1;    %KS_pro half sat. coeff. propionate [kg COD/m3]
             4.1;    %km_ac max. uptake rate acetate [1/d]
             0.15;   %KS_ac half sat. coeff. acetate [kg COD/m3]
             20;     %km_c4 max. uptake rate valerate and butyrate [1/d]
             0.3;    %KS_c4 half. sat. coeff. valerate and butyrate [kgCOD/m^3]
             0.02;   %kdec_Xsu decay rate Xsu [1/d]
             0.02;   %kdec_Xac decay rate Xac [1/d]
             0.02;   %kdec_Xh2 decay rate Xh2 [1/d]
             7e-6;   %KS_h2 half sat. coeff. H2 for p12 [kg COD/m3]
             3.5e-6; %KI_H2_pro half sat. coeff. H2 in p10 [kg COD/m3]
             1e-5;   %KI_H2_c4 half. sat. coeff. H2 for p8,9 [kg COD/m3]
             0.002;  %KI_NH3 half. sat. coeff. NH3 in p11 [k mole N/m3]
             7;      %pHUL_ac upper pH limit p11 [-]
             6;      %pHLL_ac lower pH limit for p11 [-]      
           ];

%%

if nargout >= 2
  varargout{1}= {'kdis'; 'khyd_ch'; 'khyd_pr'; 'khyd_li'; 'km_pro'; 
                 'KS_pro'; 'km_ac'; 'KS_ac'; 'km_c4'; 'KS_c4'; 'kdec_Xsu'; 
                 'kdec_Xac'; 'kdec_Xh2'; 'KS_h2'; 'KI_H2_pro'; 'KI_H2_c4';
                 'KI_NH3'; 'pHUL_ac'; 'pHLL_ac'};
               
  if numel(varargout{1}) ~= numel(p_Matrix)
    error('numel(varargout{1}) ~= numel(p_Matrix)');
  end
else
  varargout{1}= [];
end

%%

if nargout >= 3
  varargout{2}= {'disintegration rate [1/d]'; 
                 'hydrolysis rate carbohydrates [1/d]'; 
                 'hydrolysis rate propionate [1/d]'; 
                 'hydrolysis rate lipids [1/d]'; 
                 'max. uptake rate propionate [1/d]'; 
                 'half sat. coeff. propionate [kgCOD/m^3]'; 
                 'max. uptake rate acetate [1/d]'; 
                 'half sat. coeff. acetate [kgCOD/m^3]'; 
                 'max. uptake rate valerate and butyrate [1/d]'; 
                 'half. sat. coeff. valerate and butyrate [kgCOD/m^3]'; 
                 'decay rate Xsu [1/d]'; 
                 'decay rate Xac [1/d]'; 
                 'decay rate Xh2 [1/d]'; 
                 'half sat. coeff. H2 for p12 [kg COD/m3]'; 
                 'half sat. coeff. H2 in p10 [kg COD/m3]'; 
                 'half. sat. coeff. H2 for p8,9 [kg COD/m3]';
                 'half. sat. coeff. NH3 in p11 [k mole N/m3]'; 
                 'upper pH limit p11 [-]'; 
                 'lower pH limit for p11 [-]'};
               
  if numel(varargout{2}) ~= numel(p_Matrix)
    error('numel(varargout{2}) ~= numel(p_Matrix)');
  end            
else
  varargout{2}= [];
end

%%


