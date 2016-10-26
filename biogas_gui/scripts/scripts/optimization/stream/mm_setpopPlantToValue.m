%% mm_setpopPlantToValue
% Set the index of the popPlant to the given |plantName|.
%
%% Toolbox
% |mm_setpopPlantToValue| belongs to the _Biogas Plant Modeling_ Toolbox
% and is an internal function.
%
%% Release
% Approval for Release 1.3, to get the approval for Release 1.4 make a
% thorough review, Daniel Gaida 
%
%% Syntax
%       handles= mm_setpopPlantToValue(handles, plantName)
%
%% Description
% |handles= mm_setpopPlantToValue(handles, plantName)| sets the index of the
% popPlant to the given |plantName|. Belongs to <set_input_stream_min_max.html
% set_input_stream_min_max>. 
%
%%
% @param |handles| : handle of gui
%
%%
% @param |plantName| : char with the name of the plant
%
%%
% @return |handles| : handle of gui
%
%% Example
%
% 
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc deblank">
% doc deblank</a>
% </html>
% ,
% <html>
% <a href="matlab:doc cellstr">
% doc cellstr</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="mm_actualizeGUI.html">
% mm_actualizeGUI</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="set_input_stream_min_max.html">
% set_input_stream_min_max</a>
% </html>
% ,
% <html>
% <a href="stream\set_input_stream.html">
% set_input_stream</a>
% </html>
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
% Last Update: 17.10.2011
%
%% Function
%
function handles= mm_setpopPlantToValue(handles, plantName)

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 1st parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

if ~ischar(plantName)
  error('The 2nd parameter plantName must be a char, but is a %s!', ...
        class(plantName));
end

%%

contents= cellstr( get(handles.mm_popPlant, 'String') ); 

for ivalue= 1:size(contents,1)

  % returns selected item from mm_popPlant
  if strcmp( deblank(char(contents{ivalue,1})), plantName )

    set(handles.mm_popPlant, 'Value', ivalue);

    break;

  end
    
end

%%


