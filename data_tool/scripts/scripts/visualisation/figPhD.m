%% figPhD
% Creates figure for my PhD. If a subplot shall be plotted a figure is
% created, else a fig. 
%
function myfig= figPhD(varargin)
%% Release: 1.0

%%

error( nargchk(0, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% read out varargin

if nargin >= 1 && ~isempty(varargin{1})
  dosubplot= varargin{1};
  is0or1(dosubplot, 'dosubplot', 1);
else
  dosubplot= 0;
end

if nargin >= 2 && ~isempty(varargin{2})
  fak= varargin{2};
  isR(fak, 'fak', 2);
else
  fak= 2;
end

if nargin >= 3 && ~isempty(varargin{3})
  width= varargin{3};
  isN(width, 'width', 3);
else
  width= 560;
end

if nargin >= 4 && ~isempty(varargin{4})
  height= varargin{4};
  isN(height, 'height', 4);
else
  height= 420;
end

%%

if dosubplot
  myfig= figure('Position', [45 100 width*fak height*fak], ...
                'Color','w', ...'PaperSize',[20.98404194812 29.67743169791], 
                'InvertHardcopy', 'on');

  set(myfig, 'DefaultTextFontSize', 11); 
  set(myfig, 'DefaultAxesFontSize', 11); 
  set(myfig, 'DefaultAxesFontName', 'times new roman');
  set(myfig, 'DefaultTextFontName', 'times new roman');
else
  myfig= fig;
end

%%



%%


