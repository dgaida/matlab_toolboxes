%% Syntax
%       adm1_loadfcn(adm1_model)
%       adm1_loadfcn(adm1_model, DEBUG_DISP)
%
%% Description
% |adm1_loadfcn()| loads the ADM1DE model by creating the dropdown menus
% of the block's mask. The function is called by the ADM1DE, ADM1xp and
% ADM1xp variable fXC blocks in the LoadFcn Callback.
%
%%
% @param |adm1_model| : type of model
%
% * 'ADM1xp' for ADM1xp and ADM1xp variable fXC blocks
% * 'ADM1DE' for ADM1DE block
%
%%
% |adm1_loadfcn(adm1_model, DEBUG_DISP)| additionally displays messages, if
% DEBUG_DISP == 1; DEBUG_DISP == 0, is the default
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc bdroot">
% matlab/bdroot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/createinitstatetypepopup')">
% createinitstatetypepopup</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/createdatasourcetypepopup')">
% createdatasourcetypepopup</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/createfermenterpopup')">
% createfermenterpopup</a>
% </html>
%
% and is called by:
%
% (LoadFcn Callback of 'adm' blocks)
%
%% See Also
% 
% <html>
% <a href="ADM1DE.html">
% ADM1DE</a>
% </html>
% ,
% <html>
% <a href="adm1_closefcn.html">
% adm1_closefcn</a>
% </html>
%
%% TODOs
% # check documentation
% # check code
%
%% <<AuthorTag_DG/>>


