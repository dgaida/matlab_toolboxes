%% Syntax
%       TmrFcn(src, event, handles)
%       
%% Description
% |TmrFcn(src, event, handles)| is a timer function updating
% <gui_digester_combi.html gui_digester_combi>. It gets a bunch of
% measurements out of the sensor object being in the model workspace of the
% currently simulated biogas plant model. 
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('evalinmws')">
% evalinMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('calc_aceto_hydro_ratio')">
% calc_aceto_hydro_ratio</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('get_intvars')">
% get_intvars</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="gui_digester_combi_openingfcn.html">
% gui_digester_combi_OpeningFcn</a>
% </html>
%
%% See also
% 
% <html>
% <a href="matlab:doc('adm1de')">
% ADM1DE</a>
% </html>
%
%% TODOs
% # make the gui more safe
% # improve documentation
%
%% <<AuthorTag_DG/>>


