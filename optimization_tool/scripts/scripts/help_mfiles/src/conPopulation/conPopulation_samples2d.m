%% 2-D Examples
%
% 

%%
% No. 1
%
% use length of genome = 3
%
% $$\vec{x}_i := (x_1, x_2)^T \in R^2, i= 1, \dots, 10$$
%
% $$(0, 1)^T \leq \vec{x}_i \leq (5, 6)^T$$
%
% $$(1, 1) \cdot \vec{x}_i \leq 6$$
%
% $$(1, 0) \cdot \vec{x}_i = 4$$
%                      
optimization.conPopulation(2, 10, [1 1], 6, [1 0], 4, [0 1], [5 6], ...
                           [], {'CMAES'}, {'CMAES'}, [], [], [], 3)

%%
% No. 2
%
% use length of genome = 2
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
% ==>
%
% $$x_1= x_2$$
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
% ==>
%
% $$x_1 - 3 \leq x_1 \leq x_1 + 3$$
%
% is always true, thus this constraint is not plotted, because not
% existing. 
% 
optimization.conPopulation(2, 10, [1, -1; -1, 1], [3; 3], [-1, 1], 0, ...
                           [0,0], [10,10], [], {'CMAES'}, {'CMAES'}, [], [], ...
                           [], 3, [], 1);

%%

plotnonlcon= 0; % 1 - takes very long

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
optimization.conPopulation(2, 10, [1, 1], 5, [-1, 1], 1, ...
                           [0,0], [4,4], @(r)nonlconSphere(r, 2, 0, 1, 0), ...
                           {'CMAES'}, {'CMAES'}, [], [], [], 3, 0, plotnonlcon);
 
%% 
% No. 4
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
optimization.conPopulation(2, 10, [1, 1], 5, [-1, 1], 1, [0,0], [4,4], ...
                           @(r)nonlconSphere(r, 1.0, [2,3,2,3,2,3], 1, 0), ...
                           {'CMAES'}, {'CMAES'}, [], [], [], 3, 0, plotnonlcon);

%%


