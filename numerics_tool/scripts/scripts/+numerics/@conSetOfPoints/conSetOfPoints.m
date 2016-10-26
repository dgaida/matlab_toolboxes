%% numerics.conSetOfPoints
% Definition of a set of points where each row is bounded and constrained
% to (non-)linear (in-)equality constraints.
%
classdef conSetOfPoints < handle
%% Release: 1.4

  %% Properties (private)
  %
  properties (SetAccess= private)

    % number of columns (dimension of the set) of the matrix
    dim;

    % dimension of the subset, which is constrained by Aeq, beq
    conDim;

    % number of rows of the dataset, same as number of points in the
    % set
    nRows;

    % lower bound of each row. LB is a row vector
    LB;

    % upper bound of each row. UB is a row vector
    UB;

    % lower bound of the subset, which is constrained by Aeq, beq
    conLB;

    % upper bound of the subset, which is constrained by Aeq, beq
    conUB;

    % matrix of the inequality constraint, which must hold for each row
    % of the dataset. $A \cdot x \leq b$, where $x'$ is an
    % arbitrary row of the dataset matrix
    %
    A;

    % right side of the inequality constraint, which must hold for each
    % row of the dataset. b is a column vector. $A \cdot x \leq
    % b$, where $x'$ is an arbitrary row of the dataset
    %
    b;

    % transformed matrix A in the subset, which is constrained by Aeq,
    % beq
    conA;

    % transformed vector b in the subset, which is constrained by Aeq,
    % beq
    conb;

    % matrix of the equality constraint, which must hold for each row
    % of the dataset. $Aeq \cdot x = beq$, where $x'$ is an
    % arbitrary row of the dataset
    %
    Aeq;

    % right side of the equality constraint, which must hold for each
    % row of the dataset. beq is a column vector. $Aeq \cdot x =
    % beq$, where $x'$ is an arbitrary row of the dataset
    %
    beq;

    % the subset, which is constrained by Aeq, beq has no equality
    % constraints anymore, because they are satisfied per default
    conAeq= [];

    % the subset, which is constrained by Aeq, beq has no equality
    % constraints anymore, because they are satisfied per default
    conbeq= [];

    % nullspace of the equality constraints matrix Aeq
    V= [];

    % nonlinear inequality constraint function handle, for which $c(x)
    % \leq 0$ must hold
    % nonlinear equality constraint function handle, for which $ceq(x)
    % = 0$ must hold
    %
    nonlcon;

    % data of the dataset (double array), the number of columns are
    % equal to the dimension of the points, and the number of rows are
    % equal to the amount of points in the set
    %
    data;

    % data of the subset, which is constrained by Aeq,
    % beq
    conData;

    % header of the matrix's columns as cell array (row vector)
    %
    % TODO: not used yet
    %
    header;

    % scaling matrix, the original data is scaled between 0 and 10
    %
    C;

    % inverse of scaling matrix
    %
    Cinv;

    % offset of the scaling tranformation, thus its scaling and
    % shifting
    %
    d;

    %
    %
    %solverlist

    % 
    %
    %parallel;

    %
    %
    %nWorker;

  end % Properties (private)



  %% Methods (public)
  %
  methods (Access= public)

    function obj= conSetOfPoints(varargin)
      %
      % Standard Constructor
      %
      
      error( nargchk(0, 15, nargin, 'struct') );
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

      obj.dim= cols;
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

      if nargin >= 10 && ~isempty(varargin{10}) 
        solverlist= varargin{10}; 
      else
        solverlist= {'PS', 'ISRES', 'GA'}; 
      end

      checkArgument(solverlist, 'solverlist', 'char || cellstr', 10);
      
      %%

      if nargin >= 11 && ~isempty(varargin{11}), 
        parallel= varargin{11}; 
      else
        parallel= 'none'; 
      end

      checkArgument(parallel, 'parallel', 'char || cell', 11);

      parallel= char(parallel);

      %%

      if nargin >= 12 && ~isempty(varargin{12}), 
        nWorker= varargin{12}; 
      else
        nWorker= 2; 
      end

      isN(nWorker, 'nWorker', 12);

      %%

      if nargin >= 13 && ~isempty(varargin{13}), 
        obj.data= varargin{13}; 
      else
        obj.data= []; 
      end

      checkArgument(obj.data, 'data', 'double', 13);

      if ~isempty(obj.data) && size(obj.data, 2) ~= obj.dim
        error(['The given data has not the correct dimension! ', ...
               '%i ~= %i!'], size(obj.data, 2), obj.dim);
      end

      %%
      
      if nargin >= 14 && ~isempty(varargin{14})
        dispValidBounds= varargin{14};

        is0or1(dispValidBounds, 'dispValidBounds', 14);
      else
        dispValidBounds= 0;
      end

      if nargin >= 15 && ~isempty(varargin{15}),
        plotnonlcon= varargin{15}; 

        is0or1(plotnonlcon, 'plotnonlcon', 15);
      else
        plotnonlcon= 0; 
      end

      %%

%             [obj.scaling_vector, obj.LB, obj.UB]= ...
%                             getScalingVector(obj.UB - obj.LB);
%             
%             UBmLB= obj.UB - obj.LB;
%                         
%             for icon= 1:size(UBmLB,2)
%  
%                 obj.scaling_vector(:,icon)= 1 ./ UBmLB(1,icon);
%      
%             end            


      %%

      getConstrainedSpace(obj);


      %%

      if ~isempty(obj.LB) && obj.nRows > 0
        getValidSetOfPoints(obj, solverlist, parallel, nWorker, ...
                            dispValidBounds, plotnonlcon);
      end


    end


    %%
    % function declaration
    x= getPointsInFullDimension(obj, p)%, Aeq, beq)


    %%
    % function declaration
    p= getPointsInConstrainedDimension(obj, x)%, Aeq, beq)


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
    function LB= getconLB(obj)
      %
      % returns the LB of the random matrix
      %

      LB= obj.conLB;

    end

    %%
    %
    function UB= getconUB(obj)
      %
      % returns the UB of the random matrix
      %

      UB= obj.conUB;

    end

    %%
    %
    function A= getconA(obj)
      %
      % returns the inequality matrix A of the random matrix
      %

      A= obj.conA;

    end

    %%
    %
    function Aeq= getconAeq(obj)
      %
      % returns the equality matrix Aeq of the random matrix
      %

      Aeq= obj.conAeq;

    end

    %%
    %
    function b= getconb(obj)
      %
      % returns the inequality vector b of the random matrix
      %

      b= obj.conb;

    end

    %%
    %
    function beq= getconbeq(obj)
      %
      % returns the equality vector beq of the random matrix
      %

      beq= obj.conbeq;

    end

    %%
    %
    function obj= setConData(obj, data)
        %
        % returns the equality vector beq of the random matrix
        %

        obj.conData= data;

    end

    %%
    %
    function obj= setData(obj, data)
      %
      % returns the equality vector beq of the random matrix
      %

      obj.data= data;

    end

    %%
    %
    setParams(obj, conDim, rows, varargin)
    
    %%
    %
    [x, success]= validateSetForConstraints(obj, varargin)
    

  end % end Methods (public)


  %% Methods (protected)
  %
  methods (Access= protected)



  end


  %% Methods (private)
  %
  methods (Access= private)

    %%
    %
    [fitness]= fitnessSatisfyContraints(obj, u, popSize, varargin)



  end % end Methods (private)
            
end % end class

%%


