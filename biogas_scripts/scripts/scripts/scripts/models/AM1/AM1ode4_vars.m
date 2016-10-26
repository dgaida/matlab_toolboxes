%% AM1ode4_vars
% Calculate variables of model AM1
%
function [mu1, mu2]= AM1ode4_vars(x, p)
%% Release: 1.7

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

isRn(x, 'x', 1);%, '+');
checkArgument(p, 'p', 'struct', '2nd');

%% 
% parameters
%

mu1max= p.mu1max;   % [d^-1]
KS1= p.KS1;         % [g/l]

mu2max= p.mu2max;   % [d^-1]
KS2= p.KS2;         % [mmol/l]
KI2= p.KI2;         % [mmol/l]^(1/2)

%%
% state variables

S1= x(1);           % [g/l]
S2= x(3);           % [mmol/l]

%% 
% variables
%

% [d^-1 * g/l / ( g/l + g/l )] = [d^-1]
mu1= mu1max * S1 / ( S1 + KS1 );    

% [d^-1 * mmol/l / ( mmol/l + mmol/l + (mmol/l/(mmol/l)^(1/2))^2 )] = [d^-1]
mu2= mu2max * S2 / ( S2 + KS2 + ( S2 / KI2 )^2 );

%%


