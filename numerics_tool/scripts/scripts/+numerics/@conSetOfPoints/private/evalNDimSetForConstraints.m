%% numerics.conSetOfPoints.private.evalNDimSetForConstraints
% Evaluate a n-dim dataset |x| with respect to boundaries and
% constraints.
%
function success= evalNDimSetForConstraints(x, varargin)
%% Release: 1.8

%%

error( nargchk(1, 9, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% readout varargin

if nargin >= 2, 
  A= varargin{1}; 
  
  error( nargchk(3, 9, nargin, 'struct') );
else
  A= []; 
end

if nargin >= 3, b= varargin{2}; else b= []; end;

if nargin >= 4, 
  Aeq= varargin{3}; 
  
  error( nargchk(5, 9, nargin, 'struct') );
else
  Aeq= []; 
end

if nargin >= 5, beq= varargin{4}; else beq= []; end;

if nargin >= 6, LB= varargin{5}; else LB= []; end;
if nargin >= 7, UB= varargin{6}; else UB= []; end;
if nargin >= 8, nonlcon= varargin{7}; else nonlcon= []; end;

if nargin >= 9 && ~isempty(varargin{8})
  dispValidBounds= varargin{8};
else
  dispValidBounds= 0;
end


%%
% check parameters

checkArgument(x, 'x', 'double', '1st');
checkArgument(A, 'A', 'double', '2nd');
checkArgument(b, 'b', 'double', '3rd');
checkArgument(Aeq, 'Aeq', 'double', '4th');
checkArgument(beq, 'beq', 'double', '5th');
checkArgument(LB, 'LB', 'double', 6);
checkArgument(UB, 'UB', 'double', 7);
checkArgument(nonlcon, 'nonlcon', 'function_handle', 8, 'on');

if ~isempty(A) && size(A, 2) ~= size(x,2)
  error('size(A, 2) ~= size(x,2) : %i ~= %i', size(A, 2), size(x,2));
end

if size(A,1) ~= size(b,1)
  error('size(A,1) ~= size(b,1) : %i ~= %i', size(A,1), size(b,1));
end

if ~isempty(Aeq) && size(Aeq, 2) ~= size(x,2)
  error('size(Aeq, 2) ~= size(x,2) : %i ~= %i', size(Aeq, 2), size(x,2));
end

if size(Aeq,1) ~= size(beq,1)
  error('size(Aeq,1) ~= size(beq,1) : %i ~= %i', size(Aeq,1), size(beq,1));
end

LB= LB(:)';
UB= UB(:)';

if size(LB,2) ~= size(x,2)
  error('size(LB,2) ~= size(x,2) : %i ~= %i', size(LB,2), size(x,2));
end

if size(UB,2) ~= size(x,2)
  error('size(UB,2) ~= size(x,2) : %i ~= %i', size(UB,2), size(x,2));
end

is0or1(dispValidBounds, 'dispValidBounds', 9);

%%

nRows= size(x,1);

success= 1;


%%

if all( min(x,[],1) >= LB )
   
  if (dispValidBounds)
    disp('LB holds!');
  end

else

  [value, index]= max(LB - min(x,[],1));

  warning('bounds:LB', 'LB does not hold! The maximal error at %i is: %.2e', ...
          index, value);

  success= 0;

end


%%

if all( max(x,[],1) <= UB )

  if (dispValidBounds)
    disp('UB holds!');
  end

else

  [value, index]= max(max(x,[],1) - UB);

  warning('bounds:UB', 'UB does not hold! The maximal error at %i is: %.2e', ...
          index, value);

  success= 0;

end

%%

if ~isempty(A)

  for irow= 1:nRows

    if all( A*x(irow, :)' <= b )

      if (dispValidBounds)
        disp('Inequality constraints A*x <= b hold!');

        disp('A * x <= b');
        %disp( ['[', num2str(A), '] * [', ...
         %           num2str(x(irow, :)'), ']'' <= ', ...
          %          num2str(b)] );
      end
      
    else

      [value, index]= max(A*x(irow, :)' - b);

      warning(['Inequality constraints A*x <= b do not hold! ', ...
               'The maximal error at %i is: %.2e'], index, value);

      disp('A * x > b');
      disp( ['[', num2str(A(index,:)), '] * [', ...
                  num2str(x(irow, :)), ']'' > ', ...
                  num2str(b(index,:))] );

      success= 0;

    end

  end

end


%%

if ~isempty(Aeq)

  epsilon= 10^-12;

  for irow= 1:nRows

    if all( abs( Aeq*x(irow, :)' - beq ) <= epsilon )

      if (dispValidBounds)
        disp('Equality constraints Aeq*x == beq hold!');

        disp('Aeq * x == beq');
        %disp( ['[', num2str(Aeq), '] * [', ...
        %           num2str(x(irow, :)'), ']'' == ', ...
          %          num2str(beq)] );
      end
      
    else

      [value, index]= max( abs( Aeq*x(irow, :)' - beq ) );

      warning(['Equality constraints Aeq*x == beq do not hold! ', ...
               'The maximal error at %i is: %.2e'], index, value);

      disp('Aeq * x ~= beq');
      disp( ['[', num2str(Aeq(index,:)), '] * [', ...
                  num2str(x(irow, :)), ']'' ~= ', ...
                  num2str(beq(index,:))] );

      success= 0;

    end

  end

end


%%

if isa(nonlcon, 'function_handle')

  for irow= 1:nRows

    %%

    [c, ceq]= feval(nonlcon, x(irow, :));

    %%

    if ~isempty(c)

      if all( c <= 0 )

        if (dispValidBounds)
          disp('Nonlinear inequality constraints c <= 0 hold!');
        end
        
      else

        [value, index]= max(c);

        warning(['Nonlinear inequality constraints c(x) <= 0 do not hold! ', ...
                 'The maximal error at %i is: %.2e'], index, value);

        success= 0;

      end

    end

    %%

    if ~isempty(ceq)

      epsilon= 10^-12;

      if all( abs( ceq ) <= epsilon )

        if (dispValidBounds)
          disp('Nonlinear equality constraints ceq(x) == 0 hold!');
        end
        
      else

        [value, index]= max( abs( ceq ) );

        warning(['Nonlinear equality constraints ceq(x) == 0 do not hold! ', ...
                 'The maximal error at %i is: %.2e'], index, value);

        success= 0;

      end

    end

  end
    
end

%%


