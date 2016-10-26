%% griddata_vectors
% <matlab:doc('griddata') griddata> for vectors
%
function [X, Y, varargout]= griddata_vectors(x, y, z, f, varargin)
%% Release: 1.1

%%

error( nargchk(4, 9, nargin, 'struct') );
error( nargoutchk(0, 6, nargout, 'struct') );

%%

if nargin >= 5 && ~isempty(varargin{1})
  c= varargin{1};
else
  c= [];
end

if nargin >= 6 && ~isempty(varargin{2})
  samples= varargin{2};
  
  isN(samples, 'samples', 6);
else
  samples= 35;
end

if nargin >= 7 && ~isempty(varargin{3})
  min_step_size= varargin{3};
  
  isR(min_step_size, 'min_step_size', 7, '+');
else
  min_step_size= 0.2;
end

if nargin >= 8 && ~isempty(varargin{4})
  interp_method= varargin{4};
  
  checkArgument(interp_method, 'interp_method', 'char', '8th');
else
  interp_method= 'linear';
end

%%

if nargin >= 9 && ~isempty(varargin{5})
  useKriging= varargin{5};
  
  is0or1(useKriging, 'useKriging', 9);
else
  useKriging= 0;
end


%%

if ~isempty(z) && strcmp(interp_method, 'cubic')
  interp_method= 'linear';
  warning('griddata:NoValidInterpMethod', 'Set interp_method to linear!');
end


%%
% check params

if ~isa(x, 'double') || numel(x) ~= max(size(x))
  error('The 1st parameter x must be a double vector, but is a %s!', class(x));
end

if ~isa(y, 'double') || numel(y) ~= max(size(x))
  error('The 2nd parameter y must be a double vector, but is a %s!', class(y));
end

if ~isa(z, 'double') || (~isempty(z) && numel(z) ~= max(size(x)))
  error('The 3rd parameter z must be a double vector, but is a %s!', class(z));
end

if ~isa(f, 'double') || numel(f) ~= max(size(x))
  error('The 4th parameter f must be a double vector, but is a %s!', class(f));
end

if ~isa(c, 'double') || (~isempty(c) && numel(c) ~= max(size(x)))
  error('The 5th parameter c must be a double vector, but is a %s!', class(c));
end

%%
% make column vectors

x= x(:);
y= y(:);
z= z(:);
f= f(:);
c= c(:);

%%
% filter out non-numeric values

%% TODO 
% auch z und c müssen hier mit zugefügt werden, machen Probleme da sie leer
% sein können

is_ok= ~isnan(x) & ~isnan(y) & ~isnan(f);

x= x(is_ok);
y= y(is_ok);
z= z(~isnan(z));
f= f(is_ok);
c= c(~isnan(c));


%%

step_x= ( max(x) - min(x) ) / samples;
step_y= ( max(y) - min(y) ) / samples;
step_z= ( max(z) - min(z) ) / samples;


%%
% create grid

x_ti= min(x):min(min_step_size, step_x):max(x);
y_ti= min(y):min(min_step_size, step_y):max(y);
z_ti= min(z):min(min_step_size, step_z):max(z);
    
%%

[X, fc]= deleteDuplicates([x, y, z], [f, c]);

x= X(:,1);
y= X(:,2);

if size(X, 2) >= 3
  z= X(:,3);
end

f= fc(:,1);

if size(fc, 2) >= 2
  c= fc(:,2);
end

%%

if isempty(z_ti)
    
  %%
  % 2-dimensional domain
  
  if ~useKriging
    
    [X Y]= meshgrid(x_ti, y_ti);

    %F= griddata(x, y, f, X, Y, interp_method);
    Ff= TriScatteredInterp(x, y, f, interp_method);
    F= Ff(X, Y);

    %%
    
    Ff= TriScatteredInterp(x, y, f, 'nearest');
    F_N= Ff(X, Y);

    F(isnan(F))= F_N(isnan(F));
    
    %%

  else
    
    [X, Y, ~, F, model]= evaluate_kriging([x, y], f);
        
  end
  
  %%
  
  if ~isempty(c)
    %% TODO
    % warum nur 'cubic'?
    %C= griddata(x, y, c, X, Y, 'cubic');%interp_method);
    Ff= TriScatteredInterp(x, y, c, interp_method);
    C= Ff(X, Y);
  else
    C= [];
  end

else

  %%
  % 3-dimensional domain
  
  if ~useKriging

    %%
    
    [X Y Z]= meshgrid(x_ti, y_ti, z_ti);

    %F= griddata3(x, y, z, f, X, Y, Z, interp_method);
    Ff= TriScatteredInterp(x, y, z, f, interp_method);
    F= Ff(X, Y, Z);

    %%

    %F_N= griddata3(x, y, z, f, X, Y, Z, 'nearest');
    Ff= TriScatteredInterp(x, y, z, f, 'nearest');
    F_N= Ff(X, Y, Z);

    F(isnan(F))= F_N(isnan(F));

    %%
    
  else
  
    [X, Y, Z, F, model]= evaluate_kriging([x, y, z], f);
    
  end
  
  %%
  
  if ~isempty(c)
    %C= griddata3(x, y, z, c, X, Y, Z, interp_method);
    Ff= TriScatteredInterp(x, y, z, c, interp_method);
    C= Ff(X, Y, Z);
  else
    C= [];
  end

end


%%

if ~isempty(z_ti),
  varargout{1}= Z;
  varargout{2}= F;
  varargout{3}= C;
  
  if nargout >= 6 && exist('model', 'var'),
    varargout{4}= model;
  else
    varargout{4}= [];
  end
else
  varargout{1}= F;
  varargout{2}= C;
  
  if nargout >= 5 && exist('model', 'var'),
    varargout{3}= model;
  else
    varargout{3}= [];
  end
end


%%


