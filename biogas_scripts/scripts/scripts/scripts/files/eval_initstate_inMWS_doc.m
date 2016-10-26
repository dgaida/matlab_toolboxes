%% Syntax
%       s= eval_initstate_inMWS(plant_id)
%       
%% Description
% |s= eval_initstate_inMWS()| evaluates |initstate| in the modelworkspace of
% the <matlab:doc('bdroot') current model> using
% <matlab:doc('script_collection/evalinmws') script_collection/evalinMWS>.
% For new MATLAB versions (>= 7.11) |initstate| is 
% <matlab:doc('load') load> out of the file |initstate__plant_id_.mat| which must
% be in the current path. The |initstate| variable is returned inside the
% sructure |s|, which can be accessed by |s.initstate|. 
%
% During parallel simulation of models, in case of loading |initstate| from
% file, the file must have the structure |initstate__plant_id__1.mat|.
% Where |1| symbolizes the number of the model. Therefore, to avoid
% confusion, the 
% plant ID should not contain underscores |_| and numbers at the same time.
%
%%
% @param |plant_id| : char, containing the plant ID.
%
%%
% @return |s| : sructure containing the |initstate| variable, which can be
% accessed by |s.initstate|. 
%
%% Example
%
%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

eval_initstate_inMWS('gummersbach')

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
% <a href="matlab:doc('matlab/load')">
% matlab/load</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="createinitstatefile.html">
% createinitstatefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/savestateinequilibriumstruct')">
% biogas_optimization/saveStateInEquilibriumStruct</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="assign_initstate_inmws.html">
% assign_initstate_inMWS</a>
% </html>
%
%% TODOs
%
%
%% <<AuthorTag_DG/>>


