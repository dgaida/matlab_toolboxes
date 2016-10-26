%% createSubstrateFeedsForStateEstimation
% Create substrate feeds used to learn the state estimator
%
function createSubstrateFeedsForStateEstimation(substrate, ...
              substrate_network_min, substrate_network_max, ...
              plant, plant_network, plant_network_min, plant_network_max, ...
              timespan, varname, varargin)
%% Release: 1.3

%%

error( nargchk(9, 11, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 10 && ~isempty(varargin{1})
  n_filter_out= varargin{1};
  isN(n_filter_out, 'n_filter_out', 10);
else
  n_filter_out= 7;
end

if nargin >= 11 && ~isempty(varargin{2})
  n_filter_in= varargin{2};
  isN(n_filter_in, 'n_filter_in', 11);
else
  n_filter_in= 5;
end


%%
% check arguments

is_substrate(substrate, '1st');
is_substrate_network(substrate_network_min, 2, substrate, plant);
is_substrate_network(substrate_network_max, 3, substrate, plant);
is_plant(plant, 4);
is_plant_network(plant_network, 5, plant);
is_plant_network(plant_network_min, 6, plant);
is_plant_network(plant_network_max, 7, plant);

checkArgument(timespan, 'timespan', 'double', 8);
checkArgument(varname, 'varname', 'char', 9);

%%

n_substrate= substrate.getNumSubstratesD();
n_digester= plant.getNumDigestersD();

%%
% add a little bit of randomness, such that feed sometimes is created
% randomly and not always based on the histogram criteria
if exist(sprintf('%s.mat', varname), 'file') && rand(1,1) > 0.4
  create_feed_systematically= 1;
else
  create_feed_systematically= 0;
end

%%

if create_feed_systematically
  
  %%
  
  dataset= load_file(varname);
    
  %% TODO
  % 4 is a fixed number, als parameter übergeben
  
  % position where the substrate feed begins
  % 4 comes from 4 measurements
  % +1 in Klammer, weil eine spalte auch original messung übersprungen
  % werden muss.
  pos= (n_filter_out + 1)*4*n_digester + 1;     
  
  dataset= dataset(:, pos:end);
  
  % ignore the columns containing filtered feed values
  % +1, da 1 spalte original input feed
  dataset= dataset(:,1:n_filter_in + 1:end);    
  
  %%
  
  n_classes= 4;     % number of bins, that are used to create Q
  
  %%
  
  nenner= sum(1:n_classes);
  
  % split timespan into n_classes parts, where the first class
  % gets the longest duration.
  % example: 4/10, 3/10, 2/10, 1/10
  % 10 is the sum of 1:n_classes
  % wird gemacht, da unten aufgezeichneter Datensatz in 10 klassen
  % eingeteilt wird, und die 4 kleinsten klassen mit daten gefüllt werden,
  % damit kleinste klasse die meisten daten bekommt, wird hier timespans
  % ungleichmäßig aufgeteilt
  timespans= round( timespan(end) .* (n_classes:-1:1) ./ nenner );
  % the last value is set accordingly, such that the sum of
  % the elements in timespans is equal to timespan(end)
  timespans(end)= timespan(end) - sum(timespans(1:end-1));
  
end

%%
% for each substrate and recirculation
for isubstrate= 1:n_substrate

  %%

  LB= sum(substrate_network_min(isubstrate,:));
  UB= sum(substrate_network_max(isubstrate,:));

  %%
  
  if (LB > UB)
    temp= UB;
    UB= LB;
    LB= temp;
    warning('bounds:invalid', 'LB > UB!');
  end
  
  %%
  
  if (LB == UB)
    Q= ones(timespan(end), 1) * LB;
  elseif create_feed_systematically == 1
    
    %%
    
    feed= dataset(:,isubstrate);    % get recorded feed for given substrate

    n= hist(feed, 10);              % get histogram, 10 bins

    [nsort, idx]= sort(n);

    % take the smallest n_classes bins
    smallest_class_ids= idx(1:n_classes); % get n_classes smallest bins

    Q= [];%zeros(timespan(end), 1);

    step= (UB - LB) / 10;           % die 10 kommt von 10 bins oben bei hist

    %%
    % create data for smallest classes 
    
    for iclass= 1:numel(smallest_class_ids)

      lb= LB + (smallest_class_ids(iclass) - 1) * step;
      ub= lb + step;

      Qclass= ones(timespans(iclass), 1) * lb + ...
              rand(timespans(iclass), 1) * ( ub - lb );

      Qclass= Qclass(:)';

      Q= [Q, Qclass];

    end

  else
  
    Q= ones(timespan(end), 1) * LB + ...
       rand(timespan(end), 1) * ( UB - LB );
    
  end
  
  %%
  % decides whether data gets sorted or not
  %% TODO
  % warum hängt das von n_substrate ab? ws ist wenn es nur 2 substrate
  % gibt?
  sw_substrate= round( rand(1,1) .* (n_substrate - 1) ) + 1;

  %%

  if mod(sw_substrate, 3) == 1    
    Q= sort(Q, 'ascend');    
  elseif mod(sw_substrate, 3) == 2  
    Q= sort(Q, 'descend');    
  end

  %%

  substrate_id= char(substrate.getID(isubstrate));

  createvolumeflowfile('user', [], substrate_id, 1, Q, [], [], [], [], [], 0);

  %%

end
  
%% 

[nSplits, digester_splits, digester_indices]= ...
       getNumDigesterSplits(plant_network, plant_network_max, plant);

%%

if exist('dataset', 'var') && (nSplits ~= size(dataset, 2) - n_substrate)
  
  %% TODO
  % es kann auch passieren, dass rezirkulation 0 ist, dann steht die nicht
  % in dataset. 
  % ne das problem ist, dass auch mehrere pumpen im modell sein können,
  % welche nicht rezirkulieren oder etwas splitten, sondern vorwärts
  % pumpen, diese sind dann auch in dataset, werden aber nicht von splits
  % aufgezählt 
  
  warning('nSplits ~= size(dataset, 2) - n_substrate)');
  
  disp(nSplits)
  disp(size(dataset, 2))
  disp(n_substrate)
  
end

%%

for ifeed= n_substrate + 1:n_substrate + nSplits
  
  %% TODO
  % use dataset
  
  %%
  
  irecirculation= ifeed - n_substrate;
  
  %%
  
  LB= plant_network_min( digester_indices(irecirculation,1), ...
                         digester_indices(irecirculation,2) );
  UB= plant_network_max( digester_indices(irecirculation,1), ...
                         digester_indices(irecirculation,2) );

  %%
  
  if LB == UB
    Q= ones(timespan(end), 1) * LB;
  else
    %% TODO
    %
    error('not yet implemented!');
  end
  
  %%
  
  createvolumeflowfile('user', [], digester_splits{irecirculation}, 1, Q, ...
                       [], [], [], [], [], 0);

  %%
  
end

%%



%%


