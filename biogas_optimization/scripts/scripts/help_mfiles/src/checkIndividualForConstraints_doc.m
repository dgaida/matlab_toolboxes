%% Syntax
%       isvalid= checkIndividualForConstraints(popBiogas, u)
%
%% Description
% |isvalid= checkIndividualForConstraints(popBiogas, u)| checks the
% individual |u| for constraints. As constraints the following are checked:
%
% * nonlinear (in-)equality constraints calling <getfitnessnonlconfromindividual.html
% biogasM.optimization.popBiogas.getFitnessNonlconFromIndividual>
% * linear inequality constraints calling <getfitnessafromindividual.html
% biogasM.optimization.popBiogas.getFitnessAFromIndividual>
% * lower and upper boundaries
%
%%
% @param |popBiogas| : object of the <popbiogas.html
% |biogasM.optimization.popBiogas|> class 
%
%%
% @param |u| : indivdual, double row vector
%
%%
% @return |isvalid| : 1, if individual is valid, else 0
%
%% Example
% 
%

[popBiogas]= biogasM.optimization.popBiogas(10, ...
                    [0 1], [5 8], [], [], [], [], [], [], ...
                    [1 1 10]);

%%
% not valid

checkIndividualForConstraints(popBiogas, [7 9])

%%
% valid 

checkIndividualForConstraints(popBiogas, [7 5])


%%

[popBiogas]= biogasM.optimization.popBiogas(10, ...
                    [0 1], [5 8], [], [], [], [], [], [], ...
                    [1 1 10], [], [], [], [], [], [], ...
                    [], [], [], [], [], [], 3);

%%
%

checkIndividualForConstraints(popBiogas, [1 2 0 5 1 4])


%% Dependencies
%
% This method calls:
%
% <html>
% <a href="getfitnessnonlconfromindividual.html">
% biogasM.optimization.popBiogas.getFitnessNonlconFromIndividual</a>
% </html>
% , 
% <html>
% <a href="getfitnessafromindividual.html">
% biogasM.optimization.popBiogas.getFitnessAFromIndividual</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/biogasepisode')">
% biogas_control/biogasM.optimization.RL.biogasRLearner.biogasEpisode</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="popbiogas.html">
% biogasM.optimization.popBiogas</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


