%% biogas.optimization.popBiogas
% Definition of a population used for biogas plant optimization, where each
% individual is bounded and constrained to (non-)linear (in-)equality
% constraints. 
%
classdef popBiogas < optimization.conPopulation
%% Release: 1.0

  %% Properties (private)
  properties (SetAccess= private)

    % object of biogas.optimization.popSubstrate
    pop_substrate;

    % object of biogas.optimization.popPlantNetwork
    pop_plant;

    % object of biogas.optimization.popState
    pop_state;

    % object of biogas.optimization.popParams
    pop_params;

  end % Properties (private)



  %% Methods (public)
  methods (Access= public)

    %%
    % Standard Constructor
    %
    % @param lenIndividual : length of the individual in the population
    % @param popSize : number of individuals in the population
    % 
    function obj= popBiogas(varargin)

      %%
      
      error( nargchk(0, 23, nargin, 'struct') );
      error( nargoutchk(0, 1, nargout, 'struct') );
      
      %%

      if nargin >= 1, pop_size= varargin{1}; else pop_size= 0; end;

      pop_size= pop_size(:);

      %%

      if nargin >= 2
          substrate_network_min= varargin{2};
      else
          substrate_network_min= []; 
      end

      if nargin >= 3
          substrate_network_max= varargin{3};
      else
          substrate_network_max= []; 
      end

      %%

      if nargin >= 4
          plant_network_min= varargin{4};
      else
          plant_network_min= []; 
      end

      if nargin >= 5
          plant_network_max= varargin{5};
      else
          plant_network_max= []; 
      end

      %%

      if nargin >= 6
          digester_state_min= varargin{6};
      else
          digester_state_min= []; 
      end

      if nargin >= 7
          digester_state_max= varargin{7};
      else
          digester_state_max= []; 
      end

      %%

      if nargin >= 8
          params_min= varargin{8};
      else
          params_min= []; 
      end

      if nargin >= 9
          params_max= varargin{9};
      else
          params_max= []; 
      end

      %%

      if nargin >= 10
          substrate_ineq= varargin{10};
      else
          substrate_ineq= []; 
      end

      if nargin >= 11
          substrate_eq= varargin{11};
      else
          substrate_eq= []; 
      end

      if nargin >= 12
          nonlcon_substrate= varargin{12};

          if ~isempty(nonlcon_substrate) && ...
               nargin(nonlcon_substrate) == 2
              nonlcon_substrate= feval(nonlcon_substrate, obj);
          end
      else
          nonlcon_substrate= []; 
      end

      %%

      if nargin >= 13
          plant_ineq= varargin{13};
      else
          plant_ineq= []; 
      end

      if nargin >= 14
          plant_eq= varargin{14};
      else
          plant_eq= []; 
      end

      if nargin >= 15
          nonlcon_plant= varargin{15};
      else
          nonlcon_plant= []; 
      end

      %%

      if nargin >= 16
          state_ineq= varargin{16};
      else
          state_ineq= []; 
      end

      if nargin >= 17
          state_eq= varargin{17};
      else
          state_eq= []; 
      end

      if nargin >= 18
          nonlcon_state= varargin{18};
      else
          nonlcon_state= []; 
      end

      %%

      if nargin >= 19
          nonlcon_params= varargin{19};
      else
          nonlcon_params= []; 
      end

      %%

      if nargin >= 20 && ~isempty(varargin{20})
          parallel= varargin{20};
      else
          parallel= 'none'; 
      end

      if ~ischar(parallel) && ~iscell(parallel)
        error(['The parameter parallel must be a char or a cell, ', ...
               'but is a %s!'], class(parallel));
      end

      parallel= char(parallel);

      %%

      if nargin >= 21 && ~isempty(varargin{21})
          nWorker= varargin{21};
      else
          nWorker= 2; 
      end

      %% TODO
      % data


      %%
      % lenGenom

      if nargin >= 23 && ~isempty(varargin{23})
          lenGenom= varargin{23};
      else
          lenGenom= 1; 
      end


      %%
      % Creating the object for the substrates

      nvars_substrate= numel(substrate_network_min);

      %%
      %

      disp('Creating the object for the substrates!');

      %%

      [obj.pop_substrate]= ...
          biogasM.optimization.popSubstrate(nvars_substrate, pop_size(1), ...
                      substrate_ineq, ...
                      substrate_eq, ...
                      substrate_network_min, ...
                      substrate_network_max, ...
                    nonlcon_substrate, ...
                      {'PS', 'CMAES'}, ..., 'ISRES'}, ...
                      {'CMAES', 'DE', 'PS'}, ..., PS 'ISRES'}, ... GA
                      parallel, nWorker, [], lenGenom);


      %%
      % Creating the object for the fermenter flux

      nvars_plant= numel(plant_network_min);    

      if numel(pop_size) >= 2
          popSizePlant= pop_size(2,1);

          if popSizePlant == 0
              popSizePlant= pop_size(1,1);
          elseif popSizePlant < 0
              error('popSizePlant < 0 : %i', popSizePlant);
          end
      else
          popSizePlant= pop_size;
      end

      %%
      %

      disp('Creating the object for the fermenter flux!');

      %%

      [obj.pop_plant]= ...
          biogasM.optimization.popPlantNetwork(nvars_plant, popSizePlant, ...
                              plant_ineq, ...
                              plant_eq, ...
                              plant_network_min, ...
                              plant_network_max, ...
                              nonlcon_plant, ...
                              {'PS'}, {'GA', 'ISRES'}, ...
                              parallel, nWorker);


      %%
      % Creating the object for the fermenter states

      nvars_state= numel(digester_state_min);                     

      if numel(pop_size) >= 2
          if numel(pop_size) >= 3
              popSizeState= pop_size(3,1);

              if popSizeState == 0
                  popSizeState= pop_size(2,1);
              elseif popSizeState == -1
                  popSizeState= pop_size(1,1);
              elseif popSizeState < -1
                  error('popSizeState < -1 : %i', popSizeState);
              end

              if popSizeState == 0
                  popSizeState= pop_size(1,1);

                  if popSizeState == 0
                     error('popSizeState == 0'); 
                  end
              end
          else
              error('numel(pop_size)= 2');
          end
      else
          popSizeState= pop_size;
      end

      %%
      %

      disp('Creating the object for the fermenter states!');

      %%

      [obj.pop_state]= ...
          biogasM.optimization.popState(nvars_state, popSizeState, ...
                        state_ineq, ...
                          state_eq, ...
                        digester_state_min, ...
                        digester_state_max, ...
                        nonlcon_state, ...
                          {'PS', 'CMAES', 'PSO', 'PS'}, ...
                          {'PSO', 'CMAES', 'DE', 'PS'}, ...
                          parallel, nWorker);


      %%
      % Creating the object for the ADM1 parameters

      nvars_params= numel(params_min);                     

      if numel(pop_size) >= 2
          if numel(pop_size) >= 4
              popSizeParams= pop_size(4,1);

              if popSizeParams == 0
                  popSizeParams= pop_size(3,1);
              elseif popSizeParams == -1 || popSizeParams == -2
                  popSizeParams= pop_size(3 - popSizeParams,1);
              elseif popSizeParams < -2
                  error('popSizeState < -2 : %i', popSizeParams);
              end

              if popSizeParams == 0
                  popSizeParams= pop_size(1,1);

                  if popSizeParams == 0
                     error('popSizeParams == 0'); 
                  end
              end
          else
              error('numel(pop_size) <= 3 : %i', numel(pop_size));
          end
      else
          popSizeParams= pop_size;
      end

      %%
      %

      disp('Creating the object for the ADM1 parameters!');

      %%

      [obj.pop_params]= ...
          biogasM.optimization.popParameters(nvars_params, popSizeParams, ...
                        [], ...
                          [], ...
                        params_min, ...
                        params_max, ...
                        nonlcon_params, ...
                          {'PS', 'CMAES', 'PSO', 'PS'}, ...
                          {'PSO', 'CMAES', 'DE', 'PS'}, ...
                          parallel, nWorker);


      %%
      %

      if obj.pop_substrate.nCols == 0
          pop_size(1)= 0;
      end

      if obj.pop_plant.nCols == 0
          popSizePlant= 0;

          if numel(pop_size) >= 2
              pop_size(2)= 0;
          end
      end

      if obj.pop_state.nCols == 0
          popSizeState= 0;

          if numel(pop_size) >= 3
              pop_size(3)= 0;
          end
      end

      if obj.pop_params.nCols == 0
          popSizeParams= 0;

          if numel(pop_size) >= 4
              pop_size(4)= 0;
          end
      end


      %%
      % set constrained object

      A_substrate= obj.pop_substrate.conObj.conA;
      A_plant=     obj.pop_plant.conObj.conA;
      A_state=     obj.pop_state.conObj.conA;
      A_params=    obj.pop_params.conObj.conA;

      conA= setSizeOfLinEq(obj, A_substrate, A_plant, ...
                           A_state, A_params);

      %%

      Aeq_substrate= obj.pop_substrate.conObj.conAeq;
      Aeq_plant=     obj.pop_plant.conObj.conAeq;
      Aeq_state=     obj.pop_state.conObj.conAeq;
      Aeq_params=    obj.pop_params.conObj.conAeq;

      conAeq= setSizeOfLinEq(obj, Aeq_substrate, Aeq_plant, ...
                             Aeq_state, Aeq_params);

      if numel(conAeq) == 0
          conAeq= [];
      end

      %%

      A_substrate= obj.pop_substrate.conObj.A;
      A_plant=     obj.pop_plant.conObj.A;
      A_state=     obj.pop_state.conObj.A;
      A_params=    obj.pop_params.conObj.A;

      A= setSizeOfLinEq(obj, A_substrate, A_plant, A_state, ...
                        A_params, 0);

      %%

      Aeq_substrate= obj.pop_substrate.conObj.Aeq;
      Aeq_plant=     obj.pop_plant.conObj.Aeq;
      Aeq_state=     obj.pop_state.conObj.Aeq;
      Aeq_params=    obj.pop_params.conObj.Aeq;

      Aeq= setSizeOfLinEq(obj, Aeq_substrate, Aeq_plant, ...
                          Aeq_state, Aeq_params, 0);

      %%

      C_substrate= obj.pop_substrate.conObj.C;
      C_plant=     obj.pop_plant.conObj.C;
      C_state=     obj.pop_state.conObj.C;
      C_params=    obj.pop_params.conObj.C;

      C= setSizeOfLinEq(obj, C_substrate, C_plant, C_state, C_params);
      C= C(1:min(size(C)), 1:min(size(C)));

      %%

      Cinv_substrate= obj.pop_substrate.conObj.Cinv;
      Cinv_plant=     obj.pop_plant.conObj.Cinv;
      Cinv_state=     obj.pop_state.conObj.Cinv;
      Cinv_params=    obj.pop_params.conObj.Cinv;

      Cinv= setSizeOfLinEq(obj, Cinv_substrate, Cinv_plant, ...
                           Cinv_state, Cinv_params);
      Cinv= Cinv(1:min(size(Cinv)), 1:min(size(Cinv)));

      %%

      if numel(pop_size) >= 4

          popData= concatData(pop_size, ...
                          obj.pop_substrate.conObj.conData, ...
                          obj.pop_plant.conObj.conData, ...
                          obj.pop_state.conObj.conData, ...
                          obj.pop_params.conObj.conData, ...
                          popSizePlant, popSizeState, ...
                          popSizeParams);

      else

          popData= [obj.pop_substrate.conObj.conData, ...
                      obj.pop_plant.conObj.conData, ...
                      obj.pop_state.conObj.conData, ...
                      obj.pop_params.conObj.conData];

      end

      %%

      conLB= [obj.pop_substrate.conObj.conLB, ...
                      obj.pop_plant.conObj.conLB, ...
                      obj.pop_state.conObj.conLB, ...
                      obj.pop_params.conObj.conLB];

      conUB= [obj.pop_substrate.conObj.conUB, ...
                      obj.pop_plant.conObj.conUB, ...
                      obj.pop_state.conObj.conUB, ...
                      obj.pop_params.conObj.conUB];            

      beq= [obj.pop_substrate.conObj.beq; ...
                      obj.pop_plant.conObj.beq; ...
                      obj.pop_state.conObj.beq; ...
                      obj.pop_params.conObj.beq];

      LB= [obj.pop_substrate.conObj.LB, ...
                      obj.pop_plant.conObj.LB, ...
                      obj.pop_state.conObj.LB, ...
                      obj.pop_params.conObj.LB];

      UB= [obj.pop_substrate.conObj.UB, ...
                      obj.pop_plant.conObj.UB, ...
                      obj.pop_state.conObj.UB, ...
                      obj.pop_params.conObj.UB];


      %%

      conDim= obj.pop_substrate.conObj.conDim + ...
              obj.pop_plant.conObj.conDim + ...
              obj.pop_state.conObj.conDim + ...
              obj.pop_params.conObj.conDim;

      %%

      setParams( obj.conObj, conDim, ...size(popData,2), ...
                      ...
                      size(popData,1), ...
                      ...
                      conLB, ...
                      ...
                      conUB, ...
                      ...
                      conA, ...
                      ...
                     [obj.pop_substrate.conObj.conb; ...
                      obj.pop_plant.conObj.conb; ...
                      obj.pop_state.conObj.conb; ...
                      obj.pop_params.conObj.conb], ...
                      ...
                      conAeq, ...
                      ...
                     [obj.pop_substrate.conObj.conbeq; ...
                      obj.pop_plant.conObj.conbeq; ...
                      obj.pop_state.conObj.conbeq; ...
                      obj.pop_params.conObj.conbeq], ...
                      ...
                     {obj.pop_substrate.nonlcon; ...
                      obj.pop_plant.nonlcon; ...
                      obj.pop_state.nonlcon; ...
                      obj.pop_params.nonlcon}, ...
                      ...
                      popData, ...
                      ...
                      ...calcNullspace(Aeq, conUB - conLB), ...
                      numerics.math.calcNullspace(Aeq), ...
                      ...
                      A, ...
                      ...
                     [obj.pop_substrate.conObj.b; ...
                      obj.pop_plant.conObj.b; ...
                      obj.pop_state.conObj.b; ...
                      obj.pop_params.conObj.b], ...
                      ...
                      Aeq, ...
                      ...
                      beq, ...
                      ...
                      C, ...
                      Cinv, ...
                      ...
                      [obj.pop_substrate.conObj.d; ...
                      obj.pop_plant.conObj.d; ...
                      obj.pop_state.conObj.d; ...
                      obj.pop_params.conObj.d] ...
               );   



      %%
      % set object

      if numel(pop_size) >= 4

          popData= concatData(pop_size, ...
                          obj.pop_substrate.conObj.data, ...
                          obj.pop_plant.conObj.data, ...
                          obj.pop_state.conObj.data, ...
                          obj.pop_params.conObj.data, ...
                          popSizePlant, popSizeState, popSizeParams);

      else

          popData= [obj.pop_substrate.conObj.data, ...
                      obj.pop_plant.conObj.data, ...
                      obj.pop_state.conObj.data, ...
                      obj.pop_params.conObj.data];

      end

      %%

      setParams( obj, conDim, ...size(popData,2), ...%obj.pop_substrate.conObj.conDim + ...
                      ...%obj.pop_plant.conObj.conDim + ...
                      ...%obj.pop_state.conObj.conDim, ...
                      ...
                      size(popData,1), ...
                 ...%min([obj.pop_substrate.nRows, ...
                  ...%    obj.pop_plant.nRows, obj.pop_state.nRows]), ...
                      ...
                      LB, ...
                      ...
                      UB, ...
                      ...
                      A, ...
                      ...
                     [obj.pop_substrate.conObj.b; ...
                      obj.pop_plant.conObj.b; ...
                      obj.pop_state.conObj.b; ...
                      obj.pop_params.conObj.b], ...
                      ...
                      Aeq, ...
                      ...
                     [obj.pop_substrate.conObj.beq; ...
                      obj.pop_plant.conObj.beq; ...
                      obj.pop_state.conObj.beq; ...
                      obj.pop_params.conObj.beq], ...
                      ...
                     {obj.pop_substrate.nonlcon; ...
                      obj.pop_plant.nonlcon; ...
                      obj.pop_state.nonlcon; ...
                      obj.pop_params.nonlcon}, ...
                      ...
                      popData, ...
                      ...
                 max([obj.pop_substrate.fitness, ...
                      obj.pop_plant.fitness, ...
                      obj.pop_state.fitness, ...
                      obj.pop_params.fitness]) ...
               );   

      %%

    end


  end % end Methods (public)



  %% Methods (private)
  methods (Access= private)



  end % end Methods (private)

end % end class

%%


