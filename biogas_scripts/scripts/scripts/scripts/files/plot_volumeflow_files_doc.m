%% Syntax
%       plot_volumeflow_files('substrate', vol_type, substrate)
%       plot_volumeflow_files('substrate', vol_type, substrate, mypath)
%       plot_volumeflow_files('substrate', vol_type, substrate, mypath,
%       id_write) 
%       plot_volumeflow_files('substrate', vol_type, substrate, mypath,
%       id_write, accesstofile) 
%       plot_volumeflow_files('substrate', vol_type, substrate, mypath,
%       id_write, accesstofile, myfig) 
%       plot_volumeflow_files('substrate', vol_type, substrate, mypath,
%       id_write, accesstofile, myfig, colors) 
%       plot_volumeflow_files('substrate', vol_type, substrate, mypath,
%       id_write, accesstofile, myfig, colors, nPlots) 
%       plot_volumeflow_files('substrate', vol_type, substrate, mypath,
%       id_write, accesstofile, myfig, colors, nPlots, xlimits) 
%       plot_volumeflow_files('substrate', vol_type, substrate, mypath,
%       id_write, accesstofile, myfig, colors, nPlots, xlimits, where2plot) 
%       plot_volumeflow_files('substrate', vol_type, substrate, mypath,
%       id_write, accesstofile, myfig, colors, nPlots, xlimits, where2plot,
%       legend_labels) 
%       plot_volumeflow_files('substrate', vol_type, substrate, mypath,
%       id_write, accesstofile, myfig, colors, nPlots, xlimits, where2plot,
%       legend_labels, legend_location) 
%       plot_volumeflow_files('digester', vol_type, plant, mypath,
%       id_write, accesstofile, myfig, colors, nPlots, xlimits, where2plot,
%       legend_labels, legend_location, plant_network, plant_network_max) 
%
%% Description
% |plot_volumeflow_files('substrate', vol_type, substrate)| loads
% substrate feed volumeflow.mat files and plots their content. The files
% must be in the <matlab:doc('pwd') pwd>. 
%
%%
% @param |id| : the first parameter
%
% * 'substrate' : load and plot substrate feed files
% * 'digester' : load and plot sludge files, sludge is pumped between
% digesters 
%
%%
% @param |vol_type| : type of volumeflow files to be load and plotted
%
% * 'const' : volumeflow_..._const.mat files are load and plotted
% * 'user' : volumeflow_..._user.mat files are load and plotted
% * 'random' : volumeflow_..._random.mat files are load and plotted
%
%% <<substrate/>>
%%
% @param |mypath| : path from which the files should be load from. Default:
% <matlab:doc('pwd') pwd>. 
%
%%
% @param |id_write| : char which is appended at the end of the volumeflow
% filename: |volumeflow_..._user_1.mat|. Here |id_write|= '1'. Default: [].
% If |id == 'substrate'| may also be a cellstr with more than one
% |id_write|. As a result the files of the given ids are plotted in one
% figure, for each substrate one figure is plotted. Example: |id_write=
% {'1', '2'}|. Easier to compare different substrate feeds from different
% scenarios. 
%
%%
% @param |accesstofile| : 
%
% * 1 : if 1, then really load the data from a file. 
% * 0 : if set to 0, then the data isn't load from a file, but is load from
% the base workspace 
% * -1 : if it is -1, then load the data not from the workspace but from the
% model workspace. Not yet implemented!
%
%%
% @param |myfig| : a handle to a figure. As default a new figure is
% created. 
%
%%
% @param |colors| : char with a Color Specification or a cellstr with more
% than one color specification. As default as many colors are created as
% |id_write| has elements. 
%
%%
% @param |nPlots| : number of substrates that shall be plotted. if
% empty, then all substrates are plotted. 
%
%%
% @param |xlimits| : 2d vector used in <matlab:doc('matlab/xlim')
% matlab/xlim>. 
%
%%
% @param |where2plot| : 0, 1, 2
%
% * 0 : each feed is plotted in his own figure
% * 1 : all feeds are plotted in one subplot (default)
% * 2 : all feeds are plotted in the same plot
%
%%
% @param |legend_labels| : cellstr with labels for plot legend
%
%%
% @param |legend_location| : 
%
%%
% @param |Q_control| : 
%
%%
% @param |linewth| : double with the LineWidth. Default: 0.5
%
%%
% |plot_volumeflow_files('digester', vol_type, plant, mypath, id_write,
% accesstofile, myfig, colors, nPlots, xlimits, where2plot, legend_labels,
% legend_location, Q_control, linewth, plant_network, 
% plant_network_max)| loads digester pumped sludge volumeflow.mat files and
% plots their content. The files must be in the <matlab:doc('pwd') pwd>. 
%
%% <<plant/>>
%% <<plant_network/>>
%% <<plant_network_max/>>
%
%% Example
% 
%

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ) );

[substrate, plant, ~, plant_network, ~, ~, ~, plant_network_max]= ...
  load_biogas_mat_files('gummersbach');

plot_volumeflow_files('substrate', 'user', substrate, [], '1');

%%

myfig= figure;

plot_volumeflow_files('substrate', 'user', substrate, [], '1', [], myfig, 'b');

volumeflowfiles_append('gummersbach', [10 20 30], 20, 1);

plot_volumeflow_files('substrate', 'user', substrate, [], '1', [], myfig, 'r');

%%

plot_volumeflow_files('digester', 'const', plant, ...
  fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ), [], ...
  1, [], [], [], [], [], plant_network, plant_network_max);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc load">
% matlab/load</a>
% </html>
% ,
% <html>
% <a href="matlab:doc fullfile">
% matlab/fullfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/load_file">
% biogas_scripts/load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_substrate">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_plant">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_plant_network">
% biogas_scripts/is_plant_network</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/getnumdigestersplits">
% biogas_scripts/getNumDigesterSplits</a>
% </html>
%
% and is called by:
%
% (the user)
% 
%% See Also
%
% <html>
% <a href="matlab:doc biogas_scripts/load_volumeflow_files">
% biogas_scripts/load_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/createvolumeflowfile">
% biogas_scripts/createvolumeflowfile</a>
% </html>
%
%% TODOs
% # do documentation for script file
% # improve documentation
% # make todos
%
%% <<AuthorTag_DG/>>


