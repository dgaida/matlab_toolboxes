%% startADMparamsCalibration
% Start Calibration Procedure, so optimization of ADM params
% 
function startADMparamsCalibration(plant_id, varargin)
%% Release: 1.4

%%
% check input parameters

error( nargchk(1, 7, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1}), 
  method_type= varargin{1}; 
  validatestring(method_type, {'mean', 'median', 'last'}, mfilename, 'method_type', 2);
else
  method_type= 'mean'; 
end

if nargin >= 3 && ~isempty(varargin{2}), 
  p_Matrix= varargin{2}; 
  validateattributes(p_Matrix, {'double'}, {'2d', 'nonnegative'}, ...
                     mfilename, 'p_Matrix', 3);
else
  p_Matrix= [ ...
              3.5,     0.15;    %kdis [1/d]           0.25
              15,      0.01;    %khyd_ch [1/d]        10
              15,      0.01;    %khyd_pr [1/d]        10
              15,      0.01;    %khyd_li[1/d]         10
              5,       2;       %km_pro [1/d]         4
              0.4,     0.05;    %KS_pro [kgCOD/m^3]   0.1
              5,       2;       %km_ac [1/d]          4.1
              0.3,     0.01;    %KS_ac [kgCOD/m^3]    0.15
              20,      10;      %km_c4 [1/d]          20
              0.3,     0.11;    %KS_c4 [kgCOD/m^3]    0.3
              0.03,    0.01;    %kdec_Xsu [-]         0.02
              0.03,    0.01;    %kdec_Xac [-]         0.02
              0.03,    0.01;    %kdec_Xh2 [-]         0.02
              7.5e-5,  6.0e-6;  %KS_h2 [-]            7e-6
              4e-6,    3e-8;    %KI_H2_pro [-]        3.5e-6
              1.25e-4, 0.75e-8; %KI_H2_c4 [-]         1e-5
              0.0085,  0.0015;  %KI_NH3 [-]           0.002
              8.5,     6.5;     %pHUL_ac [-]          7
              6.5,     5.0;     %pHLL_ac[-]           6
            ];
end

if nargin >= 4 && ~isempty(varargin{3}), 
  timespan_calib= varargin{3}; 
  isR(timespan_calib, 'timespan_calib', 4, '+');
else
  timespan_calib= 50; 
end

if nargin >= 5 && ~isempty(varargin{4}), 
  opt_method= varargin{4}; 
  validatestring(opt_method, {'CMAES', 'GA', 'PSO', 'DE', 'ISRES'}, ...
                 mfilename, 'opt_method', 5);
else
  opt_method= 'CMAES'; 
end

if nargin >= 6 && ~isempty(varargin{5}), 
  pop_size= varargin{5}; 
  isN(pop_size, 'pop_size', 6);
else
  pop_size= 20; 
end

if nargin >= 7 && ~isempty(varargin{6}), 
  nGenerations= varargin{6}; 
  isN(nGenerations, 'nGenerations', 7);
else
  nGenerations= 10;
end

%%
% check arguments

checkArgument(plant_id, 'plant_id', 'char', '1st');


%%
% adm1_params_opt_sunderhook.mat

% Create the file |adm1_params_opt__plant_id_.mat| for the given |plant_id|
% in the subfolder steadystate
createADM1paramsfile( plant_id, fullfile(pwd, 'steadystate') );

%%
% run a steady state simulation 

calib_SteadyStateCalc( plant_id, method_type, 700 );

%% TODO

% if(1)
%   
%   copyfile('initstate_geiger_new.mat', 'initstate_geiger.mat');
%   
%   createDigesterStateMinMax(plant_id);
%   
% end

%%
% create all necessary ADM1 parameter mat files

calib_BiogasPlantParams( plant_id, 'user', p_Matrix );

%%
% start parameter optimization

findOptimalEquilibrium(plant_id, opt_method, [], [], [], pop_size, ...
                       nGenerations, [], [0 timespan_calib]);

%%


