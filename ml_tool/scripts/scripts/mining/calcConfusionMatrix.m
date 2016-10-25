%% calcConfusionMatrix
% Calculate confusion matrix for predicted vs. given vector
%
function [confMatrix, confPMatrix, varargout]= calcConfusionMatrix(theta, theta_hat)
%% Release: 1.8
% Calculate confusion matrix for predicted vs. given vector

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%
% check input params

isN0n(theta, 'theta', 1);
isN0n(theta_hat, 'theta_hat', 2);

%%

theta= theta(:);
theta_hat= theta_hat(:);

%%
% get the class labels
labels= unique([unique(theta); unique(theta_hat)]);
labels= sort(labels);

numClass= numel(labels);      % number of classes

confMatrix= zeros(numClass);  % confusion matrix initialization

%%

for irow= 1:size(confMatrix, 1)     % given classes

  for icol= 1:size(confMatrix, 2)   % predicted classes

    % count the amount of samples, for which the given class is 
    % equal to the predicted class
    confMatrix(irow, icol)= sum( min( theta == labels(irow), ...
                                  theta_hat == labels(icol) ) );

  end
    
end

%%
% calculate confusion matrix measured in 100 %, could contain nans if
% testdata for one class is missing
confPMatrix= confMatrix ./ repmat( sum( confMatrix, 2 ), 1, size(confMatrix, 1) );

%%

if nargout >= 3

  %%
  % kick NaNs out of square matrix, if ith col is deleted than is also ith
  % row, always returning a square matrix
  confMatrix_red= kick0rowsoo2matrix(confMatrix);

  %%

  % get the sum over the rows of the original confusion matrix, the original
  % one is used to reflect errors on the thrown out class -> the sum over the
  % rows then can be lower than 1. 
  row_sum= sum( confMatrix, 2 );
  % throw out those who are 0
  row_sum(row_sum == 0)= [];

  % normalize
  confPMatrix_red= confMatrix_red ./ ...
               repmat( row_sum, 1, size(confMatrix_red,1) );

  %%
  % actually should never happen, can only happen, if the while loop above is
  % not working correctly
  if any(isnan(confPMatrix_red))

    disp(confPMatrix);

  end

  %%
  
  varargout{1}= confPMatrix_red;

end

%%


