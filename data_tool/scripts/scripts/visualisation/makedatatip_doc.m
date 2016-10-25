%% Syntax
%MAKEDATATIP  Adds data tips to specified data points of graphical objects.
%
%  MAKEDATATIP(HOBJ,INDEX) adds a datatip to the graphical object HOBJ at
%  the data point defined by INDEX.
%
%  HOUT = MAKEDATATIP(...) returns handles to the created datatips.
%
%% Description
%  If HOBJ is 1-dimensional, INDEX can be of any size and is assumed to be
%  a linear index into the data contained by HOBJ.  HOUT will be of the
%  same size as INDEX.
%
%  If HOBJ is 2-dimensional and INDEX is N-by-2, INDEX is assumed to be a
%  set of N subscripts, and HOUT will be N-by-1.  If INDEX is of any other
%  size, it is assumed to a linear index and HOUT will be the same size as
%  INDEX.  Note that if you wish to specify 2 linear indices, ensure INDEX
%  is a column vector, else it will be assumed to be a single set of
%  subscripts.
%
%% Example
% # Example: 

x = 1:10;
y = rand(1,10);
hPlot = plot(x,y);
makedatatip(hPlot,[3 8])

%%
% # Example:

[X,Y,Z] = peaks(30);
hObj = surf(X,Y,Z);
makedatatip(hObj,[5 8; 20 12; 22 28])

%%
% # Example: Add a single data tip to data point (5,25)

[X,Y,Z] = peaks(30);
hObj = surf(X,Y,Z);
makedatatip(hObj,[5 25])

%%
% # Example: Add two data tips to data points (5) and (25)

[X,Y,Z] = peaks(30);
hObj = surf(X,Y,Z);
makedatatip(hObj,[5; 25])

%%
% Author: Tim Farajian
% Release: 1.0
% Release date: 5/10/2008
%
%% TODOs
% # make documentation
% # understand script
%


