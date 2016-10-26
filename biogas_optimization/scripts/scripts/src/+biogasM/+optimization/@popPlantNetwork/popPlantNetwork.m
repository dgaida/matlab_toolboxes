%% biogasM.optimization.popPlantNetwork
% Definition of a population for the digesters flux in between where each
% individual is bounded and constrained to (non-)linear (in-)equality
% constraints. 
%
classdef popPlantNetwork < optimization.conPopulation
%% Release: 1.4

  %% Properties (private)
  %
  properties (SetAccess= private)

    % plant flux inequalities in the form as in the file with the same
    % name
    plant_ineq

    % plant flux equalities in the form as in the file with the same
    % name
    plant_eq

    % plant flux lower boundaries in the form as in the file with the 
    % same name
    plant_network_min

    % plant flux upper boundaries in the form as in the file with the 
    % same name
    plant_network_max

  end % Properties (private)



  %% Methods (public)
  %
  methods (Access= public)

    %%
    % Standard Constructor
    %
    % @param lenIndividual : length of the individual in the population
    % @param popSize : number of individuals in the population
    % 
    function obj= popPlantNetwork(varargin)

      %% 
      % read out varargin

      if nargin >= 1, lenVector= varargin{1}; else lenVector= 0; end;
      if nargin >= 2, popSize= varargin{2}; else popSize= 0; end;

      if nargin >= 3
        l_plant_ineq= varargin{3};

        checkArgument(l_plant_ineq, 'l_plant_ineq', 'double', '3rd');
        
        if ~isempty(l_plant_ineq)
            A= l_plant_ineq(:,1:end - 1);
            b= l_plant_ineq(:,end);
        else
            A= [];
            b= [];
        end
      else
        A= [];
        b= [];
        l_plant_ineq= [];
      end

      if nargin >= 4
        l_plant_eq= varargin{4};

        checkArgument(l_plant_eq, 'l_plant_eq', 'double', '4th');
        
        if ~isempty(l_plant_eq)
            Aeq= l_plant_eq(:,1:end - 1);
            beq= l_plant_eq(:,end);
        else
            Aeq= [];
            beq= [];
        end
      else
        Aeq= [];
        beq= [];
        l_plant_eq= [];
      end

      if nargin >= 5
          l_plant_network_min= varargin{5};
          
          checkArgument(l_plant_network_min, 'l_plant_network_min', 'double', 5);
      else
          l_plant_network_min= [];
      end

      if nargin >= 6
          l_plant_network_max= varargin{6};
          
          checkArgument(l_plant_network_max, 'l_plant_network_max', 'double', 6);
      else
          l_plant_network_max= []; 
      end

      LB= l_plant_network_min(:)';
      UB= l_plant_network_max(:)';

      %%

      obj= obj@optimization.conPopulation(lenVector, popSize, ...
                              A, b, Aeq, beq, LB, UB, ...
                              varargin{7:end});

      %%

      obj.plant_ineq= l_plant_ineq;
      obj.plant_eq= l_plant_eq;
      obj.plant_network_min= l_plant_network_min;
      obj.plant_network_max= l_plant_network_max;

    end

  end % end Methods (public)



  %% Methods (private)
  %
  methods (Access= private)



  end % end Methods (private)

end % end class

%%


