%% numerics.conRandMatrix.private.fitnessndmesh
% fitness function for generating a n-d mesh
%
function [fitness, varargout]= ...
                fitnessndmesh(obj, u, popSize, fh, LB, UB, varargin)
%% Release: 1.4

%%

error( nargchk(6, 9, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

if nargin >= 7, nonlcon= varargin{1}; else nonlcon= []; end;
if nargin >= 8, A= varargin{2}; else A= []; end;
if nargin >= 9, b= varargin{3}; else b= []; end;


%%
% check input params

checkArgument(u, 'u', 'double', 2);

validateattributes(popSize, {'double'}, {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'popSize', 3);
                 
checkArgument(fh, 'fh', 'function_handle', 4);
checkArgument(LB, 'LB', 'double', 5);
checkArgument(UB, 'UB', 'double', 6);
checkArgument(nonlcon, 'nonlcon', 'function_handle', 7, 'on');                 
checkArgument(A, 'A', 'double', 8);
checkArgument(b, 'b', 'double', 9);


%%

uswarm= u;

fitness= zeros(size(uswarm, 1), 1);

if nargout >= 2
  linconstraints= zeros(size(uswarm, 1), 1);
end

%par
for iIndividual= 1:size(uswarm, 1)
              
  %%
  
  u= uswarm(iIndividual, :);


  population= reshape(u, numel(u)/popSize, [])';

  p= population;

  v= prod(svd(p));

  %%
  
  if v > 1

%         if size(p,1) < size(p,2)
%             [K, v]= convhulln(p(:,1:size(p,1)));
%         else
%             [K, v]= convhulln(p);
%         end

    if size(p,2) >= size(p,1)
        p= p(:,1:size(p,1) - 1);
    end

    t= delaunayn(p);                           	% List of triangles

    dim= size(p, 2);

    %L0mult= 1+.4/2^(dim-1);

    %%
    % 4. Describe each edge by a unique pair of nodes
    pair= zeros(0,2);
    localpairs= nchoosek(1:dim+1,2);

    for ii=1:size(localpairs,1)
      pair= [pair; t(:,localpairs(ii,:))];
    end

    pair= unique(sort(pair,2),'rows');


    %%

    bars= p(pair(:,1),:) - p(pair(:,2),:); 	% List of bar vectors
    L= sqrt(sum(bars.^2,2));             	% L = Bar lengths
    L0= feval(fh, ( p(pair(:,1),:) + p(pair(:,2),:) ) / 2);
    % L0 = Desired lengths
    L0= L0 * ( sum(L.^dim) / sum(L0.^dim) )^(1/dim);
    %F= max(L0 - L, 0);                      % Bar forces (scalars)
    F= abs(L0 - L);

    fitness(iIndividual,1)= sum(F);

    %%

    if v > prod(UB - LB)
        try
            [K, v]= convhulln(p);
        catch ME
            warning('convhulln:error', 'Got an error! %s', ME.message);
        end
    end

    %v= prod( max(p) - min(p) );

    fitness(iIndividual,1)= fitness(iIndividual,1) + ...
                            max(150, fitness(iIndividual,1))* ...
                            abs( prod(UB - LB)*1/v - 1 );

  else

    fitness(iIndividual,1)= fitness1dmesh(u, popSize, LB, UB, fh);

  end


  %%

  points= obj.getPointsInFullDimension(population);%, Aeq, beq);


  %%
  % nonlinear constraints

  if isa(nonlcon, 'function_handle')

    for ipoint= 1:size(points,1)
        [c, ceq]= feval(nonlcon, points(ipoint,:));

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


