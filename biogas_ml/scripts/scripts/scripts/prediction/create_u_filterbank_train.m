%% create_u_filterbank_train
% Create u for filterbank for training
%
function [u, u_sample]= create_u_filterbank_train(system, toiteration)%, set)
%% Release: 0.7

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%% 

checkArgument(system, 'system', 'char', '1st');
isN(toiteration, 'toiteration', 2);

%%

%% TODO - schnelleres u nutzen - nutze nicht mehr _v
u= load_file('u_rand_signal_train_v2.mat');  % sampling time of u in minutes

% nicht machen, da onst bei interp1 unten NaNs am Ende entstehen
% if set ~= 0
%   u= u(1:30000,:);   % equal to 5 days simulation
% end

%%
% die originalen us haben zu viele Schritte, deshalb wird hier noch mal
% interpoliert, damit insgesamt 1/delta weniger Schritte in u sind

% delta gibt an wie weit runter gebrochen wird, bei delta= 1 wird original
% u genommen
delta= 1.25; % probleme mit singulärer Matrix bei delta= 1 in solver
% u_sample wird im Verhältnis zu sampletime gemessen und nicht im
% Verhältnis zur grundeinheit, welche tage und studnen sein kann. grund
% liegt beim aufruf der simulation ode15s. 
% für beide systeme bedeutet das, dass u in min. gemessen wird
% in kalman filter wird u in minuten genutzt, hier nur in stunden, aber
% deshalb wird u im zeitrater 1 minute gemacht, für den vergleich
u_sample= 1/60;   % u wird gemessen in h, neue u's damit gemessen in min.
u_size= numel(u(:,1));
t_sample= 0:delta:delta*(u_size - 1);

% zusätzlich wird u auf 1 min. Raster interpoliert, damit EKF genauer
% arbeiten kann. da mein state estimator ebenfalls im minutenraster
% arebitet ist das für vergleich wichtig!
u11= interp1(t_sample, u(:,1), 0:u_sample:toiteration - u_sample)';
u12= interp1(t_sample, u(:,2), 0:u_sample:toiteration - u_sample)';

u= [u11, u12];

%%
% Wertebereich von u evtl. für ADode6 anpassen
if strcmp(system, 'ADode6')
  u(:,1)= u(:,1) .* 1000;
  u(:,2)= u(:,2) .* 100;
end

%%


