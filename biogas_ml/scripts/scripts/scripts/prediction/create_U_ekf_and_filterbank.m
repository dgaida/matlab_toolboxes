%% create_U_ekf_and_filterbank
% Create U for EKF and filterbank for validation
%
function [U, u_sample]= create_U_ekf_and_filterbank(system)
%% Release: 0.6

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%% 

checkArgument(system, 'system', 'char', '1st');

%%
% 2400 dim vector: for 100 days a 1/24 sampling time
% wenn man in Bernard et al. (ref. 1, S. 7) schaut, sind Werte für CODin
% im Bereich von 4 bis 15 g/l und S2in von 30 bis 120 mmol/l absolut in
% Ordnung
load('u_rand_signal.mat');    % sample time in u is in hours

%%
% die originalen us haben zu viele Schritte, deshlab wird hier noch mal
% interpoliert, damit insgesamt 1/delta weniger Schritte in u sind

% delta gibt an wie weit runter gebrochen wird, bei delta= 1 wird original
% u genommen
delta= 1.25; % probleme mit singulärer Matrix bei delta= 1 in solver
u_size= numel(u11);
t_sample= 0:delta:delta*(u_size - 1);
u_sample= 1/60;   % u wird gemessen in h, neue u's damit gemessen in min.

% zusätzlich wird u auf 1 min. Raster interpoliert, damit EKF genauer
% arbeiten kann. da mein state estimator ebenfalls im minutenraster
% arebitet ist das für vergleich wichtig!
u11= interp1(t_sample, u11, 0:u_sample:u_size - u_sample)';
u12= interp1(t_sample, u12, 0:u_sample:u_size - u_sample)';
u13= interp1(t_sample, u13, 0:u_sample:u_size - u_sample)';
u21= interp1(t_sample, u21, 0:u_sample:u_size - u_sample)';
u22= interp1(t_sample, u22, 0:u_sample:u_size - u_sample)';
u23= interp1(t_sample, u23, 0:u_sample:u_size - u_sample)';

%%
% Wertebereich von u evtl. für ADode6 anpassen
if strcmp(system, 'ADode6')
  u11= u11 .* 1000;
  u12= u12 .* 1000;
  u13= u13 .* 1000;
  u21= u21 .* 100;
  u22= u22 .* 100;
  u23= u23 .* 100;
end

%%

U= {[u11, u21], [u11, u22], [u11, u23], ...
    [u12, u21], [u12, u22], [u12, u23], ...
    [u13, u21], [u13, u22], [u13, u23]};

%%



%%


