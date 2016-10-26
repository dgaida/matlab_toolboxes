%% Syntax
%       [A, B, C]= calcADode6_ABC(t, x, u, deltatk, p)
%       [A]= calcADode6_ABC(t, x, u, deltatk, p, 'A')
%       [B]= calcADode6_ABC(t, x, u, deltatk, p, 'B')
%       [C]= calcADode6_ABC(t, x, u, deltatk, p, 'C')
%       
%% Description
% |[A, B, C]= calcADode6_ABC(t, x, u, deltatk, p)| calculates the absolute
% differential of the ad model 'f' at the state |x|:
%
% $$d x_i'(t) := \sum_{j=1}^{n} { \frac{\partial x_i'(t_0)}{\partial x_j(t)} \cdot d x_j(t) } + 
% \sum_{k=1}^{u} { \frac{\partial x_i'(t_0)}{\partial u_k(t)} \cdot d
% u_k(t) } \qquad \qquad i= 1, \dots, n$$
% 
% with the definition:
% 
% $$d \vec{x}'(t) := \left( d x_1'(t), \dots, d x_i'(t), \dots, d x_n'(t) \right)^T$$
%
% using the approximations:
% 
% $$d \vec{x}'(t) \approx \vec{x}'(t) - \vec{x}'(t_0) \qquad , \qquad
% d \vec{x}(t) \approx \vec{x}(t) - \vec{x}(t_0) \qquad , \qquad
% d \vec{u}(t) \approx \vec{u}(t) - \vec{u}(t_0)$$
%
% one obtains
%
% $$x_i'(t) \approx x_i'(t_0) + \sum_{j=1}^{n} { \frac{\partial x_i'(t_0)}{\partial x_j(t)} \cdot 
% \left( x_j(t) - x_j(t_0) \right) } + 
% \sum_{k=1}^{u} { \frac{\partial x_i'(t_0)}{\partial u_k(t)}
% \cdot \left( u_k(t) - u_k(t_0) \right)  } \qquad \qquad i= 1, \dots, n$$
%
% introducing
%
% $$A_{i,j} := \frac{\partial x_i'(t_0)}{\partial x_j(t)} \qquad \qquad A
% := \left[ A_{i,j} \right] \qquad \qquad i= 1, \dots, n \qquad j= 1, \dots, n$$ 
%
% $$B_{i,j} := \frac{\partial x_i'(t_0)}{\partial u_j(t)} \qquad \qquad B
% := \left[ B_{i,j} \right] \qquad \qquad i= 1, \dots, n \qquad k= 1, \dots, u$$ 
%
% leads to
%
% $$\vec{x}'(t) \approx \vec{x}'(t_0) + A \cdot 
% \left( \vec{x}(t) - \vec{x}(t_0) \right) + 
% B \cdot \left( \vec{u}(t) - \vec{u}(t_0) \right) $$
%
%%
% @param |t| : current simulation time, double scalar
%
%%
% @param |x| : 6 dim. state vector. double
%
%%
% @param |u| : double matrix. It has as many number of rows as the system
% has inputs, thus 2. Each row symbolizes one sample of the input. 
%
%%
% @param |deltatk| : sampling time of the input of the system. Row
% |round(t/deltatk + 0.5)| is taken out of given |u|.
%
%%
% @param |p| : parameter vector, struct, can be created by
% <setadode6params.html setADode6params> 
%
%%
% @return |A| : matrix A
%
%%
% @return |B| : matrix B
%
%%
% @return |C| : matrix C
%
%% 
% derivatives of inhibition functions
%
% $$
% \frac{\partial f_a \left( S(t_0), S_i(t_0) \right) }{\partial S(t)}= 
% \frac{k_{sa} + S_i(t_0)}{S_i(t_0)} \cdot \mu_{max}^a \cdot \left(
% \frac{1}{k_{sa} + S(t_0)} - \frac{S(t_0)}{ \left( k_{sa} + S(t_0) \right)^2 } \right) 
% $$
%
%%
% $$\frac{\partial f_a \left( S(t), S_i(t) \right) }{\partial S_i(t)} = 
% \frac{\mu_{max}^a \cdot S(t_0)}{k_{sa} + S(t_0)} \cdot \left(
% \frac{1}{S_i(t_0)} - \frac{k_{sa} + S_i(t_0)}{ \left( S_i(t_0) \right)^2 } \right)
% $$
%
%%
%
%
%% 
% build linear system matrix A
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
%
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
%
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
%
%%
%
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
%
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
%
%%
%
% $$d P_c'(t) := \dots + \frac{\partial P_c'(t_0)}{\partial V_a(t)} \cdot d V_a(t) + 
% \frac{\partial P_c'(t_0)}{\partial X_m(t)} \cdot d X_m(t) + 
% \frac{\partial P_c'(t_0)}{\partial C(t)} \cdot d C(t) + 
% \frac{\partial P_c'(t_0)}{\partial P_c(t)} \cdot d P_c(t) + 
% \dots$$
%
% $$
% \frac{\partial P_c'(t_0)}{\partial V_a(t)}= -k_g \cdot r_g \cdot P_c(t_0)
% \cdot X_m(t_0) \cdot y_{ch4}^m \cdot  
% \frac{\partial f_m \left( V_a(t_0) \right) }{\partial V_a(t)}
% $$
% 
% $$
% \frac{\partial P_c'(t_0)}{\partial X_m(t)}= -k_g \cdot r_g \cdot P_c(t_0) \cdot y_{ch4}^m \cdot 
% f_m \left( V_a(t_0) \right)
% \qquad \qquad \qquad \qquad
% \frac{\partial P_c'(t_0)}{\partial C(t)}= k_g \cdot k_{la} \cdot \left( 1
% - P_c(t_0) \right)
% $$
%
% intermediate result:
%
% $$
% P_c'(t)= -k_g k_{la} \cdot 
% k_h \cdot P_c(t) + k_g \cdot k_{la} \cdot k_h \cdot \left( P_c(t) \right)^2 -
% k_g \cdot k_{la} \cdot C(t) \cdot P_c(t) - r_g \cdot P_c(t) \cdot k_g \cdot f_m \left( V_a(t)
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
%
%% 
% build input matrix B
%
% $$
% \frac{\partial S'(t_0)}{\partial S_i(t)}= D - Y_a \cdot X_a(t_0) \cdot
% \frac{\partial f_a \left( S(t_0), S_i(t_0) \right) }{\partial S_i(t)}
% $$
%
%% 
% $$
% \frac{\partial X_a'(t_0)}{\partial S_i(t)}= X_a(t_0) \cdot
% \frac{\partial f_a \left( S(t_0), S_i(t_0) \right) }{\partial S_i(t)}
% $$
%
%%
% $$
% \frac{\partial V_a'(t_0)}{\partial S_i(t)}= X_a(t_0) \cdot y_{vf}^a \cdot
% \frac{\partial f_a \left( S(t_0), S_i(t_0) \right) }{\partial S_i(t)}
% $$
%
%%
% $$
% \frac{\partial V_a'(t_0)}{\partial S_i(t)}= X_a(t_0) \cdot y_{co2}^a \cdot
% \frac{\partial f_a \left( S(t_0), S_i(t_0) \right) }{\partial S_i(t)}
% $$
%
%
%% Example
%
%

D= 0.90;

p= setADode6params(D);

S_i= 3793.827207;
B_ic= 1077.663387;

u= [S_i, B_ic];

x= [15 1928.452487 4.8077 994.0616 265.299 0.24199];

[A, B, C]= calcADode6_ABC(0, x, u, 1, p);

disp('A')
disp(A)

disp('B')
disp(B)

disp('C')
disp(C)

%%
% check observability
% hier rang ist 3, unten kommt sum(k)= 6 raus, system ist also doch
% beobachtbar, nur mit dieser funktion nicht bestimmbar, s. ebenfalls
% matlab doku, welche davor warnt diese funktion zu nutzen

r= rank ( obsv( A, C ) );

if r < size(A, 1)
  warning('system:notobservable', ...
          'the system is not observable: rank (%i) < %i', r, size(A, 1));
end


%%
% decomposes the state-space system with matrices A, B, and C into the
% observability staircase form Abar, Bbar, and Cbar, as described above
% (see documentation: <matlab:doc('obsvf') obsvf>). T 
% is the similarity transformation matrix and k is a vector of length n,
% where n is the number of states in A. Each entry of k represents the
% number of observable states factored out during each step of the
% transformation matrix calculation [1]. The number of nonzero elements in
% k indicates how many iterations were necessary to calculate T, and sum(k)
% is the number of states in Ao, the observable portion of Abar. 
%

[Abar,Bbar,Cbar,T,k]= obsvf(A,B,C)

if sum(k) < size(A, 1)
  warning('system:notobservable', ...
          'the system is not observable: sum(k) (%i) < %i', sum(k), size(A, 1));
end

%% 
% check controlability

rc= rank ( ctrb( A, B ) )

%%
% See documentation: <matlab:doc('ctrbf') ctrbf>
%

[Abar,Bbar,Cbar,T,k]= ctrbf(A,B,C)

if sum(k) < size(A, 1)
  warning('system:notcontrolable', ...
          'the system is not controlable: sum(k) (%i) < %i', sum(k), size(A, 1));
end


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/adode6_vars')">
% biogas_scripts/ADode6_vars</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('script_collection/isrn')">
% script_collection/isRn</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_scripts/setadode6params')">
% biogas_scripts/setADode6params</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('biogas_scripts/adode6')">
% biogas_scripts/ADode6</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('biogas_scripts/calcadode6y')">
% biogas_scripts/calcADode6y</a>
% </html>
% , 
% <html>
% <a href="matlab:doc('biogas_scripts/am1ode4')">
% biogas_scripts/AM1ode4</a>
% </html>
%
%% TODOs
% # check documentation
% # make TODO in script
% # maybe improve example
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Shen, S.; Premier, G.C.; Guwy, A. and Dinsdale, R.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\07 bifurcation and stability analysis of an anaerobic digestion model.pdf'', 
% biogas_scripts.getHelpPath())'))">
% Bifurcation and stability analysis of an anaerobic digestion model</a>, 
% in Nonlinear Dynamics, vol. 48(4), pp. 391-408, 2007. 
% </li>
% <li> 
% Marsili-Libelli, S.; Beni, S.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\96 Shock load modelling in the anaerobic digestion process.pdf'', 
% biogas_scripts.getHelpPath())'))">
% Shock load modelling in the anaerobic digestion process</a>, 
% in Ecological Modelling, vol. 84(1-3), pp. 215-232, 1996. 
% </li>
% </ol>
% </html>
%


