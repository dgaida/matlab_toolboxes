%% numerics.conSetOfPoints.private.getValidSetOfPoints
% Get a population which holds the constraints
%
function [obj]= getValidSetOfPoints(obj, varargin)
%% Release: 1.4

%%

error( nargchk(1, 6, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% read out varargin

if nargin >= 2 && ~isempty(varargin{1}) 
  solverlist= varargin{1}; 
  
  checkArgument(solverlist, 'solverlist', 'cellstr', '2nd');
else
  solverlist= {'CMAES'};%{'PS', 'ISRES', 'GA'}; 
end

if nargin >= 3 && ~isempty(varargin{2})
  parallel= varargin{2}; 
  
  validatestring(parallel, {'none', 'multicore', 'cluster'}, ...
                 mfilename, 'parallel', 3);
else
  parallel= 'none'; 
end

if nargin >= 4 && ~isempty(varargin{3})
  nWorker= varargin{3}; 
  
  validateattributes(nWorker, {'double'}, {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'nWorker', 4);
else
  nWorker= 2; 
end

if nargin >= 5 && ~isempty(varargin{4})
  dispValidBounds= varargin{4};
  
  is0or1(dispValidBounds, 'dispValidBounds', 5);
else
  dispValidBounds= 0;
end

if nargin >= 6 && ~isempty(varargin{5}),
  plotnonlcon= varargin{5}; 
  
  is0or1(plotnonlcon, 'plotnonlcon', 6);
else
  plotnonlcon= 0; 
end


%%
% since the whole population is regarded as one individual to be able to
% measure the volume spanned up by the points, which has to be maximized,
% the linear inequality constraints are reproduced
if ~isempty(obj.conA) && obj.nRows > 0
    
  Acell= cell(1, obj.nRows);

  for ii= 1:obj.nRows
    Acell{1,ii}= obj.conA;
  end

  A= blkdiag( Acell{:} );

  b= repmat(obj.conb, obj.nRows, 1);

else

  A= [];
  b= [];

end


%%

if ~isempty(obj.conAeq)

  % normally it has to be empty
  warning('conAeq:notEmpty', 'obj.conAeq is not empty');

  Aeqcell= cell(1, obj.nRows);

  for ii= 1:obj.nRows
    Aeqcell{1,ii}= obj.conAeq;
  end

  Aeq= blkdiag( Aeqcell{:} );

  beq= repmat(obj.conbeq, obj.nRows, 1);

else

  Aeq= [];
  beq= [];

end


%%
% reproducing the bounds, too

LB= repmat(obj.conLB, 1, obj.nRows);

UB= repmat(obj.conUB, 1, obj.nRows);


%%
 
ObjectiveFunction= @(u)fitnessSatisfyContraints(obj, u, obj.nRows, ...
                          A, b, obj.nonlcon);%, obj.Aeq, obj.beq);


%%

fitness= Inf;
iteration= 0;

fitnesslimit= 0;

nvars= obj.conDim * obj.nRows;

%%

while(~isempty(fitness) && fitness > fitnesslimit && ...
       iteration < numel(solverlist))

  %%

  iteration= iteration + 1;

  %%

  solver= char(solverlist(iteration));

  %%
  %

  disp(['Starting the optimization problem to get a valid ', ...
        'population satisfying the constraints using method ', ...
        solver, '!']);

  %% TODO - teilweise OK
  % create initial population, respectively initial set of points, using
  % StartPopulationKriging using latin hypercube sampling (lhSampling.m).
  % then the points are already spaced ok, then they are changed such that
  % they meet the constraints. For further information see TODOs inside
  % StartPopulationKriging.m. 
  
  %% TODO - teilweise OK
  % mit obj.data wird noch nichts gemacht
  % data which is used as e.g. initial population for the to
  % be solved optimization problem that the data should satisfy the
  % constraints. the rows in |data| satisfying the constraints already are
  % not changed, the data not yet satisfying the constraints are
  % changed as wanted
  %
  
  %%
  %

  switch solver

    %%

    case {'ISRES', 'PSO', 'GA', 'CMAES', 'DE'}

      popSize= setPopSize(UB(:) - LB(:), 5000);
      popSize= min(popSize, 2*nvars);

      noGenerations= round(popSize)*2;

      if isempty(obj.data)
%         u0= ones(popSize, nvars) * diag( LB(:) ) + ...
%             rand(popSize, nvars) * diag( UB(:) - LB(:) );
          
        u0= lhSampling(popSize, nvars, LB(:)', UB(:)');
      else
        u0= obj.data(1:popSize,:);
      end

      %%

      if iteration >= 2
        if exist('population', 'var')
            popPart= min(round(size(population,1)/1.5), popSize);

            u0(1:popPart,:)= population(1:popPart,:);
        else
            u0(1,:)= u;
        end
      end

      %%

      if strcmp(solver, 'ISRES')

        [u, fitness, Gm, population]= ...
              startISRES( ObjectiveFunction, LB, UB, u0, popSize, ...
                   noGenerations, parallel, nWorker );%, fitnesslimit );

      elseif strcmp(solver, 'PSO')

        [u, fitness]= ...
              startPSO( ObjectiveFunction, nvars, LB, UB, u0, ...
                  popSize, noGenerations, [], 1e-50, parallel, ...
                  nWorker, fitnesslimit );

      elseif strcmp(solver, 'GA')

        %% TODO
        [u, fitness, exitflag, output, population]= ...
          startGA( ObjectiveFunction, nvars, LB, UB, u0, popSize, ...
            noGenerations, [], [], [], [], Aeq, beq, parallel, ...
            nWorker ); % TODO: can i also pass fitnesslimit???, fitnesslimit );

      elseif strcmp(solver, 'CMAES')

        if popSize > 60
            popSize= min(round(popSize / 2), 200);
        end

        noGenerations= 35;

        [u, fitness, test, exitflag, population]= ...
          startCMAES( ObjectiveFunction, u0, ...%(1,:), 
            LB, UB, ...
            ...[], 
            popSize, noGenerations, parallel, nWorker );

      elseif strcmp(solver, 'DE')

        if popSize > 60
            popSize= min(round(popSize / 2), 200);
        end

        noGenerations= min(popSize, 100);

        [u, fitness, test, population]= ...
          startDE( ObjectiveFunction, nvars, LB, UB, ...
              u0, popSize, noGenerations, parallel, nWorker );

      else

        error('Not implemented: %s!', solver);

      end

    %%

    case {'PS', 'SA'}
    %case 'SA' % Simulated Annealing

    %% TODO:
    % why is this different, then the command above: line 164
      if isempty(obj.data)
