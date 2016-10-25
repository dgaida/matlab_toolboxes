%% predict_data
% Predict data using Kriging approximation or an interpolation method
%
function [fp]= predict_data(xp, yp, zp, varargin)
%% Release: 1.5

%%

error( nargchk(4, 8, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check first 3 arguments

checkArgument(xp, 'xp', 'double', '1st');
checkArgument(yp, 'yp', 'double', '2nd');
checkArgument(zp, 'zp', 'double', '3rd');


%%

if isstruct(varargin{1}) % then a model is given

  %%
  
  error( nargchk(4, 4, nargin, 'struct') );

  model= varargin{1};
  
  if ~(numel(xp) == numel(yp) && numel(xp) == numel(zp))
    error('xp, yp and zp must have the same number of elements! But they are: %i, %i and %i!', ...
          numel(xp), numel(yp), numel(zp));
  end
  
  X_grid= [xp(:), yp(:), zp(:)];
  
  try
    [fp]= predictor(X_grid, model);
  catch ME
    rethrow(ME);
  end
  
  %%
  
  fp= reshape(fp, size(xp));
  
  %%
  
else % do prediction using interpolation
  
  %%
  
  error( nargchk(7, 8, nargin, 'struct') );

  xm= varargin{1};
  ym= varargin{2};
  zm= varargin{3};
  fm= varargin{4};
  
  if nargin >= 8 && ~isempty(varargin{5})
    interp_method= varargin{5};
    
    validatestring(interp_method, {'natural', 'linear', 'nearest'}, ...
                   mfilename, 'interp_method', 8);
  else
    interp_method= 'linear';
  end
  
  %%
  % check other arguments
  
  checkArgument(xm, 'xm', 'double', '4th');
  checkArgument(ym, 'ym', 'double', '5th');
  checkArgument(zm, 'zm', 'double', '6th');
  checkArgument(fm, 'fm', 'double', '7th');
  
  if ~(numel(xm) == numel(ym) && numel(xm) == numel(zm) && numel(xm) == numel(fm))
    error(['xm, ym, zm and fm must have the same number of elements! ', ...
           'But they are: %i, %i, %i and %i!'], ...
           numel(xm), numel(ym), numel(zm), numel(fm));
  end
  
  
  %%
  
  xp_nan= xp;
  
  xp= xp(~isnan(xp));
  yp= yp(~isnan(yp));
  zp= zp(~isnan(zp));
  
  [X, fm]= deleteDuplicates([xm, ym, zm], fm);

  xm= X(:,1);
  ym= X(:,2);
  zm= X(:,3);
  
  %%
  %fp=  griddata3(xm, ym, zm, fm, xp(:), yp(:), zp(:), interp_method);
  F= TriScatteredInterp(xm, ym, zm, fm, interp_method);
  fp= F(xp(:), yp(:), zp(:));
  
  %%

  %F_N= griddata3(xm, ym, zm, fm, xp(:), yp(:), zp(:), 'nearest');
  F= TriScatteredInterp(xm, ym, zm, fm, 'nearest');
  F_N= F(xp(:), yp(:), zp(:));
  
  fp(isnan(fp))= F_N(isnan(fp));

  %%
  
  fp= reshape(fp, size(xp));
  
  xp_nan(~isnan(xp_nan))= fp;
  
  % xp now contains fp, and the original nans
  fp= xp_nan;
  
  %%
  
end

%%



%%


