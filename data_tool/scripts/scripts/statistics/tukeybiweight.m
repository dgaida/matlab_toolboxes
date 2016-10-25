%% tukeybiweight
% Compute Tukey's biweight rho (not psi) function
%
function rho= tukeybiweight(x, varargin)
%% Release: 0.9

% Computes Tukey's biweight rho (not psi) function with constant C for all 
% values in the vector x.

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  C= varargin{1};
  checkArgument(C, 'C', 'double', '2nd');
else
  C= 4.6851;
end

%%

% this is for psi := d/dx rho
% hulp= x - 2 .* x.^3 / (C^2) + x.^5 / (C^4);

% rho
hulp= C^2/6 .* ( 1 - ( 1 - ( x ./ C ).^2 ).^3 );

rho= hulp .* ( abs(x) < C ) + C^2/6 .* ( abs(x) >= C );

%%


