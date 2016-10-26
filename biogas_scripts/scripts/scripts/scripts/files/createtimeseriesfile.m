%% createtimeseriesfile
% Creates a file with timeseries data
%
function createtimeseriesfile(data_name, deltatime, data)
%% Release: 1.4

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check input parameters

checkArgument(data_name, 'data_name', 'char', '1st');

isR(deltatime, 'deltatime', 2, '+');

validateattributes(data, {'double'}, {'vector'}, ...
                   mfilename, 'data', 3);

%%
% data changes once per week
time_grid= (0:deltatime:max(size(data)) - 1)';

% schreibt *.mat file, wird benutzt als Import für Simulationen

data= data(:);

simudata= [time_grid data]';

%%

filenamepre= sprintf('reference_%s', data_name);
filename= sprintf('reference_%s.mat', data_name);

filestruct.(filenamepre)= simudata;

save( filename, '-struct', 'filestruct', filenamepre);

%%


