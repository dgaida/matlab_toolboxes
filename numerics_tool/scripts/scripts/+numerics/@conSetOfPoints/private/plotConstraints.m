%% numerics.conSetOfPoints.private.plotConstraints
% Plots linear constraints in 1, 2, 3, 4 dimensions.
%
function plotConstraints(obj, dim, A, b, Aeq, beq, LB, UB, varargin)
%% Release: 1.5

%%

error( nargchk(8, 12, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

isN(dim, 'dim', 2);

checkArgument(A, 'A', 'double', '3rd');
checkArgument(b, 'b', 'double', '4th');
checkArgument(Aeq, 'Aeq', 'double', '5th');
checkArgument(beq, 'beq', 'double', '6th');
checkArgument(LB, 'LB', 'double', '7th');
checkArgument(UB, 'UB', 'double', '8th');

%%
% readout varargin

if nargin >= 9, nonlcon= varargin{1}; else nonlcon= []; end;

if nargin >= 10 && ~isempty(varargin{2}),
  iframe= varargin{2}; 
  
  isN(iframe, 'iframe', 10);
else
  iframe= 1; 
end

if nargin >= 11 && ~isempty(varargin{3}), 
  noFrames= varargin{3};
  
  isN(noFrames, 'noFrames', 11);
else
  noFrames= 10; 
end

if nargin >= 12 && ~isempty(varargin{4}),
  plotnonlcon= varargin{4}; 
  
  is0or1(plotnonlcon, 'plotnonlcon', 12);
else
  plotnonlcon= 0; 
end


%%

colordefs= {'b', 'm', 'c', 'r', 'g', 'b', 'y', 'k'};
        

%%

switch dim
    
  case 1

    %%

    %%
    % linear equality constraints

    for irow= 1:size(Aeq,1)

      color= char(colordefs(mod(irow,8) + 1));

      plot1dLinConstraints(Aeq(irow,:), beq(irow,:), [color, 'd']);

    end

    %%
    % linear inequality constraints

    for irow= 1:size(A,1)

      color= char(colordefs(mod(irow,8) + 1));

      [X]= plot1dLinConstraints(A(irow,:), b(irow,:), ...
                                [color, 's']);

      if ~isempty(X)
        quiver(X, 1, -A(irow,1), 0, color);
      end

    end

    %%
    % nonlinear (in-)equality constraints

    if plotnonlcon

      X= (LB(1):( UB(1) - LB(1) ) / 200:UB(1))';

      if isa(nonlcon, 'function_handle')

        Cnonlcon= zeros(size(X));

        for iv= 1:size(X,1)

          point= X(iv);

          % der Punkt muss evtl. noch in den richtigen Raum
          % transformiert werden, kann man evtl. auch vor der
          % schleife machen

          if obj.dim ~= size(point,2)
            x= getPointsInFullDimension(obj, point);%, obj.Aeq, obj.beq);
          else
            x= point;
          end

          [c, ceq]= feval( nonlcon, x );

          for inonlineqcon= 1:size(c,1)
              Cnonlcon(iv)= Cnonlcon(iv) + inonlineqcon .* ...
                   ( c(inonlineqcon,1) <= 0 );
          end

          for inonleqcon= 1:size(ceq,1)
              Cnonlcon(iv)= Cnonlcon(iv) + ...
                   ( inonleqcon + size(c,1) ) .* ...
                   ( numerics.math.approxEq(ceq(inonleqcon,1), 0, 0.05) );
          end

        end

        [X,Y]= meshgrid( LB(1):( UB(1) - LB(1) ) / 200:UB(1), ...
                     0.95:0.05:1.05);

        surf(X, Y, repmat(Cnonlcon',3,1), 'LineStyle', 'none', ...
                             'FaceAlpha', 0.4), view(0,90), hold on

        clear Cnonlcon X Y;

      end

    end

    %%


  case 2

    %%
    % linear equality constraints

    for irow= 1:size(Aeq,1)

      color= char(colordefs(mod(irow,8) + 1));

      plot2dLinConstraints(Aeq(irow,:), beq(irow,:), LB, UB, 10, color);

    end

    %%
    % linear inequality constraints

    for irow= 1:size(A,1)

      color= char(colordefs(mod(irow,8) + 1));

      [X, Y]= plot2dLinConstraints(A(irow,:), b(irow,:), LB, UB, ...
                                   10, [color, '--']);

      if ~isempty(X)
        quiver(X, Y, -A(irow,1), -A(irow,2), color);
      end

    end

    %%
    % nonlinear (in-)equality constraints

    if plotnonlcon

      [X,Y]= meshgrid( LB(1):( UB(1) - LB(1) ) / 200:UB(1), ...
                       LB(2):( UB(2) - LB(2) ) / 200:UB(2));

      if isa(nonlcon, 'function_handle')

        Cnonlcon= zeros(size(X));

        for iv= 1:size(X,1)
          for ih= 1:size(X,2)
            point= [X(iv,ih), Y(iv,ih)];

            % der Punkt muss evtl. noch in den richtigen Raum
            % transformiert werden, kann man evtl. auch vor der
            % schleife machen

            if obj.dim ~= size(point,2)
              x= getPointsInFullDimension(obj, point);%, obj.Aeq, obj.beq);
            else
              x= point;
            end

            [c, ceq]= feval( nonlcon, x );

            for inonlineqcon= 1:size(c,1)
              Cnonlcon(iv,ih)= Cnonlcon(iv,ih) + inonlineqcon .* ...
                   ( c(inonlineqcon,1) <= 0 );
            end

            for inonleqcon= 1:size(ceq,1)
              Cnonlcon(iv,ih)= Cnonlcon(iv,ih) + ...
                   ( inonleqcon + size(c,1) ) .* ...
                   ( numerics.math.approxEq(ceq(inonleqcon,1), 0, 0.05) );
            end
          end
        end

        surf(X, Y, Cnonlcon, 'LineStyle', 'none', ...
                             'FaceAlpha', 0.4), view(0,90), hold on

        clear Cnonlcon X Y;

      end

    end

    %%


  case 3

    %%
    % linear equality constraints

    for irow= 1:size(Aeq,1)

      color= char(colordefs(mod(irow,8) + 1));

      plot3dLinConstraints(Aeq(irow,:), beq(irow,:), LB, UB, ...
                           0.75, 20, color);

    end

    %%
    % linear inequality constraints

    for irow= 1:size(A,1)

      color= char(colordefs(mod(irow,8) + 1));

      if irow <= size(A,1) - 2*dim
          [X,Y,Z]= plot3dLinConstraints(A(irow,:), b(irow,:), ...
                                        LB, UB, 0.75, 10, color);
      else
          [X,Y,Z]= plot3dLinConstraints(A(irow,:), b(irow,:), ...
                                        LB, UB, 0.15, 2, color);
      end

      if ~isempty(X)
        quiver3(X, Y, Z, -A(irow,1), -A(irow,2), -A(irow,3), color);
      end

    end

    %%
    % nonlinear (in-)equality constraints

    if plotnonlcon

      [X,Y,Z]= meshgrid( LB(1):( UB(1) - LB(1) ) / 200:UB(1), ...
                         LB(2):( UB(2) - LB(2) ) / 200:UB(2), ...
                         LB(3):( UB(3) - LB(3) ) / 10:UB(3));

      if isa(nonlcon, 'function_handle')

        Cnonlcon= zeros(size(X));

        for iv= 1:size(X,1)
          for ih= 1:size(X,2)
            for i3= 1:size(X,3)

              point= [X(iv,ih,i3), Y(iv,ih,i3), Z(iv,ih,i3)];

              % der Punkt muss evtl. noch in den richtigen Raum
              % transformiert werden, kann man evtl. auch vor der
              % schleife machen

              if obj.dim ~= size(point,2)
                x= getPointsInFullDimension(obj, point);%, obj.Aeq, obj.beq);
              else
                x= point;
              end

              [c, ceq]= feval( nonlcon, x );

              for inonlineqcon= 1:size(c,1)
                  Cnonlcon(iv,ih,i3)= ...
                      Cnonlcon(iv,ih,i3) + inonlineqcon .* ...
                       ( c(inonlineqcon,1) <= 0 );
              end

              for inonleqcon= 1:size(ceq,1)
                  Cnonlcon(iv,ih,i3)= Cnonlcon(iv,ih,i3) + ...
                       ( inonleqcon + size(c,1) ) .* ...
                       ( numerics.math.approxEq(ceq(inonleqcon,1), 0, 0.1) );
              end

            end
          end
        end

        BW= zeros(size(Cnonlcon));

        for iz= 1:1:size(BW,3)
          BW(:,:,iz)= edge(Cnonlcon(:,:,iz), 'sobel', 0);
        end

        for ix= 1:size(BW,1)
            for iy= 1:size(BW,2)
                for iz= 1:size(BW,3)
                    if BW(ix,iy,iz) == 1
                        plot3(X(ix,iy,iz), Y(ix,iy,iz), Z(ix,iy,iz), ...
                              ['+', char(colordefs(mod(...
                              Cnonlcon(ix,iy,iz),8) + 1))], ...
                              'MarkerSize', 2);

                        %hold on
                    end
                end
            end
        end

        clear Cnonlcon X Y Z BW;

      end      

    end

    %%


  case 4

    %%
    % linear equality constraints

    for irow= 1:size(Aeq,1)

      color= char(colordefs(mod(irow,8) + 1));

      plot4dLinConstraints(Aeq(irow,:), beq(irow,:), ...
                           LB, UB, 0.75, 20, color, iframe, noFrames);

    end

    %%
    % linear inequality constraints

    for irow= 1:size(A,1)

      % die letzten 2 sind die LB und UB für die 4. Dimension t
      if all(A(irow,1:3) == 0)
          continue;
      end

      color= char(colordefs(mod(irow,8) + 1));

      if irow <= size(A,1) - 2*dim
          [X,Y,Z]= plot4dLinConstraints(A(irow,:), b(irow,:), ...
                          LB, UB, 0.75, 10, color, iframe, noFrames);
      else
          [X,Y,Z]= plot4dLinConstraints(A(irow,:), b(irow,:), ...
                          LB, UB, 0.15, 2, color, iframe, noFrames);
      end

      if ~isempty(X)
          quiver3(X, Y, Z, -A(irow,1), -A(irow,2), -A(irow,3), color);
      end

      clear X Y Z;

    end

    %%
    % nonlinear (in-)equality constraints

    if plotnonlcon

      [X,Y,Z,t]= ndgrid( LB(1):( UB(1) - LB(1) ) / 200:UB(1), ...
                         LB(2):( UB(2) - LB(2) ) / 200:UB(2), ...
                         LB(3):( UB(3) - LB(3) ) / 10:UB(3) , ...
                         LB(4):( UB(4) - LB(4) ) / noFrames:UB(4));

      X= X(:,:,:,iframe);
      Y= Y(:,:,:,iframe);
      Z= Z(:,:,:,iframe);  
      t= t(:,:,:,iframe);  

      if isa(nonlcon, 'function_handle')

        Cnonlcon= zeros(size(X));

        for iv= 1:size(X,1)
          for ih= 1:size(X,2)
            for i3= 1:size(X,3)

              point= [X(iv,ih,i3), Y(iv,ih,i3), ...
                      Z(iv,ih,i3), t(iv,ih,i3)];

              % der Punkt muss evtl. noch in den richtigen Raum
              % transformiert werden, kann man evtl. auch vor der
              % schleife machen

              if obj.dim ~= size(point,2)
                  x= getPointsInFullDimension(obj, point);%, obj.Aeq, obj.beq);
              else
                  x= point;
              end

              [c, ceq]= feval( nonlcon, x );

              for inonlineqcon= 1:size(c,1)
                  Cnonlcon(iv,ih,i3)= ...
                      Cnonlcon(iv,ih,i3) + inonlineqcon .* ...
                       ( c(inonlineqcon,1) <= 0 );
              end

              for inonleqcon= 1:size(ceq,1)
                  Cnonlcon(iv,ih,i3)= Cnonlcon(iv,ih,i3) + ...
                       ( inonleqcon + size(c,1) ) .* ...
                       ( numerics.math.approxEq(ceq(inonleqcon,1), 0, 0.1) );
              end

            end
          end
        end

        BW= zeros(size(Cnonlcon));

        for iz= 1:1:size(BW,3)
          BW(:,:,iz)= edge(Cnonlcon(:,:,iz), 'sobel', 0);
        end

        for ix= 1:size(BW,1)
          for iy= 1:size(BW,2)
            for iz= 1:size(BW,3)
              if BW(ix,iy,iz) == 1
                  plot3(X(ix,iy,iz), Y(ix,iy,iz), Z(ix,iy,iz), ...
                        ['+', char(colordefs(mod(...
                        Cnonlcon(ix,iy,iz),8) + 1))], ...
                        'MarkerSize', 2);
              end
            end
          end
        end

        clear Cnonlcon X Y Z t BW;

      end      

    end


end

%%


