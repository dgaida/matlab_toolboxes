%% NMPC_append2volumeflow_user
% Appends scalar u to volumeflow variable vdata to get piecewise constant
% volumeflow
%
function vdata= NMPC_append2volumeflow_user(vdata, u, delta)
%% Release: 1.4

%%

narginchk(3, 3);
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(vdata, 'vdata', 'double', '1st');
isR(u, 'u', 2, '+');
isR(delta, 'delta', 3, '+');

%%
%

if ~isempty(vdata)

  %%
  % check vdata
  
  if size(vdata, 1) ~= 2
    error('vdata must have 2 rows, but has %i rows!', size(vdata, 1));
  end
  
  %%
  % volumeflow_maize_user= [0 0.9; 29.81 29.81]
  last_c_horizon= vdata(1,end);

  % volumeflow_maize_user= [0 0.9 1; 29.81 29.81 30.11]
  % write the new value twice to get a piecewise constant signal
  vdata(:,end + 1)= [last_c_horizon + (0.1*delta); u];

  % volumeflow_maize_user= [0 0.9 1 1.9; 29.81 29.81 30.11 30.11]
  vdata(:,end + 1)= [last_c_horizon + delta; u];

else

  %%
  % volumeflow_maize_user= [0; 29.81]
  vdata= [0; u];

  % volumeflow_maize_user= [0 0.9; 29.81 29.81]
  vdata(:,end + 1)= [(0.9*delta); u];

end

%%


