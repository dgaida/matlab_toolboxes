%% numerics.conRandMatrix.private.fitness2dmesh
% fitness function for generating a 2d mesh
%
function [fitness, varargout]= ...
            fitness2dmesh(obj, u, popSize, fh, LB, UB, varargin)
%% Release: 1.5

%%

error( nargchk(6, 9, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% readout varargin

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
              
  u= uswarm(iIndividual, :);


  population= reshape(u, numel(u)/popSize, [])';

  p= population;

  v= prod(svd(p));

  %%
  
  if size(p,1) >= 2 && v > 1

    [K, v]= convhulln(p);

    p= unique(p, 'rows');

    t= delaunayn(p);                           	% List of triangles       

    %%

    bars= [t(:,[1,2]); t(:,[1,3]); t(:,[2,3])]; % Interior bars duplicated
    bars= unique(sort(bars,2),'rows');          % Bars as node pairs

    barvec= p(bars(:,1),:) - p(bars(:,2),:);    % List of bar vectors
    L= sqrt(sum(barvec.^2,2));               	% L = Bar lengths
    hbars= feval(fh, ( p(bars(:,1),:) + p(bars(:,2),:) ) / 2);
    % L0 = Desired lengths
    L0= hbars * sqrt( sum(L.^2) / sum(hbars.^2) );
    %F= max(L0-L, 0);                        	% Bar forces (scalars)
    F= abs(L0 - L);

    fitness(iIndividual,1)= sum(F);

    %%

    %v= prod( max(p) - min(p) );

    fitness(iIndividual,1)= fitness(iIndividual,1) + ...
             max(150, fitness(iIndividual,1))* ...
             abs( prod(UB - LB)*1/v - 1 );

  else

    fitness(iIndividual,1)= fitness1dmesh(u, popSize, fh, LB, UB);

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


