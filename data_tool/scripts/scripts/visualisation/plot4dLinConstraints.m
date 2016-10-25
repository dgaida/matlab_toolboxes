%% plot4dLinConstraints
% Plot 4-d linear constraints.
%
function [X,Y,Z]= plot4dLinConstraints(A, b, LB, UB, varargin)
%% Release: 1.6

%%

error( nargchk(4, 9, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%

if ~isa(A, 'double') || numel(A) ~= 4
  error('The 1st parameter A must be a 4dim double vector, but is a %s!', ...
        class(A));
end

isR(b, 'b', 2);

if ~isa(LB, 'double') || numel(LB) ~= 4
  error('The 3rd parameter LB must be a 4dim double vector, but is a %s!', ...
        class(LB));
end

if ~isa(UB, 'double') || numel(UB) ~= 4
  error('The 4th parameter UB must be a 4dim double vector, but is a %s!', ...
        class(UB));
end


%%
% readout varargin

if nargin >= 5 && ~isempty(varargin{1})
  alpha= varargin{1};
  
  validateattributes(alpha, {'double'}, {'scalar', 'nonnegative', '<=', 1}, ...
                   mfilename, 'alpha', 5);
else
  alpha= 0.5;
end

if nargin >= 6 && ~isempty(varargin{2})
  noPoints= varargin{2};
  
  isN(noPoints, 'noPoints', 6);
else
  noPoints= 10;
end

%%

if nargin >= 7 && ~isempty(varargin{3})
  color= varargin{3};
  
  checkArgument(color, 'color', 'char', '7th');
else
  color= 'r';
end


%%

if nargin >= 8 && ~isempty(varargin{4})
  iframe= varargin{4};
  
  isN(iframe, 'iframe', 8);
else
  iframe= 1;
end

if nargin >= 9 && ~isempty(varargin{5})
  noFrames= varargin{5}; 
  
  isN(noFrames, 'noFrames', 9);
else 
  noFrames= 10; 
end

%%

if (iframe > noFrames)
  error('iframe > noFrames: %i > %i!', iframe, noFrames);
end

%%

X= []; Y= []; Z= [];

%%

for icol= 1:size(A,2)

  %%

  if A(1,icol)' * A(1,icol) ~= 0

    %%

    switch icol

      case 1

          [Y,Z,t]= ndgrid( ...
                 LB(2):( UB(2) - LB(2) ) / noPoints:UB(2), ...
                 LB(3):( UB(3) - LB(3) ) / noPoints:UB(3), ...
                 LB(4):( UB(4) - LB(4) ) / noFrames:UB(4));

          Y= Y(:,:,iframe);
          Z= Z(:,:,iframe);

          X= 1./ (A(1,1)' .* A(1,1)) .* ...
              A(1,1)' .* ( b(1,1) - A(1,2).*Y ...
                                  - A(1,3).*Z ...
                                  - A(1,4).*t(:,:,iframe) );

      case 2

          [X,Z,t]= ndgrid( ...
                 LB(1):( UB(1) - LB(1) ) / noPoints:UB(1), ...
                 LB(3):( UB(3) - LB(3) ) / noPoints:UB(3), ...
                 LB(4):( UB(4) - LB(4) ) / noFrames:UB(4) );

          X= X(:,:,iframe);
          Z= Z(:,:,iframe);

          Y= 1./ (A(1,2)' .* A(1,2)) .* ...
              A(1,2)' .* ( b(1,1) - A(1,1).*X ...
                                  - A(1,3).*Z ...
                                  - A(1,4).*t(:,:,iframe) );

      case 3

          [X,Y,t]= ndgrid( ...
                 LB(1):( UB(1) - LB(1) ) / noPoints:UB(1), ...
                 LB(2):( UB(2) - LB(2) ) / noPoints:UB(2), ...
                 LB(4):( UB(4) - LB(4) ) / noFrames:UB(4) );

          X= X(:,:,iframe);
          Y= Y(:,:,iframe); 

          Z= 1./ (A(1,3)' .* A(1,3)) .* ...
              A(1,3)' .* ( b(1,1) - A(1,1).*X ...
                                  - A(1,2).*Y ...
                                  - A(1,4).*t(:,:,iframe) );

      otherwise
        error('A value for icol= %i is not allowed!', icol);
    end

    %%

    surf( X, Y, Z, ...
                'EdgeColor', color, ...
                'EdgeAlpha', alpha, ...
                'FaceColor', 'none' );

    X= X(1,round(end/2),round(end/2));
    Y= Y(1,round(end/2),round(end/2));
    Z= Z(1,round(end/2),round(end/2));      

    break;

  end

end

%%

%hold on

%%


