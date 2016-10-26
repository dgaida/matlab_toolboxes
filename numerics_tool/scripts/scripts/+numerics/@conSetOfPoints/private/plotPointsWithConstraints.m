%% numerics.conSetOfPoints.private.plotPointsWithConstraints
% Plot constraints and points which satisfy these constraints.
%
function x= plotPointsWithConstraints(obj, p, dim, A, b, Aeq, beq, ...
                                   LB, UB, nonlcon, Aval, bval, varargin)
%% Release: 1.5

%%

error( nargchk(12, 13, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 13 && ~isempty(varargin{1}),
  plotnonlcon= varargin{1}; 
  
  is0or1(plotnonlcon, 'plotnonlcon', 13);
else
  plotnonlcon= 0; 
end

%%

checkArgument(p,   'p',   'double', '2nd');

isN(dim, 'dim', 3);

checkArgument(A,   'A',   'double', '4th');
checkArgument(b,   'b',   'double', '5th');
checkArgument(Aeq, 'Aeq', 'double', '6th');
checkArgument(beq, 'beq', 'double', '7th');
checkArgument(LB,  'LB',  'double', '8th');
checkArgument(UB,  'UB',  'double', '9th');

checkArgument(nonlcon, 'nonlcon', 'function_handle', 10, 'on');

checkArgument(Aval, 'Aval', 'double', '11th');
checkArgument(bval, 'bval', 'double', '12th');

%%

x= getPointsInFullDimension(obj, p);

%%

hold on;
     
%%

if size(x,2) == dim
  % plot full dimension
  plotConstraints(obj, dim, A, b, Aeq, beq, LB, UB, nonlcon, [], [], plotnonlcon);

  plotValidPoints(x, Aval, bval);
elseif size(p,2) == dim
  % plot reduced dimension
  plotConstraints(obj, dim, A, b, [], [], LB, UB, nonlcon, [], [], plotnonlcon);

  plotValidPoints(x, Aval, bval, p);
else
  error('dim must have either the dimension of x (%i) or p (%i), but has %i!', ...
        size(x,2), size(p,2), dim);
end

%%

min_dist= min(UB-LB);

if dim == 1
  min_dist= 0.1;
end

if min_dist / max(UB-LB) > 0.1 
  axis equal;
end

%%

setAxisLimits(dim, LB, UB);

%%
        
hold off;

%%


