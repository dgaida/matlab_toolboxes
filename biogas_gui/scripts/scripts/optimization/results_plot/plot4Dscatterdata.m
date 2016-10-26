%% plot4Dscatterdata
%
%
function [X, Y, Z, Fitness, varargout]= ...
         plot4Dscatterdata(x, y, z, fitness, varargin)
%% Release: 1.2

%%

error( nargchk(4, 10, nargin, 'struct') );
error( nargoutchk(0, 5, nargout, 'struct') );

%%

if nargin >= 5 && ~isempty(varargin{1})
  plotSurface= varargin{1};
  
  validateattributes(plotSurface, {'double'}, ...
                   {'scalar', 'nonnegative', 'integer', '<=', 1}, ...
                   mfilename, 'plotSurface', 5);
else
  plotSurface= 1;
end

if nargin >= 6 && ~isempty(varargin{2})
  useKriging= varargin{2};
  
  validateattributes(useKriging, {'double'}, ...
                   {'scalar', 'nonnegative', 'integer', '<=', 1}, ...
                   mfilename, 'useKriging', 6);
else
  useKriging= 0;
end

if nargin >= 7 && ~isempty(varargin{3})
  plotArrow= varargin{3};
  
  validateattributes(plotArrow, {'double'}, ...
                   {'scalar', 'nonnegative', 'integer', '<=', 1}, ...
                   mfilename, 'plotArrow', 7);
else
  plotArrow= 1;
end

if nargin >= 8 && ~isempty(varargin{4})
  simtime= varargin{4};
else
  plotArrow= 0;
  simtime= [];
end

if nargin >= 9 && ~isempty(varargin{5})
  chkFastSlow= varargin{5};
else
  chkFastSlow= 'off';
end

if nargin >= 10 && ~isempty(varargin{6})
  Npoints= varargin{6};
else
  Npoints= numel(x);
end

%%

if useKriging
  [X, Y, Z, Fitness, ~, model]= griddata_vectors(x, y, z, fitness, ...
                                [], [], [], [], useKriging);
else
  [X, Y, Z, Fitness]=           griddata_vectors(x, y, z, fitness, ...
                                [], [], [], [], useKriging);
end
    
%%

if plotSurface
  plot3dsurface_alpha(X, Y, Z, Fitness);                
end

%%

if (plotArrow)

  %%

  M= [simtime, x, y, z];
  M= M(1:Npoints,:);

  % get values with : simtime < 10 or > 100
  criteria= max( M(:,1) < 10, M(:,1) > 350 );

  x_c= M(criteria, 2);
  y_c= M(criteria, 3);
  z_c= M(criteria, 4);

  %%

  if exist('model', 'var')
    arrow3d_connect_dots(x_c, y_c, z_c, model);
  else
    arrow3d_connect_dots(x_c, y_c, z_c, x, y, z, fitness);
  end

  %%

end

%%
%

hold on;

scatter3MarkerEdgeColor(x(1:Npoints), y(1:Npoints), z(1:Npoints), ...
                        fitness(1:Npoints), ...
                        chkFastSlow);

%%

set(gca, 'CLim', [min(fitness), max(fitness)]);

hold off

%%

if(plotArrow == 0)
  daspect([1 1 1])
  
  varargout{1}= [];
else
  varargout{1}= criteria;
end

%%
%daspect([1/(max(x) - min(x)) 1/(max(y) - min(y)) 1/(max(z) - min(z))])
%daspect(daspect)
view(3); axis tight
%daspect(daspect)
%camlight 
%lighting gouraud
%lighting phong
%material default

%%


