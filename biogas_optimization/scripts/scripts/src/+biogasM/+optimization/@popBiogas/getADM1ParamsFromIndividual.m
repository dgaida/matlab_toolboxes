%% biogas.optimization.popBiogas.getADM1ParamsFromIndividual
% Create the ADM1 parameter struct out of an individual.
%
function adm1_params= getADM1ParamsFromIndividual(obj, u, plant)
%% Release: 1.5

%%
% check inputs

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

validateattributes(u, {'double'}, {'2d'}, mfilename, 'individual',  1);

checkArgument(plant, 'plant', 'biogas.plant', '2nd');

%%
% get individual in full dimension, d.h. die zahlen im individuum
% entsprechen exakt der physik, ohne skalierung oder ähnliches
%

u= getPointsInFullDimension(obj.conObj, u);

u_params= u( min( obj.pop_substrate.nCols + 1 + ...
                  obj.pop_plant.nCols + ...
                  obj.pop_state.nCols , size(u, 2) ) : end );

%%

adm1_params= struct;

%%

params_network_min= obj.pop_params.params_network_min;
params_network_max= obj.pop_params.params_network_max;

n_params= size(params_network_min, 1);
n_fermenter= plant.getNumDigestersD();

%

[dummy, paramsNetworkMask]= ...
            getIndividualByMask( obj, [], ...
                                 obj.pop_params.params_ineq(:, 1:end - 1), ...
                                 obj.pop_params.params_eq(:, 1:end - 1), ...
                                 params_network_min, params_network_max );   
                             
%

paramsNetworkMask= ...
                reshape(paramsNetworkMask, n_params, n_fermenter);

%%

% index in the individual vector u
i_individual= 1;

%%

for ifermenter= 1:n_fermenter
   
  fermenter_id= char( plant.getDigesterID(ifermenter) );

  for iparam= 1:n_params

    if paramsNetworkMask(iparam, ifermenter)
      adm1_params.(fermenter_id)(iparam,1)= u_params(1, i_individual);

      i_individual= i_individual + 1;
    else
      adm1_params.(fermenter_id)(iparam,1)= ...
                   params_network_min(iparam, ifermenter);
    end

  end
        
end
           

%%


