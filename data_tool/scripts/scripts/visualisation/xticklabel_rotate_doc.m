%% Syntax
%hText = xticklabel_rotate(XTick,rot,XTickLabel,varargin)     Rotate XTickLabel
%
%% Description
% Syntax: xticklabel_rotate
%
% Input:    
% {opt}     XTick       - vector array of XTick positions & values (numeric) 
%                           uses current XTick values or XTickLabel cell array by
%                           default (if empty) 
% {opt}     rot         - angle of rotation in degrees, 90° by default
% {opt}     XTickLabel  - cell array of label strings
% {opt}     [var]       - "Property-value" pairs passed to text generator
%                           ex: 'interpreter','none'
%                               'Color','m','Fontweight','bold'
%
% Output:   hText       - handle vector to text labels
%
%% Example
% Example 1:  Rotate existing XTickLabels at their current position by 90°
    
figure; xticklabel_rotate

%%
% Example 2:  Rotate existing XTickLabels at their current position by 45° and change
% font size

figure; xticklabel_rotate([],45,[],'Fontsize',14)

%%
% Example 3:  Set the positions of the XTicks and rotate them 90°
  
figure;  plot(1960:2004,randn(45,1)); xlim([1960 2004]);
xticklabel_rotate(1960:2:2004);

%%

close all;

%%
% Example 4:  Use text labels at XTick positions rotated 45° without tex interpreter
% xticklabel_rotate(XTick,45,NameFields,'interpreter','none');

%%
% Example 5:  Use text labels rotated 90° at current positions
% xticklabel_rotate([],90,NameFields);

%%
% Note : you can not RE-RUN xticklabel_rotate on the same graph. 
%


%%
% This is a modified version of xticklabel_rotate90 by Denis Gilbert
% Modifications include Text labels (in the form of cell array)
%                       Arbitrary angle rotation
%                       Output of text handles
%                       Resizing of axes and title/xlabel/ylabel positions to maintain same overall size 
%                           and keep text on plot
%                           (handles small window resizing after, but not well due to proportional placement with 
%                           fixed font size. To fix this would require a serious resize function)
%                       Uses current XTick by default
%                       Uses current XTickLabel is different from XTick values (meaning has been already defined)
%
%%
% Brian FG Katz
% bfgkatz@hotmail.com
% 23-05-03
% Modified 03-11-06 after user comment
%	Allow for exisiting XTickLabel cell array
% Modified 03-03-2006 
%   Allow for labels top located (after user comment)
%   Allow case for single XTickLabelName (after user comment)
%   Reduced the degree of resizing
% Modified 11-jun-2010
%   Response to numerous suggestions on MatlabCentral to improve certain
%   errors.
%
%%
% Other m-files required: cell2mat
% Subfunctions: none
% MAT-files required: none
%
%%
% See also: xticklabel_rotate90, TEXT,  SET
%
%%
% Based on xticklabel_rotate90
%   Author: Denis Gilbert, Ph.D., physical oceanography
%   Maurice Lamontagne Institute, Dept. of Fisheries and Oceans Canada
%   email: gilbertd@dfo-mpo.gc.ca  Web: http://www.qc.dfo-mpo.gc.ca/iml/
%   February 1998; Last revision: 24-Mar-2003
%
%% TODOs
% # make documentation
% # understand code
% 


