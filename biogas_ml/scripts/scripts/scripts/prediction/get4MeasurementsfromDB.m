%% get4MeasurementsfromDB
% Get measurement streams for pH, CH4 and CO2 concentration and CH4
% production out of a postgreSQL database, it is the equivalent to
% getDataOfSensor
%
function sensor_data= get4MeasurementsfromDB(plant_id, varargin)
%% Release: 0.1

%%

narginchk(1, 4);
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

if nargin >= 2 && ~isempty(varargin{1}), 
  database_name= varargin{1}; 
  
  %% TODO - check argument
else
  database_name= 'postgres'; 
end

if nargin >= 3 && ~isempty(varargin{2}), 
  nRows= varargin{2}; 
  isN(nRows, 'nRows', 2);
else
  nRows= Inf; 
end

%%

if nargin >= 4 && ~isempty(varargin{3})
  sample_time= varargin{3};
  isR(sample_time, 'sample_time', 3, '+');
else
  % sample time in hours / day
  sample_time= 4;   % means 4 measurements a day, thus 6 h sample time
end


%% TODO
% check arguments

%%

% street index, 1 or 2
mystreet= 2;  %1

%% TODO
% this script is written for street 2 of the MiniBGA auf der Leppe, and
% is only working for that plant.

if ~strcmp(plant_id, 'leppe')
  error('This script only works for the plant leppe! Write your own script!');
end

%%
% now minus 30 days, max_filter is 31 days, so we need more than 30 days

numdays= 40;      % number of days we look into the past

dateStart= datestr(now() - numdays, 'yyyy-mm-dd HH:MM:SS');


%%
% 'postgres', solid substrates (maize1) fed into street 2
[maize1, tfeed]= getFilteredDataFromDB(database_name, ...
          sprintf('solidfeeds%i', mystreet), ...
          nRows, sample_time, ...
          [], 1, 'gecouser', 'geco', [1 2], dateStart);

% from kg/d to m³/d
maize1= maize1 ./ 1000;

%% 

biowaste1= getFilteredDataFromDB(database_name, sprintf('solidfeeds%i', mystreet), ...
           nRows, sample_time, ...
           [], 1, 'gecouser', 'geco', [1 8], dateStart);

% from kg/d to m³/d
biowaste1= biowaste1 ./ 1000;

%% müsste jetzt ok sein
%% TODO: opcdb60 bzw. opcdb50 stimmt nicht. ich muss processdata nehmen
%% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!        idm_sub1,2
[manure, tliq]= getFilteredDataFromDB(database_name, ...
          'processdata', ...sprintf('opcdb%i', 40+mystreet*10), ... % opcdb50 or 60
          nRows, sample_time, ...
          [], 1, 'gecouser', 'geco', [1 14+mystreet-1], dateStart, [], 30);

ind= mod(tliq, 1) == 0; % integer: 0, 1, 2, ...
mydat= manure(ind); % take data of end of day
manure= diff(mydat)'; % calc the 

manure= max(manure, 0);

tliq= 0:(numel(manure) - 1);
        
%%

fprintf('Over the last %i days street %i of the biogas plant was fed with maize [m³/d]:\n', ...
  numdays, mystreet);

summary(maize1);

fprintf('Over the last %i days street %i of the biogas plant was fed with biowaste [m³/d]:\n', ...
  numdays, mystreet);

summary(biowaste1);

fprintf('Over the last %i days street %i of the biogas plant was fed with manure [m³/d]:\n', ...
  numdays, mystreet);

summary(manure);

%%
%

