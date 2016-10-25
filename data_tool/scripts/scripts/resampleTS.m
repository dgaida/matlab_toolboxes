%% resampleTS
% Resamples a <matlab:doc('matlab/timeseries') timeseries> using the
% <matlab:doc('tstool') TS tool> 
%
function ts_res= resampleTS(ts, varargin)
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

checkArgument(ts, 'ts', 'timeseries', '1st');

%%

if ~exist('timeseries', 'file') == 2
  error('Timeseries Toolbox not installed!');
end

%%
% t_end is always measured in days
 
if ~isempty(ts.Time)

  t_start= ts.Time(1);
  t_end= ts.Time(end);

  %%
  % ts1= resample(ts, time) resamples the timeseries object ts using the new
  % time vector. The resample method uses the default interpolation method,
  % which you can view by using the getinterpmethod(ts) syntax. 
  %
  % the step width of the time vector, muat be 1/numPerDay, because the time
  % domain in the timeseries object is measured in days per default. 
  %
  % it is important to use fix here instead of round to assure that there
  % are numbers at the given time, otherwise NaNs are appended

  ts_res= resample(ts, ( fix(numPerDay * t_start):1:fix(numPerDay * t_end) ) ./ numPerDay);

else

  ts_res= ts;
  warning('ts:empty', 'The timeseries object ts is empty!');
  
end

%%


