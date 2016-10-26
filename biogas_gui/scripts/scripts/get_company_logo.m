%% get_coany_logo
% Returns logo of globally selected company
%
function logo= get_company_logo(varargin)
%% Release: 0.4

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

global COMPANY;

%%

switch(COMPANY)
  
  case 'BWE'
    
    %
    logo= imread('bwelogo.jpg');
    
  case 'PlanET'
    
    [data, map]= imread('planetlogo.gif');
    logo= ind2rgb(data, map);

    clear map;
    
    color= [];  % never change background color here!

  otherwise
    
    error('Unknown company: %s!', COMPANY);
  
end

%%

if ~isempty(color)
        
  logo= changeColorInRGB(logo, color);

end

%%


