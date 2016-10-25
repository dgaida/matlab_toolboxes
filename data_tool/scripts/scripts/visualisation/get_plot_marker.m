%% get_plot_marker
% Return marker specifications used to plot different graphs in one plot
%
function marker= get_plot_marker(num_marker, varargin)
%% Release: 0.9

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

isZ(num_marker, 'num_marker', 1, 1);

%%

if nargin >= 2 && ~isempty(varargin{1})
  mode= varargin{1};
  isZ(mode, 'mode', 2, 1, 2);
else
  mode= 1;
end

%%

if mode == 1
  marker= {'o', 's', 'd', '.', '*', '+', 'x', '^', 'v'};
  resam= ceil(num_marker / numel(marker));
  
  if resam > 0
    marker= repmat(marker, 1, resam);
  end
  
  marker= marker(1:num_marker);
else
  marker= ['o', 's', 'd', '.', '*', '+', 'x', '^', 'v']';
  resam= ceil(num_marker / numel(marker));
  
  if resam > 0
    marker= repmat(marker, resam, 1);
  end
  
  marker= marker(1:num_marker);
end

%%


