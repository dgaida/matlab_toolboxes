%% Syntax
%        fitness= evalIndividualForConstraints(popBiogas, u)  
%        fitness= evalIndividualForConstraints(popBiogas, u,
%        eval_lin_constraints)
%
%% Description
% |fitness= evalIndividualForConstraints(popBiogas, u)| tests u for
% nonlinear (in-)equality and linear inequality constraints. 
%
%%
% @param |popBiogas| : object of the class <popbiogas.html
% |biogasM.optimization.popBiogas|>. 
%
%%
% @param |u| : the individual, double row vector
%
%%
% @return |fitness| : fitness of the given individual. Each failing
% constraint is penalized with 1e4, the sum is returned. If all constraints
% hold, then fitness is 0. 
%
%%
% @param |eval_lin_constraints| : 0 or 1
%
% * 0 : linear inequality constraint is not evaluated
% * 1 : linear inequality constraint is evaluated (default)
%
%% Example
% 
%

[popBiogas]= biogasM.optimization.popBiogas(10, ...
                    [0 1], [5 8], [], [], [], [], [], [], ...
                    [1 1 10]);

%%
% this individual is ok

evalIndividualForConstraints(popBiogas, [1 3])   

%%
% this is not
% due to scaling the individuals are located in a space ranging from 0 to
% 10, thus the individual [7 9] is valid with respect to lower and upper
% boundaries ...

evalIndividualForConstraints(popBiogas, [7 9])
        
%%

[popBiogas]= biogasM.optimization.popBiogas(10, ...
                    [0 1], [5 8], [], [], [], [], [], [], ...
                    [1 1 10], [], [], [], [], [], [], ...
                    [], [], [], [], [], [], 3);

%%
%

evalIndividualForConstraints(popBiogas, [1 2 0 5 1 4])

%%
%

evalIndividualForConstraints(popBiogas, [7 9 7 9 7 9])
 
%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getfitnessnonlconfromindividual')">
% biogas_optimization/biogasM.optimization.popBiogas.getFitnessNonlconFromIndividual</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getfitnessafromindividual')">
% biogas_optimization/biogasM.optimization.popBiogas.getFitnessAFromIndividual</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
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
% # es gibt ein paar Anmerkungen in der Funktion
%
%% <<AuthorTag_DG/>>


