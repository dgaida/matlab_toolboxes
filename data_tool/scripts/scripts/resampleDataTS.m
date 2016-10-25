%% resampleDataTS
% Resamples data using the timeseries toolbox
%
function ts_res= resampleDataTS(data, varargin)
%% Release: 1.8

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  numPerDay= varargin{1};
  
  isN(numPerDay, 'numPerDay', 2);
else
  numPerDay= 24; % 24*60, 24*60*60
end

%%
% check input args

checkArgument(data, 'data', 'cell', '1st');

%%
% create timeseries object

if exist('timeseries', 'file') == 2
  ts= timeseries(cell2mat(data(:,2)),data(:,1));
else
  error('Timeseries Toolbox not installed!');
end

%%

ts_res= resampleTS(ts, numPerDay);

%%


