%% getudotnorm
% Get 1/T * int ( || u'(t) ||_2^2 ) dt
%
function udotnorm= getudotnorm(substrate, sensors, t, varargin)
%% Release: 1.0

%%

error( nargchk(3, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

is_substrate(substrate, '1st');
is_sensors(sensors, '2nd');
isRn(t, 't', 3, '+');

%%

n_substrate= substrate.getNumSubstratesD();

%%
% ein paar Ideen:

% 1) wenn Schwingen des Reglers detektiert wird (wie macht man das???), dann
% |udot| stärker bestrafen um schwingen zu unterbinden
% 2) wenn aktueller zustand weit von optimalem Zustand entfernt ist, oder ein
% großer sollwertfehler da ist, dann ein größeres |udot| erlauben, damit
% man da hin kommt
% 3) wenn es keine änderungen mehr in optimierungskriterien gibt über einen
% längeren zeitraum, dann |udot| höher bestrafen, damit regler nicht
% anfängt zu schwingen.  

%%

if nargin >= 4 && ~isempty(varargin{1})
  init_substrate_feed= varargin{1};
  %% TODO
  % check argument n_substrate x n_digester
  
  % in case only one digester or one substrate exists
  if isvector(init_substrate_feed)  
    if n_substrate > 1
      % one digester, make a row vector. WHY????
      % since sum below goes over second dimension, thus the columns, we
      % have to create a column vector, such that the vector is not changed
      % by the sum
      init_substrate_feed= init_substrate_feed(:);%';
    else
      % one substrate, make a column vector. WHY??? Same as above. sum goes
      % over columns, therefore we need a row vector here.which spans over
      % n_digester columns
      init_substrate_feed= init_substrate_feed(:)';
    end
  end
  
  init_substrate_feed= sum(init_substrate_feed, 2); % sum over digester
else
  init_substrate_feed= [];
end

%%

%t_sample= min(t):1:max(t);

udotnorm= 0;

if isempty(init_substrate_feed)
  return;     % then we do not have an initial substrate feed
end

%%

u= double(sensors.getMeasurementsAt('Q', 'Q', t(1), substrate));

u= u(:);

%% TODO - wer sagt, dass das 1 tage sind, das ist doch willkürlich so gesetzt
% genau genommen muss ich hier durch 1 tag teilen, aber dann auch wieder
% mit 1 tag multiplizieren, da ich hier das integral zurück geben muss von
% udot -> ALSO pro welche dt ist hier egal, also ok
% teile noch durch zeit, ist aber 1 day
udotnorm= (u - init_substrate_feed)' * (u - init_substrate_feed);

%%
% durch Periodendauer teilen, ähnlich wie bei berechnung von el. leistung
% in der physik, weil ich das bei fitness berechnung auch mache, muss das
% hier auch gemacht werden, da ich udotnorm auf fitness wert addiere

% if max(t) - min(t) > 0
%   udotnorm= udotnorm / ( max(t) - min(t) );
% end

% durch 150 teilen. das mache ich nur damit ich Tp= 150 d experimente
% behalten kann. vorher wurde durch max(t) - min(t) geteilt, das war
% allerdings falsch
udotnorm= udotnorm / 150;   % s. getRecordedFitness

%% TODO - das ist zum Test um strafe für zu große substratänderungen zu begrenzen
%udotnorm= min(udotnorm, 1.5); %0.8 ist zu klein

%%

return;

%%

for isubstrate= 1:n_substrate
  
  %%
  
  substrate_id= char(substrate.getID(isubstrate));

  %%
  % diff feeds

  feeds= double(sensors.getMeasurementStream('Q', ['Q_', substrate_id]));
  
  time= double(sensors.getTimeStream('Q', ['Q_', substrate_id]));
  
  %%
  % I need to assure that feeds and time have equal length
  
  if numel(feeds) ~= numel(time)
    error('numel(feeds) ~= numel(time): %i ~= %i', numel(feeds), numel(time));
  end
  
  %%
  % is done because of interp1 below, otherwise we would get NaNs
%   if t_sample(end) > time(end)  
%     time= [time(1:end - 1), t_sample(end)];
%   end
  
  % duplicates in time would introduce errors during interpolation
  % würde auch probleme machen wenn man durch diff(time) teilt. s.u.
  [time, feeds]= deleteDuplicates(time', feeds');
  
  % make row vectors
  time= time(:)';
  feeds= feeds(:)';
  
  %% 
  % ich darf hier nicht resample, da sonst dass nicht mehr die wirkliche
  % ableitung ist, weil zeitinformation nicht mehr drin sind
  %% 
  % ich hatte resampled damit nur die zeiten aus time genommen werden,
  % welche auch tatsächlich simuliert wurden
  %dfeeds= interp1(time', feeds', t_sample, 'nearest');
  
  % das mache ich hier manuell
  
  % erstelle einen vektor welcher bei t(1) oder später beginnt und bei
  % t(end) ode früher endet
  time(1)= max(t(1), time(1));
  time(end)= min(t(end), time(end));
  
  % wähle alle welche zwischen dem interval sind
  % nehme nur die werte, welche echt zwischen min und max sind um duplikate
  % an den rändern zu vermeiden
  idx= min(time > time(1), time < time(end));
  % min und max hier hinzufügen
  idx(1)= 1;
  idx(end)= 1;
  
  time= time(idx);
  
  %%
  % das passiert wenn die simulation nicht bei 0 gestartet wird und time
  % vector vor t(1) liegt, bei const files der fall, welche in der regel
  % zeit von [0 7 14 21] haben
  
  if isempty(time)
    
    time= t(1);             % setze time auf start der simulation
    feeds= feeds(end);      % nehme letzten feed wert
    
  else
    feeds= feeds(idx);      % sonst wähle feeds so aus wie auch time oben
  end
  
  %% 
  % das ist dann nicht mehr die ableitung. Ableitung ist diff(feeds)/diff(time)
  % oder so ähnlich - so sollte es richtig sein
  % if the initial substrate feed of the plant is known, before feeds are
  % applied, then include it in the differentiation. 
  if isempty(init_substrate_feed)
    dfeeds= [0, diff( feeds )] ./ [t(1)-1, diff( time )];
  else
    % assume that init_substrate_feed was one day before simulation started
    dfeeds= diff( [init_substrate_feed(isubstrate), feeds] ) ./ diff( [t(1)-1, time] );
  end
  
  %% 
  % SO IST ES RICHTIG!!!
  % evtl. noch mal quadrieren, bzw. erst gar nicht wurzel ziehen, dann gilt
  % der Ausdruck:
  % || u'(t) ||_2^2 -> Vorteil hier ist, dass Funktion konvex ist, mit sqrt
  % ist diese konkav. konvexe funktion unterscheidet lösungen besser, da
  % diese im wertebereich steiler ist als wie wurzelfunkt. (STIMMT DAS???)
  % aktuell gilt: || u'(t) ||_2  mit sqrt
  %
  % s. auch Diehl: Combined NMPC and MHE for a Copoly... Process
  
  %udotnorm= udotnorm + sqrt(dfeeds * dfeeds');
  udotnorm= udotnorm + (dfeeds * dfeeds');
  
  %%
  
end

%%
% durch Periodendauer teilen, ähnlich wie bei berechnung von el. leistung
% in der physik

if max(t) - min(t) > 0
  udotnorm= udotnorm / ( max(t) - min(t) );
end

%%



%%


