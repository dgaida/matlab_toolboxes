%% Introduction
% This tool contains scripts which are useful for handling with data and
% performing data analysis. There are scripts for data in- and output as well 
% as for data processing algorithms (such as filters) and scripts for 
% determining statistical properties of data. Furthermore there are a
% couple of scripts which can be useful to visualize your data. A further
% topic is state estimation. The most important functions of these five
% blocks are listed in the following. 
%
%% In-/ Output
% # To read data out of a postgreSQL or ODBC database have a look at
% <matlab:doc('data_tool/getfiltereddatafromdb')
% data_tool/getFilteredDataFromDB> which also filters the data. To write
% into a database look at <matlab:doc('data_tool/writetodatabase')
% data_tool/writetodatabase>. 
% # To write in a csv- and xls-files see <matlab:doc('data_tool/writeincsv')
% data_tool/writeInCSV> and <matlab:doc('data_tool/writeinxls')
% data_tool/writeInXLS>, respectively. 
% # To write into a <matlab:doc('dataset') dataset> see
% <matlab:doc('data_tool/writeindataset') data_tool/writeInDataset> 
%
%% Data Processing
% # To filter data on a global scale have a look at
% <matlab:doc('data_tool/filterdata') data_tool/filterData> and to filter
% data on a local scale see
% <matlab:doc('data_tool/online_outlier_detection')
% data_tool/online_outlier_detection>. 
% # To use the minmax filters <matlab:doc('data_tool/lemire_nd_minengine')
% data_tool/lemire_nd_minengine> and <matlab:doc('data_tool/lemire_nd_maxengine')
% data_tool/lemire_nd_maxengine> you have to install them. Therefore use
% <matlab:edit('minmaxfilter_install.m') minmaxfilter_install.m> inside the
% |minmax| folder. 
%
%% Statistical Analysis
% # There are a couple of methods, which can be used to estimate the scale
% of the probability distribution. Among them are <matlab:doc('data_tool/mad') Median
% Absolute Deviation>, <matlab:doc('qn') QN> and <matlab:doc('sn') SN>. 
% # You can perform a principal component analysis using
% <matlab:doc('data_tool/pca') pca> or using the robust version
% <matlab:doc('data_tool/rpca') rPCA>. 
%
%% Visualisation
% # To analyse a random vector (or a residual vector) visually
% <matlab:doc('data_tool/residual4plotanalysis')
% data_tool/residual4plotAnalysis> could be useful.
% # To visualize 3-dimensional data
% <matlab:doc('data_tool/plot3dsurface_alpha')
% data_tool/plot3dsurface_alpha> and
% <matlab:doc('data_tool/scatter3markeredgecolor')
% data_tool/scatter3MarkerEdgeColor> are of help. 
%
%% Estimation
% The following State Estimation filters are included:
%
% * Continuous Extended Kalman Filter <matlab:doc('data_tool/ekf_cont_simon')
% data_tool/ekf_cont_simon>
% * Discrete Extended Kalman Filter <matlab:doc('data_tool/ekf_discrete_simon')
% data_tool/ekf_discrete_simon>
% * Hybrid Extended Kalman Filter <matlab:doc('data_tool/ekf_hybrid_simon')
% data_tool/ekf_hybrid_simon>
% * Discrete Kalman Filter <matlab:doc('data_tool/kalman_discrete_simon')
% data_tool/kalman_discrete_simon>
%
%% Dependencies
% Some files use the <matlab:doc('database') Database Toolbox> of MATLAB.
% Thus, to use these functions you need the mentioned toolbox. The function
% <matlab:doc('data_tool/predict_data') data_tool/predict_data> uses the
% MATLAB Kriging Toolbox DACE, which you can download from:
% <http://www2.imm.dtu.dk/~hbn/dace/ http://www2.imm.dtu.dk/~hbn/dace/>. 
%


