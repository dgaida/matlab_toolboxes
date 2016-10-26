%% optimization.conPopulation
% doc optimization.conPopulation
%
% Definition of a population where each individual is bounded and constrained
% to (non-)linear (in-)equality constraints.
%
classdef conPopulation < numerics.conRandMatrix
%% Release: 1.4

  %% Properties (private)
  %
  properties (SetAccess= private)



  end % Properties (private)



  %% Methods (public)
  %
  methods (Access= public)

    %%
    %
    function obj= conPopulation(varargin)
      %
      % Standard Constructor
      %
      
      error( nargchk(0, 17, nargin, 'struct') );
      error( nargoutchk(0, 1, nargout, 'struct') );

      %%
      % @param lenVector : length of the individual in the
      % population 
      % @param popSize : number of individuals in the population
      % 

      if nargin >= 1 && ~isempty(varargin{1})
          lenVector= varargin{1}; 
      else
          lenVector= 0;
      end

      if nargin >= 2 && ~isempty(varargin{2})
          popSize= varargin{2};
      else
          popSize= 0;
      end

      if nargin >= 3
          A= varargin{3};
      else
          A= [];
      end

      if nargin >= 4
          b= varargin{4};
      else
          b= [];%0;
      end

      if nargin >= 5
          Aeq= varargin{5};
      else
          Aeq= [];
      end

      if nargin >= 6
          beq= varargin{6};
      else
          beq= [];%0;
      end

      if nargin >= 7
          LB= varargin{7};
      else
          LB= [];
      end

      if nargin >= 8
          UB= varargin{8};
      else
          UB= [];
      end

      
      if nargin >= 15
          lenGenom= varargin{15};
      else
          lenGenom= 1;
      end

      %%

      [lenIndividual, uMask, Amin, Aeqmin, LBmin, UBmin]= ...
                       getMinimalDescription( lenVector * lenGenom, A, ...
                                              Aeq, LB, UB, ...
                                              [], lenGenom );

      %%

      if ~isempty(Amin) && isempty(b), 
          b= zeros(size(Amin,1),1); 
      elseif isempty(Amin)
          b= [];
      end

      if ~isempty(Aeqmin) && isempty(beq)
          beq= zeros(size(Aeqmin,1),1);
      elseif isempty(Aeqmin)
          beq= [];
      end


      %%
      % anpassen der lineare ungleichungsnebenbedingung
      % Amin und b, Amin wird schon in getMinimalDescription richtig
      % gemacht, nur b noch nicht

      [Amin_dummy, b]= adaptConstraintsToLenGenom(Amin, b, lenGenom);


      %%
      % Aeq und beq, Aeqmin wird schon in getMinimalDescription richtig
      % gemacht, nur beq noch nicht

      [Aeqmin_dummy, beq]= adaptConstraintsToLenGenom(Aeqmin, beq, lenGenom);


      %%


      if nargin >= 9

        if nargin >= 10
          
          if nargin >= 16
          
            %% 
            % nonlcon, fitness, solverlist1, solverlist2, parallel,
            % nWorker, data, dispValidBounds, plotnonlcon
            arguments= {varargin{9}, ...
                        NaN, varargin{10:14}, varargin{16:end}};
                      
          else
            % nonlcon, fitness, solverlist1, ...
            arguments= { varargin{9}, ...
                         NaN, varargin{ 10:min(14, nargin) } };
            
          end
                    
        else
          % nonlcon, fitness
          arguments= {varargin{9}, NaN};
          
        end

      else
        % nonlcon not passed anymore 
        arguments= {};

      end

      obj= obj@numerics.conRandMatrix(lenIndividual, popSize, ...
                      Amin, b, Aeqmin, beq, LBmin, UBmin, ...
                      arguments{:});

    end

    %%
    % returns the specified individual of the population
    %
    function individual= getIndividual(obj, index)

        individual= obj.getRow(index);

    end

    %%
    % returns the population of the population
    %
    function population= getPopulation(obj)

        population= obj.getData();

    end


  end % end Methods (public)



  %% Methods (protected)
  methods (Access= public)

    %%
    %
    %
    [u, uMask]= getIndividualByMask(obj, nCols, Amax, Aeqmax, ...
                        LBmax, UBmax, varargin)


  end % end Methods (protected)



  %% Methods (protected)
  methods (Access= protected)



  end



  %% Methods (private)
  methods (Access= private)



  end % end Methods (private)

end % end class

%%


