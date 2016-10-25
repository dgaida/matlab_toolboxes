%% plot2dLinConstraints
% Plot 2-d linear constraints.
%
function [X, Y]= plot2dLinConstraints(A, b, LB, UB, varargin)
%% Release: 1.8

%%

error( nargchk(4, 6, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

if ~isa(A, 'double') || numel(A) ~= 2
  error('The 1st parameter A must be a 2dim double vector, but is a %s!', ...
        class(A));
end

isR(b, 'b', 2);

if ~isa(LB, 'double') || numel(LB) ~= 2
  error('The 3rd parameter LB must be a 2dim double vector, but is a %s!', ...
        class(LB));
end

if ~isa(UB, 'double') || numel(UB) ~= 2
  error('The 4th parameter UB must be a 2dim double vector, but is a %s!', ...
        class(UB));
end

%%
% readout varargin

if nargin >= 5 && ~isempty(varargin{1})
  noPoints= varargin{1};
  
  isN(noPoints, 'noPoints', 5);
else
  noPoints= 10;
end

%%

if nargin >= 6 && ~isempty(varargin{2}), 
  color= varargin{2}; 
  
  checkArgument(color, 'color', 'char', '6th');
else
  color= 'r';
end

%%

X= []; Y= [];

%%

for icol= 1:size(A,2)

  %%

  if A(1,icol)' * A(1,icol) ~= 0

    %%

    switch icol

      case 1

          %%
          % $a_{11} \cdot x + a_{12} \cdot y= b$
          %
          % ->
          %
          % $x= \frac{ b - a_{12} \cdot y }{ a_{11} }$
          %
          Y= ( LB(2):( UB(2) - LB(2) ) / noPoints:UB(2) );
          X= 1./ (A(1,1)' .* A(1,1)) .* ...
                  A(1,1)' .* ( b(1,1) - A(1,2).*Y );

      case 2

          %%
          % $a_{11} \cdot x + a_{12} \cdot y= b$
          %
          % ->
          %
          % $y= \frac{ b - a_{11} \cdot x }{ a_{12} }$
          %
          % Die Gleichung ist so geschrieben, dass sie auch für
          % Vektoren $\vec{a}_1$ gelten würde, hier nicht
          % benötigt, da der Plot nur 1 RB auf einmal zulässt
          %
          X= ( LB(1):( UB(1) - LB(1) ) / noPoints:UB(1) );
          Y= 1./ (A(1,2)' .* A(1,2)) .* ...
                  A(1,2)' .* ( b(1,1) - A(1,1).*X );

      otherwise

          error('Unallowed value for icol= %i', icol);
    end

    %%

    plot( X, Y, color );

    %%
    % return the median knot

    X= X(1,round(end/2));
    Y= Y(1,round(end/2));

    %%

    break;

  end

end

%%

%hold on

%%
   