for idigester= 1:2

  %%
  
  digester_id= sprintf('tank%i', idigester);

  %%
  % ph of digester, postdigester street 2
  [pH, t]= getFilteredDataFromDB(database_name, 'opcdb302', nRows, sample_time, ...
            [], 1, 'gecouser', 'geco', [1 6+mystreet-1 + (idigester-1)*2], ...
            dateStart, [], 30);

  %%
  % co2 concentration of digester, postdigester street 2
  co2= getFilteredDataFromDB(database_name, 'opcdb300', nRows, sample_time, ...
            [], 1, 'gecouser', 'geco', [1 7+mystreet-1 + (idigester-1)*2], ...
            dateStart, [], 30);

  %%
  % ch4 concentration of digester, postdigester street 2
  ch4= getFilteredDataFromDB(database_name, 'opcdb300', nRows, sample_time, ...
            [], 1, 'gecouser', 'geco', [1 12+mystreet-1 + (idigester-1)*2], ...
            dateStart, [], 30);

  %%
  % 'postgres', biogas production of digester, postdigester street 2
  ch4p= getFilteredDataFromDB(database_name, 'biogas_production', nRows, sample_time, ...
            [], 1, 'gecouser', 'geco', [1 3+(mystreet-1)*2 + (idigester-1)], dateStart);

  %% TODO: needed to calculate mean as long as both streets are not separated
  % 'postgres', biogas production of digester, postdigester street 1
  %ch4p1= getFilteredDataFromDB(database_name, 'biogas_production', nRows, sample_time, ...
   %         [], 1, 'gecouser', 'geco', [1 3 + (idigester-1)], dateStart);
        
  %%

  minlen= min([length(t) length(pH) length(co2) length(ch4) length(ch4p)]);% length(ch4p1)]);

  %pH= pH(1:minlen);
  %t= t(1:minlen);
  %co2= co2(1:minlen);
  %ch4= ch4(1:minlen);
  %ch4p= ch4p(1:minlen);
  
  % get the most recent data. as t(1) is zero, we have to get the data from the end
  pH= pH(end - (minlen-1):end);
  t= t(end - (minlen-1):end);
  t= t-t(1);
  co2= co2(end - (minlen-1):end);
  ch4= ch4(end - (minlen-1):end);
  ch4p= ch4p(end - (minlen-1):end);
  
  %%
  
  ch4p= max(ch4p, 0);     % biogas production can only be positive

  %% TODO: kick out when gas line of both streets are separated
  %ch4p1= ch4p1(1:minlen);

  %%
  
  %% TODO: die ältesten Daten in sensor_data müssen ganz oben stehen und die 
  % neuesten ganz unten, da in getStateEstimateOfDigester in Zeile 82 die
  % letzte Zeile genommen wird (aktuellsten Daten). PRÜFEN!!!

  sensor_data.(digester_id).time= t;

  sensor_data.(digester_id).stream= [];

  sensor_data.(digester_id).pH= pH;
  sensor_data.(digester_id).ch4= ch4;
  sensor_data.(digester_id).co2= co2;
  sensor_data.(digester_id).biogas= ch4p;
  %% TODO: for now calc the mean biogas production for both streets
  % mean of digesters, mean of postdigesters
  %sensor_data.(digester_id).biogas= (ch4p + ch4p1)./2;

  %%
  
  fprintf('pH value of street %i over the last %i days:\n', mystreet, numdays);

  summary(pH);
  
  fprintf('CH4 concentration of street %i over the last %i days:\n', mystreet, numdays);

  summary(ch4);
  
  fprintf('CO2 concentration of street %i over the last %i days:\n', mystreet, numdays);

  summary(co2);
  
  fprintf('Biogas production of street %i over the last %i days:\n', mystreet, numdays);

  %% TODO: only ch4p
  %summary((ch4p + ch4p1)./2);
  summary(ch4p);
  

  
  %%
  
  %% TODO, ich glaube Zeiten für substarte unten sollte wie zeiten der messwerte
  % sein. oder zumindest bei flüssig/fest gleich sein
  
  %%
  % get substrate feed data from postgresql
  % auch wenn der nachgärer nicht gefüttert wird, wird der input in den
  % hauptgärer auch für die zustandsschätzung des nachgärers genutzt. 
  
  % save everything as column vectors
  
  sensor_data.(digester_id).Q.('maize')= maize1(:);
  sensor_data.(digester_id).Q.('manure')= manure(:);
  sensor_data.(digester_id).Q.('biowaste')= biowaste1(:);

  %

  sensor_data.(digester_id).t_q.('maize')= tfeed(:);
  sensor_data.(digester_id).t_q.('manure')= tliq(:);
  sensor_data.(digester_id).t_q.('biowaste')= tfeed(:);


  %%
  
end

%%


