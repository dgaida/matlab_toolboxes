%% Syntax
%       make_toolbox(toolbox_id, toolbox_name, toolbox_version, toolbox_path)
%
%% Description
% |make_toolbox(toolbox_id, toolbox_name, toolbox_version, toolbox_path)| 
%
%% Example
%
% 
% make_toolbox('gecoc_tool_def', 'GECO-C MATLAB Tools Definition', '1.1',
% 'H:\wissMitarbeiter\matlab_toolboxes\gecoc_tool_def\trunk') 
%
% make_toolbox('script_collection', 'GECO-C MATLAB Script Collection',
% '1.1', 'H:\wissMitarbeiter\matlab_toolboxes\script_collection\trunk') 
%
% make_toolbox('doc_tool', 'GECO-C Documentation for MATLAB Tools', '1.1',
% 'H:\wissMitarbeiter\matlab_toolboxes\doc_tool\trunk') 
%
% make_toolbox('setup_tool', 'GECO-C Setup for MATLAB Tools', '1.1',
% 'H:\wissMitarbeiter\matlab_toolboxes\setup_tool\trunk') 
%
% make_toolbox('data_tool', 'GECO-C MATLAB Data Tools', '1.1',
% 'H:\wissMitarbeiter\matlab_toolboxes\data_tool\trunk') 
%


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('toolbox_creator/createfolderstructure')">
% toolbox_creator/createFolderStructure</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('copyfile')">
% matlab/copyfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('rmdir')">
% matlab/rmdir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('toolbox_creator/include_templates')">
% toolbox_creator/include_templates</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('toolbox_creator/make_doc')">
% toolbox_creator/make_doc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('setup_tool/getallsubfolders')">
% setup_tool/getAllSubfolders</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% 
%
%% TODOs
% # improve documentation and create it for script
% # add example
% 
%% <<AuthorTag_DG/>>


