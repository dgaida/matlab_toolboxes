%% convertStateEstimateToDefaultUnits
% Convert vector of state estimate to default measurements
%
function x_hat_new= convertStateEstimateToDefaultUnits(x_hat, varargin)
%% Release: 1.4

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  goal_variables= varargin{1};
  checkArgument(goal_variables, 'goal_variables', 'cellstr', '2nd');
else
  goal_variables= load_file('adm1_state_abbrv');
end

%%

validateattributes(x_hat, {'double'}, {'2d'}, mfilename, 'x_hat', 1);


%%

% x_hat is measured in default measurement units
x_hat_new= zeros(size(x_hat));
  
for idigester= 1:size(x_hat, 2)

  for iel= 1:numel( x_hat(:,idigester) )
    % last - 1 param given is fromUnit
    % converts to units which are used by ADM1, thus kgCOD/m^3, ...
    x_hat_new(iel,idigester)= ...
          getVectorOutOfStream(x_hat(:,idigester), goal_variables{iel}, [], [], [], ...
                        getDefaultMeasurementUnit(goal_variables{iel}), ...
                        char(biogas.ADMstate.getUnitOfADMstatevariable(iel)));
  end

end

%%


