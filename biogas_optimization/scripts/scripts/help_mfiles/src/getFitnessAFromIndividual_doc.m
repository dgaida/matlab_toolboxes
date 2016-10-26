%% Syntax
%        fitness=
%        biogasM.optimization.popBiogas.getFitnessAFromIndividual(obj, u) 
%
%% Description
% |fitness= biogasM.optimization.popBiogas.getFitnessAFromIndividual(obj,
% u)| calculates the fitness of the passed individual |u| with respect to
% linear inequality constraints of the constrained object |obj|.  
%
%%
% @param |obj| : object of the class <popbiogas.html
% |biogasM.optimization.popBiogas|>. 
%
%%
% @param |u| : the individual, double row vector
%
%%
% @return |fitness| : fitness of the given individual. Each faling
% constraint is penalized with 1e4, the sum is returned. If all constraints
% hold, then fitness is 0. 
%
%% Example
% 
%

[popBiogas]= biogasM.optimization.popBiogas(10, ...
                    [0 1], [5 8], [], [], [], [], [], [], ...
                    [1 1 10]);

%%
% this individual is ok

getFitnessAFromIndividual(popBiogas, [1 3])   

%%
% this is not
% due to scaling the individuals are located in a space ranging from 0 to
% 10, thus the individual [7 9] is valid with respect to lower and upper
% boundaries ...

getFitnessAFromIndividual(popBiogas, [7 9])
        
%%

[popBiogas]= biogasM.optimization.popBiogas(10, ...
                    [0 1], [5 8], [], [], [], [], [], [], ...
                    [1 1 10], [], [], [], [], [], [], ...
                    [], [], [], [], [], [], 3);

%%
%

getFitnessAFromIndividual(popBiogas, [1 2 0 5 1 4])

%%
%

getFitnessAFromIndividual(popBiogas, [7 9 7 9 7 9])
 
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('fitnessfindoptimalequilibrium')">
% fitnessFindOptimalEquilibrium</a>
% </html>
%
%% See Also
%
% <html>
% <a href="popbiogas.html">
% biogasM.optimization.popBiogas</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('setlinearmanurebonusconstraint')">
% setLinearManureBonusConstraint</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


