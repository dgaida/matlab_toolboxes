%% calcADode6_ABC
% Calculate linearized model out of ADode6 model
%
function varargout= calcADode6_ABC(t, x, u, deltatk, p, varargin)
%% Release: 1.3

%%

error( nargchk(5, 6, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%
% check input args

isR(t, 't', 1, '+');
isRn(x, 'x', 2);%, '+');
checkArgument(u, 'u', 'double', '3rd');
isR(deltatk, 'deltatk', 4, '+');
checkArgument(p, 'p', 'struct', 5);

%%

if nargin >= 6 && ~isempty(varargin{1})
  retval= varargin{1};
  % 'A', 'B', 'C'
  checkArgument(retval, 'retval', 'char', 6);
else
  retval= [];
end


%% 
% parameters
%
%%
% $$\mu_{max}^a$$
mu_max_a= p.mu_max_a; 

k_sa= p.k_sa; 
k_sm= p.k_sm; 
k_im= p.k_im; 

% $$y_{vf}^a$$
y_vf_a= p.y_vf_a; 
%%
% $$y_{co2}^a$$
y_co2_a= p.y_co2_a; 
%%
% $$y_{ch4}^m$$
y_ch4_m= p.y_ch4_m;
%%
% $$y_{co2}^m$$
y_co2_m= p.y_co2_m;
%%
% $$k_h$$
k_h= p.k_h; 

k_a= p.k_a; 

%%
% $$k_{la}$$
k_la= p.k_la;

%%
% Dilution rate: 
%
% $$D$$
D= p.D;


%% 

c_time= round(t/deltatk + 0.5);


%% 
% variables
%
% $$Y_{a}, D_{a}, Y_{m}, D_{m}, k_{g}, r_{g}, [H^+], H_{a}, f_{a}, f_{m}$$

if c_time > size(u, 1)
  error('c_time > size(u, 1) : %i > %i', c_time, size(u, 1));
end

[Y_a, D_a, Y_m, D_m, k_g, r_g, cH, H_a, f_a, f_m]= ADode6_vars(x, u(c_time, :), p);



%% derivatives of inhibition functions
%
% $$
% \frac{\partial f_a \left( S(t_0), S_i(t_0) \right) }{\partial S(t)}= 
% \frac{k_{sa} + S_i(t_0)}{S_i(t_0)} \cdot \mu_{max}^a \cdot \left(
% \frac{1}{k_{sa} + S(t_0)} - \frac{S(t_0)}{ \left( k_{sa} + S(t_0)
% \right)^2 } \right)  
% $$
%
df_adS= ( k_sa + u(c_time, 1) ) / u(c_time, 1) * mu_max_a * ( 1 / ( k_sa + x(1) ) - ...
        ( x(1) / ( k_sa + x(1) )^2 ) );

%%
% $$\frac{\partial f_a \left( S(t), S_i(t) \right) }{\partial S_i(t)} = 
% \frac{\mu_{max}^a \cdot S(t_0)}{k_{sa} + S(t_0)} \cdot \left(
% \frac{1}{S_i(t_0)} - \frac{k_{sa} + S_i(t_0)}{ \left( S_i(t_0) \right)^2 } \right)
% $$
%
df_adSi= mu_max_a * x(1) / ( k_sa + x(1) ) * ( 1 / u(c_time, 1) - ...
        ( ( k_sa + u(c_time, 1) ) / (u(c_time, 1)^2) ) );


%%
% $$\frac{\partial f_m \left( V_a(t) \right) }{\partial V_a(t)}= \dots
% s. Maple
% $$
%
% OK: in maple geprüft
%
% here the assumption is made, that cH = const.
% 
df_mdVa= mu_max_a * cH / ( (k_a + cH ) * ( x(3) * cH / ( k_a + cH ) + k_sm + x(3)^2 * cH^2 / ( k_im * ( k_a + cH)^2 ) ) ) ...
         - mu_max_a * x(3) * cH * ( cH / ( k_a + cH ) + 2 * x(3) * cH^2 / ( k_im * ( k_a + cH )^2 ) ) / ...
         ( ( k_a + cH ) * ( x(3) * cH / ( k_a + cH ) + k_sm + x(3)^2 * cH^2 / ( k_im * ( k_a + cH )^2 ) )^2 );

%%

if isempty(retval) || strcmp(retval, 'A')
  
  %%
  % $$
  % P_c'(t)= k_g \left[ k_{la} \left( 1 - P_c(t) \right) \cdot \left( C(t) -
  % k_h \cdot P_c(t) \right) - r_g \cdot P_c(t) \cdot
  % f_m \left( V_a(t) \right) \cdot X_m(t) \cdot y_{ch4}^m \right]
  % $$
  %
  % TODO: sollte nicht hier definiert werden, sollte man eigentlich aus dem
  % modell holen diese gleichung
  %
  P_cdot= k_g * ( k_la * ( 1 - x(6) ) * ( x(5) - k_h * x(6) ) - r_g * x(6) * f_m * x(4) * y_ch4_m );


  %% build linear system matrix A
  %
  % $$d S'(t) := \frac{\partial S'(t_0)}{\partial S(t)} \cdot d S(t) + 
  % \frac{\partial S'(t_0)}{\partial X_a(t)} \cdot d X_a(t) + \dots + 
  % \frac{\partial S'(t_0)}{\partial S_i(t)} \cdot d
  % S_i(t) + \dots$$
  %
  % $$
  % \frac{\partial S'(t_0)}{\partial S(t)}= - D - Y_a \cdot X_a(t_0) \cdot
  % \frac{\partial f_a \left( S(t_0), S_i(t_0) \right) }{\partial S(t)}
  % $$
  % 
  % $$\frac{\partial S'(t_0)}{\partial X_a(t)}= - Y_a \cdot f_a \left( S(t_0), S_i(t_0) \right)$$
  %
  A(1,:)= [ - D - Y_a * x(2) * df_adS, - Y_a * f_a,   0,                          0,             0,          0];

  %%
  % 
  % $$d X_a'(t) := \frac{\partial X_a'(t_0)}{\partial S(t)} \cdot d S(t) + 
  % \frac{\partial X_a'(t_0)}{\partial X_a(t)} \cdot d X_a(t) + \dots + 
  % \frac{\partial X_a'(t_0)}{\partial S_i(t)} \cdot d
  % S_i(t) + \dots$$
  %
  % $$
  % \frac{\partial X_a'(t_0)}{\partial S(t)}= X_a(t_0) \cdot
  % \frac{\partial f_a \left( S(t_0), S_i(t_0) \right) }{\partial S(t)}
  % \qquad \qquad \qquad \qquad \qquad
  % \frac{\partial X_a'(t_0)}{\partial X_a(t)}= f_a \left(
  % S(t_0), S_i(t_0) \right) - D_a
  % $$
  %
  A(2,:)= [ x(2) * df_adS,             f_a - D_a,     0,                          0,             0,          0];

  %%
  % 
  % $$d V_a'(t) := \frac{\partial V_a'(t_0)}{\partial S(t)} \cdot d S(t) + 
  % \frac{\partial V_a'(t_0)}{\partial X_a(t)} \cdot d X_a(t) + 
  % \frac{\partial V_a'(t_0)}{\partial V_a(t)} \cdot d V_a(t) + 
  % \frac{\partial V_a'(t_0)}{\partial X_m(t)} \cdot d X_m(t) + 
  % \dots + 
  % \frac{\partial X_a'(t_0)}{\partial S_i(t)} \cdot d
  % S_i(t) + \dots$$
  %
  % $$
  % \frac{\partial V_a'(t_0)}{\partial S(t)}= X_a(t_0) \cdot y_{vf}^a \cdot
  % \frac{\partial f_a \left( S(t_0), S_i(t_0) \right) }{\partial S(t)}
  % \qquad \qquad \qquad \qquad \quad
  % \frac{\partial V_a'(t_0)}{\partial X_a(t)}= f_a \left(
  % S(t_0), S_i(t_0) \right) \cdot y_{vf}^a
  % $$
  % 
  % $$\frac{\partial V_a'(t_0)}{\partial V_a(t)}= - D - X_m(t_0) \cdot Y_m \cdot 
  % \frac{\partial f_m \left( V_a(t_0) \right) }{\partial V_a(t)}
  % \qquad \qquad \qquad \qquad
  % \frac{\partial V_a'(t_0)}{\partial X_m(t)}= Y_m \cdot 
  % f_m \left( V_a(t_0) \right)
  % $$
  %
  A(3,:)= [ x(2) * y_vf_a * df_adS,    f_a * y_vf_a,  - D - x(4) * Y_m * df_mdVa, Y_m * f_m,     0,          0];

  %%
  % 
  % $$d X_m'(t) := \dots + \frac{\partial X_m'(t_0)}{\partial V_a(t)} \cdot d V_a(t) + 
  % \frac{\partial X_m'(t_0)}{\partial X_m(t)} \cdot d X_m(t) + \dots $$
  %
  % $$
  % \frac{\partial X_m'(t_0)}{\partial V_a(t)}= X_m(t_0) \cdot
  % \frac{\partial f_m \left( V_a(t_0) \right) }{\partial V_a(t)}
  % \qquad \qquad \qquad \qquad \qquad
  % \frac{\partial X_m'(t_0)}{\partial X_m(t)}= f_m \left(
  % V_a(t_0) \right) - D_m$$
  %
  A(4,:)= [ 0,                         0,             x(4) * df_mdVa,             f_m - D_m,     0,          0];

  %%
  % 
  % $$d C'(t) := \frac{\partial C'(t_0)}{\partial S(t)} \cdot d S(t) + 
  % \frac{\partial C'(t_0)}{\partial X_a(t)} \cdot d X_a(t) + 
  % \frac{\partial C'(t_0)}{\partial V_a(t)} \cdot d V_a(t) + 
  % \frac{\partial C'(t_0)}{\partial X_m(t)} \cdot d X_m(t) + 
  % \frac{\partial C'(t_0)}{\partial C(t)} \cdot d C(t) + $$
  %
  % $$ + \frac{\partial C'(t_0)}{\partial P_c(t)} \cdot d P_c(t) + 
  % \frac{\partial C'(t_0)}{\partial S_i(t)} \cdot d
  % S_i(t) + \dots$$
  %
  % $$
  % \frac{\partial C'(t_0)}{\partial S(t)}= X_a(t_0) \cdot y_{co2}^a \cdot
  % \frac{\partial f_a \left( S(t_0), S_i(t_0) \right) }{\partial S(t)}
  % \qquad \qquad \qquad \qquad
  % \frac{\partial C'(t_0)}{\partial X_a(t)}= f_a \left(
  % S(t_0), S_i(t_0) \right) \cdot y_{co2}^a$$
  % 
  % $$
  % \frac{\partial C'(t_0)}{\partial V_a(t)}= X_m(t_0) \cdot y_{co2}^m \cdot 
  % \frac{\partial f_m \left( V_a(t_0) \right) }{\partial V_a(t)}
  % \qquad \qquad \qquad \qquad \qquad
  % \frac{\partial C'(t_0)}{\partial X_m(t)}= y_{co2}^m \cdot 
  % f_m \left( V_a(t_0) \right)$$
  % 
  % $$
  % \frac{\partial C'(t_0)}{\partial C(t)}= -k_{la} - D
  % \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad
  % \frac{\partial C'(t_0)}{\partial P_c(t)}= k_{la} \cdot 
  % k_h
  % $$
  %
  A(5,:)= [ x(2) * y_co2_a * df_adS,   f_a * y_co2_a, x(4) * y_co2_m * df_mdVa,   ...
            f_m * y_co2_m, - k_la - D, k_la * k_h];

  %%
  % 
  % $$d P_c'(t) := \dots + \frac{\partial P_c'(t_0)}{\partial V_a(t)} \cdot d V_a(t) + 
  % \frac{\partial P_c'(t_0)}{\partial X_m(t)} \cdot d X_m(t) + 
  % \frac{\partial P_c'(t_0)}{\partial C(t)} \cdot d C(t) + 
  % \frac{\partial P_c'(t_0)}{\partial P_c(t)} \cdot d P_c(t) + 
  % \dots$$
  %
  % $$
  % \frac{\partial P_c'(t_0)}{\partial V_a(t)}= -k_g \cdot r_g \cdot
  % P_c(t_0) \cdot X_m(t_0) \cdot y_{ch4}^m \cdot  
  % \frac{\partial f_m \left( V_a(t_0) \right) }{\partial V_a(t)}
  % $$
  % 
  % $$
  % \frac{\partial P_c'(t_0)}{\partial X_m(t)}= -k_g \cdot r_g \cdot
  % P_c(t_0) \cdot y_{ch4}^m \cdot  
  % f_m \left( V_a(t_0) \right)
  % \qquad \qquad \qquad \qquad
  % \frac{\partial P_c'(t_0)}{\partial C(t)}= k_g \cdot k_{la} \cdot \left( 1
  % - P_c(t_0) \right)
  % $$
  %
  % intermediate result:
  %
  % $$
  % P_c'(t)= k_g k_{la} \cdot C(t) - k_g k_{la} \cdot 
  % k_h \cdot P_c(t) + k_g \cdot k_{la} \cdot k_h \cdot \left( P_c(t) \right)^2 -
  % k_g \cdot k_{la} \cdot C(t) \cdot P_c(t) - r_g \cdot P_c(t) \cdot k_g
  % \cdot f_m \left( V_a(t) 
  % \right) \cdot X_m(t) \cdot y_{ch4}^m
  % $$
  %
  % $$
  % \frac{\partial P_c'(t_0)}{\partial P_c(t)}= -k_g \cdot k_{la} \cdot 
  % k_h + 2 \cdot k_g \cdot k_{la} \cdot k_h \cdot P_c(t_0) \cdot P_c'(t_0) -
  % k_g \cdot k_{la} \cdot C(t_0) - r_g \cdot k_g \cdot f_m \left( V_a(t_0)
  % \right) \cdot X_m(t_0) \cdot y_{ch4}^m
  % $$
  %
  A(6,:)= [ 0,                         0,             -k_g * r_g * x(6) * x(4) * y_ch4_m * df_mdVa, ...
           -k_g * r_g * x(6) * f_m * y_ch4_m, ...
            k_g * k_la - k_g * k_la * x(6), ...
            k_g * ( -k_la * k_h + 2 * k_la * k_h * x(6) * P_cdot - k_la * x(5) - ...
            r_g * f_m * x(4) * y_ch4_m )];

end


%%

if isempty(retval) || strcmp(retval, 'B')

  %% TODO
  % abhängigkeit von Bic ist schwierig anzugeben, da Bic nur in H^+
  % Berechnung steckt, deshalb Abhängigkeit hier überall auf 0 gesetzt.
  
  %% build input matrix B
  %
  % $$
  % \frac{\partial S'(t_0)}{\partial S_i(t)}= D - Y_a \cdot X_a(t_0) \cdot
  % \frac{\partial f_a \left( S(t_0), S_i(t_0) \right) }{\partial S_i(t)}
  % $$
  %
  B(1,:)= [ D - Y_a * x(2) * df_adSi, 0];

  %% 
  % $$
  % \frac{\partial X_a'(t_0)}{\partial S_i(t)}= X_a(t_0) \cdot
  % \frac{\partial f_a \left( S(t_0), S_i(t_0) \right) }{\partial S_i(t)}
  % $$
  %
  B(2,:)= [ x(2) * df_adSi, 0];

  %% 
  % $$
  % \frac{\partial V_a'(t_0)}{\partial S_i(t)}= X_a(t_0) \cdot y_{vf}^a \cdot
  % \frac{\partial f_a \left( S(t_0), S_i(t_0) \right) }{\partial S_i(t)}
  % $$
  %
  B(3,:)= [ x(2) * y_vf_a * df_adSi, 0];

  %%
  %
  B(4,:)= [0, 0];

  %% 
  % $$
  % \frac{\partial C'(t_0)}{\partial S_i(t)}= X_a(t_0) \cdot y_{co2}^a \cdot
  % \frac{\partial f_a \left( S(t_0), S_i(t_0) \right) }{\partial S_i(t)}
  % $$
  %
  B(5,:)= [ x(2) * y_co2_a * df_adSi, 0];

  %%
  %
  B(6,:)= [0, 0];

end


%%

if isempty(retval) || strcmp(retval, 'C')

  %% TODO
  % C hängt auch sehr indirekt von u ab, was eigentlich nicht sein dürfte
  % Abhängigkeit kommt durch df_mdVa, über cH, cH Berechnung fließt u(2) =
  % Bic ein
  
  %% TODO
  % improve documentation
  % add formulas
  %
  C(1,:)= [0, 0, k_g * r_g * x(4) * y_ch4_m * df_mdVa, ...
           k_g * r_g * f_m * y_ch4_m, 0, 0];
         
  C(2,:)= [0, 0, 0, 0, k_g * k_la, - k_g * k_la * k_h];
  
  %% TODO
  % difficult to model dependency of H^+
  %
  %C(3,:)= [0, 0, 0, 0, 0, 0];
  
end


%%

if isempty(retval)

  varargout{1}= A;
  varargout{2}= B;
  varargout{3}= C;
  
elseif strcmp(retval, 'A')
  
  varargout{1}= A;
  
elseif strcmp(retval, 'B')
  
  varargout{1}= B;
  
elseif strcmp(retval, 'C')
  
  varargout{1}= C;

end



%% calculate absolute differential:
%
% $$\vec{x}'(t) \approx \vec{x}'(t_0) + A \cdot 
% \left( \vec{x}(t) - \vec{x}(t_0) \right) + 
% B \cdot \left( \vec{u}(t) - \vec{u}(t_0) \right) $$
%

% u0= u;
% 
% xdot= x0dot + A * ( x - x0 ) + B * ( u - u0 );
% 
% if calceig == 1
% 
% %% calculate eigenvalues and eigenvectors of the system matrix A
% % 
% [eigVec, lambdaM]= eig(A);
% 
% % put the eigenvalues in a vector
% 
% lambda= diag(lambdaM);
% 
% else
%    
%     eigVec= 0;
%     lambda= 0;
%     
% end

%%


