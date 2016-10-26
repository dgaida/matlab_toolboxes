%% integrate_data
% Integrate data vector over time domain between boundaries
%
function int_data= integrate_data(data, time, varargin)
%% Release: 1.2

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  a= varargin{1};
  isR(a, 'a', 3);
else
  a= time(1);
end

if nargin >= 4 && ~isempty(varargin{2})
  b= varargin{2};
  isR(b, 'b', 4);
else
  b= time(end);
end

%%
% check argument

isRn(data, 'data', 1);
isRn(time, 'time', 2);

%%

[a0, ind_a]= get_nearest_el_in_vec(time, a, 'after');
[b0, ind_b]= get_nearest_el_in_vec(time, b, 'before');

%%

if (ind_a >= ind_b)
  warning('int:bounds', 'time domain is zero: %.3e >= %.3e!', a, b);
  
  int_data= 0;
  
  return;
end

%%

time= time(ind_a:ind_b);
data= data(ind_a:ind_b);

time= time(:)';
% to get the integral I need to take the absolute values
% we do not do that, so we have negative and positive areas which cancel
% out, thus area of sinus(0, 2pi) is 0. 
data= ...abs(
  data(:)'; %);

%%

dt= diff(time);
% wenn ich am fang eine 0 einfüge, unterschlage ich den anfang der fläche
% ein wenig, aber denke, das ist das beste was ich machen kann
dt= [0*dt(1)/2 dt(1:end)];

int_data= data * dt';

%%


