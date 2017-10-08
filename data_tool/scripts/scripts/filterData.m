%% filterData
% Detect global outliers in a double vector using 3 $\sigma$ edit rule,
% where sigma is estimated using the MAD or std. deviation.
%
function [data_filter]= filterData(data, varargin)
%% Release: 1.6

%%

error( nargchk(1, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% read out varargin

if nargin >= 2 && ~isempty(varargin{1})
  deviation= varargin{1};
else
  deviation= 'mad'; % 'std'
end

if nargin >= 3 && ~isempty(varargin{2})
  replaceNANs= varargin{2};
else
  replaceNANs= 1; % replace nans by moving average
end

if nargin >= 4 && ~isempty(varargin{3})
  multiplicator= varargin{3};
else
  multiplicator= 3; % 
end


%%
% check input params

checkArgument(data, 'data', 'double', '1st');

validatestring(deviation, {'mad', 'std'}, ...
               mfilename, 'deviation', 2);

is0or1(replaceNANs, 'replaceNANs', 3);

validateattributes(multiplicator, {'double'}, ...
                   {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'multiplicator', 4);


%%
% auf jeden fall müssen die mittelwertfrei sein, wegen abfrage unten auf
% valid!!!

median_data= nanmedian(data);

% daten mittelwertfrei machen, dazu wird der median genutzt, da mittelwert
% nicht sinnvoll erscheint

%data_orig= data;
data= data - median_data;


%% 
% Bestimmung der Stdabweichung

if strcmp(deviation, 'mad')

  %% TODO
  % sollte hier evtl. nanmad genutzt werden, aus data_tool/statistics?
  std_data= mad(data);
  
  if (std_data == 0)
    if (nanmedian(data) == min(data) || nanmedian(data) == max(data))
      warning(['median absolute deviation of data is zero, ', ...
             'because median of data (%.2f) is the same as min or max ', ...
             'of data (%.2f respectively %.2f)! Returning unfiltered data.'], ...
             nanmedian(data), min(data), max(data));
           
      data_filter= data;
      return;
    else
       % since we use mad above, mad can be 0 although min and max != 0,
        % then we cannot filter the data, so all data is valid
      warning('median absolute deviation of data is zero, do not know why!');
      data_filter= data;
      return;
    end
  end
  
  %% 
  % 1.4826 actually should be deleted, because it is already inside mad
  %valid= (abs(data) < multiplicator * 1.4826 * std_data);
  valid= (abs(data) < multiplicator * std_data);

elseif strcmp(deviation, 'std')

  std_data= std(data);

  valid= (abs(data) < multiplicator * std_data);

else
  error('Unknown standard deviation estimator: %s!', deviation);
end


%%
% filtern der daten, NANs zeigen outlier an

data_filter= NaN(size(data));

data_filter(valid)= data(valid);

%%
% mittelwert wieder drauf rechnen

data_filter= data_filter + median_data;

%%

if (replaceNANs)
   
  data_filter= replaceNaNs(data_filter);

end

%%


