%% create_rand_signal
% Generate/Create a random signal
%
function u= create_rand_signal(varargin)
%% Release: 1.4

%%

error( nargchk(0, 6, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 1 && ~isempty(varargin{1})
  toiter= varargin{1};
  isN(toiter, 'toiter', 1);
else
  toiter= 2000;
end

if nargin >= 2 && ~isempty(varargin{2})
  npoints= varargin{2};
  isN(npoints, 'npoints', 2);
else
  npoints= 15;
end

if nargin >= 3 && ~isempty(varargin{3})
  min_max= varargin{3};
  isRn(min_max, 'min_max', 3);
  
  if numel(min_max) ~= 2
    error('min_max has to be 2-dimensional!');
  end
else
  min_max= [0 50];
end

if nargin >= 4 && ~isempty(varargin{4})
  interpolation= varargin{4};
  % 
  validatestring(interpolation, {'linear', 'nearest', 'cubic', 'spline'}, ...
                 mfilename, 'interpolation', 4);
else
  interpolation= 'spline';
end

if nargin >= 5 && ~isempty(varargin{5})
  start_value= varargin{5};
  isR(start_value, 'start_value', 5);
else
  start_value= [];
end

if nargin >= 6 && ~isempty(varargin{6})
  end_value= varargin{6};
  isR(end_value, 'end_value', 6);
else
  end_value= [];
end

%%
% generate npoints uniformly distributed pseudorandom integers, ranging
% from 0 to toiter
timesteps= unique(sort([0; randi(toiter, max(0, npoints - 2), 1); toiter]));

% generate uniformly distributed pseudorandom integers, ranging
% from min to max
rand_num= min_max(1) - 1 + (1 + min_max(2) - min_max(1)) .* rand(numel(timesteps), 1);

if ~isempty(start_value)
  rand_num(1)= start_value;
end

if ~isempty(end_value)
  rand_num(end)= end_value;
end

%%
% generate an interpolated signal

u= interp1(timesteps, rand_num, 1:toiter, interpolation)';

%%

u= max(u, min_max(1));
u= min(u, min_max(2));

%%


