%% biogasM.optimization.popSubstrate
% Definition of a population for the substrate mix where each individual is
% bounded and constrained to (non-)linear (in-)equality constraints.
%
classdef popSubstrate < optimization.conPopulation
%% Release: 1.4

  %% Properties (private)
  properties (SetAccess= private)

    % substrate inequalities in the form as in the file with the same
    % name
    substrate_ineq

    % substrate equalities in the form as in the file with the same
    % name
    substrate_eq

    % substrate lower boundaries in the form as in the file with the 
    % same name
    substrate_network_min

    % substrate upper boundaries in the form as in the file with the 
    % same name
    substrate_network_max

    % lenGenom double scalar
    lenGenom

  end % Properties (private)



  %% Methods (public)
  methods (Access= public)

    %%
    % Standard Constructor
    %
    % @param lenVector : length of the individual in the population
    % @param popSize : number of individuals in the population
    % 
    function obj= popSubstrate(varargin)

      %% 
      % read out varargin

      if nargin >= 1, lenVector= varargin{1}; else lenVector= 0; end;
      if nargin >= 2, popSize= varargin{2}; else popSize= 0; end;

      if nargin >= 3
        l_substrate_ineq= varargin{3};

        checkArgument(l_substrate_ineq, 'l_substrate_ineq', 'double', '3rd');
        
        if ~isempty(l_substrate_ineq)
            A= l_substrate_ineq(:,1:end - 1);
            b= l_substrate_ineq(:,end);
        else
            A= [];
            b= [];
        end
      else
        A= [];
        b= [];
        l_substrate_ineq= [];
      end

      if nargin >= 4
        l_substrate_eq= varargin{4};
        
        checkArgument(l_substrate_eq, 'l_substrate_eq', 'double', '4th');

        if ~isempty(l_substrate_eq)
            Aeq= l_substrate_eq(:,1:end - 1);
            beq= l_substrate_eq(:,end);
        else
            Aeq= [];
            beq= [];
        end
      else
        Aeq= [];
        beq= [];
        l_substrate_eq= [];
      end

      if nargin >= 5
          l_substrate_network_min= varargin{5}; 
          
          checkArgument(l_substrate_network_min, 'l_substrate_network_min', 'double', 5);
      else
          l_substrate_network_min= [];
      end

      if nargin >= 6
          l_substrate_network_max= varargin{6};
          
          checkArgument(l_substrate_network_max, 'l_substrate_network_max', 'double', 6);
      else
          l_substrate_network_max= [];
      end

      LB= l_substrate_network_min(:)';
      UB= l_substrate_network_max(:)';


      %%

      obj= obj@optimization.conPopulation(lenVector, popSize, ...
                A, b, Aeq, beq, LB, UB, ...
                  varargin{7:end});

      %%

      obj.substrate_ineq= l_substrate_ineq;
      obj.substrate_eq= l_substrate_eq;
      obj.substrate_network_min= l_substrate_network_min;
      obj.substrate_network_max= l_substrate_network_max;

      %%

      if nargin >= 13 && ~isempty(varargin{13})
          obj.lenGenom= varargin{13};
      else
          obj.lenGenom= 1;
      end

    end

  end % end Methods (public)



  %% Methods (private)
  methods (Access= private)



  end % end Methods (private)

end % end class

%%


