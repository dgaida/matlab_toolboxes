%% biogasM.optimization.popBiogas.checkIndividualForConstraints
% Checks an indivdual for constraints
%
function isvalid= checkIndividualForConstraints(popBiogas, u)
%% Release: 1.8

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

validateattributes(u, {'double'}, {'2d'}, mfilename, 'individual',  1);

%%
%

fitness= 0;

%%
% check for nonlinear constraints

fitness= fitness + popBiogas.getFitnessNonlconFromIndividual(u);


%%
% check for linear inequality constraints

fitness= fitness + popBiogas.getFitnessAFromIndividual(u);

% there is no need to check for linear equality constraints, because
% they are eliminated in popBiogas through linear transformation


%%
% OK - check for LB and UB

LB_individual= getconLB(popBiogas.conObj);
UB_individual= getconUB(popBiogas.conObj);

fitness= fitness + any( u < LB_individual ) * 10;

fitness= fitness + any( u > UB_individual ) * 10;


%%
%

if (fitness == 0)
  isvalid= 1;
else
  isvalid= 0;
end

%%


