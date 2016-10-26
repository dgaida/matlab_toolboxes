%% approxEq
% Check two double matrices for approximate equality.
%
function equal= approxEq(a, varargin)
%% Release: 1.9
%approxEq    Check two double matrices for approximate equality.
%
%   equal= numerics.math.approxEq(a)
%   
%   equal= numerics.math.approxEq(a, b)
%
%   equal= numerics.math.approxEq(a, b, accuracy)
%
%   Example:
%
%   equal= numerics.math.approxEq([1,2,3;4,5,6], [1.1,2.01,3;4.1,5,6], 0.2)
%
%   See also ALL
%
%   Copyright 2009-2012 Daniel Gaida
%   $Revision: 1.9 $  $Date: 2012/05/13 16:33:38 $

%%

if nargin + nargout == 0
  disp(' ')
  disp('Example: ');
  disp(' ')
  disp('numerics.math.approxEq([1,2,3;4,5,6], [1.1,2.01,3;4.1,5,6], 0.2)');
  
  numerics.math.approxEq([1,2,3;4,5,6], [1.1,2.01,3;4.1,5,6], 0.2)
  
end

%%

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% readout varargin

if nargin >= 2 && ~isempty(varargin{1}), 
  b= varargin{1}; 
else
  b= zeros(size(a));
end

if isempty(b), 
  b= zeros(size(a));
end

if nargin >= 3 && ~isempty(varargin{2})
  accuracy= varargin{2}; 
else
  accuracy= 0.01 .* ones(size(a));
end


%%
% check input parameters

if ~isnumeric(a) || ~isnumeric(b) || ~isnumeric(accuracy)

  error('All parameters must be numeric!');

end

if any(size(b) ~= size(a))

  error('The size of a ([%i %i]) and b ([%i %i]) must be the same!', ...
        size(a), size(b));

end

if numel(accuracy) ~= 1 && max( size(a) ~= size(accuracy) )

  error(['The size of accuracy ([%i %i]) and a ([%i %i]) must be the same or accuracy ', ...
         'must be a scalar!'], size(accuracy), size(a));

end


%%

if all(all(a - accuracy./2 <= b)) && all(all(a + accuracy./2 >= b))
  equal= 1;
else
  equal= 0;
end

%%


