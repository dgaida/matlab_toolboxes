%% createDataSetForPredictor
% Create dataset of measurements for predicting the internal state of a biogas
% plant. 
%
function [dataset, stream]= createDataSetForPredictor(sensors, ...
                            plant, fermenter_id, varargin)
%% Release: 1.6
                  
%%

%% WARNING
% although we pass fermenter_id here, sensors must contain measurement data
% from both digesters. That's because we assume that the state of one
% digester may also be depend on the measured data at the other digester.
% E.g. the state of the post digester may be dependent on the state of the
% primary digester

error( nargchk(3, 10, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% read out varargin and check parameters

if isa(sensors, 'biogas.sensors')
  %% 
  % wurde ein biogas.sensors objekt übergeben oder ein struct 'sensor_data'?
  sim_obj= 1;
elseif isstruct(sensors)
  sim_obj= 0;         % dataset matrix
else
  checkArgument(sensors, 'sensors', 'biogas.sensors || struct', '1st');
end

%%

is_plant(plant, '2nd');
checkArgument(fermenter_id, 'fermenter_id', 'char', '3rd');

%%

if nargin >= 4 && ~isempty(varargin{1})
  sample_time= varargin{1};
  isR(sample_time, 'sample_time', 4, '+');
else
  % sample time in hours
  sample_time= 1;
end

%% TODO
% noise_in is not needed anymore, is replaced by noisy
% delete noise_in in a future version
if nargin >= 5 && ~isempty(varargin{2})
  noise_in= varargin{2};
  isR(noise_in, 'noise_in', 5, '+');
else
  % noise on the input measurements (q) in 100 %, meaning 100 % noise 
  % = error in the size of the mean measurement value
  noise_in= 0;
end

%% TODO
% noise_out is not needed anymore, is replaced by noisy
% delete noise_out in a future version
if nargin >= 6 && ~isempty(varargin{3})
  noise_out= varargin{3};
else
  % noise on the output (measurements) (biogas, pH, ...) in 100 %,
  % meaning 100 % noise  
  % = error in the size of the mean measurement value
  noise_out= [0, 0, 0, 0];
end

%% TODO - can be deleted
% 4 hängt von anzahl messgrößen ab

if ~isa(noise_out, 'double') || numel(noise_out) ~= 4
  error(['The 6th parameter noise_out must be a 4dim double vector, ', ...
         'but is of type ', class(noise_out), ...
         ' with ', numel(noise_out), ' elements!']);
end

%% TODO  can be deleted
% delete when changed from rand to randn

if (noise_in > 0 || any(noise_out) > 0)
  error('Change rand to randn! See TODO!');
end


%%
% moving average filters for the output measurements, the values in the
% array are given in hours

if nargin >= 7 && ~isempty(varargin{4})
  filter_num_out= varargin{4};
  checkArgument(filter_num_out, 'filter_num_out', 'double', 7);
else
  filter_num_out= [12, 24, 2*24, 3*24, 5*24, 7*24, 10*24, 14*24, 21*24, 31*24];
  %filter_num_out= [12, 24, 3*24, 7*24, 14*24, 21*24];
  %filter_num_out= [12, 24, 3*24, 7*24, 14*24];
  %filter_num_out= [12, 24, 3*24, 7*24];
  %filter_num_out= [24, 3*24, 7*24, 14*24, 21*24, 31*24];
  %filter_num_out= [3*24, 7*24, 14*24, 21*24, 31*24];
end

%%
% moving average filters for the input measurements, the values in the
% array are given in hours

if nargin >= 8 && ~isempty(varargin{5})
  filter_num_in= varargin{5};
  checkArgument(filter_num_in, 'filter_num_in', 'double', 8);
else
  %% TODO
  % der filter darf nicht weiter in die Vergangenheit zurück gehen, als wie
  % filter_num_out, da sonst max_filter nicht stimmt. ist ne vermutung
  
  filter_num_in= [12, 24, 2*24, 3*24, 5*24, 7*24, 10*24, 14*24, 21*24];
  %filter_num_in= [12, 24, 3*24, 7*24];
  %filter_num_in= [12, 24, 3*24];
  %filter_num_in= [24, 3*24, 7*24, 14*24];
end

%%

if sample_time > min(min(filter_num_out), min(filter_num_in))
  error('sample_time must be <= the min values of filter_num_out and filter_num_in!');
end

%%
% if true, then input and output data are noisy with a noise level defined
% in sensors.xml file for each of the sensors
if nargin >= 9 && ~isempty(varargin{6})
  noisy= varargin{6};
  checkArgument(noisy, 'noisy', 'logical', 9);
else
  noisy= false;
end

% if true, then method is called from simBiogasPlantForPrediction, there we
% want to use all recorded data.
% If false, then called from getStateEstimateOfDigester, there we just need
% the last simulated values to estimate the current state estimate
if nargin >= 10 && ~isempty(varargin{7})
  use_history= varargin{7};
  checkArgument(use_history, 'use_history', 'logical', 10);
else
  use_history= false;
end

%%
%

if nargout >= 2 % then calculate stream

  if sim_obj

    %%
    % stream ist im grunde der aufgezeichnete 37dim zustandsraum
    % das dürften die Werte des Zustandsvektors in den
    % Standard-Modelleinheiten sein, also meistens kgCOD/m^3

    stream= sensors.getMeasurementStreams(['ADMstate_', fermenter_id]);
    stream= double(stream)';

  else

    stream= sensors.stream;

  end

  %%

  if size(stream, 2) ~= biogas.ADMstate.dim_state
    error('The second dimension of stream must be %i, but is %i!', ...
          biogas.ADMstate.dim_state, size(stream, 2));
  end
  
else
  
  stream= [];

end

%%

%ys= getVectorOutOfStream(stream, goal_variable);


%%
%

n_fermenter= plant.getNumDigestersD();

%%

if sim_obj

  % hole die zeit aus irgendeiner variablen, zeit ist überall gleich
  ts= double( sensors.getTimeStream() )';
  
else
  
  ts= sensors.(char(plant.getDigesterID(1))).time;
    
end

%%
% es wurden bisher noch keine daten aufgezeichnet
if max(ts) <= min(ts)
  dataset= [];
  stream= [];

  dispMessage('max(ts) <= min(ts)', mfilename);
  
  return;
end

% erstelle ein äquidistanten zeitvektor
% sample_time wird in stunden gemessen, ts in tagen
% deshalb umrechnungsfaktor 1/24 von stunden in tagen
t= (min(ts):sample_time*1/24:max(ts))';

%y= interp1(ts, ys, t, 'linear');

% sample (interpoliere) stream auf das äquidistante zeitraster
% resample methode des timeseries tool macht ebenfalls eine
% interpolation
% s. resampleDataTS.m
if ~isempty(stream)
  stream= interp1(ts, stream, t, 'linear');
end


%%
% creates a cell array containing chars with the filter abbreviations

filter_char= create_filter_char(filter_num_out);

%filter_char= {'h12', 'h24', 'd3', 'd7', 'd14', 'd31'}; % in hours / days
% filter_num ist ein einheitenloses vielfaches von der sample time in den
% ausgangsfiltern, d.h. wie viele sample times vergehen von jetzt bis zum
% entsprechenden filter
filter_num= filter_num_out ./ sample_time; % in hours

% anzahl der filter
n_filter= size(filter_char, 2);

% max. faktor den man * sample_time in die vergangenheit durch die
% filterung zurück geht, bzw. gehen muss.
max_filter= max(filter_num);


%%
% t ist in sample times gerastert, d.h. wenn man weiter in die
% vergangenheit muss, als wie t lang ist, dann geht das nicht...
if max_filter - 1 >= size(t,1)
  %t(1:max_filter - 1, :)= [];
  dataset= [];
  %warning('time length is to short!');

  dispMessage('max_filter - 1 >= size(t,1)', mfilename);
  
  return;
end

%%
% initialization of the mean output measurements

for ifilter= 1:n_filter
  pH_mean.(char(filter_char(1, ifilter)))= ...
                              zeros(numel(t), n_fermenter);

  ch4_mean.(char(filter_char(1, ifilter)))= ...
                              zeros(numel(t), n_fermenter);

  ch4p_mean.(char(filter_char(1, ifilter)))= ...
                              zeros(numel(t), n_fermenter);

  co2_mean.(char(filter_char(1, ifilter)))= ...
                              zeros(numel(t), n_fermenter);                        
end


%%
%

[pH, ch4, co2, ch4p]= get4MeasurementsfromSensors(sensors, plant, sample_time, noisy);


%%

for idigester= 1:n_fermenter
  
  %%
  % create mean

  %%
  % OK
  % hier gibt es einen fehler (doch kein fehler): filter setzt seinen
  % filter symmetrisch (nicht symmetrisch, sondern nur in die
  % vergangenheit) an,  
  % d.h. es wird immer um den aktuellen punkt herum gefiltert und nicht
  % nur in die vergangenheit... falsch. s.:
  %
  % windowSize = 5;
  % data= ones(16,1);
  % filter(ones(1,windowSize)/windowSize,1,data)
  %

  for ifilter= 1:n_filter

    % zeitfenster einheitenlos, vielfaches der sampling time
    window= filter_num(1, ifilter);

    pH_mean.(char(filter_char(1, ifilter)))(:,idigester)= ...
            filter(1/window .* ones(1,window), 1, pH(:,idigester));
    %pH_mean.(char(filter_char(1, ifilter)))(1:window-1,idigester)= ...
     %       mean(pH(1:window,idigester));

    ch4_mean.(char(filter_char(1, ifilter)))(:,idigester)= ...
            filter(1/window .* ones(1,window), 1, ch4(:,idigester));
    %ch4_mean.(char(filter_char(1, ifilter)))(1:window-1,idigester)= ...
     %       mean(ch4(1:window,idigester));

    ch4p_mean.(char(filter_char(1, ifilter)))(:,idigester)= ...
            filter(1/window .* ones(1,window), 1, ch4p(:,idigester));
    %ch4p_mean.(char(filter_char(1, ifilter)))(1:window-1,idigester)= ...
    %        mean(ch4p(1:window,idigester));

    co2_mean.(char(filter_char(1, ifilter)))(:,idigester)= ...
            filter(1/window .* ones(1,window), 1, co2(:,idigester));
    %co2_mean.(char(filter_char(1, ifilter)))(1:window-1,idigester)= ...
    %        mean(co2(1:window,idigester));    

  end


end


%% 
% OK - doch kein Fehler - s.o.
% um den oben angeschriebenen fehler zu beheben, sollte man das schneiden
% der mittelwerte unten von dem jeweiligen filter abhängig machen. d.h. das
% 12 h filter sollte man, bei angenommener sampling time von 6 h, nur um 2
% punkte schieben, bzw. nur 2 elemente abschneiden, das 7 tage filter um
% 7*24h/6h= 28 stellen... den rest (damit alle vektoren gleich lang sind)
% muss man dann am ende abschneiden...

% we just want to have the last value here, becasue that is the current
% value
if ~use_history % if not need history, then delete all data except the last
  % if need history, then just delete the first few values which are wrong
  % because of filter
  max_filter= numel(t);
end

pH(  1:max_filter - 1, :)= [];
ch4( 1:max_filter - 1, :)= [];
ch4p(1:max_filter - 1, :)= [];
co2( 1:max_filter - 1, :)= [];

%%

% if use_history
%   % throw away the first few values distorted by used filter
%   for ifilter= 1:n_filter
% 
%     pH_mean.(  char(filter_char(1, ifilter)))(1:max_filter - 1, :)= [];
%     ch4_mean.( char(filter_char(1, ifilter)))(1:max_filter - 1, :)= [];
%     ch4p_mean.(char(filter_char(1, ifilter)))(1:max_filter - 1, :)= [];
%     co2_mean.( char(filter_char(1, ifilter)))(1:max_filter - 1, :)= [];
% 
%   end
% end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% GET Qs
%

if sim_obj
  obj_fieldnames_NET= sensors.getIDsOfArray('Q');
  %fieldnames(obj_simulator.substrate.q_substrate);

  obj_fieldnames= cell(obj_fieldnames_NET.Length, 1);

  for iel= 1:numel(obj_fieldnames)

    obj_fieldnames{iel}= char( obj_fieldnames_NET.Get(iel - 1) );

  end
else
  obj_fieldnames= fieldnames(sensors.(char(plant.getDigesterID(1))).Q);
end

n_substrate= numel(obj_fieldnames); %size(substrate.ids, 2);

volFlow= zeros(numel(t), n_substrate);

%%

filter_s_char= create_filter_char(filter_num_in);

%filter_s_char= {'h12', 'h24', 'd3', 'd7'}; % in hours / days
filter_s_num= filter_num_in ./ sample_time;

n_filter_s= size(filter_s_char, 2);

for ifilter= 1:n_filter_s
  volFlow_mean.(char(filter_s_char(1, ifilter)))= ...
              zeros(numel(t), n_substrate);
end

%%

for isubstrate= 1:n_substrate

  %substrate_id= char(substrate.ids(1, isubstrate));

  substrate_id= char(obj_fieldnames(isubstrate, 1));

  %data= obj_simulator.substrate.q_substrate.(substrate_id);

  if sim_obj
    data= double( sensors.getMeasurementStream('Q', ['Q_', substrate_id], noisy) );
  else
    data= sensors.(char(plant.getDigesterID(1))).Q.(substrate_id)';
  end
  
  %% TODO
  % use randn and not rand
  %% TODO
  % wird nicht mehr benötigt, übernommen durch noisy
  data= data + noise_in .* ( rand(size(data,1), 1) - 0.5 ) .* mean(data);

  if sim_obj
    %cur_grid= obj_simulator.substrate.t_q.(substrate_id);
    cur_grid= double( sensors.getTimeStream('Q', ['Q_', substrate_id]) );
  else
    cur_grid= sensors.(char(plant.getDigesterID(1))).t_q.(substrate_id)';
  end
  
  volFlow(:,isubstrate)= resampleData(data, cur_grid, t')';

  %%
  % create mean

  for ifilter= 1:n_filter_s

      window= filter_s_num(1, ifilter);


      %% 
      % OK - s.o.
      % hier gibt es einen fehler: filter setzt seinen filter symmerisch and,
      % d.h. es wird immer um den aktuellen punkt herum gefiltert und nicht
      % nur in die vergangenheit...

      volFlow_mean.(char(filter_s_char(1, ifilter)))(:,isubstrate)= ...
              filter(1/window .* ones(1,window), 1, volFlow(:,isubstrate));
      %volFlow_mean.(char(filter_s_char(1, ifilter)))(1:window-1,isubstrate)= ...
      %        mean(volFlow(1:window,isubstrate));

  end

end


%% 
% OK - s.o.
% um den oben angeschriebenen fehler zu beheben, sollte man das schneiden
% der mittelwerte unten von dem jeweiligen filter abhängig machen. d.h. das
% 12 h filter sollte man, bei angenommener sampling time von 6 h, nur um 2
% punkte schieben, bzw. nur 2 elemente abschneiden, das 7 tage filter um
% 7*24h/6h= 28 stellen... den rest (damit alle vektoren gleich lang sind)
% muss man dann am ende abschneiden...

volFlow(1:max_filter-1, :)= [];

for ifilter= 1:n_filter_s

  volFlow_mean.(char(filter_s_char(1, ifilter)))(1:max_filter-1,:)= [];

end


%%
%

%% 
% defines number of output measurements: pH, CH4, CO2, biogas
n_meas= 4;

t(1:max_filter - 1, :)= [];   % just done to decrease dimension of t, the time 
% in t is not used later

% 1 because of non-filtered data
% the other 1 because of 2nd (24 h) filter I not only want the last 24 h
% mean, but also the 24 h mean before that
X= zeros(numel(t), n_meas*(1+1 + n_filter)*n_fermenter);

%%
%

for idigester= 1:n_fermenter

  %% 
  % pH value

  X(:, 1 + (n_filter + 2)*n_meas*(idigester - 1))= pH(:, idigester);

  for ifilter= 1:n_filter

    % if numel(t) only 1, then just get the last mean value, else get as
    % much mean values as there are (also form the past: use_history= 1)
    X(:, 1 + ifilter + (n_filter + 2)*n_meas*(idigester - 1))= ...
        pH_mean.(char(filter_char(1, ifilter)))(end-numel(t)+1:end,idigester);

  end
  
  %%
  % get mean of 2nd filter (24 h) of the day before
  
  window= filter_num(1, 2);

  X(:, 2 + n_filter + (n_filter + 2)*n_meas*(idigester - 1))= ...
        ...[pH_mean.(char(filter_char(1, 2)))(1,idigester) .* ones(window, 1); ...
         pH_mean.(char(filter_char(1, 2)))(max(1,end-numel(t)+1-window):end-window,idigester);%];

  %%

%     X(:, 2 + n_filter + (n_filter + 1)*n_meas*(idigester - 1))= ch4(:, idigester);
%     
%     for ifilter= 1:n_filter
%     
%         X(:, 2 + n_filter + ifilter + (n_filter + 1)*n_meas*(idigester - 1))= ...
%             ch4_mean.(char(filter_char(1, ifilter)))(:,idigester);
% 
%     end

  %%
  % total amount of produced biogas

  X(:, 3 + n_filter + (n_filter + 2)*n_meas*(idigester - 1))= ch4p(:, idigester);

  for ifilter= 1:n_filter

    X(:, 3 + n_filter + ifilter + (n_filter + 2)*n_meas*(idigester - 1))= ...
        ch4p_mean.(char(filter_char(1, ifilter)))(end-numel(t)+1:end,idigester);

  end

  %%
  % get mean of 2nd filter (24 h) of the day before
  
  window= filter_num(1, 2);

  X(:, 4 + 2*n_filter + (n_filter + 2)*n_meas*(idigester - 1))= ...
        ...[ch4p_mean.(char(filter_char(1, 2)))(1,idigester) .* ones(window, 1); ...
         ch4p_mean.(char(filter_char(1, 2)))(max(1,end-numel(t)+1-window):end-window,idigester);%];

  %%

%     X(:, 3 + 2*n_filter + (n_filter + 1)*n_meas*(idigester - 1))= ch4p(:, idigester);
%     
%     for ifilter= 1:n_filter
%     
%         X(:, 3 + 2*n_filter + ifilter + (n_filter + 1)*n_meas*(idigester - 1))= ...
%             ch4p_mean.(char(filter_char(1, ifilter)))(:,idigester);
% 
%     end

  %%
  % ch4 content in the biogas

  X(:, 5 + 2*n_filter + (n_filter + 2)*n_meas*(idigester - 1))= ch4(:, idigester);

  for ifilter= 1:n_filter

    X(:, 5 + 2*n_filter + ifilter + (n_filter + 2)*n_meas*(idigester - 1))= ...
        ch4_mean.(char(filter_char(1, ifilter)))(end-numel(t)+1:end,idigester);

  end

  %%
  % get mean of 2nd filter (24 h) of the day before
  
  window= filter_num(1, 2);

  X(:, 6 + 3*n_filter + (n_filter + 2)*n_meas*(idigester - 1))= ...
        ...[ch4_mean.(char(filter_char(1, 2)))(1,idigester) .* ones(window, 1); ...
         ch4_mean.(char(filter_char(1, 2)))(max(1,end-numel(t)+1-window):end-window,idigester);%];

  %%
  % co2 content in the biogas

  X(:, 7 + 3*n_filter + (n_filter + 2)*n_meas*(idigester - 1))= co2(:, idigester);

  for ifilter= 1:n_filter

    X(:, 7 + 3*n_filter + ifilter + (n_filter + 2)*n_meas*(idigester - 1))= ...
        co2_mean.(char(filter_char(1, ifilter)))(end-numel(t)+1:end,idigester);

  end

  %%
  % get mean of 2nd filter (24 h) of the day before
  
  window= filter_num(1, 2);

  X(:, 8 + 4*n_filter + (n_filter + 2)*n_meas*(idigester - 1))= ...
        ...[co2_mean.(char(filter_char(1, 2)))(1,idigester) .* ones(window, 1); ...
         co2_mean.(char(filter_char(1, 2)))(max(1,end-numel(t)+1-window):end-window,idigester);%];

  %%
  
end

%%


%if ~use_history
  % delete all values except of the last if ~use_history
  % else, only delete the first values that are distorted by the filter
  for ifilter= 1:n_filter

    pH_mean.(  char(filter_char(1, ifilter)))(1:max_filter - 1, :)= [];
    ch4_mean.( char(filter_char(1, ifilter)))(1:max_filter - 1, :)= [];
    ch4p_mean.(char(filter_char(1, ifilter)))(1:max_filter - 1, :)= [];
    co2_mean.( char(filter_char(1, ifilter)))(1:max_filter - 1, :)= [];

  end
%end




%%
% substrate amount

U= zeros(numel(t), n_substrate*n_filter_s);

for isubstrate= 1:n_substrate

  U(:, 1 + (n_filter_s + 1)*(isubstrate - 1))= ...
                                              volFlow(:,isubstrate);

  for ifilter= 1:n_filter_s

      U(:, 1 + ifilter + (n_filter_s + 1)*(isubstrate - 1))= ...
          volFlow_mean.(char(filter_s_char(1, ifilter)))(:,isubstrate);

  end

end


%%
%

if ~isempty(stream) 
  stream(1:max_filter - 1, :)= [];
end

%%
%

if size(X, 1) ~= size(U, 1)

  error('The datasets X and U do not have the same number of rows!');

end

%%
%

dataset= [X, U];

%%


