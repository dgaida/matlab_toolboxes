%% get_plot_colors
% Return color specifications used to plot different graphs in one plot
%
function colors= get_plot_colors(num_colors, varargin)
%% Release: 1.3

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

isZ(num_colors, 'num_colors', 1, 1);

%%

if nargin >= 2 && ~isempty(varargin{1})
  mode= varargin{1};
  isZ(mode, 'mode', 2, 0, 2);
else
  mode= 1;
end

%%

if mode == 0
  colors= repmat(linspace(0, .8, num_colors)', 1, 3);
  %colors= rand(num_colors, 3);
elseif mode == 1
  colors= {'b', 'r', 'g', 'm', 'c', 'k', 'y'};
  resam= ceil(num_colors / numel(colors));
  
  if resam > 0
    colors= repmat(colors, 1, resam);
  end
  
  colors= colors(1:num_colors);
else
  colors= ['b', 'r', 'g', 'm', 'c', 'k', 'y']';
  resam= ceil(num_colors / numel(colors));
  
  if resam > 0
    colors= repmat(colors, resam, 1);
  end
  
  colors= colors(1:num_colors);
end

%%


