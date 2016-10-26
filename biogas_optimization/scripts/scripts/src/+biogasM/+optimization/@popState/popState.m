%% biogas.optimization.popState
% Definition of a population for the digesters state where each individual
% is bounded and constrained to (non-)linear (in-)equality constraints.
%
classdef popState < optimization.conPopulation
%% Release: 1.4

  %% Properties (private)
  %
  properties (SetAccess= private)

    % digester state inequalities in the form as in the file with the same
    % name
    state_ineq

    % digester state equalities in the form as in the file with the same
    % name
    state_eq

    % digester state lower boundaries in the form as in the file with the 
    % same name
    digester_state_min

    % digester state upper boundaries in the form as in the file with the 
    % same name
    digester_state_max

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
    function obj= popState(varargin)

      %% 
      % read out varargin

      if nargin >= 1, lenVector= varargin{1}; else lenVector= 0; end;
      if nargin >= 2, popSize= varargin{2}; else popSize= 0; end;

      if nargin >= 3
        l_state_ineq= varargin{3};

        checkArgument(l_state_ineq, 'l_state_ineq', 'double', '3rd');
        
        if ~isempty(l_state_ineq)
            A= l_state_ineq(:,1:end - 1);
            b= l_state_ineq(:,end);
        else
            A= [];
            b= [];
        end
      else
        A= [];
        b= [];
        l_state_ineq= [];
      end

      if nargin >= 4
        l_state_eq= varargin{4};

        checkArgument(l_state_eq, 'l_state_eq', 'double', '4th');
        
        if ~isempty(l_state_eq)
            Aeq= l_state_eq(:,1:end - 1);
            beq= l_state_eq(:,end);
        else
            Aeq= [];
            beq= [];
        end
      else
        Aeq= [];
        beq= [];
        l_state_eq= [];
      end

      if nargin >= 5
          l_digester_state_min= varargin{5};
          
          checkArgument(l_digester_state_min, 'l_digester_state_min', 'double', 5);
      else
          l_digester_state_min= [];
      end

      if nargin >= 6
          l_digester_state_max= varargin{6};
          
          checkArgument(l_digester_state_max, 'l_digester_state_max', 'double', 6);
      else
          l_digester_state_max= [];
      end

      LB= l_digester_state_min(:)';
      UB= l_digester_state_max(:)';

      %%

      obj= obj@optimization.conPopulation(lenVector, popSize, ...
                              A, b, Aeq, beq, LB, UB, ...
                              varargin{7:end});

      %%

      obj.state_ineq= l_state_ineq;
      obj.state_eq= l_state_eq;
      obj.digester_state_min= l_digester_state_min;
      obj.digester_state_max= l_digester_state_max;

    end

  end % end Methods (public)



  %% Methods (private)
  %
  methods (Access= private)



  end % end Methods (private)

end % end class

%%


