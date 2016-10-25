%% Syntax
%       fp= predict_data(xp, yp, zp, model)
%       fp= predict_data(xp, yp, zp, xm, ym, zm, fm)
%       fp= predict_data(xp, yp, zp, xm, ym, zm, fm, interp_method)
%
%% Preliminaries
% If you use the first call of this function, then it uses the MATLAB
% Kriging Toolbox DACE. You can download this toolbox from
% <http://www2.imm.dtu.dk/~hbn/dace/ http://www2.imm.dtu.dk/~hbn/dace/>.
% See also the <matlab:doc('ml_tool') ml_tool> toolbox. 
%
%% Description
% |fp= predict_data(xp, yp, zp, model)| uses the trained Kriging model
% |model| to return the output values |fp| based on the input values (|xp|,
% |yp|, |zp|). Thereby the Kriging model must be a mapping of the form f=
% F(x, y, z). Here f, x, y, z are either all vectors or all matrices. 
%
%%
% @param |xp| : data double matrix or vector
%
%%
% @param |yp| : data double matrix or vector, must have same size as |xp|. 
%
%%
% @param |zp| : data double matrix or vector, must have same size as |xp|. 
%
%%
% @param |model| : Kriging model modelling the map |fp| = F(|xp|, |yp|,
% |zp|). To create this model see the <matlab:doc('ml_tool') ml_tool>
% toolbox, more specifically <matlab:doc('ml_tool/evaluate_kriging')
% ml_tool/evaluate_kriging>. 
%
%%
% @return |fp| : data double matrix or vector, will have same size as |xp|. 
%
%%
% |fp= predict_data(xp, yp, zp, xm, ym, zm, fm)| returns the output values
% |fp| based on the input values (|xp|, |yp|, |zp|) using an interpolation
% method. The interpolation method builds a function f= F(x, y, z), which
% is trained using the data |xm|, |ym|, |zm| and |fm|. The default
% interpolation method is linear interpolation. For those values for which
% the selected interpolation method returns NaN we use nearest neighbour
% interpolation to fill the gaps. You can use this call without having the
% DACE toolbox installed. If there are duplicates in the data |[xm, ym,
% zm]|, then they are kicked out of the dataset calling
% <deleteduplicates.html deleteDuplicates>. 
%
%%
% @param |xm| : data double matrix or vector
%
%%
% @param |ym| : data double matrix or vector, must have same size as |xm|. 
%
%%
% @param |zm| : data double matrix or vector, must have same size as |xm|. 
%
%%
% @param |fm| : data double matrix or vector, must have same size as |xm|. 
%
%%
% |fp= predict_data(xp, yp, zp, xm, ym, zm, fm, interp_method)| lets you
% choose the interpolation method. 
%
%%
% @param |interp_method| : Sets the method used for interpolation. This
% argument only applies to the interpolation method, not the Kriging model.
% See also: <matlab:doc('TriScatteredInterp') matlab/TriScatteredInterp>. 
%
% * 'natural' : Natural neighbor interpolation
% * 'linear' : Linear interpolation (default)
% * 'nearest' : Nearest neighbor interpolation
%
%% Example
%
% # load data, create training and validation dataset and try to predict data
% using the trained interpolation method, which is a linear method. 
%

dataAnalysis= load_file('data_to_plot.mat');

N= numel( double(dataAnalysis(:,2)) );

indices= min(max(round( rand(N, 1) * N ), 1), N);

i_m= indices(1:fix(end*4/5));
i_p= indices(fix(end*4/5)+1:end);

% split dataset into training ... 
xm= double(dataAnalysis(i_m,2));
ym= double(dataAnalysis(i_m,3));
zm= double(dataAnalysis(i_m,8));

fm= double(dataAnalysis(i_m,end));

% ... and validation dataset
xp= double(dataAnalysis(i_p,2));
yp= double(dataAnalysis(i_p,3));
zp= double(dataAnalysis(i_p,8));

fp_ref= double(dataAnalysis(i_p,end));

fp_pred= predict_data(xp, yp, zp, xm, ym, zm, fm);

% plot the residual vector
% the residual seems to be ok, but there are quite a few outliers

residual4plotAnalysis(fp_ref - fp_pred);

%%
% # this time use the Kriging model
%

[xyz, fm]= deleteDuplicates([xm, ym, zm], fm);

[X, Y, Z, Fitness, model]= evaluate_kriging(xyz, fm);

fp_pred_kriging= predict_data(xp, yp, zp, model);

% plot the residual vector
% the residual seems to be more worse then the residual above

residual4plotAnalysis(fp_ref - fp_pred_kriging);


%%
% plot data returned by Kriging model

figure

plot3dsurface_alpha(X, Y, Z, Fitness);

daspect([1 1 1])

view(3); axis tight


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="deleteduplicates.html">
% deleteDuplicates</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('reshape')">
% matlab/reshape</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('triscatteredinterp')">
% matlab/TriScatteredInterp</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validatestring')">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="arrow3d_connect_dots.html">
% arrow3d_connect_dots</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_gui/gui_plot_optimresults')">
% biogas_gui/gui_plot_optimResults</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_gui/plot_xyz')">
% biogas_gui/plot_xyz</a>
% </html>
% ,
% <html>
% <a href="residual4plotanalysis.html">
% data_tool/residual4plotAnalysis</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/evaluate_kriging')">
% ml_tool/evaluate_kriging</a>
% </html>
% ,
% <html>
% <a href="plot3dsurface_alpha.html">
% data_tool/plot3dsurface_alpha</a>
% </html>
%
%% TODOs
% # create documentation for script file
% # check appearance of last example, the kriging model produced is quite
% bad, we have to improve evaluate_kriging
% 
%% <<AuthorTag_DG/>>


