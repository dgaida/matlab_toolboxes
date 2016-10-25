%% online_outlier_detection
% Implementation of an online outlier detection (Median and MAD)
%
function data_filter= online_outlier_detection(N, varargin)
%% Release: 1.3

%%

error( nargchk(2, 5, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

Tmin= 1;

%% TODO
% make this value variable?
c= 3; % 2 <= c <= 4.45, mad multipliziert schon mit 1.4...

%%

validateattributes(N, {'double'}, ...
                   {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'N', 1);

%%

if ischar(varargin{1}) % then read from a database, table
  
  %%
  
  error( nargchk(3, 5, nargin, 'struct') );

  database_name= varargin{1};
  table_name= varargin{2};
    
  checkArgument(database_name, 'database_name', 'char', '2nd');
  checkArgument(table_name, 'table_name', 'char', '3rd');
  
  %%
  
  if nargin >= 4 && ~isempty(varargin{3})
    replaceStrategy= varargin{3};
  else
    replaceStrategy= 'median';
  end
  
  if nargin >= 5 && ~isempty(varargin{4})
    mode= varargin{4};
  else
    mode= 'online';
  end
  
  %%

  validatestring(replaceStrategy, {'median', 'moving average'}, ...
                 mfilename, 'replaceStrategy', 4);

  validatestring(mode, {'online', 'offline'}, ...
                 mfilename, 'mode', 5);

  %%
  
  if strcmp(mode, 'online')
    data= readfromdatabase(database_name, table_name, N);
  else
    % get all data out of database, if offline
    data= readfromdatabase(database_name, table_name, inf);
  end

  %% 
  % hier wäre noch die Option die Daten zu resamplen
  % das ist eher kritisch, da potenzielle Ausreisser dann resampled werden
  % könnte und sich damit verbreiten, so dass diese dann evtl. nicht mehr
  % als lokale ausreisser zu erkennen sind.
  
  % die zeile wurde noch nicht getestet
%   min_time= min( diff( datenum( data(:,1) ) ) );
%   
%   ts_res= resampleDataTS(data, min_time);
%   
%   data= ts_res.Data;
  
  %% TODO
  % hier wird die Annahme gemacht, dass data äquidistant abgetastet ist
  
  data= cell2mat(data(:,2));
  
  %%
  
elseif isa(varargin{1}, 'double') || isa(varargin{1}, 'timeseries')
  
  %%
  
  error( nargchk(2, 4, nargin, 'struct') );
  
  %%
  
  if nargin >= 3 && ~isempty(varargin{2})
    replaceStrategy= varargin{2};
  else
    replaceStrategy= 'median';
  end
  
  if nargin >= 4 && ~isempty(varargin{3})
    mode= varargin{3};
  else
    mode= 'online';
  end
  
  %%

  validatestring(replaceStrategy, {'median', 'moving average'}, ...
                 mfilename, 'replaceStrategy', 3);

  validatestring(mode, {'online', 'offline'}, ...
                 mfilename, 'mode', 4);

  %% TODO
  % hier wird die Annahme gemacht, dass data äquidistant abgetastet ist
  
  if isa(varargin{1}, 'timeseries')
    data= varargin{1}.Data;
  else
    data= varargin{1};
  end
  
else
  error('Check your input arguments!');
end

%%

data= data(:);

%% TODO
% hier wird die Annahme gemacht, dass data äquidistant abgetastet ist
  
if N > numel(data)
  N= numel(data);
end

%%

if strcmp(mode, 'offline')
  start_index= 1;
else
  start_index= numel(data);
end

%%

data_filter= data;

%%

for idata= numel(data):-1:start_index

  %%
  % Window
  % because data must not be equidistantly distributed the interpretation of
  % time length here is not possible.

  W= data( max(idata - N + 1, 1) : idata);

  %%

  if strcmp(replaceStrategy, 'median')
    yMedian= median(W);
  else
    %% TODO
    % does this make sense at all????
    yMedian= nanmoving_average(data(1:idata), min(N, idata), 1, 1);
    yMedian= yMedian( max( fix( min(N, idata) / 2 ), 1) );
  end

  %%
  % Median Absolute Deviation

  T= max(c * mad(W), Tmin);

  %%
  % replace outlier with median over window

  if abs(yMedian - data(idata)) > T
    data_filter(idata)= yMedian;
  end

  %%

end

%%

if strcmp(mode, 'online')
  % only return the last value
  data_filter= data_filter(end);
end

%%


