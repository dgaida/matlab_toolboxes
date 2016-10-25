%% delNaNrows
% Delete NaN/Inf rows in data
%
function [data, varargout]= delNaNrows(data, varargin)
%% Release: 1.3

%%

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  data2nd= varargin{1};
  
  checkArgument(data2nd, 'data2nd', 'double', '2nd');
  
  checkDimensionOfVariable(data2nd, [size(data, 1) size(data2nd, 2)], 'data2nd');
else
  data2nd= [];
end

if nargin >= 3 && ~isempty(varargin{2})
  delWhat= varargin{2};
  
  % NaN, Inf
  if ~isnan(delWhat) && ~isinf(delWhat)
    error('param:delWhat', 'Parameter delWhat must be NaN or Inf.');
  end
else
  delWhat= NaN;
end

%%
% check argument

checkArgument(data, 'data', 'double', '1st');

%%

if isnan(delWhat)
  % if any element in one row is not nan, then retuns 1 for this row
  ind= any(~isnan(data), 2);
else
  %ind= any(data ~= delWhat, 2);
  ind= any(~isinf(data), 2);
end

% only rows that are completely nan or inf are deleted
data= data(ind, :);

if ~isempty(data2nd)
  data2nd= data2nd(ind, :);
end

%%

if nargout >= 2
  varargout{1}= data2nd;
end

%%


