%% scale_Data
% Scale the given (0,1,2)-dimensional data between [0,1] or a given scale.
%
function [scaled_data, varargout]= scale_Data(data, varargin)
%% Release: 1.9

%%

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%
% check arguments

checkArgument(data, 'data', 'double', '1st');

%%
% making a column vector out of the given vector
if numel(data) == max(size(data))
  data= data(:);
end

%%
% check parameters

if nargin >= 2 && ~isempty(varargin{1})
  lowLimit= varargin{1};
  
  checkArgument(lowLimit, 'lowLimit', 'double', '2nd');
  
  % make a row vector
  lowLimit= lowLimit(:)';
  
  if numel(lowLimit) == 1 % is a scalar
    lowLimit= repmat(lowLimit, 1, size(data, 2));
  end
  
  if numel(lowLimit) ~= size(data, 2)
      error(['The 2nd argument lowLimit has not as much elements (%i) ', ...
             'as the data has rows (%i)!'], numel(lowLimit), size(data, 2));
  end
else
  lowLimit= min(data, [], 1); % returns min values for each column
end

%%

if nargin >= 3 && ~isempty(varargin{2})
  maxLimit= varargin{2};
  
  checkArgument(maxLimit, 'maxLimit', 'double', '3rd');
  
  % make a row vector
  maxLimit= maxLimit(:)';
  
  if numel(maxLimit) == 1 % is a scalar
    maxLimit= repmat(maxLimit, 1, size(data, 2));
  end
  
  if numel(maxLimit) ~= size(data, 2)
      error(['The 3rd argument maxLimit has not as much elements (%i) ', ...
             'as the data has rows (%i)!'], numel(maxLimit), size(data, 2));
  end
else
  maxLimit= max(data, [], 1); % returns max values for each column
end


%%
% check parameters

if numel(data) == 1 && nargin == 1
  warning('data:scalar', ...
          ['Trying to scale a scalar without specifying min and max! ', ...
           'Result will be NaN!'])
end

%% 
% lowLimit and maxLimit are always row vectors or scalars with same number
% of columns as data

varargout{1}= lowLimit;
varargout{2}= maxLimit;

%%
% set min values to zero

data= ( data - repmat( lowLimit, size(data, 1), 1 ) );

%%
% normalize data

scaled_data= data ./ ...
             repmat( maxLimit - lowLimit, size(data, 1), 1 );

%%


