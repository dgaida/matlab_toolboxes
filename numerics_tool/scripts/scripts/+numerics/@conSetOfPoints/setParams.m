%% numerics.conSetOfPoints.setParams
% Set the parameters of the <consetofpoints.html |numerics.conSetOfPoints|>
% class. 
%
function setParams(obj, conDim, rows, varargin)
%% Release: 1.4

%%

error( nargchk(3, 19, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );


%%

obj.conDim= conDim;
validateattributes(conDim, {'double'}, {'scalar', 'nonnegative', 'integer'}, ...
                   mfilename, 'conDim', 2);

obj.nRows= rows;
validateattributes(rows, {'double'}, {'scalar', 'nonnegative', 'integer'}, ...
                   mfilename, 'rows', 3);
                 
if nargin >= 4, obj.conLB= varargin{1}; else obj.conLB= []; end;

if ~isempty(obj.conLB) && ...
    ( numel(size(obj.conLB)) ~= 2 || min(size(obj.conLB)) ~= 1 )
    error('The format of obj.conLB is wrong!');
else
  obj.conLB= obj.conLB(:)';

  if numel(obj.conLB) ~= conDim
    error('obj.conLB has wrong number of elements: %i ~= %i', ...
          numel(obj.conLB), conDim);
  end
end

if nargin >= 5, obj.conUB= varargin{2}; else obj.conUB= []; end;

if ~isempty(obj.conUB) && ...
    ( numel(size(obj.conUB)) ~= 2 || min(size(obj.conUB)) ~= 1 )
    error('The format of obj.conUB is wrong!');
else
  obj.conUB= obj.conUB(:)';
    
  if numel(obj.conUB) ~= conDim
    error('obj.conUB has wrong number of elements: %i ~= %i', ...
          numel(obj.conUB), conDim);
  end  
end

if nargin >= 6, obj.conA= varargin{3}; else obj.conA= []; end;

if obj.conDim ~= 0 && ~isempty(obj.conA) && ...
    ( numel(size(obj.conA)) ~= 2 || size(obj.conA,2) ~= obj.conDim )
    error('The format of obj.conA is wrong!');
end

if nargin >= 7, obj.conb= varargin{4}; else obj.conb= []; end;

if ~isempty(obj.conb) && ...
    ( numel(size(obj.conb)) ~= 2 || size(obj.conb,1) ~= size(obj.conA,1) )
    error('The format of obj.conb is wrong!');
end

if nargin >= 8, obj.conAeq= varargin{5}; else obj.conAeq= []; end;

if nargin >= 9, obj.conbeq= varargin{6}; else obj.conbeq= []; end;

if ~isempty(obj.conAeq) || ~isempty(obj.conbeq)
  warning('conAeqbeq:notempty', 'conAeq or/and conbeq are not empty!');
end

if nargin >= 10 && ~isempty(varargin{7})
  obj.nonlcon= varargin{7};
  
  % could also be a cell array of funtion handles
  %checkArgument(obj.nonlcon, 'nonlcon', 'function_handle', 10);
else
  obj.nonlcon= []; 
end

if nargin >= 11, obj.conData= varargin{8}; else obj.conData= []; end;

if ~isempty(obj.conData) && ...
    ( numel(size(obj.conData)) ~= 2 || ...
      size(obj.conData,1) ~= obj.nRows || ...
      size(obj.conData,2) ~= obj.conDim )
    error('The format of obj.conData is wrong!');
end

if nargin >= 12, obj.V= varargin{9}; else obj.V= []; end;

%%

if nargin >= 13, obj.A= varargin{10}; else obj.A= []; end;

if obj.conDim ~= 0 && ~isempty(obj.A) && ...
  ( numel(size(obj.A)) ~= 2 || size(obj.A,2) ~= obj.conDim )
  error('The format of obj.A is wrong!');
end

if nargin >= 14, obj.b= varargin{11}; else obj.b= []; end;

if ~isempty(obj.b) && ...
  ( numel(size(obj.b)) ~= 2 || size(obj.b,1) ~= size(obj.A,1) )
  error('The format of obj.b is wrong!');
end

%%

if nargin >= 15, obj.Aeq= varargin{12}; else obj.Aeq= []; end;

% die auskommenierte Abfrage verstehe ich nicht, das dürfte eigentlich
% immer der Fall sein, da Aeq in der Originaldimension gemessen wird und
% nicht in der constrained Dimension
if obj.conDim ~= 0 && ~isempty(obj.Aeq) && ...
  ( numel(size(obj.Aeq)) ~= 2 ) % || size(obj.Aeq,2) ~= obj.conDim )
  error('The format of obj.Aeq is wrong!');
end

if nargin >= 16, obj.beq= varargin{13}; else obj.beq= []; end;

if ~isempty(obj.beq) && ...
  ( numel(size(obj.beq)) ~= 2 || size(obj.beq,1) ~= size(obj.Aeq,1) )
  error('The format of obj.beq is wrong!');
end

%%

if nargin >= 17, obj.C= varargin{14}; else obj.C= []; end;

if nargin >= 18, obj.Cinv= varargin{15}; else obj.Cinv= []; end;

if nargin >= 19, obj.d= varargin{16}; else obj.d= []; end;


%% TODO
% check parameters a bit better

% maybe write a function which checks all parameters of conSetOfPoints on
% validity.


%%


