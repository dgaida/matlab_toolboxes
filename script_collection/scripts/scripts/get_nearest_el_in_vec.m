%% get_nearest_el_in_vec
% Get element out of vector nearest to value of el
%
function [el, index]= get_nearest_el_in_vec(vec, el, before_after)
%% Release: 1.3

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% check arguments

isRn(vec, 'vec', 1);
isR(el, 'el', 2);

validatestring(before_after, {'before', 'after', 'abs'}, ...
               mfilename, 'before_after', 3);   

if sort(vec) ~= vec
  error('Values in vec are not sorted!');
end

%%

diff= vec - el;

%%

if strcmp(before_after, 'before')
  idx= ( diff <= 0 );      % idx= [1 1 1 1 1 0 0 0 ...]
  [minval, index]= min(idx);    % min returns the pos. of 1st 0
  
  if minval == 1      % then they are all before, so return the last value
    index= numel(vec);
  else % if none is before we would have all zeros, then 1st value is returned
    % we get here a 0 then, but below we return max(index, 1) value, so the
    % first
    index= index - 1;         % because we want pos. of last 1
  end
elseif strcmp(before_after, 'after')    % after
  idx= ( diff >= 0 );     % idx= [0 0 0 0 0 1 1 1 ...]
  [maxval, index]= max(idx);    % returns pos. of 1st 1
  
  if maxval == 0          % then first value is returned, because there is no 1
    index= numel(vec);    % none is after, so return last value
  end
else              % absolute value
  [minval, index]= min(abs(diff));
end

%%

el= vec(max(index, 1));

%%


