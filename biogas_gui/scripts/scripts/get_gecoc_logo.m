%% get_gecoc_logo
% Get GECO-C Logo from file
%
function logo= get_gecoc_logo(varargin)
%% Release: 0.9

%%

error( nargchk(0, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 1 && ~isempty(varargin{1})
  color= varargin{1};   % if color is given, then white background of logo 
  % is colored in color
  
  % check argument
  isRn(color, 'color', 1);
else
  color= [];
end

%%

data= imread('GECOC_final_small.png');

%%

if ~isempty(color)
        
  data= changeColorInRGB(data, color);

end

%%

logo= data;

%%


