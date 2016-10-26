%% calcNormalizedRMSE
% Calculates the normalized root mean squared error (deviation) between the
% vectors |x| and |y|. The result is normalized over the mse of |y|.
%
function n_rmse= calcNormalizedRMSE(x, y)
%% Release: 1.9

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check params

checkArgument(x, 'x', 'double', '1st');
checkArgument(y, 'y', 'double', '2nd');


%%
%

rmse= numerics.math.calcRMSE(x, y);

% calc rmse between y and zero vector -> rms of y for normalization
rms_y= numerics.math.calcRMSE(y, zeros(numel(y),1));


%%

if (rms_y > 0)
  n_rmse= rmse / rms_y;
else
  error('The root mean square of y isn''t positive: %.2d!', rms_y);
end

%%


