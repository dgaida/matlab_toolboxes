%% searchForModelFile
% Search and load a biogas plant model.
%
%% Toolbox
% |searchForModelFile| belongs to the _Biogas Plant Modeling_
% Toolbox and is an internal function.
%
%% Release
% Approval for Release 1.7, to get the approval for Release 1.8 make a
% thorough review, Daniel Gaida 
%
%% Syntax
%       handles= searchForModelFile(handles)
%
%% Description
% |handles= searchForModelFile(handles)| tries to load a biogas plant
% model.
%
%%
% @param |handles| : handle to a gui
%
%%
% @return |handles| : changed handle to a gui
%
%% Example
%
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('what')">
% doc what</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="stream\set_input_stream.html">
% set_input_stream</a>
% </html>
% ,
% <html>
% <a href="set_input_stream_min_max.html">
% set_input_stream_min_max</a>
% </html>
%
%% See Also
% 
%
%% TODOs
%
%
%% Author
% Daniel Gaida, M.Sc.EE.IT
%
% Cologne University of Applied Sciences (Campus Gummersbach)
%
% Department of Automation & Industrial IT
%
% GECO-C Group
%
% daniel.gaida@fh-koeln.de
%
% Copyright 2010-2011
%
% Last Update: 07.10.2011
%
%% Function
%
function handles= searchForModelFile(handles)

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 1st parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

%%

s_files= what(handles.model_path);

mdl_files= s_files.mdl;

plant_id= [];

%%

for ifile= 1:size(mdl_files, 1)

  if regexpi(char(mdl_files(ifile,1)), 'plant_\w*.mdl', 'once')

    [t]= regexpi(char(mdl_files(ifile,1)), 'plant_(\w+).*?.mdl', ...
                   'once', 'tokens');

    plant_id= char(t);

    break;

  end

end

%%

if isempty( plant_id )

  try
    set(handles.popPlant, 'enable', 'on');
  catch ME
    try
      set(handles.mm_popPlant, 'enable', 'on');
    catch ME1
      rethrow(ME);
    end
  end
  
  %msgbox('Please choose the plant''s name in the popup menu.', ...
   %      'Could not find the model of the plant');

  msgbox('Bitte wählen Sie den Namen der Anlage aus dem Popup-Menü.', ...
         'Konnte kein Simulationsmodell einer Anlage finden', ...
         'help');

else

  try
    set(handles.popPlant, 'enable', 'off');
  catch ME
    try
      set(handles.mm_popPlant, 'enable', 'off');
    catch ME1
      rethrow(ME);
    end
  end
  
  handles.plantID= plant_id;
  handles.plantName= [];

end

%%


