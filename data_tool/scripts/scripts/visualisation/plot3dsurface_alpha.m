%% plot3dsurface_alpha
% Plot transparent 3d surface
%
function plot3dsurface_alpha(X, Y, Z, Fitness, varargin)
%% Release: 1.8

%%
%

error( nargchk(4, 8, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 5 && ~isempty(varargin{1})
  plotBoundaryLines= varargin{1};
  
  is0or1(plotBoundaryLines, 'plotBoundaryLines', 5);
else
  plotBoundaryLines= 0;
end

if nargin >= 6 && ~isempty(varargin{2})
  alpha_val= varargin{2};
  
  validateattributes(alpha_val, {'double'}, ...
                     {'scalar', 'nonnegative', '<=', 1}, ...
                     mfilename, 'alpha_val', 6);
else
  alpha_val= 0.25;
end

if nargin >= 7 && ~isempty(varargin{3})
  % from 1 to end
  eval_at_1= varargin{3};

  checkArgument(eval_at_1, 'eval_at_1', 'char', '7th');
else
  eval_at_1= '1';%'1/4*end';%'1';%'1/4*end';
end

if nargin >= 8 && ~isempty(varargin{4})
  % from 1 to end
  eval_at_2= varargin{4};

  checkArgument(eval_at_2, 'eval_at_2', 'char', '8th');
else
    eval_at_2= 'end';%'3/4*end';%'end';%'3/4*end';
end

%%
% check params

if ~isa(X, 'double') || numel(size(X)) ~= 3
  error('The 1st argument X must be a 3dim double matrix, but is a %idim %s!', ...
        numel(size(X)), class(X));
end

if ~isa(Y, 'double') || numel(size(Y)) ~= 3
  error('The 2nd argument Y must be a 3dim double matrix, but is a %idim %s!', ...
        numel(size(Y)), class(Y));
end

if ~isa(Z, 'double') || numel(size(Z)) ~= 3
  error('The 3rd argument Z must be a 3dim double matrix, but is a %idim %s!', ...
        numel(size(Z)), class(Z));
end

if ~isa(Fitness, 'double') || numel(size(Fitness)) ~= 3
  error('The 4th argument Fitness must be a 3dim double matrix, but is a %idim %s!', ...
        numel(size(Fitness)), class(Fitness));
end


%%
%

newplot;

%%

hold on
            
surface(reshape( X(1,:,:), size(X,2), size(X,3) ), ...
        reshape( Y(1,:,:), size(Y,2), size(Y,3) ), ...
        reshape( Z(1,:,:), size(Z,2), size(Z,3) ), ...
        reshape( eval(['Fitness(round(', eval_at_1, '),:,:)']), ...
                 size(Fitness,2), size(Fitness,3) ) );

surface(reshape( X(:,1,:), size(X,1), size(X,3) ), ...
        reshape( Y(:,1,:), size(Y,1), size(Y,3) ), ...
        reshape( Z(:,1,:), size(Z,1), size(Z,3) ), ...
        reshape( eval(['Fitness(:,round(', eval_at_1, '),:)']), ...
                 size(Fitness,1), size(Fitness,3) ) );             

surface(reshape( X(:,end,:), size(X,1), size(X,3) ), ...
        reshape( Y(:,end,:), size(Y,1), size(Y,3) ), ...
        reshape( Z(:,end,:), size(Z,1), size(Z,3) ), ...
        reshape( eval(['Fitness(:,round(', eval_at_2, '),:)']), ...
                 size(Fitness,1), size(Fitness,3) ) );               

surface(reshape( X(end,:,:), size(X,2), size(X,3) ), ...
        reshape( Y(end,:,:), size(Y,2), size(Y,3) ), ...
        reshape( Z(end,:,:), size(Z,2), size(Z,3) ), ...
        reshape( eval(['Fitness(round(', eval_at_2, '),:,:)']), ...
                 size(Fitness,2), size(Fitness,3) ) );             

surface(reshape( X(:,:,1), size(X,1), size(X,2) ), ...
        reshape( Y(:,:,1), size(Y,1), size(Y,2) ), ...
        reshape( Z(:,:,1), size(Z,1), size(Z,2) ), ...
        reshape( eval(['Fitness(:,:,round(', eval_at_1, '))']), ...
                 size(Fitness,1), size(Fitness,2) ) );   

surface(reshape( X(:,:,end), size(X,1), size(X,2) ), ...
        reshape( Y(:,:,end), size(Y,1), size(Y,2) ), ...
        reshape( Z(:,:,end), size(Z,1), size(Z,2) ), ...
        reshape( eval(['Fitness(:,:,round(', eval_at_2, '))']), ...
                 size(Fitness,1), size(Fitness,2) ) );   

%%
%

%%
% Linien in x-Richtung

if (plotBoundaryLines)

  line( [X(1,1,1), X(1,end,1)], [Y(1,1,1), Y(1,1,1)], ...
                                [Z(1,1,1), Z(1,1,1)], ...
        'LineWidth', 0.5, 'Color', [0 0 0] );
  line( [X(1,1,1), X(1,end,1)], [Y(end,1,1), Y(end,1,1)], ...
                                [Z(1,1,1), Z(1,1,1)], ...
        'LineWidth', 0.5, 'Color', [0 0 0] ); 
  line( [X(1,1,1), X(1,end,1)], [Y(1,1,1), Y(1,1,1)], ...
                                [Z(1,1,end), Z(1,1,end)], ...
        'LineWidth', 0.5, 'Color', [0 0 0] );
  line( [X(1,1,1), X(1,end,1)], [Y(end,1,1), Y(end,1,1)], ...
                                [Z(1,1,end), Z(1,1,end)], ...
        'LineWidth', 0.5, 'Color', [0 0 0] );                           

  %%
  % Linien in y-Richtung

  line( [X(1,1,1), X(1,1,1)], [Y(1,1,1), Y(end,1,1)], ...
                                [Z(1,1,1), Z(1,1,1)], ...
        'LineWidth', 0.5, 'Color', [0 0 0] );
  line( [X(1,end,1), X(1,end,1)], [Y(1,1,1), Y(end,1,1)], ...
                                [Z(1,1,1), Z(1,1,1)], ...
        'LineWidth', 0.5, 'Color', [0 0 0] );
  line( [X(1,1,1), X(1,1,1)], [Y(1,1,1), Y(end,1,1)], ...
                                [Z(1,1,end), Z(1,1,end)], ...
        'LineWidth', 0.5, 'Color', [0 0 0] );
  line( [X(1,end,1), X(1,end,1)], [Y(1,1,1), Y(end,1,1)], ...
                                [Z(1,1,end), Z(1,1,end)], ...
        'LineWidth', 0.5, 'Color', [0 0 0] );  

  %%
  % Linien in z-Richtung

  line( [X(1,1,1), X(1,1,1)], [Y(1,1,1), Y(1,1,1)], ...
                                [Z(1,1,1), Z(1,1,end)], ...
        'LineWidth', 0.5, 'Color', [0 0 0] );
  line( [X(1,end,1), X(1,end,1)], [Y(1,1,1), Y(1,1,1)], ...
                                [Z(1,1,1), Z(1,1,end)], ...
        'LineWidth', 0.5, 'Color', [0 0 0] );
  line( [X(1,1,1), X(1,1,1)], [Y(end,1,1), Y(end,1,1)], ...
                                [Z(1,1,1), Z(1,1,end)], ...
        'LineWidth', 0.5, 'Color', [0 0 0] );
  line( [X(1,end,1), X(1,end,1)], [Y(end,1,1), Y(end,1,1)], ...
                                [Z(1,1,1), Z(1,1,end)], ...
        'LineWidth', 0.5, 'Color', [0 0 0] );

end

%%
%

shading interp%flat
alpha(alpha_val)

%%


