%% applyFilterBankToDataStream
% Apply a filter bank to a data stream, used for state estimation using
% machine learning methods
%
function [YU, X, varargout]= applyFilterBankToDataStream(x, y, u, t, varargin)
%% Release: 1.1

%%

error( nargchk(4, 7, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%

if nargin >= 5 && ~isempty(varargin{1})
  sample_time= varargin{1};
  isR(sample_time, 'sample_time', 5, '+');
else
  % sample time in hours
  sample_time= 1;
end

%%
% moving average filters for the output measurements, the values in the
% array are given in hours

if nargin >= 6 && ~isempty(varargin{2})
  filter_num_out= varargin{2};
  checkArgument(filter_num_out, 'filter_num_out', 'double', 6);
else
  filter_num_out= [12, 24, 3*24, 7*24, 14*24, 21*24, 31*24];
end

%%
% moving average filters for the input measurements, the values in the
% array are given in hours

if nargin >= 7 && ~isempty(varargin{3})
  filter_num_in= varargin{3};
  checkArgument(filter_num_in, 'filter_num_in', 'double', 7);
else
  filter_num_in= [12, 24, 3*24, 7*24, 14*24];
end

%%

if sample_time > min(min(filter_num_out), min(filter_num_in))
  error('sample_time must be >= the min values of filter_num_out and filter_num_in!');
end

%%
% check input arguments

checkArgument(x, 'x', 'double', '1st');
checkArgument(y, 'y', 'double', '2nd');
checkArgument(u, 'u', 'double', '3rd');
isRn(t, 't', 4, '+');

%%
% ts as parameter measured in days
% because sample_time measured in hours we divide by 24
% new t is still measured in days
ts= t;

%%
% es wurden bisher noch keine daten aufgezeichnet
if max(ts) <= min(ts)
  YU= [];
  X= [];

  return;
end

% erstelle ein äquidistanten zeitvektor
% sample_time wird in stunden gemessen, ts in tagen
% deshalb umrechnungsfaktor 1/24 von stunden in tagen
t= (min(ts):sample_time*1/24:max(ts))';


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
n_filter_in= numel(filter_num_in);

% max. faktor den man * sample_time in die vergangenheit durch die
% filterung zurück geht, bzw. gehen muss.
max_filter= max(filter_num);


%%
% resample state vector x

X= interp1(ts, x, t, 'linear');

X(1:max_filter - 1, :)= [];

%%
% t ist in sample times gerastert, d.h. wenn man weiter in die
% vergangenheit muss, als wie t lang ist, dann geht das nicht...
if max_filter - 1 >= size(t,1)
  %t(1:max_filter - 1, :)= [];
  YU= [];
  %warning('time length is to short!');

  return;
end

%%

ys= y;

%% 
% init 
YU= zeros(numel(t), ( n_filter    + 1 ) * size(y, 2) + ...
                    ( n_filter_in + 1 ) * size(u, 2));

%%

icolYU= 1;

for ioutin= 1:2

  %%
  
  if ioutin == 2
    % input
    ys= u;
    n_filter= n_filter_in;
    filter_num= filter_num_in ./ sample_time; % in hours
  end
  
  %%
  
  for icol= 1:size(ys, 2)

    y= interp1(ts, ys(:, icol), t, 'linear');

    YU(:, icolYU)= y;

    for ifilter= 1:n_filter

      % zeitfenster einheitenlos, vielfaches der sampling time
      window= filter_num(1, ifilter);

      YU(:, icolYU + ifilter)= filter(1/window .* ones(1,window), 1, y);

    end

    icolYU= icolYU + n_filter + 1;

  end

end

%%

YU(1:max_filter - 1, :)= [];

%%

if nargout >= 3
  t(1:max_filter - 1, :)= [];
  
  varargout{1}= t;
end

%%


