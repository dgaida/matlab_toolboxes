%% tonight
% Returns 8pm this evening as date string format 0: 'dd-mmm-yyyy HH:MM:SS'
%
function mydatestr0= tonight(varargin)
%% Release: 1.7

%%

error( nargchk(0, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 1 && ~isempty(varargin{1})
  hour= varargin{1};
  isN0(hour, 'hour', 1);
else
  hour= 20;
end

%%

date_now= clock();

%%

if hour <= 12
  hour= hour + 12;
end

%%

date_now(4)= hour;
date_now(5:6)= 0;

mydatestr0= datestr(date_now);

%%


