%% expand_state_x_MHE
% Expand state returned from optimization with constant components taken
% out of x0
%
function x= expand_state_x_MHE(x_red, x0, pH)
%% Release: 0.0

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% scale data back to physical values
  
x_red(8, :)= x_red(8, :) ./ 1e5;   % hydrogen: 10e-7
  
%%
% assumption that x_red only contains first 25 values of state of 1st
% digester, append second and all other digesters

if isvector(x_red)
  x_red= [x_red, x0(1:25, 2:end)];
end

%% TODO
% use pH to calculate ions of acids

x= [x_red; x0(26:end,:)];

%%


