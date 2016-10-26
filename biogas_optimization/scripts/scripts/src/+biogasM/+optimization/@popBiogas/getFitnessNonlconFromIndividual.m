%% biogasM.optimization.popBiogas.getFitnessNonlconFromIndividual
% Get the fitness of the individual with respect to nonlinear constraints.
%
function fitness= getFitnessNonlconFromIndividual(obj, u)
%% Release: 1.8

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

validateattributes(u, {'double'}, {'2d'}, mfilename, 'individual',  1);

%%
% get individual in full dimension

u= getPointsInFullDimension(obj.conObj, u);%, obj.Aeq, obj.beq);


%%
%

nvars= numel(u);

fitness= 0;


%%
%

if nvars >= obj.pop_substrate.nCols && obj.pop_substrate.nCols > 0 && ...
   ~isempty(obj.nonlcon{1,1})
    
  fitness= fitness + sum( max( obj.nonlcon{1,1}(...
                          u(1,1:obj.pop_substrate.nCols)...
                                         ), 0) );
    
end


%%
%

if nvars >= obj.pop_substrate.nCols + 1 && obj.pop_plant.nCols > 0 && ...
   ~isempty(obj.nonlcon{2,1})
    
  fitness= fitness + sum( max( obj.nonlcon{2,1}(...
                  u(1,obj.pop_substrate.nCols + 1:...
                      obj.pop_substrate.nCols + ...
                      obj.pop_plant.nCols)...
                                         ), 0) );
    
end


%%
%

if nvars >= obj.pop_substrate.nCols + 1 + ...
            obj.pop_plant.nCols && obj.pop_state.nCols > 0 && ...
   ~isempty(obj.nonlcon{3,1})
    
  fitness= fitness + sum( max( obj.nonlcon{3,1}(...
                  u(1,obj.pop_substrate.nCols + 1 + ...
                      obj.pop_plant.nCols:...
                      obj.pop_substrate.nCols + ...
                      obj.pop_plant.nCols + ...
                      obj.pop_state.nCols)...
                                         ), 0) );
    
end


%%
%

if nvars >= obj.pop_substrate.nCols + 1 + ...
            obj.pop_plant.nCols + obj.pop_state.nCols && ...
            obj.pop_params.nCols > 0 && ...
   ~isempty(obj.nonlcon{4,1})
    
  fitness= fitness + sum( max( obj.nonlcon{4,1}(...
                  u(1,obj.pop_substrate.nCols + 1 + ...
                      obj.pop_plant.nCols + ...
                      obj.pop_state.nCols:...
                      obj.pop_substrate.nCols + ...
                      obj.pop_plant.nCols + ...
                      obj.pop_state.nCols + ...
                      obj.pop_params.nCols)...
                                         ), 0) );
    
end

%%


