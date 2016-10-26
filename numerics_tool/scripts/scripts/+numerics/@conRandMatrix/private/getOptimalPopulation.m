%% numerics.conRandMatrix.private.getOptimalPopulation
% Get a population which holds the constraints and which has the defined
% distribution.
%
function [conRandMatrix, obj]= ...
            getOptimalPopulation(conObj, conRandMatrix, varargin)
%% Release: 1.3

%%

error( nargchk(2, 8, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% read out varargin

checkArgument(conObj, 'conObj', 'numerics.conSetOfPoints', 1);
checkArgument(conRandMatrix, 'conRandMatrix', 'numerics.conRandMatrix', 2);

if nargin >= 3 && ~isempty(varargin{1})
  solverlist= varargin{1}; 
  
  if ~iscellstr(solverlist) && ~ischar(solverlist)
    error('The 3rd argument solverlist must either be a char or a cellstr, but is a %s!', ...
      class(solverlist));
  end
else
  solverlist= {'CMAES'};%{'PS', 'ISRES', 'GA'}; 
end


%% TODO
% nur für christian
useLHS= 1;

if (useLHS)
  solverlist= [];
end


%%

if nargin >= 4 && ~isempty(varargin{2}), 
  fh= varargin{2}; 
  
  checkArgument(fh, 'fh', 'function_handle', 4);
else
  fh= @huniform; 
end

if nargin >= 5 && ~isempty(varargin{3})
  parallel= char(varargin{3}); 

  validatestring(parallel, {'none', 'multicore', 'cluster'}, ...
                 mfilename, 'parallel', 5);
else
  parallel= 'none'; 
end

if nargin >= 6 && ~isempty(varargin{4})
  nWorker= varargin{4}; 

  validateattributes(nWorker, {'double'}, {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'nWorker', 6);
else
  nWorker= 2; 
end

if nargin >= 7 && ~isempty(varargin{5})
  dispValidBounds= varargin{5};
  
  is0or1(dispValidBounds, 'dispValidBounds', 7);
else
  dispValidBounds= 0;
end

if nargin >= 8 && ~isempty(varargin{6}),
  plotnonlcon= varargin{6}; 
  
  is0or1(plotnonlcon, 'plotnonlcon', 8);
else
  plotnonlcon= 0; 
end


%%

obj= conObj;

nvars= obj.conDim * obj.nRows;


%%

if ~isempty(obj.conA)

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

LB= repmat(obj.conLB, 1, obj.nRows);

UB= repmat(obj.conUB, 1, obj.nRows);


%%

fitness= Inf;
iteration= 0;

fitnesslimit= 0;

%%

while(~isempty(fitness) && fitness > fitnesslimit && ...
                           iteration < numel(solverlist))

  %%

  iteration= iteration + 1;

  %%
  %

  solver= char(solverlist(iteration));

  %%
  %

  disp(['Starting the optimization problem to get the optimal ', ...
        'distributed population using method ', solver, '!']);

  %%

  switch solver

    %%
    
    case {'ISRES', 'PSO', 'GA', 'GA+PS', 'CMAES', 'DE'}
            
        popSize= setPopSize(UB(:) - LB(:), 5000);
        popSize= min(popSize, 2*nvars);

        noGenerations= round(popSize)*2;
            
        u0= ones(popSize, nvars) * diag( LB(:) ) + ...
            rand(popSize, nvars) * diag( UB(:) - LB(:) );

        %%

        u01= obj.conData;
        
        u01= u01';
        u01= u01(:)';
        
        u0(1,:)= u01;
        
        %%
        
        if iteration >= 2
            if exist('population', 'var')
                popPart= round(size(population,1)/1.5);
                
                u0(1:popPart,:)= population(1:popPart,:);
            else
                u0(1,:)= u;
            end
        end

        %%

        if strcmp(solver, 'ISRES')
            
            ObjectiveFunction= selectObjectiveFunction(obj, fh, A, b);
        
            [u, fitness, Gm, population]= ...
                startISRES( ObjectiveFunction, LB, UB, u0, popSize, ...
                noGenerations, parallel, nWorker, fitnesslimit );

        elseif strcmp(solver, 'PSO')
            
            ObjectiveFunction= selectObjectiveFunction(obj, fh, A, b);
        
            [u, fitness]= ...
            startPSO( ObjectiveFunction, nvars, LB, UB, u0, popSize, ...
                 noGenerations, [], 1e-50, parallel, nWorker, ...
                 fitnesslimit );
             
        elseif strcmp(solver, 'GA')
            
            ObjectiveFunction= selectObjectiveFunction(obj, fh);

            [u, fitness, exitflag, output, population]= ...
                startGA( ObjectiveFunction, nvars, LB, UB, u0, popSize, ...
                noGenerations, [], [], A, b, Aeq, beq, parallel, ...
                nWorker, fitnesslimit );
            
            % Could not find a feasible initial point.
            if exitflag == -2
            
                ObjectiveFunction= selectObjectiveFunction(obj, fh, A, b);
    
                [u, fitness, exitflag, output, population]= ...
                startGA( ObjectiveFunction, nvars, LB, UB, u0, popSize, ...
                    noGenerations, [], [], [], [], Aeq, beq, ...
                    parallel, nWorker, fitnesslimit );
            
            end
            
        elseif strcmp(solver, 'GA+PS')
            
            ObjectiveFunction= selectObjectiveFunction(obj, fh);

            [u, fitness, exitflag, output, population]= ...
            startGA_PatternSearch( ObjectiveFunction, nvars, LB, UB, ...
                u0, popSize, noGenerations, ...
                [], [], A, b, Aeq, beq, parallel, nWorker, fitnesslimit );
            
            % Could not find a feasible initial point.
            if exitflag == -2
            
                ObjectiveFunction= selectObjectiveFunction(obj, fh, A, b);
    
                [u, fitness, exitflag, output, population]= ...
              	startGA_PatternSearch( ObjectiveFunction, nvars, LB, UB, ...
                    u0, popSize, 100, [], [], [], [], ...
                    Aeq, beq, parallel, nWorker, fitnesslimit );
             
            end
            
        elseif strcmp(solver, 'CMAES')
            
            ObjectiveFunction= selectObjectiveFunction(obj, fh, A, b);
        
            %%
        
            if popSize > 60
                popSize= min(round(popSize / 2), 200);
            end
                
            noGenerations= 35;
            
            [u, fitness, test, exitflag, population]= ...
            startCMAES( ObjectiveFunction, u0, ...(1,:), 
            LB, UB, ...
                 ...[], 
                 popSize, noGenerations, parallel, nWorker );
             
        elseif strcmp(solver, 'DE')
                
            ObjectiveFunction= selectObjectiveFunction(obj, fh, A, b);
        
            %%
            
            if popSize > 60
                popSize= min(round(popSize / 2), 200);
            end
            
            noGenerations= min(popSize, 100);

            [u, fitness, test, population]= ...
            startDE( ObjectiveFunction, nvars, LB, UB, ...
                u0, popSize, noGenerations, parallel, nWorker );
                
        else
                
            error('Not implemented');
                    
        end
            
    %%
        
    case {'PS', 'SA'}
    %case 'SA' % Simulated Annealing
              
        u0= obj.conData;
        
        u0= u0';
        u0= u0(:)';
                        
        %%
        
        maxIter= min( max(3*numel(u0), 750), 2000 );

        %%

        if iteration >= 2
            u0(1,:)= u;
            
            %break;
        end
        
        %%
        
        if strcmp(solver, 'PS')
             
            %searchMethod= @searchneldermead;
            searchMethod= [];
            
            ObjectiveFunction= selectObjectiveFunction(obj, fh);

            [u, fitness, exitflag, output]= ...
            startPatternSearch( ObjectiveFunction, u0, LB, UB, ...
                 maxIter, [], 10^-10, A, b, ...
                 Aeq, beq, parallel, nWorker, searchMethod, fitnesslimit );
             
            % Could not find a feasible initial point.
            if exitflag == -2
            
                ObjectiveFunction= selectObjectiveFunction(obj, fh, A, b);
    
                [u, fitness, exitflag, output]= ...
                    startPatternSearch( ObjectiveFunction, u0, LB, UB, ...
                    maxIter, [], 10^-10, [], [], Aeq, beq, ...
                    parallel, nWorker, searchMethod, fitnesslimit );
        
            end
            
        elseif strcmp(solver, 'SA')
            
            ObjectiveFunction= selectObjectiveFunction(obj, fh, A, b);
        
            %%
        
            [u, fitness, exitflag, output]= ...
            startSimulAnnealing( ObjectiveFunction, u0, LB, UB, ...
                 maxIter, [], 10^-10 );
            
        else
            
            error('Not implemented');
            
        end
    
    %%
        
    case 'fmincon'
        
        
        
  end % end switch

end % end while


%%

% Could not find a feasible initial point.
% if exitflag == -2 || iteration == 2
% 
%     ObjectiveFunction= selectObjectiveFunction(obj, fh, A, b);
%     
%     fitness= Inf;
%     iteration= 0;
% 
%     while(~isempty(fitness) && fitness >= 1 && iteration < 4)
% 
%         %%
% 
%         if iteration >= 1
%             %solver= 'GA+PS';
%             
%             u0(1,:)= u;
%         end
%         
%         if iteration >= 3
%            
%             solver= 'GA+PS';
%             
%         end
% 
%         iteration= iteration + 1;
% 
%         %%
% 
%         switch solver
% 
%             case 'GA'
% 
%                 %%
% 
%                 [u, fitness, exitflag, output, population]= ...
%                     startGA( ObjectiveFunction, nvars, LB, UB, u0, popSize, ...
%                      100, [], [], [], [], Aeq, beq, 'none', 1 );
% 
% 
%             case 'PS'
% 
%                 %%
% 
%                 maxIter= min( max(3*numel(u0), 1000), 2000 );
% 
%                 [u, fitness, exitflag, output]= ...
%                      startPatternSearch( ObjectiveFunction, u0, LB, UB, ...
%                      maxIter, [], 10^-10, [], [], ...
%                      Aeq, beq, 'none', [], searchMethod );
% 
%                  
%             case 'SA'
% 
%                 %%
% 
%                 maxIter= min( max(3*numel(u0), 1000), 2000 );
% 
%                 [u, fitness, exitflag, output]= ...
%                      startSimulAnnealing( ObjectiveFunction, u0, LB, UB, ...
%                      maxIter, [], 10^-10 );
%                  
% 
%             case 'GA+PS'
% 
%                 %%
% 
%                 [u, fitness, exitflag, output, population]= ...
%                      startGA_PatternSearch( ObjectiveFunction, nvars, LB, UB, ...
%                      u0, popSize, ...
%                      100, [], [], [], [], Aeq, beq, 'none', 1 );
% 
% 
%             case 'fmincon'
% 
% 
%         end
%     
%     end
%     
% end


%% TODO
% nur für Christian, see TODOs inside StartPopulationKriging.m, how to
% solve this issue
%
% if isempty(solverlist)
% 
%   u= StartPopulationKriging('latin hypercube', ...
%                             obj.conDim, obj.nRows, [obj.conLB; obj.conUB]);
% 
%   % ist schon im richtigen format
%   %u= u(:);
% 
% end


%%
% only overwrite conData if new data is generated. else use the data
% generated by numerics.conSetOfPoints. Because there the initial
% population is a latin hypercube sampling, just changed such that the
% bounds are satisfied. 
if ~isempty(solverlist)
    
  if ~isempty(u)
    obj.setConData( reshape(u, obj.conDim, obj.nRows)' );     
  else
    obj.setConData( [] );
  end

end

%%

if ~isempty(obj.conData)

  data= validateSetForConstraints(obj, dispValidBounds, plotnonlcon);

  obj.setData( data );

  conRandMatrix.data= obj.data;%...
      %evalPopulation(obj.conData, obj.conA, obj.conb, ... 
       %      obj.conLB, obj.conUB, obj.nonlcon, conRandMatrix);

end

%%

conRandMatrix.fitness= fitness;
                    
end                    



%%
%
%
function ObjectiveFunction= selectObjectiveFunction(obj, fh, varargin)
                     
  if nargin >= 3, A= varargin{1}; else A= []; end;
  if nargin >= 4, b= varargin{2}; else b= []; end;

  if min(obj.conDim, max(obj.nRows - 1, 1)) == 1

    ObjectiveFunction= ...
        @(u)fitness1dmesh(obj, u, obj.nRows, fh, obj.conLB, obj.conUB, ...
                          obj.nonlcon, ...%obj.Aeq, obj.beq, 
                          A, b);

  elseif obj.conDim == 2

    ObjectiveFunction= ...
        @(u)fitness2dmesh(obj, u, obj.nRows, fh, obj.conLB, obj.conUB, ...
                          obj.nonlcon, ...obj.Aeq, obj.beq, 
                          A, b);

  elseif obj.conDim >= 3

    ObjectiveFunction= ...
        @(u)fitnessndmesh(obj, u, obj.nRows, fh, obj.conLB, obj.conUB, ...
                          obj.nonlcon, ...obj.Aeq, obj.beq, 
                          A, b);

  else
    error('obj.conDim= %i', obj.conDim);
  end

end

%%


