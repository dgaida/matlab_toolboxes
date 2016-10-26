%% biogasM.optimization.popParameters
% Definition of a population for the ADM1 parameters where each individual is
% bounded and constrained to (non-)linear (in-)equality constraints.
%
classdef popParameters < optimization.conPopulation
%% Release: 1.4

  %% Properties (private)
  %
  properties (SetAccess= private)

    % params inequalities in the form as in the file with the same
    % name
    params_ineq

    % params equalities in the form as in the file with the same
    % name
    params_eq

    % params lower boundaries in the form as in the file with the 
    % same name
    params_network_min

    % params upper boundaries in the form as in the file with the 
    % same name
    params_network_max

  end % Properties (private)



  %% Methods (public)
  %
  methods (Access= public)

    %%
    % Standard Constructor
    %
    % @param lenVector : length of the individual in the population
    % @param popSize : number of individuals in the population
    % 
    function obj= popParameters(varargin)

      %% 
      % read out varargin

      if nargin >= 1, lenVector= varargin{1}; else lenVector= 0; end;
      if nargin >= 2, popSize= varargin{2}; else popSize= 0; end;

      if nargin >= 3
        l_params_ineq= varargin{3};
        
        checkArgument(l_params_ineq, 'l_params_ineq', 'double', '3rd');

        if ~isempty(l_params_ineq)
            A= l_params_ineq(:,1:end - 1);
            b= l_params_ineq(:,end);
        else
            A= [];
            b= [];
        end
      else
        A= [];
        b= [];
        l_params_ineq= [];
      end

      if nargin >= 4
        l_params_eq= varargin{4};

        checkArgument(l_params_eq, 'l_params_eq', 'double', '4th');
        
        if ~isempty(l_params_eq)
            Aeq= l_params_eq(:,1:end - 1);
            beq= l_params_eq(:,end);
        else
            Aeq= [];
            beq= [];
        end
      else
        Aeq= [];
        beq= [];
        l_params_eq= [];
      end

      if nargin >= 5
        l_params_network_min= varargin{5}; 
        
        checkArgument(l_params_network_min, 'l_params_network_min', 'double', 5);
      else
        l_params_network_min= [];
      end

      if nargin >= 6
        l_params_network_max= varargin{6};
        
        checkArgument(l_params_network_max, 'l_params_network_max', 'double', 6);
      else
        l_params_network_max= [];
      end

      LB= l_params_network_min(:)';
      UB= l_params_network_max(:)';

      %%

      obj= obj@optimization.conPopulation(lenVector, popSize, ...
                A, b, Aeq, beq, LB, UB, ...
                  varargin{7:end});

      %%

      obj.params_ineq= l_params_ineq;
      obj.params_eq= l_params_eq;
      obj.params_network_min= l_params_network_min;
      obj.params_network_max= l_params_network_max;

    end

  end % end Methods (public)



  %% Methods (private)
  %
  methods (Access= private)



  end % end Methods (private)

end % end class

%%


