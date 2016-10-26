%% Syntax
%       accesstofile= get_accesstofile_from_datasource_type(datasource_type)
%
%% Description
% |accesstofile= get_accesstofile_from_datasource_type(datasource_type)|
% returns scalar |accesstofile| out of char |datasource_type|. Both decode the
% same information with different values. They define where a data source
% used in a Simulink model gets its data. This is an internal function with
% no further external use. 
%
%%
% @param |datasource_type| : char
%
% * 'file' : load data from a file
% * 'workspace' : load data from the MATLAB base workspace
% * 'modelworkspace' : load data from the model workspace of the currently
% open Simulink model. 
%
%%
% @return |accesstofile| : double scalar
%
% * 1 : if 1, then really load data from a file, 
% * 0 : if set to 0, then data isn't load from a file, but is load from the 
% base workspace (better for optimization purpose -> speed)
% * -1 : if it is -1, then load data not from the workspace but to the model
% workspace, that's the default value. On new MATLAB versions (>= 7.11)
% the data is not evaluated in the modelworkspace anymore but also load 
% from a file (see e.g. <matlab:doc(eval_initstate_inmws')
% eval_initstate_inMWS>). 
%
%% Example
% 
%

get_accesstofile_from_datasource_type('file')

%%

get_accesstofile_from_datasource_type('workspace')

%%

get_accesstofile_from_datasource_type('modelworkspace')


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc strcmp">
% matlab/strcmp</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validatestring">
% matlab/validatestring</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_blocks/adm1de">
% biogas_blocks/ADM1DE</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="matlab:doc biogas_blocks/hydraulic_delay">
% biogas_blocks/hydraulic_delay</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_blocks/pump_stream">
% biogas_blocks/pump_stream</a>
% </html>
%
%% TODOs
% # do documentation for script file
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


