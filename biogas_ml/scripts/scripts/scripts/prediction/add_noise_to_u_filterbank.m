%% add_noise_to_u_filterbank
% Add noise to input u for filterbank
%
function [uused]= add_noise_to_u_filterbank(uused, rel_noise_in)
%% Release: 0.9

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%% 

checkArgument(uused, 'uused', 'double', '1st');
isR(rel_noise_in, 'rel_noise_in', 2, '+');

%%

usign1= numerics.math.calcRMSE(uused(:,1), zeros(numel(uused(:,1)),1));
usign2= numerics.math.calcRMSE(uused(:,2), zeros(numel(uused(:,2)),1));

std_dev_in1= usign1 * rel_noise_in;    % input ebenfalls mit 5 % Genauigkeit
std_dev_in2= usign2 * rel_noise_in;    % input ebenfalls mit 5 % Genauigkeit

%% 
% es kann passieren, dass u negativ wird!!!
uused(:,1)= uused(:,1) + std_dev_in1 .* randn(numel(uused(:,1)),1);
uused(:,2)= uused(:,2) + std_dev_in2 .* randn(numel(uused(:,2)),1);
uused= max(uused, 0);

%%


