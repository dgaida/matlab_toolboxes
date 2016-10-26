%% getPlantIDfrombdroot
% returns _plant_id_ from <matlab:doc('bdroot') bdroot> (the top-level
% Simulink system must be a biogas plant model) 
%
function plantID= getPlantIDfrombdroot()
%% Release: 1.9

%%

error( nargchk(0, 0, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

model_name= bdroot;

%%

[tokens]= regexp(model_name, 'plant_(\w+)', 'tokens');

tokens= tokens{:};

%%

if ~isempty(tokens)
  % trenne mit '_', da bei paralleler Berechnung die Kopien der Modelle mit
  % _1, _2, ... bezeichnet werden.
  parts= regexp(char(tokens), '\_', 'split');

  plantID= char(parts{1,1});
else
  warning('Simulink:bdroot', 'Could not find plant ID!');
  plantID= '';
end

%%


