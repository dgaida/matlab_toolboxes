%% 
% # To add a script paste it inside the folder |scripts/scripts|. At the
% moment (v1.2) you also have to add an entry inside the
% |helpfuncbycat.xml| file for your new script. 
% # To make a new release version of this toolbox first create a subfolder
% with your release version inside the |rn| folder. Then call something
% such as: 
%
% |make_toolbox('script_collection', ...
%               'GECO-C MATLAB Script Collection', ...
%               '1.1', ...
%               'H:\wissMitarbeiter\matlab_toolboxes\script_collection\trunk');|
%
% and, after you have installed the new toolbox, call
%
% |publish_toolbox(script_collection);|
%
% to create the documentation (Therefore <matlab:doc('doc_tool')
% |doc_tool|> must be installed). 
%


