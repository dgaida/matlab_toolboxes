%% numerics.conRandMatrix.setParams
% Set the parameters of the <conrandmatrix.html |numerics.conRandMatrix|>
% class. 
%
function setParams(obj, cols, rows, varargin)
%% Release: 1.4

%%

error( nargchk(3, 12, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%% TODO
% check parameters



%%

obj.nCols= cols;
validateattributes(cols, {'double'}, {'scalar', 'nonnegative', 'integer'}, ...
                   mfilename, 'cols', 2);
                 
obj.nRows= rows;
validateattributes(rows, {'double'}, {'scalar', 'nonnegative', 'integer'}, ...
                   mfilename, 'rows', 3);

if nargin >= 4, obj.LB= varargin{1}; else obj.LB= []; end;

if ~isempty(obj.LB) && ...
  ( numel(size(obj.LB)) ~= 2 || min(size(obj.LB)) ~= 1 )
  error('The format of obj.LB is wrong!');
else
  obj.LB= obj.LB(:)';
  
    % As LB is the lower boundary of the original problem and cols is the
  % dimension of the constrained problem, this inequality always holds if
  % the problem is constrained by a Aeq, therefore this has to be commented
%   if numel(obj.LB) ~= cols
%     error('obj.LB has wrong number of elements: %i ~= %i', numel(obj.LB), cols);
%   end
end

if nargin >= 5, obj.UB= varargin{2}; else obj.UB= []; end;

if ~isempty(obj.UB) && ...
  ( numel(size(obj.UB)) ~= 2 || min(size(obj.UB)) ~= 1 )
  error('The format of obj.UB is wrong!');
else
  obj.UB= obj.UB(:)';
  
  % As UB is the upper boundary of the original problem and cols is the
  % dimension of the constrained problem, this inequality always holds if
  % the problem is constrained by a Aeq, therefore this has to be commented
%   if numel(obj.UB) ~= cols
%     error('obj.UB has wrong number of elements: %i ~= %i', numel(obj.UB), cols);
%   end
end

if nargin >= 6, obj.A= varargin{3}; else obj.A= []; end;

% A gehört zum Originalproblem, deshalb stimmt die auskommentierte Abfrage
% für constrained Probleme micht
if obj.nCols ~= 0 && ~isempty(obj.A) && ...
  ( numel(size(obj.A)) ~= 2 ) % || size(obj.A,2) ~= obj.nCols )
  error('The format of obj.A is wrong!');
end

if nargin >= 7, obj.b= varargin{4}; else obj.b= []; end;

if ~isempty(obj.b) && ...
  ( numel(size(obj.b)) ~= 2 || size(obj.b,1) ~= size(obj.A,1) )
  error('The format of obj.b is wrong!');
end

%%

if nargin >= 8, obj.Aeq= varargin{5}; else obj.Aeq= []; end;

% Aeq gehört imme rzum Originalproblem, kann deshalb nie == nCols sein,
% deshalb letzte Abfrage auskommentiert
if obj.nCols ~= 0 && ~isempty(obj.Aeq) && ...
  ( numel(size(obj.Aeq)) ~= 2 ) % || size(obj.Aeq,2) ~= obj.nCols )
  error('The format of obj.Aeq is wrong!');
end

if nargin >= 9, obj.beq= varargin{6}; else obj.beq= []; end;

if ~isempty(obj.beq) && ...
  ( numel(size(obj.beq)) ~= 2 || size(obj.beq,1) ~= size(obj.Aeq,1) )
  error('The format of obj.beq is wrong!');
end

%%

if nargin >= 10 && ~isempty(varargin{7})
  obj.nonlcon= varargin{7};
  
  % could also be a cell array of function handles
  %checkArgument(obj.nonlcon, 'nonlcon', 'function_handle', 10);
else
  obj.nonlcon= []; 
end

if nargin >= 11, obj.data= varargin{8}; else obj.data= []; end;

if ~isempty(obj.data) && ...
  ( numel(size(obj.data)) ~= 2 || ...
    size(obj.data,1) ~= obj.nRows || ...
    size(obj.data,2) ~= obj.nCols )
  error('The format of obj.data is wrong!');
end

if nargin >= 12 && ~isempty(varargin{9})
  obj.fitness= varargin{9}; 
  
  checkArgument(obj.fitness, 'fitness', 'double', 12);
else
  obj.fitness= [];
end

%%


