%% arrow3d_connect_dots
% Draws a 3d arrow connecting points (x_c, y_c, z_c)
%
function arrow3d_connect_dots(x_c, y_c, z_c, varargin)
%% Release: 1.8

%%

error( nargchk(3, 8, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check params

checkArgument(x_c, 'x_c', 'double', '1st');
checkArgument(y_c, 'y_c', 'double', '2nd');
checkArgument(z_c, 'z_c', 'double', '3rd');

%% 
% check whether x_c, y_c and z_c have the same dimension

size_matrix= [numel(x_c), numel(y_c), numel(z_c)];

if max(size_matrix) ~= min(size_matrix)
  error('The arguments x_c, y_c and z_c must be of same dimension!');
end

%%

if nargin == 3
  
  model= [];
  
elseif isstruct(varargin{1})

  %%
  
  error( nargchk(4, 4, nargin, 'struct') );

  model= varargin{1};

  %%
  
else
  
  %%
  
  error( nargchk(7, 8, nargin, 'struct') );

  xm= varargin{1};
  ym= varargin{2};
  zm= varargin{3};
  fm= varargin{4};
  
  if nargin >= 8 && ~isempty(varargin{5})
    interp_method= varargin{5};
  else
    interp_method= 'linear';
  end
  
  %%
  % check params
  
  checkArgument(xm, 'xm', 'double', '4th');
  checkArgument(ym, 'ym', 'double', '5th');
  checkArgument(zm, 'zm', 'double', '6th');
  checkArgument(fm, 'fm', 'double', '7th');
  checkArgument(interp_method, 'interp_method', 'char', '8th');  

  %% 
  % check whether xm, ym, zm and fm have the same dimension

  size_matrix= [numel(xm), numel(ym), numel(zm), numel(fm)];

  if max(size_matrix) ~= min(size_matrix)
    error('The arguments xm, ym, zm and fm must be of same dimension!');
  end
  
  %%
    
end

%%

step_w= 1;

% here the last arrow line is drawn
end_1= min(numel(x_c) - 0, 4)/step_w;
% start of the tip of the arrow
end_2= min(numel(x_c) - 1, 3)/step_w;
% end of the tip
end_3= 0/step_w;

%%
% draw the lines of the piecewise arrow

for iline= 1:step_w:numel(x_c) - end_1*step_w     

  %%
  % just get X1, Y1 and Z1 - do not draw the arrow yet

  [h, X1, Y1, Z1]= arrow3d(...
      [x_c(iline, 1) x_c(iline + step_w, 1)], ...
      [y_c(iline, 1) y_c(iline + step_w, 1)], ...
      [z_c(iline, 1) z_c(iline + step_w, 1)], ...
      1.0, 0.075 + 0.025, 0.15 + 2*0.025, ...
      [], 0);

  %% 
  %

  if exist('model', 'var')
    if ~isempty(model)
      fit_arr= predict_data(X1, Y1, Z1, model);
    else
      fit_arr= Z1;
    end
  else
    fit_arr= predict_data(X1, Y1, Z1, xm, ym, zm, fm, interp_method);
  end

  %%
  % draw the arrow

  arrow3d([x_c(iline, 1) x_c(iline + step_w, 1)], ...
          [y_c(iline, 1) y_c(iline + step_w, 1)], ...
          [z_c(iline, 1) z_c(iline + step_w, 1)], ...
          1.0, 0.075 + 0.025, 0.15 + 2*0.025, ...
          fit_arr, 1);     

  %%
  
  if iline == 1
    hold on;
  end

  %%

end

%%
% draw the tip of the arrow

%%
% just get X1, Y1 and Z1 - do not draw the arrow yet

[h, X1, Y1, Z1]= arrow3d(...
          [x_c(numel(x_c) - end_2*step_w, 1) ...
           x_c(numel(x_c) - end_3*step_w, 1)], ...
          [y_c(numel(x_c) - end_2*step_w, 1) ...
           y_c(numel(x_c) - end_3*step_w, 1)], ...
          [z_c(numel(x_c) - end_2*step_w, 1) ...
           z_c(numel(x_c) - end_3*step_w, 1)], ...
          0.0, 0.125 + 0.025, 0.175 + 3*0.025, ...
          [], 0);

%%
%

if exist('model', 'var')
  if ~isempty(model)
    fit_arr= predict_data(X1, Y1, Z1, model);
  else
    fit_arr= Z1;
  end
else
  fit_arr= predict_data(X1, Y1, Z1, xm, ym, zm, fm, interp_method);
end

%%
% draw the arrow

arrow3d([x_c(numel(x_c) - end_2*step_w, 1) ...
         x_c(numel(x_c) - end_3*step_w, 1)], ...
        [y_c(numel(x_c) - end_2*step_w, 1) ...
         y_c(numel(x_c) - end_3*step_w, 1)], ...
        [z_c(numel(x_c) - end_2*step_w, 1) ...
         z_c(numel(x_c) - end_3*step_w, 1)], ...
        0.0, 0.125 + 0.025, 0.175 + 3*0.025, ...
        fit_arr, 1); 

%%

hold off;

%%


