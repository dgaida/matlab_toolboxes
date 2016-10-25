%% getStdDevOfConfMatrix
% Calculate standard deviation over rows of confusion matrix
%
function mean_std_dev= getStdDevOfConfMatrix(confMatrix, varargin)
%% Release: 1.7

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  plotdistribution= varargin{1};
  is0or1(plotdistribution, 'plotdistribution', 2);
else
  plotdistribution= 0;
end

%%
% check Argument

validateattributes(confMatrix, {'double'}, {'2d', 'nonempty', ...
                   'size', [size(confMatrix, 1), size(confMatrix, 1)]}, ...
                   mfilename, 'confMatrix', 1);

%%

std_dev= zeros(size(confMatrix, 1), 1);

if plotdistribution
  figure;
end

%%

for irow= 1:size(confMatrix, 1)

  numbers= [];

  for icol= 1:size(confMatrix, 2)

    % each point is weighted with found class icol
    numbers= [numbers, ...
        icol .* ones( confMatrix(irow,icol), 1 )'];

  end

  %%
  % Apply element-by-element binary operation to two arrays with singleton
  % expansion enabled 
  % -> center the distribution around the given class irow
  x= bsxfun(@minus, numbers, irow)';
  n= size(x,1);

  if plotdistribution
    subplot(numel(std_dev), 1, irow);
    hist(x, numel(std_dev));
  end

  % calculate standard deviation for given class
  std_dev(irow,1)= sqrt( sum(abs(x).^2, 1) ./ (n - 1) );

end

%%
% the standard deviation is the max standard deviation over the given
% classes
mean_std_dev= max(std_dev);

%%


