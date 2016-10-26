%% calcAM1y
% Calc output vector y of AM1 model
% 
function [Q_ch4]= calcAM1y(xsim, p)
%% Release: 1.7

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(xsim, 'xsim', 'double', '1st');
checkArgument(p, 'p', 'struct', '2nd');

%%

Q_ch4(size(xsim,1), 1)= 0;

k4= p.k4;                   % [mmol/g]

%%

for t=1:size(xsim,1)
    
  %%
  
  x= xsim(t,:);

  % calculate variables for this state

  [mu1, mu2]= AM1ode4_vars(x, p);

  %%
  % [mmol/l/d] Methane gas production (eq. 2.7)
  %
  % $$Q_{ch4}(t) = ...$$
  %
  % l ist hier das Volumen des Fermenters
  % dann kann man mit 22.4 l/mol Volumen eines idealen Gases auf l/d bzw.
  % l/h umrechnen
  %
  Q_ch4(t,1)= k4 * mu2 * x(4);    % [mmol/g * d^-1 * g/l] = [mmol/l/d]
  
  % [mmol/l/d * l * 22.4 l/mol * 10^-3/m / ( 24 h/d )] = [l/h]
  Q_ch4(t,1)= Q_ch4(t,1) * p.V * 22.4 * 10^-3 / 24;
  
  %% TODO
  % temp. nur für test: nicht beobachtbares System
  
  %Q_ch4(t,1)= x(1);
    
end

%%