%         u0= ones(obj.nRows, obj.conDim) * diag( obj.conLB ) + ...
%             rand(obj.nRows, obj.conDim) * diag( obj.conUB - obj.conLB );
          
        u0= lhSampling(obj.nRows, obj.conDim, obj.conLB(:)', obj.conUB(:)');
      else
        u0= obj.data(1:obj.nRows,:);
      end
      
      u0= u0';
      u0= u0(:)';

      %%

      maxIter= min( max(3*numel(u0), 750), 2000 );

      %%

      if iteration >= 2
        u0(1,:)= u;
      end

      %%

      if strcmp(solver, 'PS')

        searchMethod= [];

        [u, fitness, exitflag, output]= ...
          startPatternSearch( ObjectiveFunction, u0, LB, UB, ...
               maxIter, [], 10^-10, [], [], ...
               Aeq, beq, parallel, nWorker, searchMethod);%, ...
               %fitnesslimit );

      elseif strcmp(solver, 'SA')

        [u, fitness, exitflag, output]= ...
          startSimulAnnealing( ObjectiveFunction, u0, LB, UB, ...
               maxIter, [], 10^-10, fitnesslimit );

      else

        error('Not implemented: %s!', solver);

      end

  end % end switch

end % end while


%%

if ~isempty(u)
  obj.conData= reshape(u, obj.conDim, obj.nRows)';         
else
  obj.conData= [];
end


%%

if ~isempty(obj.conData)
    
  obj.data= validateSetForConstraints(obj, dispValidBounds, plotnonlcon);

else

  obj.data= [];
    
end
                 
%%                    


