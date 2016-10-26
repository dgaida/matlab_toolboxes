%% Syntax
%       var1= load_file(filename)
%       var1= load_file(filename, warning_msg)
%       var1= load_file(filename, warning_msg, setting)
%       var1= load_file(filename, warning_msg, setting, file_extension)
%       [var1, var2, ...]= load_file(filename, warning_msg, setting)
%
%% Description
% |load_file| loads the MAT-file |filename| in a try catch block and
% generates a warning, followed by an error, if the file could not be read.
%
%% 
% |var1= load_file(filename)| loads the MAT-file |filename.mat| and returns
% the first variable in the file as the variable |var1|. If the file could
% not be opened, then the warning message 'The file ', [filename, '.mat'],
% ' does not exist.' is generated and an error is thrown.
%
%%
% @param |filename| : The MAT-file to be loaded, without the file extension
%
%%
% |var1= load_file(filename, warning_msg)|
%
%%
% @param |warning_msg| : an additional warning message, which is shown,
% before the error is thrown, when the file could not be loaded
%
%%
% |var1= load_file(filename, warning_msg, setting)|
%
%%
% @param |setting| : char defining the relative path (no '../') to a
% subfolder where the file should be read from first. If you do not set
% this parameter, then the file is just read using <matlab:doc('load')
% load> without path specifications. This means that the file is read from
% anywhere in the path, starting in the current folder and then using the
% order of the path settings.
% If you set this parameter, then the function first tries to load the file
% from the <matlab:doc('pwd') pwd> and the subfolder |setting|. If this
% file does not exist in this subfolder, then try to find the file directly
% using <matlab:doc('exist') exist> and if existent, load the file using
% <matlab:doc('load') load>. If not existent, then try to load the file out
% of the _config_mat_ folder of the toolbox, using |setting| as subfolder.
% If not existent there, then an error is thrown.
%
%%
% @param |file_extension| : char with the file extension of the file to be
% load, default is 'mat'. Specify extension without '.'. Consider that the
% file extension has to be readable using <matlab:doc('load') load>. 
%
%%
% |[var1, var2, ...]= load_file(...)|
%
%%
% @return |var1|, |var2| : it returns the first, second, ... variable inside
% the file |filename|, if the file could be loaded, else []
%
%% Example
% 

plant_network= load_file('plant_network_gummersbach', 'warning', 'gummersbach');

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
% <a href="matlab:doc fileparts">
% matlab/fileparts</a>
% </html>
% ,
% <html>
% <a href="matlab:doc fullfile">
% matlab/fullfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc fieldnames">
% matlab/fieldnames</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('getbiogaslibpath')">
% getBiogasLibPath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('getconfigpath')">
% getConfigPath</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('adm1de')">
% ADM1DE</a>
% </html>
% ,
% <html>
% <a href="load_biogas_mat_files.html">
% load_biogas_mat_files</a>
% </html>
% ,
% <html>
% ...
% </html>
%
%% See Also
%
% -
%
%% TODOs
% # do documentation for script file
% # improve documentation a bit
%
%% <<AuthorTag_DG/>>


