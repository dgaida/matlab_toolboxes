%% 2-D Examples
% 
%

%% 
% No. 1
%
% $$\vec{x}_i := (x_1, x_2)^T \in R^2, i= 1, \dots, 35$$
%
% $$(0, 0)^T \leq \vec{x}_i \leq (5, 10)^T$$
%
numerics.conRandMatrix(2, 35, [], [], [], [], [0,0], [5,10], []);

%% 
% No. 2
%
% $$\vec{x}_i := (x_1, x_2)^T \in R^2, i= 1, \dots, 15$$
%
% $$(0, 0)^T \leq \vec{x}_i \leq (10, 10)^T$$
%
% $$(-1, 1) \cdot \vec{x}_i = 0$$
%                 
numerics.conRandMatrix(2, 15, [], [], [-1, 1], 0, [0,0], [10,10], []);

%% 
% No. 3
%
% $$\vec{x}_i := (x_1, x_2)^T \in R^2, i= 1, \dots, 10$$
%
% $$(0, 0)^T \leq \vec{x}_i \leq (4, 4)^T$$
%
% $$(1, 1) \cdot \vec{x}_i \leq 5$$
%
% $$(-1, 1) \cdot \vec{x}_i = 1$$
%                         
% $$-x_1 + x_2 = 1$$
%
% $$x_2 = 1 + x_1$$
%
numerics.conRandMatrix(2, 10, [1, 1], 5, [-1, 1], 1, [0,0], [4,4], []);

set(gcf, 'Name', 'Hase');

figures= findobj('Name', '');

figure1= figures(1);

% Create textarrow
annotation(figure1,'textarrow',[0.632047477744807 0.612759643916914],...
    [0.356088560885609 0.40590405904059],'TextEdgeColor','none',...
    'Interpreter','latex',...
    'String',{'$-A''$'});

% Create textarrow
annotation(figure1,'textarrow',[0.680237388724037 0.635014836795252],...
    [0.638671586715865 0.59409594095941],'TextEdgeColor','none',...
    'Interpreter','latex',...
    'String',{'$A \cdot \vec{x} \leq \vec{b}$','$(1, 1) \cdot \vec{x} \leq 5$'});

% Create arrow
annotation(figure1,'arrow',[0.189910979228487 0.353115727002967],...
    [0.107856088560886 0.313653136531365]);

% Create textarrow
annotation(figure1,'textarrow',[0.672106824925816 0.614243323442137],...
    [0.797047970479705 0.821033210332103],'TextEdgeColor','none',...
    'Interpreter','latex',...
    'String',{'$Aeq \cdot \vec{x}=\vec{b}_{eq}$','$(-1, 1) \cdot \vec{x} = 1$'});

% Create textbox
annotation(figure1,'textbox',...
    [0.266578635014837 0.180811808118081 0.122145400593472 0.031365313653136],...
    'Interpreter','latex',...
    'String',{'$null(Aeq)$','$\left|null(Aeq)\right|=1$'},...
    'FitBoxToText','off',...
    'LineStyle','none');

%% 
% No. 4
%
% $$\vec{x}_i := (x_1, x_2)^T \in R^2, i= 1, \dots, 50$$
%
% $$(0, 0)^T \leq \vec{x}_i \leq (10, 10)^T$$
%
% $$(1, -1) \cdot \vec{x}_i \leq 0$$
%
numerics.conRandMatrix(2, 50, [1, -1], 0, [], [], [0,0], [10,10], []);
  
%% 
% No. 5
%
% $$\vec{x}_i := (x_1, x_2)^T \in R^2, i= 1, \dots, 50$$
%
% $$(0, 0)^T \leq \vec{x}_i \leq (10, 10)^T$$
%
% $$\left[ 
% { \matrix{ 1 & -1 \cr 
%           -1 &  1 \cr } } 
% \right] \cdot \vec{x}_i \leq (3, 3)^T$$
%
numerics.conRandMatrix(2, 50, [1, -1; -1, 1], [3; 3], [], [], [0,0], [10,10], []);

