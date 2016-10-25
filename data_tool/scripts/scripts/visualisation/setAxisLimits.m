%% setAxisLimits
% Set axis limits for plotting to up to 3 dimensions.
%
function setAxisLimits(dim, LB, UB)
%% Release: 1.9

%%
% check input parameters

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(dim, 'dim', 'numeric', '1st');
checkArgument(LB,  'LB',  'numeric', '2nd');
checkArgument(UB,  'UB',  'numeric', '3rd');

validateattributes(dim, {'double'}, ...
                   {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'dim', 1);

if numel(LB) ~= dim || numel(UB) ~= dim || ...
   min(size(LB)) ~= 1 || min(size(UB)) ~= 1
  error('The dimension of the vectors LB and UB must be %i!', dim);
end

%%
% 

if ~all(UB >= LB)
  warning('Boundaries:Inconsistency', ...
  'The upper boundary is not always greater equal the lower boundary!');
end

%%
%

xlim([LB(1), UB(1)]);

if dim >= 2
  ylim([LB(2), UB(2)]);
else
  ylim([0.90, 1.10]);
end

if dim >= 3
  zlim([LB(3), UB(3)]);
end

%%


