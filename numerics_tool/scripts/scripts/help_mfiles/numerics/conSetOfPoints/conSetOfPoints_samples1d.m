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
numerics.conSetOfPoints(1, 10, [], [], [], [], 0, 10, [])

%% 
% No. 2
%
% This problem has exactly one solution: $x_i = 5$, but an error is thrown.
% If we could generate an initial population, which is $x_i = 5$, then
% problem should be solvable. TODO!
%
% $$x_i \in R, i= 1, \dots, 10$$
%
% $$0 \leq x_i \leq 10$$
%
% $$1 \cdot x_i = 5$$
% 
try
  numerics.conSetOfPoints(1, 10, [], [], 1, 5, 0, 10, [])
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
numerics.conSetOfPoints(1, 10, 1, 6, [], [], 0, 10, [])

%% 
% No. 4
%
% This problem has no solution, thus the empty solution. This is why an
% error is thrown. 
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
  numerics.conSetOfPoints(1, 10, 1, 4, 1, 5, 0, 10, [])
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
numerics.conSetOfPoints(1, 10, [1; -1], [6; 4], [], [], 0, 10, [])

%% 
% No. 6
%
% $$x_i \in R, i= 1, \dots, 10$$
%
% $$0 \leq x_i \leq 10$$
%
% $$(1, -1)^T \cdot x_i \leq (6, -4)^T$$
% 
numerics.conSetOfPoints(1, 10, [1; -1], [6; -4], [], [], 0, 10, [])

%% 
% No. 7
%
% $$x_i \in R, i= 1, \dots, 10$$
%
% $$0 \leq x_i \leq 10$$
%
numerics.conSetOfPoints(1, 10, [], [], [], [], 0, 10, ...
                       @(r)nonlconSphere(r, 1, 3, 1, 0), [], [], [], [], 0, 1)

%%


