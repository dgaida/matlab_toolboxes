%% 1-D Examples
% 
%

%% 
% No. 1
%
% $$x_i \in R, i= 1, \dots, 10$$
%
% $$0 \leq x_i \leq 10$$
%
numerics.conRandMatrix(1, 10, [], [], [], [], 0, 10, [])

%% 
% No. 2
%
% $$x_i \in R, i= 1, \dots, 10$$
%
% $$0 \leq x_i \leq 10$$
%
% $$1 \cdot x_i = 5$$
% 
try
  numerics.conRandMatrix(1, 10, [], [], 1, 5, 0, 10, [])
catch ME
  disp(ME.message)
end

%%
% No. 3
%
% $$x_i \in R, i= 1, \dots, 10$$
%
% $$0 \leq x_i \leq 10$$
%
% $$1 \cdot x_i \leq 6$$
% 
numerics.conRandMatrix(1, 10, 1, 6, [], [], 0, 10, [])

%% 
% No. 4
%
% $$x_i \in R, i= 1, \dots, 10$$
%
% $$0 \leq x_i \leq 10$$
%
% $$1 \cdot x_i \leq 4$$
%
% $$1 \cdot x_i = 5$$
% 
try
  numerics.conRandMatrix(1, 10, 1, 4, 1, 5, 0, 10, [])
catch ME
  disp(ME.message)
end

%% 
% No. 5
%
% $$x_i \in R, i= 1, \dots, 10$$
%
% $$0 \leq x_i \leq 10$$
%
% $$(1, -1)^T \cdot x_i \leq (6, 4)^T$$
% 
numerics.conRandMatrix(1, 10, [1; -1], [6; 4], [], [], 0, 10, [])

%% 
% No. 6
%
% $$x_i \in R, i= 1, \dots, 10$$
%
% $$0 \leq x_i \leq 10$$
%
% $$(1, -1)^T \cdot x_i \leq (6, -4)^T$$
% 
numerics.conRandMatrix(1, 10, [1; -1], [6; -4], [], [], 0, 10, [])

%% 
% No. 7
%
% $$x_i \in R, i= 1, \dots, 10$$
%
% $$0 \leq x_i \leq 10$$
%
numerics.conRandMatrix(1, 10, [], [], [], [], 0, 10, ...
                       @(r)nonlconSphere(r, 1, 3, 1, 0), ...
                       [], [], [], [], [], [], 0, 1)

%%


