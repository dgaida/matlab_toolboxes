%% Syntax
%       creategas2bhkwsplittypepopup(id_gas2bhkwsplittype, init)
%
%% Description
% |creategas2bhkwsplittypepopup(id_gas2bhkwsplittype, init)| creates
% popupmenu for selecting the type of splitting the gas to the bhkw's. It
% reads the variable 'gas2bhkwsplittypes' out of the modelworkspace using
% <matlab:doc('script_collection/evalinmws') evalinMWS>, on errpr 
% out of the base workspace using <matlab:doc('evalin') evalin>, generates
% the content of the popupmenu and sets the content in setting the
% parameter 'MaskStyleString' using <matlab:doc('set_param') set_param>. If
% |init| == 1, then sets the parameter |MaskValues| to the saved
% |UserData|. At the end of the function |UserData| is set to the current
% |MaskValues|. 
%
%%
% @param |id_gas2bhkwsplittype| : id of where in the gui the entry for the
% gas2bhkwsplittype is located, starting with 1. Double, scalar, integer
%
%% 
% @param |init| : double scalar
%
% * 0 : set to 0, when block is not called for the first time
% * 1 : set to 1, when block is called for the first time
%
%% Example
% 

creategas2bhkwsplittypepopup(1, 0)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/evalinmws')">
% script_collection/evalinMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('gcb')">
% matlab/gcb</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('get_param')">
% matlab/get_param</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/get_param_error')">
% script_collection/get_param_error</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/set_param_tc')">
% script_collection/set_param_tc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('evalin')">
% matlab/evalin</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% -
%
%% See Also
%
% <html>
% <a href="createfermenterpopup.html">
% createfermenterpopup</a>
% </html>
% ,
% <html>
% <a href="createvolumeflowtypepopup.html">
% createvolumeflowtypepopup</a>
% </html>
% ,
% <html>
% <a href="createdatasourcetypepopup.html">
% createdatasourcetypepopup</a>
% </html>
% ,
% <html>
% <a href="createinitstatetypepopup.html">
% createinitstatetypepopup</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('set_param')">
% matlab/set_param</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


    