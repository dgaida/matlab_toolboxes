%% numerics.conRandMatrix
% doc numerics.conRandMatrix
%
% Definition of a random matrix where each row is bounded and constrained
% to (non-)linear (in-)equality constraints.
%
classdef conRandMatrix < handle
%% Release: 1.4

  %% Properties (private)
  %
  properties (SetAccess= private)

    % number of columns of the random matrix
    nCols;

    % number of rows of the random matrix
    nRows;

    % lower bound of each row. LB is a row vector
    LB;

    % upper bound of each row. UB is a row vector
    UB;

    % matrix of the inequality constraint, which must hold for each row
    % of the random matrix. $A \cdot x \leq b$, where $x'$ is an
    % arbitrary row of the random matrix
    %
    A;

    % right side of the inequality constraint, which must hold for each
    % row of the random matrix. b is a column vector. $A \cdot x \leq
    % b$, where $x'$ is an arbitrary row of the random matrix
    %
    b;

    % matrix of the equality constraint, which must hold for each row
    % of the random matrix. $Aeq \cdot x = beq$, where $x'$ is an
    % arbitrary row of the random matrix
    %
    Aeq;

    % right side of the equality constraint, which must hold for each
    % row of the random matrix. beq is a column vector. $Aeq \cdot x =
    % beq$, where $x'$ is an arbitrary row of the random matrix
    %
    beq;

    % nonlinear inequality constraint function handle, for which $c(x)
    % \leq 0$ must hold
    % nonlinear equality constraint function handle, for which $ceq(x)
    % = 0$ must hold
    %
    nonlcon;

    % data of the random matrix (double array)
    %
    data;

    % header of the matrix's columns as cell array (row vector)
    %
    header;

    % fitness of the constrained Random Matrix
    %
    fitness;

    %
    %
    conObj= numerics.conSetOfPoints;

  end % Properties (private)



  %% Methods (public)
  %
  methods (Access= public)

    function obj= conRandMatrix(varargin)
      %
      % Standard Constructor
      %
      
      error( nargchk(0, 17, nargin, 'struct') );
      error( nargoutchk(0, 1, nargout, 'struct') );

      %%
      % @param cols : number of columns of the random matrix
      % @param rows : number of rows of the random matrix
      % 
      if nargin >= 1 && ~isempty(varargin{1})
        cols= varargin{1}; 
        
        validateattributes(cols, {'double'}, {'scalar', 'nonnegative', 'integer'}, ...
                           mfilename, 'cols', 1);
      else
        cols= 0; 
      end

      if nargin >= 2 && ~isempty(varargin{2})
        rows= varargin{2};
        
        validateattributes(rows, {'double'}, {'scalar', 'nonnegative', 'integer'}, ...
                           mfilename, 'rows', 2);
      else
        rows= 0;
      end

      obj.nCols= cols;
      obj.nRows= rows;

      %%
      % read out varargin

      if nargin >= 3
          obj.A= varargin{3}; 

          if ~isempty(obj.A)
              if size(obj.A,2) ~= cols
                  error(['The inequality matrix A has not the correct ', ...
                         'number of columns. It has %i column(s), ', ...
                         'but must have %i column(s).'], ...
                         size(obj.A,2), cols); 
              end
          end
      else
          obj.A= [];
      end

      checkArgument(obj.A, 'A', 'double', '3rd');

      %%

      if nargin >= 4, 
          obj.b= varargin{4}; 

          if ~isempty(obj.b)
              obj.b= obj.b(:);

              if length(obj.b) ~= size(obj.A,1)
                  error(['The inequality vector b has not the correct ', ...
                         'number of rows. It has %i', ...
                         ' row(s), but must have %i', ...
                         ' row(s).'], length(obj.b), size(obj.A,1)); 
              end
          end
      else
          obj.b= []; 
      end

      checkArgument(obj.b, 'b', 'double', '4th');

      %%

      if nargin >= 5, 
          obj.Aeq= varargin{5}; 

          if ~isempty(obj.Aeq)
              if size(obj.Aeq,2) ~= cols
                  error(['The equality matrix Aeq has not the correct ', ...
                         'number of columns. It has %i column(s), ', ...
                         'but must have %i column(s).'], ...
                         size(obj.Aeq,2), cols); 
              end
          end
      else
          obj.Aeq= []; 
      end

      checkArgument(obj.Aeq, 'Aeq', 'double', '5th');

      %%

      if nargin >= 6, 
          obj.beq= varargin{6}; 

          if ~isempty(obj.beq)
              obj.beq= obj.beq(:);

              if length(obj.beq) ~= size(obj.Aeq,1)
                  error(['The equality vector beq has not the correct ', ...
                         'number of rows. It has %i', ...
                         ' row(s), but must have %i row(s).'], ...
                         length(obj.beq), size(obj.Aeq,1)); 
              end
          end
      else
          obj.beq= [];
      end

      checkArgument(obj.beq, 'beq', 'double', 6);

      %%

      if nargin >= 7, 
          obj.LB= varargin{7}; 

          if ~isempty(obj.LB)
              obj.LB= obj.LB(:)';

              if length(obj.LB) ~= cols
                  error(['The lower bound vector LB has not the correct ', ...
                         'number of columns. It has %i', ...
                         ' column(s), but must have %i', ...
                         ' column(s).'], length(obj.LB), cols); 
              end
          end
      else
          obj.LB= []; 
      end

      checkArgument(obj.LB, 'LB', 'double', 7);

      %%

      if nargin >= 8, 
          obj.UB= varargin{8}; 

          if ~isempty(obj.UB)
              obj.UB= obj.UB(:)';

              if length(obj.UB) ~= cols
                  error(['The upper bound vector UB has not the correct ', ...
                         'number of columns. It has %i', ...
                         ' column(s), but must have %i', ...
                         ' column(s).'], length(obj.UB), cols); 
              end
          end
      else
          obj.UB= [];
      end

      checkArgument(obj.UB, 'UB', 'double', 8);

      %%

      if nargin >= 9, 
        obj.nonlcon= varargin{9}; 
      else
        obj.nonlcon= []; 
      end

      checkArgument(obj.nonlcon, 'nonlcon', 'function_handle', 9, 'on');

      %%

      if nargin >= 10 && ~isempty(varargin{10}), 
          obj.fitness= varargin{10};

          %return;
      else
          obj.fitness= NaN;
      end

      %%

      if nargin >= 11 && ~isempty(varargin{11})
          solverlist1= varargin{11};
      else
          solverlist1= {'PS', 'ISRES', 'GA'};
      end

      if ~ischar(solverlist1) && ~iscellstr(solverlist1)
        error(['The 11th argument solverlist1 must be a char or a cellstring, ', ...
               'but is a %s!'], class(solverlist1));
      end

      %%

      if nargin >= 12 && ~isempty(varargin{12})
          solverlist2= varargin{12};
      else
          solverlist2= {'PS', 'ISRES', 'GA'};
      end

      if ~ischar(solverlist2) && ~iscellstr(solverlist2)
        error(['The 12th argument solverlist2 must be a char or a cellstring, ', ...
               'but is a %s!'], class(solverlist2));
      end

      %%

      if nargin >= 13 && ~isempty(varargin{13})
          parallel= varargin{13};
      else
          parallel= 'none';
      end

      if ~ischar(parallel) && ~iscell(parallel)
        error(['The 13th argument parallel must be a char or a cell, ', ...
               'but is a %s!'], class(parallel));
      end

      %%

      if nargin >= 14 && ~isempty(varargin{14})
          nWorker= varargin{14};
      else
          nWorker= 2;
      end

      validateattributes(nWorker, {'double'}, {'scalar', 'positive', 'integer'}, ...
                         mfilename, 'nWorker', 14);

      %%

      if nargin >= 15 && ~isempty(varargin{15}), 
        data_set= varargin{15}; 
      else
        data_set= []; 
      end

      checkArgument(data_set, 'data', 'double', 15);

      if ~isempty(data_set) && size(data_set, 2) ~= cols
        error(['The given data has not the correct dimension! ', ...
               '%i ~= %i!'], size(data_set, 2), cols);
      end

      %%
      
      if nargin >= 16 && ~isempty(varargin{16})
        dispValidBounds= varargin{16};

        is0or1(dispValidBounds, 'dispValidBounds', 16);
      else
        dispValidBounds= 0;
      end

      if nargin >= 17 && ~isempty(varargin{17}),
        plotnonlcon= varargin{17}; 

        is0or1(plotnonlcon, 'plotnonlcon', 17);
      else
        plotnonlcon= 0; 
      end
      
      %%
      % bounds

