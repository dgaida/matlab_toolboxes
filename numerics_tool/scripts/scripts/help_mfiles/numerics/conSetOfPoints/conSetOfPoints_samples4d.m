%% 4-D Examples
% 
%

%% 
% No. 1
%
% $$\vec{x}_i := (x_1, x_2, x_3, x_4)^T \in R^4, i= 1, \dots, 100$$
%
% $$(0, 1, 0, 1)^T \leq \vec{x}_i \leq (5, 5, 3, 4)^T$$      
%
% $$(1, 1, 0, 0) \cdot \vec{x}_i \leq 5$$
%
% $$(-1, 0, 1, 1) \cdot \vec{x}_i = 1$$
%
numerics.conSetOfPoints(4, 100, [ 1, 1, 0, 0], 5, ...
                                   [-1, 0, 1, 1], 1, ...
                                   [0,1,0,1], [5,5,3,4], []);

%%

close all;
clear all;

%% 
% No. 2
%
% $$\vec{x}_i := (x_1, x_2, x_3, x_4)^T \in R^4, i= 1, \dots, 100$$
%
% $$(0, 1, 0, 1)^T \leq \vec{x}_i \leq (5, 5, 3, 4)^T$$      
%
% $$(1, 1, 0, 0) \cdot \vec{x}_i \leq 5$$
%
% $$(-1, 0, 1, 1) \cdot \vec{x}_i = 1$$
%
numerics.conSetOfPoints(4, 100, [ 1, 1, 0, 0; ...
                                      1, 0, 0, 1], [5; 4], ...
                                   [-1, 0, 1, 1], 1, ...
                                   [0,1,0,1], [5,5,3,4], []);

%%

close all;
clear all;
 
%%

plotnonlcon= 0; % 1 - takes very long

%% 
% No. 3
%
% $$\vec{x}_i := (x_1, x_2, x_3, x_4)^T \in R^4, i= 1, \dots, 100$$
%
% $$(0, 1, 0, 1)^T \leq \vec{x}_i \leq (5, 5, 3, 4)^T$$      
%
% $$(1, 1, 0, 0) \cdot \vec{x}_i \leq 5$$
%
% $$(-1, 0, 1, 1) \cdot \vec{x}_i = 1$$
%
numerics.conSetOfPoints(4, 100, [ 1, 1, 0, 0], 5, ...
                                   [-1, 0, 1, 1], 1, ...
                                   [0,1,0,1], [5,5,3,4], ...
                                   @(r)nonlconSphere(r, 1, [3,3,2,2], 1, 0), ...
                        {'CMAES'}, [], [], [], 0, plotnonlcon);

%%

close all;
clear all;
     
%%


