% FIG - Creates a figure with a desired size, no white-space, and several other options.
%
%       All Matlab figure options are accepted. 
%       FIG-specific options of the form FIG('PropertyName',propertyvalue,...) 
%       can be used to modify the default behavior, as follows:
%
%       -'units'    : preferred unit for the width and height of the figure 
%                      e.g. 'inches', 'centimeters', 'pixels', 'points', 'characters', 'normalized' 
%                      Default is 'centimeters'
%
%       -'width'    : width of the figure in units defined by 'units'
%                      Default is 14 centimeters
%                      Note: For IEEE journals, one column wide standard is
%                      8.5cm (3.5in), and two-column width standard is 17cm (7 1/16 in)
%
%       -'height'   : height of the figure in units defined by 'units'
%                      Specifying only one dimension sets the other dimension
%                      to preserve the figure's default aspect ratio. 
%
%       -'font'     : The font name for all the texts on the figure, including labels, title, legend, colorbar, etc.
%                      Default is 'Times New Roman' 
%
%       -'fontsize' : The font size for all the texts on the figure, including labels, title, legend, colorbar, etc.
%                      Default is 14pt
%       
%       -'border'   : Thin white border around the figure (compatible with export_fig -nocrop) 
%                      'on', 'off'
%                      Default is 'off' 
%
%   FIG(H) makes H the current figure. 
%   If figure H does not exist, and H is an integer, a new figure is created with
%   handle H.
%
%   FIG(H,...) applies the properties to the figure H.
%
%   H = FIG(...) returns the handle to the figure created by FIG.
%
%
% Example 1:
%   
fig

%
% Example 2:
%   

h=fig('units','inches','width',7,'height',2,'font','Helvetica','fontsize',16)

%
%
% Copyright  © 2012 Reza Shirvany,  matlab.sciences@neverbox.com 
% Source: 	 http://www.mathworks.com/matlabcentral/fileexchange/30736
% Updated:   05/14/2012
% Version:   1.6.5 
%


