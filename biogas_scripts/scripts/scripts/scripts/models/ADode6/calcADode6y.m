%% calcADode6y
% Calculate the output of the ADode6 model
%
function [Q_ch4_Q_co2, pH]= calcADode6y(xsim, u, p)
%% Release: 1.5

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

checkArgument(xsim, 'xsim', 'double', '1st');
checkArgument(u, 'u', 'double', '2nd');
checkArgument(p, 'p', 'struct', '3rd');

%%

Q_ch4(size(xsim,1), 1)= 0;
Q_co2(size(xsim,1), 1)= 0;
pH(size(xsim,1), 1)= 0;

y_ch4_m= p.y_ch4_m; 
k_h= p.k_h; 
k_la= p.k_la;

%%

if size(u,1) < size(xsim,1) && size(u,1) ~= 1
   
  %% TODO - check if this is ok
  % sonst muss ich der ganzen funktion t, t_delta übergeben
  %u= stretch(u, round( size(xsim,1) / size(u,1) ) );
  u= interp1(1:1:size(u,1), u, 1:size(u,1)/(size(xsim,1) + size(u,1)):size(u,1));
  
  warning('u:todo', 'TODO');
    
end

%%

for t=1:size(xsim,1)
    
  %%
  
  x= xsim(t,:);

  %%
  % calculate variables for this state
  if size(u,1) ~= 1
    [Y_a, D_a, Y_m, D_m, k_g, r_g, cH, H_a, f_a, f_m]= ADode6_vars(x, u(t,:), p);
  else
    [Y_a, D_a, Y_m, D_m, k_g, r_g, cH, H_a, f_a, f_m]= ADode6_vars(x, u(1,:), p);
  end

  %%
  % [l/h] Methane gas production (eq. 2.7)
  %
  % $$Q_{ch4}(t) = k_g \cdot r_g \cdot f_m \left( V_a(t) \right) \cdot
  % X_m(t) \cdot y_{ch4}^m$$
  %
  Q_ch4(t,1)= k_g * r_g * f_m * x(4) * y_ch4_m;

  %%
  % [l/h] Carbon dioxide gas production (eq. 2.8)
  %
  % $$Q_{co2}(t)= k_g \cdot k_{la} \cdot \left( C(t) - k_h \cdot P_c(t) \right)
  % $$
  %
  Q_co2(t,1)= k_g * k_la * ( x(5) - k_h * x(6) );

  %%
  % pH level of the reactor (eq. 2.9)
  %
  % $$pH(t) = -\log_{10} \left( \left[ H^+ \right] \right)$$
  %
  pH(t,1)= -log10( cH );

end

%%

Q_ch4_Q_co2= [Q_ch4, Q_co2];%, pH];

%%


