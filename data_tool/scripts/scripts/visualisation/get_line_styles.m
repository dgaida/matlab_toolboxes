%% get_line_styles
% Return line style specifications used to plot different graphs in one plot
%
function linestyles= get_line_styles(num_lines, varargin)
%% Release: 0.9

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

isZ(num_lines, 'num_lines', 1, 1);

%%

if nargin >= 2 && ~isempty(varargin{1})
  mode= varargin{1};
  isZ(mode, 'mode', 2, 1, 2);
else
  mode= 1;
end

%%

if mode == 1
  linestyles= {'-', '--', ':', '-.'};
  resam= ceil(num_lines / numel(linestyles));
  
  if resam > 0
    linestyles= repmat(linestyles, 1, resam);
  end
  
  linestyles= linestyles(1:num_lines);
else
  linestyles= ['-', '--', ':', '-.']';
  resam= ceil(num_lines / numel(linestyles));
  
  if resam > 0
    linestyles= repmat(linestyles, resam, 1);
  end
  
  linestyles= linestyles(1:num_lines);
end

%%


