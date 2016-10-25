%% Syntax
%       plot3views(fcn_handle)
%       
%% Description
% |plot3views(fcn_handle)| makes a 3views plot, calling the function
% |fcn_handle|. 
%
%%
% @param |fcn_handle| : must contain a method which plots stuff. 
%
%% Example
%
%

data= load_file('data_to_plot.mat');

inputs= [double(data(:, 2:3)), double(data(:,8))];

outputs= double(data(:, end));

xlabel('x_1')  
ylabel('x_2')  
zlabel('x_3')  

%%
% x3= -x2 + 30
% x3 + x2 = 30
% x2 + x3 = 30
% A= [0 1 1]
% b= 30

plot3views( @()testplot(inputs, outputs) );

rotate3d on

%% Dependencies
%
% This method calls:
%
% <html>
% <a href=matlab:doc('subplot')>
% matlab/surf</a>
% </html>
% ,
% <html>
% <a href=matlab:doc('view')>
% matlab/meshgrid</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="matlab:doc('numerics_tool/validatesetforconstraints')">
% numerics_tool/numerics.conSetOfPoints.validateSetForConstraints</a>
% </html>
% ,
% <html>
% <a href="plot1dlinconstraints.html">
% plot1dLinConstraints</a>
% </html>
% ,
% <html>
% <a href="plot2dlinconstraints.html">
% plot2dLinConstraints</a>
% </html>
% ,
% <html>
% <a href="plot3dlinconstraints.html">
% plot3dLinConstraints</a>
% </html>
% ,
% <html>
% <a href="plot4dlinconstraints.html">
% plot4dLinConstraints</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


