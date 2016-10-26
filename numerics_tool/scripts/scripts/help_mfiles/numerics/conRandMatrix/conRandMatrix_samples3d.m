%% 3-D Examples
% 
%

%% 
% No. 1
%
% $$\vec{x}_i := (x_1, x_2, x_3)^T \in R^3, i= 1, \dots, 50$$
%
% $$(0, 0, 0)^T \leq \vec{x}_i \leq (10, 10, 5)^T$$      
%
numerics.conRandMatrix(3, 50, [], [], [], [], [0,0,0], [10,10,5], []);

%% 
% No. 2
%
% $$\vec{x}_i := (x_1, x_2, x_3)^T \in R^3, i= 1, \dots, 50$$
%
% $$(0, 0, 0)^T \leq \vec{x}_i \leq (10, 10, 5)^T$$      
%
% $$(1, 0, 0) \cdot \vec{x}_i \leq 5$$
%
numerics.conRandMatrix(3, 50, [1, 0, 0], 5, [], [], [0,0,0], [10,10,5], []);
                      
%% 
% No. 3
%
% $$\vec{x}_i := (x_1, x_2, x_3)^T \in R^3, i= 1, \dots, 20$$
%
% $$(0, 0, 0)^T \leq \vec{x}_i \leq (5, 5, 2)^T$$      
%
% $$(1, 1, 0) \cdot \vec{x}_i \leq 5$$
%
% $$\left[ 
% { \matrix{ -1 & 1 & 0 \cr 
%             0 & 0 & 1 \cr } } 
% \right] \cdot \vec{x}_i = (1, 1)^T$$
%
numerics.conRandMatrix(3, 20, [1, 1, 0], 5, [-1, 1, 0; 0, 0, 1], [1; 1], ...
                                                 [0,0,0], [5,5,2], []);

%% 
% No. 4
%
% $$\vec{x}_i := (x_1, x_2, x_3)^T \in R^3, i= 1, \dots, 50$$
%
% $$(0, 0, 0)^T \leq \vec{x}_i \leq (5, 5, 2)^T$$      
%
% $$\left[ 
% { \matrix{  1 & 1 & 0 \cr 
%             0 & 0 & 1 \cr
%             1 & 0 & 1 \cr } } 
% \right] \cdot \vec{x}_i \leq (5, 1, 2)^T$$
%
% $$(-1, 1, 0) \cdot \vec{x}_i = 1$$
%
numerics.conRandMatrix(3, 50, [1, 1, 0; 0, 0, 1; 1, 0, 1], [5; 1; 2], ...
                                   [-1, 1, 0], 1, ...
                                   [0,0,0], [5,5,2], []);

%% 
% No. 5
%
% $$\vec{x}_i := (x_1, x_2, x_3)^T \in R^3, i= 1, \dots, 50$$
%
% $$(0, 0, 0)^T \leq \vec{x}_i \leq (5, 5, 2)^T$$      
%
% $$\left[ 
% { \matrix{    1 & 0 & 5/2 \cr 
%             2/5 & 0 & -1 \cr } } 
% \right] \cdot \vec{x}_i \leq (5, 0)^T$$
%
numerics.conRandMatrix(3, 50, [1, 0, 5/2; 2/5, 0, -1], [5; 0], ...
                                   [], [], ...
                                   [0,0,0], [5,5,2], []);
                               
%% 
% No. 6
%
% $$\vec{x}_i := (x_1, x_2, x_3)^T \in R^3, i= 1, \dots, 50$$
%
% $$(0, 0, 0)^T \leq \vec{x}_i \leq (5, 5, 2)^T$$      
%
% $$(1, 1, 0) \cdot \vec{x}_i \leq 5$$
%
% $$(-1, 1, 1) \cdot \vec{x}_i = 1$$
%
numerics.conRandMatrix(3, 50, [1, 1, 0], 5, ...
                                   [-1, 1, 1], 1, ...
                                   [0,0,0], [5,5,2], []);

%%

plotnonlcon= 0; % 1 - takes very long

%% 
% No. 7
%
% $$\vec{x}_i := (x_1, x_2, x_3)^T \in R^3, i= 1, \dots, 25$$
%
% $$(0, 0, 0)^T \leq \vec{x}_i \leq (5, 5, 2)^T$$      
%
% $$(1, 1, 0) \cdot \vec{x}_i \leq 5$$
%
% $$(-1, 1, 1) \cdot \vec{x}_i = 1$$
%
numerics.conRandMatrix(3, 25, [1, 1, 0], 5, ...
                                   [-1, 1, 1], 1, ...
                                   [0,0,0], [5,5,2], ...
                                   @(r)nonlconSphere(r, 2, 0, 0, 1), ...
                       {'CMAES'}, {'CMAES'}, [], [], [], [], 0, plotnonlcon);

