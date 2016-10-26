%% numerics.conSetOfPoints.validateSetForConstraints
% Evaluate the constrained population |p| with respect to the boundaries.
%
function [x, success]= validateSetForConstraints(obj, varargin)
%% Release: 1.6

%%

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

if nargin >= 2 && ~isempty(varargin{1})
  dispValidBounds= varargin{1};
  
  is0or1(dispValidBounds, 'dispValidBounds', 2);
else
  dispValidBounds= 0;
end

if nargin >= 3 && ~isempty(varargin{2}),
  plotnonlcon= varargin{2}; 
  
  is0or1(plotnonlcon, 'plotnonlcon', 3);
else
  plotnonlcon= 0; 
end

%%
% @param |p| : set of points in the constrained dimension. The columnnumber
% defines the dimension of the constrained space and the number of rows the
% number of points in the set.
%
p= obj.conData;
AV= obj.conA;
av= obj.conb;
LBc= obj.conLB;
UBc= obj.conUB;
nonlcon= obj.nonlcon;


%%

%success= 0;

%%

conDim= size(p, 2);

dim= obj.dim;
%nRows= size(p, 1);

%%

A= obj.A;
b= obj.b;

% put the upper and lower bounds into the form Ax <= b
%
A= [ A;...
    -eye(numel(obj.LB));
     eye(numel(obj.UB))];

b= [b;...
    -obj.LB(:);...
    obj.UB(:)];

Aeq= obj.Aeq;
beq= obj.beq;

LB= obj.LB;
UB= obj.UB;

%%

AV= [ AV;...
    -eye(numel(LBc));
     eye(numel(UBc))];

av= [av;...
    -LBc(:);...
    UBc(:)];

%%

if ( dim == 1 || ( dim >= 5 && ( conDim == 1 ) ) )
    
  %%
  % plot a 1dim space
  
  figure

  if dim == 1 % full dimension
      x= plotPointsWithConstraints(obj, p, dim, A, b, Aeq, beq, ...
                                    LB, UB, nonlcon, A, b, plotnonlcon); 
  else % constrained dimension
      x= plotPointsWithConstraints(obj, p, conDim, AV, av, [], [], ...
                                    LBc, UBc, nonlcon, A, b, plotnonlcon);    
  end

  %scatterhist(p, ones(nRows,1), [10,1]);

elseif ( dim == 2 || ( dim >= 5 && ( conDim == 2 ) ) )

  %%

  if dim == 2
      start= 1;   % plot full
  else
      start= 2;   % only plot constrained
  end

  if dim == conDim    % if both are the same, only plot first
      ende= 1;
  else
      ende= 2;        % if not plot both
  end

  for i= start:ende    

    figure

    %%

    if i == 1 % full
        x= plotPointsWithConstraints(obj, p, dim, A, b, Aeq, beq, ...
                                  LB, UB, nonlcon, A, b, plotnonlcon); 
    else      % constrained
        x= plotPointsWithConstraints(obj, p, conDim, AV, av, Aeq, beq, ...
                                  LBc, UBc, nonlcon, A, b, plotnonlcon);            
    end

  end


elseif ( dim == 3 || ( dim >= 5 && ( conDim == 3 ) ) )

  %%

  if dim == 3
      start= 1;
  else
      start= 2;
  end

  if dim == conDim
      ende= 1;
  else
      ende= 2;
  end

  for i= start:ende  

    %%

    if conDim <= 2 && i == 2

      figure;

      x= plotPointsWithConstraints(obj, p, conDim, AV, av, Aeq, beq, ...
                                LBc, UBc, nonlcon, A, b, plotnonlcon);  

    else

      figure('Position', [45 100 560*2 420*2]);

      for iplot= 1:4    % 4 views, front, left, top, 3d

        subplot(2, 2, iplot)

        %%

        if i == 1
            x= plotPointsWithConstraints(obj, p, dim, A, b, Aeq, beq, ...
                                      LB, UB, nonlcon, A, b, plotnonlcon); 
        else
            x= plotPointsWithConstraints(obj, p, conDim, AV, av, Aeq, beq, ...
                                      LBc, UBc, nonlcon, A, b, plotnonlcon);            
        end

        %%

        switch iplot
            case 1
                view([0.0 0.0]);
            case 2
                view([-90.0 0.0]);
            case 3
                view([0.0 90.0]);
            case 4
                view(3);
        end

      end

    end

  end

elseif ( dim == 4 || ( dim >= 5 && ( conDim == 4 ) ) )

  %%

  %close all;

  fak= 2;
  figure('Position', [45 100 560*fak 420*fak]);

  noFrames= 50;

  set(gcf, 'Renderer', 'zbuffer');

  for inumber= 1:100
    filename= sprintf('conSetOfPoints_%i.avi', inumber);

    if ~exist(filename, 'file')
      break;
    end
  end

  aviobject= avifile(filename, 'fps', 4); 

  z_grid= LB(4):( UB(4) - LB(4) ) / noFrames:UB(4);

  [Y,Z,t]= ndgrid( ...
                     LB(2):( UB(2) - LB(2) ) / 2:UB(2), ...
                     LB(3):( UB(3) - LB(3) ) / 2:UB(3), ...
                     z_grid );

  bframe= b;

  for iframe= 1:min(noFrames, size(t, 3))

    %plotConstraints(dim, AV, av, [], [], LBc, UBc, iframe);

    x= getPointsInFullDimension(obj, p);%, Aeq, beq);

    bframe(end,:)= z_grid(1,iframe);

    %%

    clf

    %%

    for iplot= 1:4

      subplot(2, 2, iplot)

      %%

      hold on;

      %%

      plotConstraints(obj, dim, A, b, Aeq, beq, LB, UB, ...
                      nonlcon, iframe, noFrames, plotnonlcon);

      plotValidPoints(x, A, bframe);

      %%

      switch iplot
        case 1
            view([0.0 0.0]);
        case 2
            view([-90.0 0.0]);
        case 3
            view([0.0 90.0]);
        case 4
            view(3);
      end

      %%

      axis equal

      %%

      setAxisLimits(dim, LB, UB);

      %%

      hold off;

    end

    %%

    frame= getframe(gcf);

    aviobject= addframe(aviobject, frame); 

  end

  aviobject= close(aviobject);
  clear aviobject;

else

  x= getPointsInFullDimension(obj, p);%, Aeq, beq);

end


%%

success= evalNDimSetForConstraints(x, A, b, Aeq, beq, ...
                                   LB, UB, nonlcon, dispValidBounds);

%%


