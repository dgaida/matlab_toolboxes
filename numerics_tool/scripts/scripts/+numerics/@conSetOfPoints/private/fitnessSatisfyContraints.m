%% numerics.conSetOfPoints.private.fitnessSatisfyContraints
% fitness function to satisfy (non-)linear (in-)equality constraints
%
function [fitness, varargout]= ...
                    fitnessSatisfyContraints(obj, u, popSize, varargin)
%% Release: 1.6

%%

error( nargchk(3, 6, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% readout varargin

if nargin >= 4, 
  A= varargin{1}; 
  
  error( nargchk(5, 6, nargin, 'struct') );
else
  A= []; 
end

if nargin >= 5, b= varargin{2}; else b= []; end;

if nargin >= 6, nonlcon= varargin{3}; else nonlcon= []; end;


%% 
% check arguments

checkArgument(u, 'u', 'double', 2);

validateattributes(popSize, {'double'}, ...
                   {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'popSize', 3);

checkArgument(A, 'A', 'double', 4);
checkArgument(b, 'b', 'double', 5);
checkArgument(nonlcon, 'nonlcon', 'function_handle', 6, 'on');

%%

uswarm= u;

fitness= zeros(size(uswarm, 1), 1);

if nargout >= 2
  linconstraints= zeros(size(uswarm, 1), 1);
end

%par
for iIndividual= 1:size(uswarm, 1)
              
  u= uswarm(iIndividual, :);


  population= reshape(u, numel(u)/popSize, [])';


  %%

  points= obj.getPointsInFullDimension(population);%, Aeq, beq);


  %%
  % nonlinear constraints

  if isa(nonlcon, 'function_handle')

    for ipoint= 1:size(points,1)
      if nargin(nonlcon) == 2
        [c, ceq]= feval(nonlcon, points(ipoint,:), obj);
      else
        [c, ceq]= feval(nonlcon, points(ipoint,:));
      end

      fitness(iIndividual,1)= fitness(iIndividual,1) + ...
                         sum( (c > 0) .* c ) .* 1e4 + ...
                         sum( (ceq ~= 0) .* abs(ceq) ) .* 1e4;
    end

  end


  %%
  % A*x <= b

  if ~isempty(A)
    if nargout >= 2
      linconstraints(iIndividual,1)= sum(max(A * u' - b, 0));
    else
      fitness(iIndividual,1)= fitness(iIndividual,1) + ...
                              1e4 .* sum(max(A * u' - b, 0));
    end
  end


  %%
  % LB and UB

  fitness(iIndividual,1)= fitness(iIndividual,1) + ...
              1e4 .* sum( sum( abs(points) .* ...
              ( points < repmat(obj.LB,size(points,1),1) ) ) );

  fitness(iIndividual,1)= fitness(iIndividual,1) + ...
              1e4 .* sum( sum( abs(points) .* ...
              ( points > repmat(obj.UB,size(points,1),1) ) ) );


end


%%

if nargout >= 2
  varargout{1}= linconstraints;
end


%%


