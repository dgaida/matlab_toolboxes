%% 1-D Examples
%
% 

%%
% No. 1
%
% $$x_i \in R, i= 1, \dots, 10$$
%
% $$0 \leq x_i \leq 5$$
%
% $$1 \cdot x_i \leq 3$$
%
% use length of genome = 3
% 
optimization.conPopulation(1, 10, 1, 3, [], [], 0, 5, ...
                           [], {'CMAES'}, {'CMAES'}, [], [], [], 3)

%% 
% No. 2
%
% $$x_i \in R, i= 1, \dots, 10$$
%
% $$0 \leq x_i \leq 10$$
%
% $$(1, -1)^T \cdot x_i \leq (6, -4)^T$$
% 
optimization.conPopulation(1, 10, [1; -1], [6; -4], [], [], 0, 10, ...
                           [], {'CMAES'}, {'CMAES'}, [], [], [], 3)

%% 
% No. 3
%
% $$x_i \in R, i= 1, \dots, 10$$
%
% $$0 \leq x_i \leq 10$$
%
optimization.conPopulation(1, 10, [], [], [], [], 0, 10, ...
                       @(r)nonlconSphere(r, 1, 3, 1, 0), ...
                       {'CMAES'}, {'CMAES'}, [], [], [], 2, [], 1)

%% 
% No. 4
%
% $$x_i \in R, i= 1, \dots, 10$$
%
% $$0 \leq x_i \leq 10$$
%
% $$1 \cdot x_i \leq 5$$
%
optimization.conPopulation(1, 10, 1, 5, [], [], 0, 10, ...
                       @(r)nonlconSphere(r, 1, 3, 1, 0), ...
                       {'CMAES'}, {'CMAES'}, 'none', 1, [], 3, [], 1)

%%