%% 
% No. 8
%
% $$\vec{x}_i := (x_1, x_2, x_3)^T \in R^3, i= 1, \dots, 40$$
%
% $$(0, 0, 0)^T \leq \vec{x}_i \leq (5, 5, 2)^T$$      
%
% $$(1, 1, 0) \cdot \vec{x}_i \leq 5$$
%
% $$(-1, 1, 1) \cdot \vec{x}_i = 1$$
%
numerics.conRandMatrix(3, 40, [1, 1, 0], 5, ...
                                   [-1, 1, 1], 1, ...
                                   [0,0,0], [5,5,2], ...
                                   @(r)nonlconSphere(r, 2, 0, 1, 0), ...
                       {'CMAES'}, {'CMAES'}, [], [], [], [], 0, plotnonlcon);

%%

close all;

%% 
% No. 9
%
% $$\vec{x}_i := (x_1, x_2, x_3)^T \in R^3, i= 1, \dots, 50$$
%
% $$(0, 0, 0)^T \leq \vec{x}_i \leq (10, 10, 5)^T$$      
%
numerics.conRandMatrix(3, 50, [], [], [], [], ...
                            [0,0,0], [10,10,5], ...
                            @(r)nonlconSphere(r, 2, [5,5,2], 1, 0), ...
                       {'CMAES'}, {'CMAES'}, [], [], [], [], 0, plotnonlcon);

%% 
% No. 10
%
% $$\vec{x}_i := (x_1, x_2, x_3)^T \in R^3, i= 1, \dots, 50$$
%
% $$(0, 0, 0)^T \leq \vec{x}_i \leq (10, 10, 5)^T$$      
%
numerics.conRandMatrix(3, 50, [], [], [], [], ...
                            [0,0,0], [10,10,5], ...
                            @(r)nonlconSphere(r, 1, [5,5,2], 0, 1), ...
                       {'CMAES'}, {'CMAES'}, [], [], [], [], 0, plotnonlcon);

%% 
% No. 11
%
% $$\vec{x}_i := (x_1, x_2, x_3)^T \in R^3, i= 1, \dots, 40$$
%
% $$(0, 0, 0)^T \leq \vec{x}_i \leq (10, 10, 5)^T$$      
%
% $$(0, 1, 0) \cdot \vec{x}_i \leq 5$$
%
numerics.conRandMatrix(3, 40, [0, 1, 0], 5, [], [], ...
                            [0,0,0], [10,10,5], ...
                            @(r)nonlconSphere(r, 2, [5,5,2], 1, 0), ...
                       {'CMAES'}, {'CMAES'}, [], [], [], [], 0, plotnonlcon);

%% 
% No. 12
%
% $$\vec{x}_i := (x_1, x_2, x_3)^T \in R^3, i= 1, \dots, 30$$
%
% $$(0, 0, 0)^T \leq \vec{x}_i \leq (10, 10, 5)^T$$      
%
% $$(0, 1, 0) \cdot \vec{x}_i = 5$$
%
numerics.conRandMatrix(3, 30, [], [], [0, 1, 0], 5, ...
                            [0,0,0], [10,10,5], ...
                            @(r)nonlconSphere(r, 1, [5,5,2], 0, 1), ...
                       {'CMAES'}, {'CMAES'}, [], [], [], [], 0, plotnonlcon);

%% 
% No. 13
%
% $$\vec{x}_i := (x_1, x_2, x_3)^T \in R^3, i= 1, \dots, 30$$
%
% $$(0, 0, 0)^T \leq \vec{x}_i \leq (10, 10, 5)^T$$      
%
% $$\left[ 
% { \matrix{    0 & 1 & 0 \cr 
%               0 & 0 & 1 \cr } } 
% \right] \cdot \vec{x}_i \leq (5, 2)^T$$
%
numerics.conRandMatrix(3, 30, [0, 1, 0; 0, 0, 1], [5; 2], ...
                            [], [], ...
                            [0,0,0], [10,10,5], ...
                            @(r)nonlconSphere(r, 2, [5,5,2], 1, 0), ...
                       {'CMAES'}, {'CMAES'}, [], [], [], [], 0, plotnonlcon);

%%

close all;
                        
%% 
% No. 14
%
% $$\vec{x}_i := (x_1, x_2, x_3)^T \in R^3, i= 1, \dots, 20$$
%
% $$(0, 0, 0)^T \leq \vec{x}_i \leq (10, 10, 5)^T$$      
%
% $$(0, 0, 1) \cdot \vec{x}_i \leq 2$$
%
% $$(0, 1, 0) \cdot \vec{x}_i = 5$$
%
numerics.conRandMatrix(3, 20, [0, 0, 1], 2, [0, 1, 0], 5, ...
                            [0,0,0], [10,10,5], ...
                            @(r)nonlconSphere(r, 1, [5,5,2], 0, 1), ...
                       {'CMAES'}, {'CMAES'}, [], [], [], [], 0, plotnonlcon);
                        
%%                         