%             if ~isempty(obj.A) || ~isempty(obj.Aeq) || ...
%                ~isempty(obj.nonlcon)
%                 
%                 %obj= getValidBounds(obj, 'GA');
%                 obj= getValidBounds(obj, 'PS');
%             
%             end

      %%

      arguments= cell(1, max(9 - nargin, 0));

      %if ~isempty(obj.Aeq)
      obj.conObj= numerics.conSetOfPoints(...
          varargin{1:min(9,nargin)}, arguments{:}, ...
          solverlist1, parallel, nWorker, data_set, dispValidBounds, plotnonlcon);
      %else
      %    obj.obj_constrained= [];
      %end

      %return;

      %%

      %if ~isempty(obj.obj_constrained)
      cols= obj.conObj.conDim;
      %end

      if rows*cols > 0

          %if cols > 3 && ...
                   %      ( ~isempty(obj.conObj.A) ) 
                      % || ~isempty(obj.Aeq) )

        [obj, obj.conObj]= getOptimalPopulation(...
                            obj.conObj, obj, solverlist2, @huniform, ...
                            parallel, nWorker, dispValidBounds, plotnonlcon);

          %else

            %  [obj, obj.conObj]= getOptimalPopulation(...
                  %                obj.conObj, obj, 'PS');

          %end

      end

    end


    %%
    %
    function row= getRow(obj, index)
        %
        % returns the specified row of the random matrix
        %

        row= obj.data(index,:);

    end


    %%
    %
    function data= getData(obj)
        %
        % returns the data of the random matrix
        %

        data= obj.data;

    end

    %%
    %
    function LB= getLB(obj)
        %
        % returns the LB of the random matrix
        %

        LB= obj.LB;

    end

    %%
    %
    function UB= getUB(obj)
        %
        % returns the UB of the random matrix
        %

        UB= obj.UB;

    end

    %%
    %
    function A= getA(obj)
        %
        % returns the inequality matrix A of the random matrix
        %

        A= obj.A;

    end

    %%
    %
    function Aeq= getAeq(obj)
        %
        % returns the equality matrix Aeq of the random matrix
        %

        Aeq= obj.Aeq;

    end

    %%
    %
    function b= getb(obj)
        %
        % returns the inequality vector b of the random matrix
        %

        b= obj.b;

    end

    %%
    %
    function beq= getbeq(obj)
        %
        % returns the equality vector beq of the random matrix
        %

        beq= obj.beq;

    end

  end % end Methods (public)


  %% Methods (protected)
  %
  methods (Access= protected)

      setParams(obj, cols, rows, varargin)

  end


  %% Methods (private)
  %
  methods (Access= private)



  end % end Methods (private)

end % end class

%%


