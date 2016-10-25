%% replaceNaNs
% Replace NaN values in vector or matrix by moving average, boundaries by
% median 
%
function data_filter= replaceNaNs(data)
%% Release: 1.4

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check argument

checkArgument(data, 'data', 'double', '1st');


%%

size_data= size(data);

if numel(size_data) > 2
  error('data must be a vector or an 2dim array!');
end

if min(size_data) == 1    % if a vector
  data= data(:);
end

cur_size_data= size(data);
  

%%

nan_vec= isnan(data);

% * 1.1, to make window length a little larger
% max( cumsum(nan_vec) ) returns the largest amount of consecutive nans,
% which have to be filtered. 
%window_len= fix( max( cumsum(nan_vec, 1) ) * 1.1 );

posns= repmat((1:1:cur_size_data(1))', 1, cur_size_data(2));

window_len= fix( ( max( diff( ...
            [0; posns(nan_vec == 0)], 1, 1 ), [], 1 ) - 1 ) * 1.1 );

%window_len= 2 * window_len;

if isempty(window_len)
  window_len= 1;
end

%%
% moving average, wird hier nur genutzt um outlier (NANs) durch benachbarte
% Werte zu approximieren

if size(data, 2) > 1
  data_ok= nanmoving_average2(data, window_len, 0, 1);
else
  data_ok= nanmoving_average(data, window_len, 1, 1);
end

%%
% nur die Werte, welcher vorher NAN waren durch approximierte Werte (Moving
% average) ersetzen, d.h. werte welche nicht nan waren wieder in data_ok
% einsetzen
%
data_ok(~isnan(data))= data(~isnan(data));

%%

data_filter= data_ok;

%%

% if vector
% setze den ersten Wert des Vektors auf den ersten nicht nan wert im Vektor
% und mache moving average erneut, damit randwert am anfang ebenfalls
% gefiltert wird. 
%% TODO
% warum nicht auch den letzten wert auf den letzten nicht nana wert setzen?
if size(data_filter, 2) == 1

  temp= data_filter(~isnan(data_filter));
  
  % temp(1) is nearest non nan value
  if ~isempty(temp)
    data_filter(1)= temp(1);
  else
    error('All components of temp are NaN!');
  end
  
  data_ok= nanmoving_average(data_filter, window_len, 1, 1);
  
  data_ok(~isnan(data_filter))= data_filter(~isnan(data_filter));
  
  data_filter= data_ok;
  
end

%%
% data at the beginning and end of the stream still could be NaN.
% those are set to the median value of the dataset

temp= isnan(data_filter) * diag(nanmedian(data_filter, 1));

data_filter(isnan(data_filter))= temp(isnan(data_filter));

%%

data_filter= reshape(data_filter, size_data);

%%


