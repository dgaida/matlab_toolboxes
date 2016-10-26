%% Syntax
%       createtimeseriesfile(data_name, deltatime, data)
%
%% Description
% |createtimeseriesfile(data_name, deltatime, data)| creates a mat file with
% timeseries data. The file is called |reference__data_name_.mat| and
% contains the given |data| over a time grid with the given |deltatime|. So
% it is assumed that the data is sampled equidistantly.
%
%%
% @param |data_name| : char with the name of the to be created file.
%
%%
% @param |deltatime| : double scalar with the sample time the array |data|
% has
%
%%
% @param |data| : double vector with the data
%
%% Example
%
%

createtimeseriesfile('energy', 1, rand(30,1));

delete('reference_energy.mat');

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/save')">
% matlab/save</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="createvolumeflowfile.html">
% createvolumeflowfile</a>
% </html>
%
%% TODOs
% # maybe improve function?
%
%% <<AuthorTag_DG/>>


