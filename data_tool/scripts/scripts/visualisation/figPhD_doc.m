%% Syntax
%       myfig= figPhD()
%       figPhD(dosubplot)
%       figPhD(dosubplot, fak)
%       figPhD(dosubplot, fak, width)
%       figPhD(dosubplot, fak, width, height)
%
%% Description
% |myfig= figPhD()| creates a figure for my PhD. 
%
%%
% @param |dosubplot| : 0 or 1
%
%%
% @param |fak| : real scalar
%
%%
% @param |width| : integer
%
%%
% @param |height| : integer
%
%%
% @return |myfig| : figure object
%
%% Example
%
% 

figPhD();

plot(0:0.1:2*pi, sin(0:0.1:2*pi))

%%
% if you want to do a subplot set first argument to 1

figPhD(1, 1)

for iplot= 1:4
  subplot(3,2,iplot)
  plot(0:0.1:2*pi, sin(0:0.1:2*pi))
  xlabel('time')
  ylabel('sin')
  title('title')
end

subplot(3,2,5:6)
plot(0:0.1:2*pi, sin(0:0.1:2*pi))
xlabel('time')
ylabel('sin')
title('title')

%%
% result is not that good 

figPhD(0, 1)

for iplot= 1:4
  subplot(3,2,iplot)
  plot(0:0.1:2*pi, sin(0:0.1:2*pi))
  xlabel('time')
  ylabel('sin')
  title('title')
end

subplot(3,2,5:6)
plot(0:0.1:2*pi, sin(0:0.1:2*pi))
xlabel('time')
ylabel('sin')
title('title')

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/isn">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/is0or1">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/figure">
% matlab/figure</a>
% </html>
% ,
% <html>
% <a href="matlab:doc data_tool/fig">
% data_tool/fig</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc plot">
% matlab/plot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc subplot">
% matlab/subplot</a>
% </html>
%
%% TODOs
% # create documentation for script file
% # improve documentation
% # check documentation
% # improve examples, until now there is no difference between fig and
% figure, in subplot
%
%% <<AuthorTag_DG/>>


