%% Syntax
%       assign_initstate_inMWS(plant_id, s)
%       
%% Description
% |assign_initstate_inMWS(plant_id, s)| assigns |initstate| in the
% modelworkspace of the <matlab:doc('bdroot') current model> using
% <matlab:doc('script_collection/assigninmws')
% script_collection/assigninMWS>. For new MATLAB versions (>= 7.11)
% |initstate| is 
% <matlab:doc('save') saved> in the file |initstate__plant_id_.mat| inside 
% the <matlab:doc('pwd') current path>. 
%
% During parallel simulation of models, in case of saving |initstate| to 
% file, the file gets the structure |initstate__plant_id__1.mat|.
% Where |1| symbolizes the number of the model. Therefore, to avoid
% confusion, the plant ID should not contain underscores |_| and numbers at
% the same time. 
%
%%
% @param |plant_id| : char, containing the plant ID.
%
%%
% @param |s| : sructure containing the |initstate| variable, which can be
% accessed by |s.initstate|. 
%
%% Example
%
% Creates the file 'initstate_gummersbach.mat' and writes the empty
% variable |initstate| inside the file 

initstate= [];

assign_initstate_inMWS('gummersbach', initstate)

delete('initstate_gummersbach.mat')


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/assigninmws')">
% script_collection/assigninMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/getmatlabversion')">
% script_collection/getMATLABVersion</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('bdroot')">
% matlab/bdroot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/save')">
% matlab/save</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="createinitstatefile.html">
% createinitstatefile</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="eval_initstate_inmws.html">
% eval_initstate_inMWS</a>
% </html>
%
%% TODOs
%
%
%% <<AuthorTag_DG/>>


