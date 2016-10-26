%% findMinDXNorm
% Find minimal DXNorm using <fitness_dxnorm.html fitness_DXNorm>
%
function xmin= findMinDXNorm(plant, x0, LB, UB, varargin)
%% Release: 1.4

%%

error( nargchk(4, 5, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% read out varargin

if nargin >= 5 && ~isempty(varargin{1})
  method= varargin{1};
  checkArgument(method, 'method', 'char || cellstr', 5);
  
  method= char(method);
else
  method= 'CMAES';
end

%%
% check input params

is_plant(plant, '1st');

validateattributes(x0, {'double'}, {'2d'}, mfilename, 'initial state',  2);

% contains min respectively max values of digester state variables measured
% in default measurement units
% vector containing 37 rows times number of digester columns, 
% first 37 values: digester 1, 2nd 37 values: digester 2
checkArgument(LB, 'LB', 'double', '3rd');
checkArgument(UB, 'UB', 'double', '4th');

%%

goal_variables= load_file('adm1_state_abbrv');

plant_id= char(plant.id);

%%

[~, ~, ~, plant_network]= load_biogas_mat_files(plant_id);

%%

LB= LB(:)';
UB= UB(:)';

ObjectiveFunction= @(u)fitness_DXNorm(u, plant, plant_network, goal_variables, LB, UB);

% normalize x
x0= x0(:)';
xnorm= 10 .* ( x0 - LB ) ./ ( UB - LB );

LBnorm= zeros(1, numel(LB));
UBnorm= 10 .* ones(1, numel(UB));

%%

fcn= ['plant_', plant_id];

%%

load_biogas_system(fcn);


%% 
% start optimization method
                   
switch (method)

  %%

  case 'CMAES'          

    xmin= startCMAES(ObjectiveFunction, xnorm(:)', LBnorm, UBnorm, 25, 4)';
         
  %%
  
  otherwise
    
    error('Unknown method: %s!', method);
    
%%

end

%%

close_biogas_system(fcn);

%%
% zurück skalieren. xmin ist normiert. hier wird auf realen wertebreich
% zurück skaliert

x= xmin' .* ( UB - LB ) ./ 10 + LB;

xmin= x;

%%


