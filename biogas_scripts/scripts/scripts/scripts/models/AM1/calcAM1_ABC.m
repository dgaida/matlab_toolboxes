%% calcAM1_ABC
% Calc A, B, C matrix of AM1 model
%
function varargout= calcAM1_ABC(x, p, varargin)
%% Release: 1.6

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%

isRn(x, 'x', 1);%, '+');
checkArgument(p, 'p', 'struct', '2nd');

%%
% $$x'(t)= f(x(t)) + B \cdot u(t)$$
% $$x'(t) \approx f(x_0) + f'(x_0) \cdot ( x(t) - x_0 ) + B \cdot u(t)$$
% $$f(x(t)) + B \cdot u(t) - f(x_0) \approx f'(x_0) \cdot ( x(t) - x_0 ) +
% B \cdot u(t)$$ 
% $$\Delta x := x(t) - x_0$$
% für kleines $\Delta x$ gilt
% $$f(\Delta x) + B \cdot u(t) \approx f'(x_0) \cdot \Delta x + B \cdot
% u(t)$$ 
% $$\Delta x'(t) \approx f'(x_0) \cdot \Delta x$$
%
%
% $$\vec f ( \vec x ) = \left( - D \cdot S_1 - k_1 \cdot \mu_1(S_1) \cdot X_1
%                              ( \mu_1(S_1) - \alpha \cdot D ) \cdot X_1 
%                              ... 
%                              ... \right)$$
%
%
% $$B= ( D 0
%        0 0 
%        0 D 
%        0 0 )$$
%
%
% $$\frac{d f_1}{d \vec{x}}^T \left( \vec x \right) = 
% ( - D - k_1 \cdot X_1 \cdot \frac{d \mu_1(S_1)}{d S_1} 
%   - k_1 \cdot \mu_1(S_1)
%   0
%   0 )$$ 
%
% $$\frac{d f_2}{d \vec{x}}^T \left( \vec x \right) = 
% ( X_1 \cdot \frac{d \mu_1(S_1)}{d S_1}
%   \mu_1(S_1) - \alpha \cdot D
%   0
%   0 )$$
%
% $$\frac{d f_3}{d \vec{x}}^T \left( \vec x \right) = 
% ( k_2 \cdot X_1 \cdot \frac{d \mu_1(S_1)}{d S_1} 
%   k_2 \cdot \mu_1(S_1)
%   - D - k_3 \cdot X_2 \cdot \frac{d \mu_2(S_2)}{d S_2} 
%   -k_3 \cdot \mu_2(S_2) )$$
%
% $$\frac{d f_4}{d \vec{x}}^T \left( \vec x \right) = 
% ( 0
%   0
%   \frac{d \mu_2(S_2)}{d S_2} \cdot X_2
%   \mu_2(S_2) - \alpha \cdot D )$$
%
%
% $$\frac{d \mu_1(S_1)}{d S_1} = \frac{ \mu1max \cdot K1S }{ ( K1S + S_1 )^2 }$$
%
% $$\frac{d \mu_2(S_2)}{d S_2} = \mu2max \cdot \frac{ ( KS2 + S_2 +
% (S_2/KI2)^2 ) - S_2 \cdot (...) }{ ( KS2 + S_2 + (S_2/KI2)^2 )^2 }$$ 
%
% (...) = 1 + 2 \cdot S2/KI2^2
%


%%

if nargin >= 3 && ~isempty(varargin{1})
  retval= varargin{1};
  % 'A', 'B', 'C'
  checkArgument(retval, 'retval', 'char', '3rd');
else
  retval= [];
end

%% 
% parameters
%

k1= p.k1;           
k2= p.k2;
k3= p.k3;
k4= p.k4;
alpha= p.alpha;

mu1max= p.mu1max;
KS1= p.KS1;

mu2max= p.mu2max;
KS2= p.KS2;
KI2= p.KI2;

%%
% Dilution rate: 
D= p.D; 

%%

S1= x(1);       % concentration of COD [g/l]
X1= x(2);       % concentration of acidogenic biomass [g/l]
S2= x(3);       % concentration of VFA [mmol/l]
X2= x(4);       % concentration of methanogenic biomass [g/l]

%%
% variables
%

[mu1, mu2]= AM1ode4_vars(x, p);

%%

dmu1_dS1= mu1max * KS1 / ( KS1 + S1 )^2;

term1= KS2 + S2 + (S2 / KI2)^2;
term2= S2 * ( 1 + 2 * S2 / KI2^2 );

dmu2_dS2= mu2max * ( term1 - term2 ) / term1^2;

%%

if isempty(retval) || strcmp(retval, 'A')
  
  %%
  
  d_f1_dx= [-D - k1 * X1 * dmu1_dS1, -k1 * mu1, 0, 0];

  d_f2_dx= [X1 * dmu1_dS1, mu1 - alpha * D, 0, 0];

  d_f3_dx= [k2 * X1 * dmu1_dS1, k2 * mu1, -D - k3* X2 * dmu2_dS2, -k3 * mu2];

  d_f4_dx= [0, 0, dmu2_dS2 * X2, mu2 - alpha * D];

  %%

  A= [d_f1_dx; d_f2_dx; d_f3_dx; d_f4_dx];

end

if isempty(retval) || strcmp(retval, 'B')

  B= [D 0
      0 0
      0 D
      0 0];
    
end

%% 

if isempty(retval) || strcmp(retval, 'C')

  d_qm_dx= [0, 0, k4 * X2 * dmu2_dS2, k4 * mu2];

  C= d_qm_dx;

  %% TODO
  % nur temp. test nicht beobachtbares System
  
  %C= [1 0 0 0];

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

%%


