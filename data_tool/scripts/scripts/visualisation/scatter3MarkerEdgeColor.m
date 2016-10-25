%% scatter3MarkerEdgeColor
% Plot 3d data using <matlab:doc('scatter3') scatter3> with focus on the
% MarkerEdgeColor
%
function scatter3MarkerEdgeColor(x, y, z, varargin)
%% Release: 1.4

%%

error( nargchk(3, 5, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

x= double(x);
y= double(y);
z= double(z);

if ~isa(x, 'double') || numel(x) ~= max(size(x))
  error('The 1st argument x must be a double vector, but is a %idim %s!', ...
        max(size(x)), class(x));
end

if ~isa(y, 'double') || numel(y) ~= max(size(y))
  error('The 2nd argument x must be a double vector, but is a %idim %s!', ...
        max(size(y)), class(y));
end

if ~isa(z, 'double') || numel(z) ~= max(size(z))
  error('The 3rd argument z must be a double vector, but is a %idim %s!', ...
        max(size(z)), class(z));
end

%%

if nargin >= 4 && ~isempty(varargin{1})
  c= varargin{1};
else
  c= z;
end

if nargin >= 5 && ~isempty(varargin{2})
  edgeColor= varargin{2};
else
  edgeColor= 'k';
end

%%

c= double(c);

if ~isa(c, 'double') || numel(c) ~= max(size(c))
  error('The 4th argument c must be a double vector, but is a %idim %s!', ...
        max(size(c)), class(c));
end

%%

size_matrix= [numel(x), numel(y), numel(z), numel(c)];

if max(size_matrix) ~= min(size_matrix)
  error('The arguments x, y, z and c must be of same dimension!');
end

%% 
% check edgeColor

validatestring(edgeColor, ...
               {'on', 'off', 'c', 'r', 'b', 'w', 'g', 'm', 'y', 'k'}, ...
               mfilename, 'edgeColor', 5);


%%

if strcmp(edgeColor, 'on')

  %%

  data_fit= double(c);

  %% TODO
  % gibt es dafür nicht eine funktion?
  % normalize data between 0 and 1
  
  data_fit= data_fit - max(data_fit);

  normed_fit= abs( data_fit / ...
                   max( abs( data_fit ) ) );

  %%
    
  for ipoint= 1:numel(x)      

    %%
    
    scatter3(x(ipoint), y(ipoint), z(ipoint), [], ...
             c(ipoint), 's', 'filled', ...
             'LineWidth', 0.01, ...
             'MarkerEdgeColor', [normed_fit(ipoint) ...
              normed_fit(ipoint) normed_fit(ipoint)]);

    %%
  
    if (ipoint == 1)
      hold on;
    end
    
    %%
    
  end

  %%
  
  hold off;
  
  %%
  
else

  %%

  if strcmp(edgeColor, 'off')
    
    scatter3(x, y, z, [], c, 's', 'filled');
    
  else

    %%

    scatter3(x, y, z, [], c, 's', 'filled', ...
             'LineWidth', 0.01, ...
             'MarkerEdgeColor', edgeColor);

  end
  
  %%       
         
end

%%


