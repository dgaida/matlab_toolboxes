%% resampleData
% Resample data to a piecewise constant signal.
%
function [data_res]= resampleData(data, cur_grid, new_grid)
%% Release: 1.8

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check params

checkArgument(data, 'data', 'double', '1st');
checkArgument(cur_grid, 'cur_grid', 'double', '2nd');
checkArgument(new_grid, 'new_grid', 'double', '3rd');

if max(size(data) ~= size(cur_grid))
  error('size(data) ~= size(cur_grid): %i ~= %i', size(data), size(cur_grid));
end

%%
%cur_grid= cur_grid(:)';
new_grid= new_grid(:)';


%%
%

data_res= zeros(size(data,1), size(new_grid,2));


%%
%

for itime= 1:size(new_grid,2)

  % get nearest value, k_act can be a vector if data is 2-dimensional
  [min_val, k_act]= min( abs( cur_grid - new_grid(1,itime) ), [], 2 );
  
  % switch at time cur_grid(:,k_act)
  % do not switch too early, so if cur_grid is still greater new_grid, then
  % do not yet switch
  k_act= max(k_act - 1 .* diag( cur_grid(:,k_act) > new_grid(1,itime) ), 1);
  
  % zu pumpende Menge
  data_res(:,itime)= diag( data(:,k_act) );

end

%%


