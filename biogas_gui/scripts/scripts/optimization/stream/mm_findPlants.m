%% mm_findPlants
% Call <matlab:doc('findexistingplants') 
% findExistingPlants> and updates popup menu.
%
%% Toolbox
% |mm_findPlants| belongs to the _Biogas Plant Modeling_ Toolbox
% and is an internal function.
%
%% Release
% Approval for Release 1.3, to get the approval for Release 1.4 make a
% thorough review, Daniel Gaida 
%
%% Syntax
%       handles= mm_findPlants(handles)
%
%% Description
% |handles= mm_findPlants(handles)| calls
% <matlab:doc('findexistingplants') 
% findExistingPlants> and updates popup menu.
%
%%
% @param |handles| : handle of gui
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
% <a href="matlab:doc('findexistingplants')">
% findExistingPlants</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="set_input_stream_min_max_OpeningFcn.html">
% set_input_stream_min_max_OpeningFcn</a>
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
function handles= mm_findPlants(handles)

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 1st parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

%%

[plant_ids, plant_names]= ...
    findExistingPlants({''}, {get(handles.mm_popPlant, 'String')});

%%

set(handles.mm_popPlant, 'String', char(plant_names));

%%


