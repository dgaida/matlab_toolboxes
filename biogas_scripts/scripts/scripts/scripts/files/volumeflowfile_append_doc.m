%% Syntax
%       volumeflowfile_append(volflowfile, values, position)
%
%% Description
% |volumeflowfile_append(volflowfile, values, position)| appends values to
% volumeflow file |volflowfile| at start or end of file (see |position|).
% The file |volflowfile| is load in the beginning of the function and
% overwritten at the end. 
%
%%
% @param |volflowfile| : filename of volumeflow variable, with or without
% file extension '.mat'. 
%
%%
% @param |values| : double array with 2 rows. First is time in days, 2nd is
% volumeflow in m³/d. 
%
%%
% @param |position| : char, defining the position where to append |values|
% in file
%
% * 'start' : at the start. The already existing values are shifted in time
% by the next higher integer after the largest time value in |values|. See
% the example. 
% * 'end' : at the end. The time values in the given |values| must be
% starting after the end of the time values saved in the load volumeflow
% file. Otherwise an error is thrown. 
%
%% Example
% 
% first create some files

Q= [1 2 3];

create_volumeflow_files(Q, 'gummersbach', 1);

%%
% load variables to see the originals

volflow1= load_file('volumeflow_maize_const.mat');
volflow2= load_file('volumeflow_manure_const.mat');

disp(volflow1)
disp(volflow2)

%%
% change the files

volumeflowfile_append('volumeflow_maize_const', [0 9.8; 7 7], 'start');
volumeflowfile_append('volumeflow_manure_const', [0 9; 5.5 7], 'start');

%%
% load variables again to see the change

volflow1= load_file('volumeflow_maize_const.mat');
volflow2= load_file('volumeflow_manure_const.mat');

disp(volflow1)
disp(volflow2)

%%
% change the files again

volumeflowfile_append('volumeflow_maize_const', [40 49.8; 7 7], 'end');
volumeflowfile_append('volumeflow_manure_const', [40 49; 5.5 7], 'end');

%%
% load variables again to see the change

volflow1= load_file('volumeflow_maize_const.mat');
volflow2= load_file('volumeflow_manure_const.mat');

disp(volflow1)
disp(volflow2)

%%
% clean up

del_volumeflow_files('gummersbach', 'const');


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/load_file')">
% biogas_scripts/load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/save_varname')">
% script_collection/save_varname</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isrnm')">
% script_collection/isRnm</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/fix')">
% matlab/fix</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validatestring')">
% matlab/validatestring</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_scripts/volumeflowfiles_append')">
% biogas_scripts/volumeflowfiles_append</a>
% </html>
%
%% See Also
%
% <html>
% <a href="del_volumeflow_files.html">
% biogas_scripts/del_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/create_volumeflow_files')">
% biogas_scripts/create_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="createvolumeflowfile.html">
% createvolumeflowfile</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>

    
