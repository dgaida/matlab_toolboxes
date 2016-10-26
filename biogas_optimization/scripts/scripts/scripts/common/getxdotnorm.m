%% getxdotnorm
% Get 1/T * int [ ( xdot(t)' * xdot(t) ) > threshold ] dt
%
function xdotnorm= getxdotnorm(plant, sensors, t)
%% Release: 1.2

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

is_plant(plant, '1st');
is_sensors(sensors, '2nd');
isRn(t, 't', 3, '+');

%%

n_digester= plant.getNumDigestersD();

%t_sample= min(t):1/24:max(t); % delta time 1 h

xdotnorm= 0;

%%

% FOS/TAC, H2 in biogas, VFA
mvs= {'VFA_TAC_%s_3', 'biogas_%s', 'VFA_%s_3'};
% [gAceq/gCaCO3eq] / h, m³/d of h2 / h, gAceq./l / h
thresv= [0.01, 0.001, 0.1];   % threshold value

%%

time_s= double(sensors.getTimeStream());
  
% if t_sample(end) > time_s(end) % done because of interp1
%   time_s= [time_s(1:end - 1), t_sample(end)];
% end

%%

for idigester= 1:n_digester
  
  %%
  
  digester_id= char(plant.getDigesterID(idigester));

  %%
  % diff measurement values
  
  for imv= 1:numel(mvs)
    
    %%
    
    mv= double(sensors.getMeasurementStream(sprintf(mvs{imv}, digester_id)));
  
    % duplicate time instances are a problem for interpolation
    % würde auch probleme machen wenn man durch diff(time) teilt. s.u.
    [time, mv]= deleteDuplicates(time_s', mv');
  
    % make row vectors
    % * 24 to get from per day to per hour
    time= time(:)' .* 24;
    mv= mv(:)';
  
    %% 
    % ich darf hier nicht resample, da sonst dass nicht mehr die wirkliche
    % ableitung ist, weil zeitinformation nicht mehr drin sind
    %dmv= interp1(time(2:end)', mv(2:end)', t_sample, 'linear');
  
    %% 
    % das ist dann nicht mehr die ableitung. Ableitung ist diff(mv)/diff(time)
    % oder so ähnlich - so ist es richtig
    % ignore first value
    dmv= diff( mv(2:end) ) ./ diff( time(2:end) );
    
    % do the integral over those values whose absolute value is >
    % threshold. 
    dmv= sum(abs(dmv(abs(dmv) >= thresv(imv))));

    %%
    % values are scaled by inverse of threshold value
    xdotnorm= xdotnorm + dmv / thresv(imv);
  
  end
  
  %%
  
end

%%

if max(t) - min(t) > 0
  xdotnorm= xdotnorm / ( max(t) - min(t) );
end

%%



%%


