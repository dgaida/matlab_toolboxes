%% 3-D Examples
%
% 

optimization.conPopulation(3, 10, [], [], [], [], [0, 0, 1], [5, 5, 10]); 

%%
% 
%

optimization.conPopulation(3, 10, [], [], [], [], [5, 0, 1], [5, 5, 10]);

%%
% 
% 

optimization.conPopulation(3, 10, [], [], [1, 1, 1], 5, [0, 0, 1], [5, 5, 10]);

%%
% 
%
 
optimization.conPopulation(3, 10, [0, 1, 1], 10, [], [], [0, 0, 1], [5, 5, 10]);

%%
% use length of genome = 3

optimization.conPopulation(3, 10, [1 1 0; 1 0 1], [6; 10], ...
                                  [1 0 1; 1 0 0], [4; 3.25], [0 1 0.5], [5 6 1], ...
                           [], {'CMAES'}, {'CMAES'}, [], [], [], 3)

%%
% gibt ein Fehler zurück, da letzte komponente von A 1 ist, aber LB und UB
% für letzte komponente gleich sind und ~= 0
% TODO: sollte keinen fehler zurück geben!

try
  optimization.conPopulation(3, 10, [1 1 1], 30, [], [], ...
                             [0, 1, 0.5], [25, 30, 0.5], [])
catch ME
  disp(ME.message)
end
                                
%%


