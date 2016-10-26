
%%

clear
close all;

%% TODO
% add stopping functionality during publishing



%%

plant_id= 'geiger';

%% TODO - also generate the x trajectories and load them here or below
% x brauche ich nicht, aber FOS/TAC, s. unten

u= load_file('u_feeds.mat');

y= load_file('y_MHE.mat');

%%

sampletime= 1/24; % 1 h sampling time

u_sample= 1;  % same as sample time

window= 31;   % measured in days

%%
% load x0 from initstate.mat

initstate= load_file(sprintf('initstate_%s.mat', plant_id));

x0= get_digester_state_outof_initstate(initstate);

%%

xp= MHE_ADM1(plant_id, u, y, x0(:), window, sampletime, u_sample);

%% TODO
% plot x predicted and x simulated
%% TODO
% vielleicht keine gute idee, besser, y trajectories und FOS/TAC plotten



%%


