%% get_index_of_el_in_vec
% Get the index of given element in the given vector
%
function index= get_index_of_el_in_vec(vec, el)
%% Release: 1.4

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments (is done below)

%%

if numel(vec) ~= numel(unique(vec))
  error('Elements in vector vec are not unique!');
end

%%

if ischar(el) && iscellstr(vec)
  [max_el, index]= max(cellfun(@isempty, strfind(vec, el)) == 0);
else
  % check arguments here
  isRn(vec, 'vec', 1);
  isR(el, 'el', 2);
  
  [max_el, index]= max(vec / el == 1);
end

%%

if (max_el == 0)
  error('Cannot find element el in vector vec!');
end

%%



%%


