%% insert_in_vec
% Inserts element in vector at first available position in vector
%
function vec= insert_in_vec(vec, el)
%% Release: 1.3

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

isRn(vec, 'vec', 1);
isR(el, 'el', 2);

%%

ipos= 1;
    
while (ipos <= numel(vec)) && ~isnan(vec(ipos))
  ipos= ipos + 1;     % find a free space symbolized by NaN
end

if ipos > numel(vec)
  error('No space available in given vector vec for given element el!');
end

vec(ipos)= el;      % insert element at position

%%



%%


