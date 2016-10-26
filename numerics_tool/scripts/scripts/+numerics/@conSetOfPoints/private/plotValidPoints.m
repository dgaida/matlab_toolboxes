%% numerics.conSetOfPoints.private.plotValidPoints
% Plot (1,2,3,4)-dim points x, for which the linear inequality constraints 
% $A \cdot \vec{x} \leq \vec{b}$ hold.
%
function plotValidPoints(x, A, b, varargin)
%% Release: 1.6

%%

error( nargchk(3, 5, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(x, 'x', 'double', '1st');
checkArgument(A, 'A', 'double', '2nd');
checkArgument(b, 'b', 'double', '3rd');


%%
% readout varargin

if nargin >= 4 && ~isempty(varargin{1})
  p= varargin{1};
  
  checkArgument(p, 'p', 'double', '4th');
else
  p= x;
end

if nargin >= 5 && ~isempty(varargin{2})
  dispValidBounds= varargin{2};
  
  is0or1(dispValidBounds, 'dispValidBounds', 5);
else
  dispValidBounds= 0;
end

%%

nCols= size(p, 2);

%%

for idir= 1:size(x,1)
           
  %%

  if isempty(A) || ( all(A * x(idir,:)' <= b) )

    %%

    printBoundMessage(p(idir,:), 1, dispValidBounds);

    if size(p,2) ~= size(x,2)
        printBoundMessage(x(idir,:), 1, dispValidBounds);
    end

    if nCols == 1
        %%
        scatter(p(idir, 1), 1);
        %hold on;

    elseif nCols == 2
        %%
        scatter3(p(idir, 1), p(idir, 2), 20000);
        %hold on, 
        view(0,90)

    elseif nCols == 3
        %%
        plot3(p(idir, 1), p(idir, 2), p(idir, 3), 'or');
        %hold on

    elseif nCols == 4
        %%
        plot3(p(idir, 1), p(idir, 2), p(idir, 3), 'or');
        %hold on

    end

  else

    %%

    printBoundMessage(p(idir,:), 0, dispValidBounds);

    if size(p,2) ~= size(x,2)
      printBoundMessage(x(idir,:), 0, dispValidBounds);
    end

  end
    
end

end



%%
% prints a message that the bounds hold/do not hold for the point p,
% depending on the flag valid
function printBoundMessage(p, valid, dispValidBounds)

  %%

  dim= size(p, 2);

  %%

  placeholders= repmat({'%.2f, '}, dim - 1, 1);
  placeholders= [placeholders; {'%.2f'}];

  %%

  switch valid

    %%
    % false
    case 0

      if dim == 1
        fprintf(['The bounds do not hold for p= ', ...
                     placeholders{:}, '\n'], ...
                     p');
      else
        fprintf(['The bounds do not hold for p= (', ...
                     placeholders{:}, ')''\n'], ...
                     p');
      end

    %%
    % true
    case 1

      if dispValidBounds
        if dim == 1
          fprintf(['The bounds hold for p= ', ...
                       placeholders{:}, '\n'], ...
                       p');
        else
          fprintf(['The bounds hold for p= (', ...
                       placeholders{:}, ')''\n'], ...
                       p');
        end
      end

  end

end

%%


