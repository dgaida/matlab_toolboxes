%% Preliminaries
% # This function reads the file |initstate__plant_id_.mat|. Therefore this
% file must be in the present working directory (|pwd|), usually the folder
% where a model is in. 
%
%% Syntax
%       createDigesterStateMinMax(plant_id)
%       createDigesterStateMinMax(plant_id, id_read)
%       createDigesterStateMinMax(plant_id, id_read, savetofile)
%       [digester_state_min]= createDigesterStateMinMax(plant_id, ...)
%       [digester_state_min, digester_state_max]=
%       createDigesterStateMinMax(plant_id, ...) 
%       [digester_state_min, digester_state_max, initstate]=
%       createDigesterStateMinMax(plant_id, ...) 
%       
%% Description
% |createDigesterStateMinMax(plant_id)| creates the files
% |digester_state_min__plant_id_.mat| and
% |digester_state_max__plant_id_.mat|. Both files (boundaries) are set to
% be the same. Therefore it reads the file |initstate__plant_id_.mat| and
% sets the boundaries of each digester to the user vector inside the
% initstate structure. 
%
%%
% @param |plant_id| : char with the plant ID of the plant for which the
% files should be created.
%
%%
% |createDigesterStateMinMax(plant_id, id_read)| lets you specify an
% integer, which specifies the |initstate__plant_id__id_read_.mat| to be
% read. 
%
%%
% @param |id_read| : scalar integer. This option is used in the nonlinear
% MPC algorithm. Default: []. 
%
%%
% |createDigesterStateMinMax(plant_id, id_read, savetofile)| 
%
%%
% @param |savetofile| : 0 or 1
%
% * 0 : then the two variables |digester_state_min| and
% |digester_state_max| are not saved to mat files, but just returned.
% * 1 : the two variables |digester_state_min| and
% |digester_state_max| are saved to mat files (Default)
% 
%% Example
%
%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

createDigesterStateMinMax('gummersbach');


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="load_biogas_mat_files.html">
% load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="load_file.html">
% load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/save')">
% matlab/save</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/nonlinearmpc')">
% biogas_control/nonlinearMPC</a>
% </html>
%
%% See Also
%
% <html>
% <a href="createnewinitstatefile.html">
% createNewInitstatefile</a>
% </html>
% ,
% <html>
% <a href="createinitstatefile.html">
% createinitstatefile</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