%% 
% No. 6
%
% $$\vec{x}_i := (x_1, x_2)^T \in R^2, i= 1, \dots, 10$$
%
% $$(0, 0)^T \leq \vec{x}_i \leq (10, 10)^T$$
%
% $$\left[ 
% { \matrix{ 1 & -1 \cr 
%           -1 &  1 \cr } } 
% \right] \cdot \vec{x}_i \leq (3, 3)^T$$
%
% $$(-1, 1) \cdot \vec{x}_i = 0$$
%
% $$(1, -1) \cdot (x_1, x_2)^T \leq 3$$
%
% $$x_1 - x_2 \leq 3$$
%
% $$x_2 \geq x_1 - 3$$
%
% $$(-1, 1) \cdot (x_1, x_2)^T \leq 3$$
%
% $$-x_1 + x_2 \leq 3$$
%
% $$x_2 \leq x_1 + 3$$
%
% $$x_1 - 3 \leq x_2 \leq x_1 + 3$$
% 
numerics.conRandMatrix(2, 10, [1, -1; -1, 1], [3; 3], [-1, 1], 0, ...
                            [0,0], [10,10], []);

%% 
% No. 7
%
% $$\vec{x}_i := (x_1, x_2)^T \in R^2, i= 1, \dots, 10$$
%
% $$(0, 0)^T \leq \vec{x}_i \leq (4, 4)^T$$
%
% $$(1, 1) \cdot \vec{x}_i \leq 5$$
%
% $$(-1, 1) \cdot \vec{x}_i = 1$$
%                         
% $$-x_1 + x_2 = 1$$
%
% $$x_2 = 1 + x_1$$
%
numerics.conRandMatrix(2, 10, [1, 1], 5, [-1, 1], 1, ...
                            [0,0], [4,4], @(r)nonlconSphere(r, 2, 0, 1, 0), ...
                            [], [], [], [], [], [], 0, 1);

%% 
% No. 8
%
% $$\vec{x}_i := (x_1, x_2)^T \in R^2, i= 1, \dots, 10$$
%
% $$(0, 0)^T \leq \vec{x}_i \leq (10, 10)^T$$
%
% $$\left[ 
% { \matrix{ 1 & -1 \cr 
%           -1 &  1 \cr } } 
% \right] \cdot \vec{x}_i \leq (3, 3)^T$$
%
% $$(-1, 1) \cdot \vec{x}_i = 0$$
%
% $$(1, -1) \cdot (x_1, x_2)^T \leq 3$$
%
% $$x_1 - x_2 \leq 3$$
%
% $$x_2 \geq x_1 - 3$$
%
% $$(-1, 1) \cdot (x_1, x_2)^T \leq 3$$
%
% $$-x_1 + x_2 \leq 3$$
%
% $$x_2 \leq x_1 + 3$$
%
% $$x_1 - 3 \leq x_2 \leq x_1 + 3$$
% 
numerics.conRandMatrix(2, 10, [1, -1; -1, 1], [3; 3], [-1, 1], 0, ...
                            [0,0], [10,10], ...
                            @(r)nonlconSphere(r, 4, 5, 1, 0), ...
                       [], [], [], [], [], [], 0, 1);

%% 
% No. 9
%
% $$\vec{x}_i := (x_1, x_2)^T \in R^2, i= 1, \dots, 50$$
%
% $$(0, 0)^T \leq \vec{x}_i \leq (10, 10)^T$$
%
% $$\left[ 
% { \matrix{ 1 & -1 \cr 
%           -1 &  1 \cr } } 
% \right] \cdot \vec{x}_i \leq (3, 3)^T$$
%
numerics.conRandMatrix(2, 50, [1, -1; -1, 1], [3; 3], ...
                            [], [], [0,0], [10,10], ...
                            @(r)nonlconSphere(r, 3, 5, 0, 1), ...
                       [], [], [], [], [], [], 0, 1);

%% 
% No. 10
%
% $$\vec{x}_i := (x_1, x_2)^T \in R^2, i= 1, \dots, 10$$
%
% $$(0, 0)^T \leq \vec{x}_i \leq (4, 4)^T$$
%
% $$(1, 1) \cdot \vec{x}_i \leq 5$$
%
% $$(-1, 1) \cdot \vec{x}_i = 1$$
%                         
% $$-x_1 + x_2 = 1$$
%
% $$x_2 = 1 + x_1$$
%
numerics.conRandMatrix(2, 10, [1, 1], 5, [-1, 1], 1, [0,0], [4,4], ...
                            @(r)nonlconSphere(r, 1.0, [2,3], 1, 0), ...
                       [], [], [], [], [], [], 0, 1);

%%


